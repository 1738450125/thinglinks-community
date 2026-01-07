package com.thinglinks.business.controller;

import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.thinglinks.business.domain.ThinglinksDeviceLogs;
import com.thinglinks.business.domain.ThinglinksProperties;
import com.thinglinks.business.domain.dto.PropertyListDTO;
import com.thinglinks.business.service.IThinglinksDeviceLogsService;
import com.thinglinks.business.service.IThinglinksProductService;
import com.thinglinks.business.service.IThinglinksPropertiesService;
import com.thinglinks.common.core.controller.BaseController;
import com.thinglinks.common.core.domain.AjaxResult;
import com.thinglinks.common.core.page.TableDataInfo;
import com.thinglinks.common.utils.PageUtils;
import com.thinglinks.common.utils.StringUtils;
import com.thinglinks.common.utils.poi.ExcelUtil;
import com.thinglinks.component.message.DecodeMessage;
import com.thinglinks.component.message.MessageCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

/**
 * 物模型属性定义Controller
 * 
 * @author thinglinks
 * @date 2025-09-18
 */
@RestController
@RequestMapping("/business/properties")
public class ThinglinksPropertiesController extends BaseController
{
    @Autowired
    private IThinglinksPropertiesService thinglinksPropertiesService;
    @Autowired
    private IThinglinksProductService productService;
    @Autowired
    private IThinglinksDeviceLogsService thinglinksDeviceLogsService;

    public static final List<String> KEYWORD = Arrays.asList("currentStatus","changeStatus","deviceProperty");
    /**
     * 查询物模型属性定义列表
     */
    @GetMapping("/list")
    public TableDataInfo list(ThinglinksProperties thinglinksProperties)
    {
        QueryWrapper<ThinglinksProperties> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("sort_num");
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksProperties.getBelongSn()),"belong_sn",thinglinksProperties.getBelongSn());
        Page<ThinglinksProperties> page = new Page<ThinglinksProperties>(PageUtils.getPageNum(),PageUtils.getPageSize());
        Page<ThinglinksProperties> pageList = thinglinksPropertiesService.page(page,queryWrapper);
        return getDataTable(pageList);
    }

    /**
     * 导出物模型属性定义列表
     */
    @PostMapping("/export")
    public void export(HttpServletResponse response, ThinglinksProperties thinglinksProperties)
    {
        List<ThinglinksProperties> list = thinglinksPropertiesService.selectThinglinksPropertiesList(thinglinksProperties);
        ExcelUtil<ThinglinksProperties> util = new ExcelUtil<ThinglinksProperties>(ThinglinksProperties.class);
        util.exportExcel(response, list, "物模型属性定义数据");
    }

    /**
     * 获取物模型属性定义详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id)
    {
        return success(thinglinksPropertiesService.getById(id));
    }

    /**
     * 新增物模型属性定义
     */
    @PostMapping
    public AjaxResult add(@RequestBody ThinglinksProperties thinglinksProperties)
    {
        return toAjax(thinglinksPropertiesService.insertThinglinksProperties(thinglinksProperties));
    }

    /**
     * 修改物模型属性定义
     */
    @PutMapping
    public AjaxResult edit(@RequestBody ThinglinksProperties thinglinksProperties)
    {
        return toAjax(thinglinksPropertiesService.updateThinglinksProperties(thinglinksProperties));
    }

    /**
     * 删除物模型属性定义
     */
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable String[] ids)
    {
        return toAjax(thinglinksPropertiesService.deleteThinglinksPropertiesByIds(ids));
    }

    /**
     * 批量新增属性
     */
    @PostMapping("/saveBatch")
    @Transactional(rollbackFor = Exception.class)
    public AjaxResult saveBatch(@RequestBody PropertyListDTO propertyListDTO){
        List<ThinglinksProperties> list = propertyListDTO.getPropertyList();
        if(list!=null&&list.size()>0){
            thinglinksPropertiesService.remove(new LambdaUpdateWrapper<ThinglinksProperties>()
                    .eq(ThinglinksProperties::getBelongSn,propertyListDTO.getBelongSn()));
            for (int i = 0; i < list.size(); i++) {
                if(KEYWORD.contains(list.get(i).getIdentifier())){
                    return AjaxResult.error("不能使用关键字作为属性值");
                }
            }
            list.forEach(property->{
                property.setBelongSn(propertyListDTO.getBelongSn());
                property.setBelongType(propertyListDTO.getBelongType());
                property.setFromType(propertyListDTO.getFromType());
            });
            thinglinksPropertiesService.saveBatch(list);
            return AjaxResult.success("更新属性成功");
        }else {
            return AjaxResult.error("请至少添加一条属性");
        }
    }

    /**
     * 获取设备最新json数据
     */
    @GetMapping("/getDeviceLastData")
    public AjaxResult getDeviceLastData(@RequestParam String deviceSn){
        DecodeMessage decodeMessage = MessageCache.getDeviceLastData(deviceSn);
        if(decodeMessage==null){
            ThinglinksDeviceLogs log = thinglinksDeviceLogsService.getOne(new LambdaQueryWrapper<ThinglinksDeviceLogs>()
                    .eq(ThinglinksDeviceLogs::getDeviceSn,deviceSn)
                    .orderByDesc(ThinglinksDeviceLogs::getReportTime)
                    .eq(ThinglinksDeviceLogs::getLogType,"PROPERTY")
                    .last(" limit 1 "));
            if(log!=null){
                decodeMessage = JSONObject.parseObject(log.getProperties(),DecodeMessage.class);
                MessageCache.setDeviceLastData(deviceSn,decodeMessage);
            }else {
                decodeMessage = new DecodeMessage();
                MessageCache.setDeviceLastData(deviceSn,new DecodeMessage());
            }
        }
        return AjaxResult.success(decodeMessage);
    }

    /**
     * 获取设备/产品所有可配置属性
     */
    @GetMapping("/getPropertiesBySn")
    public AjaxResult getPropertiesBySn(@RequestParam String sn){
        List<ThinglinksProperties> thinglinksProperties = thinglinksPropertiesService.list(new LambdaQueryWrapper<ThinglinksProperties>()
                .eq(ThinglinksProperties::getBelongSn,sn));
        return AjaxResult.success(thinglinksProperties);
    }
}
