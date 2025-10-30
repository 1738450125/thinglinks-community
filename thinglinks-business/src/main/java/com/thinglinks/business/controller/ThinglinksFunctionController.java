package com.thinglinks.business.controller;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.thinglinks.business.domain.ThinglinksComponent;
import com.thinglinks.business.domain.ThinglinksDevice;
import com.thinglinks.business.domain.ThinglinksProduct;
import com.thinglinks.business.down.DeviceDownUtils;
import com.thinglinks.business.service.IThinglinksComponentService;
import com.thinglinks.business.service.IThinglinksDeviceService;
import com.thinglinks.business.service.IThinglinksProductService;
import com.thinglinks.business.utils.CacheUtils;
import com.thinglinks.common.annotation.Anonymous;
import com.thinglinks.common.utils.StringUtils;
import io.netty.util.internal.StringUtil;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.thinglinks.common.utils.PageUtils;
import com.thinglinks.common.annotation.Log;
import com.thinglinks.common.core.controller.BaseController;
import com.thinglinks.common.core.domain.AjaxResult;
import com.thinglinks.common.enums.BusinessType;
import com.thinglinks.business.domain.ThinglinksFunction;
import com.thinglinks.business.service.IThinglinksFunctionService;
import com.thinglinks.common.utils.poi.ExcelUtil;
import com.thinglinks.common.core.page.TableDataInfo;

/**
 * 设备指令下发Controller
 * 
 * @author ruoyi
 * @date 2025-10-24
 */
@RestController
@Anonymous
@RequestMapping("/business/function")
public class ThinglinksFunctionController extends BaseController
{
    @Autowired
    private IThinglinksFunctionService thinglinksFunctionService;
    @Autowired
    private IThinglinksDeviceService thinglinksDeviceService;
    @Autowired
    private IThinglinksProductService thinglinksProductService;
    @Autowired
    private IThinglinksComponentService thinglinksComponentService;
    /**
     * 查询设备指令下发列表
     */
    @GetMapping("/list")
    public TableDataInfo list(ThinglinksFunction thinglinksFunction)
    {
        QueryWrapper<ThinglinksFunction> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("create_time");
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksFunction.getBelongSn()),"belong_sn",thinglinksFunction.getBelongSn());
        Page<ThinglinksFunction> page = new Page<ThinglinksFunction>(PageUtils.getPageNum(),PageUtils.getPageSize());
        Page<ThinglinksFunction> pageList = thinglinksFunctionService.page(page,queryWrapper);
        return getDataTable(pageList);
    }

    /**
     * 导出设备指令下发列表
     */
    @Log(title = "设备指令下发", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ThinglinksFunction thinglinksFunction)
    {
        List<ThinglinksFunction> list = thinglinksFunctionService.selectThinglinksFunctionList(thinglinksFunction);
        ExcelUtil<ThinglinksFunction> util = new ExcelUtil<ThinglinksFunction>(ThinglinksFunction.class);
        util.exportExcel(response, list, "设备指令下发数据");
    }

    /**
     * 获取设备指令下发详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id)
    {
        return success(thinglinksFunctionService.getById(id));
    }

    /**
     * 新增设备指令下发
     */
    @Log(title = "设备指令下发", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ThinglinksFunction thinglinksFunction)
    {
        if("1".equals(thinglinksFunction.getBelongType())){
            ThinglinksDevice device = thinglinksDeviceService.getOne(new LambdaQueryWrapper<ThinglinksDevice>()
                    .eq(ThinglinksDevice::getDeviceSn,thinglinksFunction.getBelongSn()));
            thinglinksFunction.setProtocolId(device.getProtocolId());
        }else {
            ThinglinksProduct product = thinglinksProductService.getOne(new LambdaQueryWrapper<ThinglinksProduct>()
                    .eq(ThinglinksProduct::getProductSn,thinglinksFunction.getBelongSn()));
            thinglinksFunction.setProtocolId(product.getProtocolId());
        }
        return toAjax(thinglinksFunctionService.save(thinglinksFunction));
    }

    /**
     * 修改设备指令下发
     */
    @Log(title = "设备指令下发", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ThinglinksFunction thinglinksFunction)
    {
        return toAjax(thinglinksFunctionService.updateById(thinglinksFunction));
    }

    /**
     * 删除设备指令下发
     */
    @Log(title = "设备指令下发", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable String[] ids)
    {
        return toAjax(thinglinksFunctionService.deleteThinglinksFunctionByIds(ids));
    }

    /**
     * 同步产品数据到设备
     */
    @PostMapping("/syncProductToDevice")
    public AjaxResult syncProductToDevice(@RequestBody ThinglinksFunction thinglinksFunction){
        if(StringUtils.isEmpty(thinglinksFunction.getBelongSn())){
            return AjaxResult.warn("请选择产品");
        }
        List<ThinglinksFunction> functionList = thinglinksFunctionService.list(new LambdaQueryWrapper<ThinglinksFunction>()
                .eq(ThinglinksFunction::getBelongSn,thinglinksFunction.getBelongSn()));
        List<ThinglinksDevice> deviceList = thinglinksDeviceService.list(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getProductSn,thinglinksFunction.getBelongSn()));
        List<ThinglinksFunction> list = new ArrayList<>();
        deviceList.forEach(device->{
            functionList.forEach(function ->{
                ThinglinksFunction func = new ThinglinksFunction();
                BeanUtils.copyProperties(function,func);
                func.setBelongSn(device.getDeviceSn());
                func.setId(null);
                list.add(func);
            });
        });
        thinglinksFunctionService.saveBatch(list);
        return AjaxResult.success();
    }

    /**
     * 指令下发
     */
    @PostMapping("/downFunction")
    public AjaxResult downFunction(@RequestBody ThinglinksFunction thinglinksFunction) throws MqttException, InvocationTargetException, IllegalAccessException {
        ThinglinksDevice device = thinglinksDeviceService.getOne(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getDeviceSn,thinglinksFunction.getBelongSn()));
        ThinglinksComponent component = thinglinksComponentService.getById(device.getComponentId());
        boolean isOk = DeviceDownUtils.functionDown(thinglinksFunction.getBelongSn(),
                thinglinksFunction.getFunctionCode(),
                thinglinksFunction.getFunctionParams(),
                device.getComponentId(),
                component.getNetType(),
                device.getProtocolId(),
                CacheUtils.getDeviceBySn(device.getDeviceSn()).getCustomConfig(),"0");
        if(isOk){
            return AjaxResult.success("下发成功");
        }else {
            return AjaxResult.warn("下发失败");
        }
    }
}
