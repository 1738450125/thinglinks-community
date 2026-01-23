package com.thinglinks.business.controller;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.thinglinks.business.domain.*;
import com.thinglinks.business.event.DeviceHeartbeatManager;
import com.thinglinks.business.service.IThinglinksFunctionService;
import com.thinglinks.business.service.IThinglinksProductService;
import com.thinglinks.business.service.IThinglinksWarnConfigService;
import com.thinglinks.business.utils.CacheUtils;
import com.thinglinks.common.utils.PageUtils;
import com.thinglinks.common.utils.SecurityUtils;
import com.thinglinks.common.utils.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.thinglinks.common.core.controller.BaseController;
import com.thinglinks.common.core.domain.AjaxResult;
import com.thinglinks.business.service.IThinglinksDeviceService;
import com.thinglinks.common.utils.poi.ExcelUtil;
import com.thinglinks.common.core.page.TableDataInfo;

/**
 * 设备Controller
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@RestController
@RequestMapping("/business/device")
public class ThinglinksDeviceController extends BaseController
{
    @Autowired
    private IThinglinksDeviceService thinglinksDeviceService;
    @Autowired
    private IThinglinksProductService thinglinksProductService;
    @Autowired
    private IThinglinksWarnConfigService thinglinksWarnConfigService;
    @Autowired
    private IThinglinksFunctionService thinglinksFunctionService;
    /**
     * 查询设备列表
     */
    @GetMapping("/list")
    public TableDataInfo list(ThinglinksDevice thinglinksDevice)
    {
        QueryWrapper<ThinglinksDevice> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("create_time");
        queryWrapper.like(StringUtils.isNotEmpty(thinglinksDevice.getDeviceSn()),"device_sn",thinglinksDevice.getDeviceSn());
        queryWrapper.like(StringUtils.isNotEmpty(thinglinksDevice.getDeviceName()),"device_name",thinglinksDevice.getDeviceName());
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksDevice.getProductSn()),"product_sn",thinglinksDevice.getProductSn());
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksDevice.getStatus()),"status",thinglinksDevice.getStatus());
        Page<ThinglinksDevice> page = new Page<ThinglinksDevice>(PageUtils.getPageNum(),PageUtils.getPageSize());
        Page<ThinglinksDevice> pageList = thinglinksDeviceService.page(page,queryWrapper);
        return getDataTable(pageList);
    }

    /**
     * 导出设备列表
     */
    @PostMapping("/export")
    public void export(HttpServletResponse response, ThinglinksDevice thinglinksDevice)
    {
        List<ThinglinksDevice> list = thinglinksDeviceService.selectThinglinksDeviceList(thinglinksDevice);
        ExcelUtil<ThinglinksDevice> util = new ExcelUtil<ThinglinksDevice>(ThinglinksDevice.class);
        util.exportExcel(response, list, "设备数据");
    }

    /**
     * 获取设备详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id)
    {
        return success(thinglinksDeviceService.getById(id));
    }

    /**
     * 获取设备详细信息
     */
    @GetMapping("/getDeviceBySn")
    public AjaxResult getDeviceBySn(@RequestParam String deviceSn)
    {
        ThinglinksDevice device = thinglinksDeviceService.getOne(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getDeviceSn,deviceSn),false);
        if(device==null){
            return AjaxResult.error("设备不存在，请检查是否已被删除！");
        }
        return success(device);
    }

    /**
     * 新增设备
     */
    @PostMapping
    public AjaxResult add(@RequestBody ThinglinksDevice thinglinksDevice)
    {
        return thinglinksDeviceService.saveDevice(thinglinksDevice);
    }

    /**
     * 修改设备
     */
    @PutMapping
    public AjaxResult edit(@RequestBody ThinglinksDevice thinglinksDevice)
    {
        thinglinksDeviceService.updateById(thinglinksDevice);
        ThinglinksDevice newDevice = thinglinksDeviceService.getById(thinglinksDevice.getId());
        DeviceHeartbeatManager.updateHeartbeat(newDevice.getDeviceSn(),"1",newDevice.getTimeoutSeconds());
        CacheUtils.updateDeviceCache(newDevice.getDeviceSn());
        return AjaxResult.success();
    }

    /**
     * 修改设备modbus从站ID
     */
    @PutMapping("/updateSlaveId")
    public AjaxResult updateSlaveId(@RequestBody ThinglinksDevice thinglinksDevice)
    {
        thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getDeviceSn,thinglinksDevice.getDeviceSn())
                .set(ThinglinksDevice::getSlaveId,thinglinksDevice.getSlaveId()));
        ThinglinksDevice newDevice = thinglinksDeviceService.getOne(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getDeviceSn,thinglinksDevice.getDeviceSn()),false);
        CacheUtils.updateDeviceCache(newDevice.getDeviceSn());
        return AjaxResult.success();
    }

    /**
     * 删除设备
     */
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable String[] ids)
    {
        for (String id : ids) {
            ThinglinksDevice device = thinglinksDeviceService.getById(id);
            thinglinksDeviceService.removeById(id);
            thinglinksProductService.syncDeviceCount(device.getProductSn());
            thinglinksWarnConfigService.remove(new LambdaUpdateWrapper<ThinglinksWarnConfig>()
                    .eq(ThinglinksWarnConfig::getBelongSn,device.getDeviceSn()));
            thinglinksFunctionService.remove(new LambdaUpdateWrapper<ThinglinksFunction>()
                    .eq(ThinglinksFunction::getBelongSn,device.getDeviceSn()));
            CacheUtils.DEVICE_MAP.remove(device.getDeviceSn());
        }
        return AjaxResult.success();
    }

    /**
     * 根据产品sn获取设备列表
     */
    @GetMapping("/getDeviceByProductSn")
    public AjaxResult getDeviceByProductSn(@RequestParam String productSnList){
        List<String> productSn = Arrays.asList(productSnList.split(","));
        List<ThinglinksDevice> deviceList = thinglinksDeviceService.list(new LambdaQueryWrapper<ThinglinksDevice>()
                .in(ThinglinksDevice::getProductSn,productSn));
        return AjaxResult.success(deviceList);
    }

    /**
     * 同步数据保存时间到设备
     */
    @PostMapping("/editRetentionTime")
    public AjaxResult editRetentionTime(@RequestBody ThinglinksDevice thinglinksDevice) {
        thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getDeviceSn,thinglinksDevice.getDeviceSn())
                .set(ThinglinksDevice::getRegularCleaning,thinglinksDevice.getRegularCleaning())
                .set(ThinglinksDevice::getRetentionTime,thinglinksDevice.getRetentionTime())
                .set(ThinglinksDevice::getRetentionUnit,thinglinksDevice.getRetentionUnit()));
        CacheUtils.updateDeviceCache(thinglinksDevice.getDeviceSn());
        return AjaxResult.success("修改成功");
    }

    /**
     * 修改自定义配置
     */
    @PostMapping("/editCustomConfig")
    public AjaxResult editCustomConfig(@RequestBody ThinglinksDevice thinglinksDevice){
        thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getDeviceSn,thinglinksDevice.getDeviceSn())
                .set(ThinglinksDevice::getCustomConfig,thinglinksDevice.getCustomConfig()));
        CacheUtils.updateDeviceCustomConfig(thinglinksDevice.getDeviceSn(),thinglinksDevice.getCustomConfig());
        return AjaxResult.success("更新成功");
    }
}
