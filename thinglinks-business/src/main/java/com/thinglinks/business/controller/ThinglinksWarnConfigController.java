package com.thinglinks.business.controller;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.thinglinks.business.domain.ThinglinksDevice;
import com.thinglinks.business.domain.ThinglinksProduct;
import com.thinglinks.business.service.IThinglinksDeviceService;
import com.thinglinks.business.utils.CacheUtils;
import com.thinglinks.business.warn.WarnRule;
import com.thinglinks.common.utils.SecurityUtils;
import com.thinglinks.common.utils.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.thinglinks.common.utils.PageUtils;
import com.thinglinks.common.annotation.Log;
import com.thinglinks.common.core.controller.BaseController;
import com.thinglinks.common.core.domain.AjaxResult;
import com.thinglinks.common.enums.BusinessType;
import com.thinglinks.business.domain.ThinglinksWarnConfig;
import com.thinglinks.business.service.IThinglinksWarnConfigService;
import com.thinglinks.common.utils.poi.ExcelUtil;
import com.thinglinks.common.core.page.TableDataInfo;

/**
 * 告警配置Controller
 * 
 * @author thinglinks
 * @date 2025-10-05
 */
@RestController
@RequestMapping("/business/warnConfig")
public class ThinglinksWarnConfigController extends BaseController
{
    @Autowired
    private IThinglinksWarnConfigService thinglinksWarnConfigService;
    @Autowired
    private IThinglinksDeviceService thinglinksDeviceService;
    /**
     * 查询告警配置列表
     */
    @GetMapping("/list")
    public TableDataInfo list(ThinglinksWarnConfig thinglinksWarnConfig)
    {
        QueryWrapper<ThinglinksWarnConfig> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("create_time");
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksWarnConfig.getBelongSn()),"belong_sn",thinglinksWarnConfig.getBelongSn());
        Page<ThinglinksWarnConfig> page = new Page<ThinglinksWarnConfig>(PageUtils.getPageNum(),PageUtils.getPageSize());
        Page<ThinglinksWarnConfig> pageList = thinglinksWarnConfigService.page(page,queryWrapper);
        return getDataTable(pageList.getRecords());
    }

    /**
     * 导出告警配置列表
     */
    @Log(title = "告警配置", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ThinglinksWarnConfig thinglinksWarnConfig)
    {
        List<ThinglinksWarnConfig> list = thinglinksWarnConfigService.selectThinglinksWarnConfigList(thinglinksWarnConfig);
        ExcelUtil<ThinglinksWarnConfig> util = new ExcelUtil<ThinglinksWarnConfig>(ThinglinksWarnConfig.class);
        util.exportExcel(response, list, "告警配置数据");
    }

    /**
     * 获取告警配置详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id)
    {
        return success(thinglinksWarnConfigService.getById(id));
    }

    /**
     * 新增告警配置
     */
    @Log(title = "告警配置", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody WarnRule warnRule)
    {
        warnRule.setId(IdWorker.getIdStr());
        ThinglinksWarnConfig thinglinksWarnConfig = new ThinglinksWarnConfig();
        thinglinksWarnConfig.setCreateTime(new Date());
        thinglinksWarnConfig.setBelongSn(warnRule.getBelongSn());
        thinglinksWarnConfig.setBelongType(warnRule.getBelongType());
        thinglinksWarnConfig.setWarnLevel(warnRule.getLevel());
        thinglinksWarnConfig.setWarnMessage(warnRule.getMessage());
        thinglinksWarnConfig.setCreateBy(SecurityUtils.getUsername());
        thinglinksWarnConfig.setIsEnable(warnRule.getEnable()?"1":"0");
        thinglinksWarnConfig.setExecuteAction(JSONArray.toJSONString(warnRule.getActions()));
        thinglinksWarnConfig.setName(warnRule.getName());
        thinglinksWarnConfig.setRuleJson(JSONObject.toJSONString(warnRule));
        thinglinksWarnConfig.setId(warnRule.getId());
        thinglinksWarnConfigService.save(thinglinksWarnConfig);
        CacheUtils.updateDeviceWarnRule(thinglinksWarnConfig.getBelongSn());
        return AjaxResult.success();
    }

    /**
     * 修改告警配置
     */
    @Log(title = "告警配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody WarnRule warnRule)
    {
        ThinglinksWarnConfig thinglinksWarnConfig = new ThinglinksWarnConfig();
        thinglinksWarnConfig.setBelongSn(warnRule.getBelongSn());
        thinglinksWarnConfig.setBelongType(warnRule.getBelongType());
        thinglinksWarnConfig.setWarnMessage(warnRule.getMessage());
        thinglinksWarnConfig.setWarnLevel(warnRule.getLevel());
        thinglinksWarnConfig.setIsEnable(warnRule.getEnable()?"1":"0");
        thinglinksWarnConfig.setExecuteAction(JSONArray.toJSONString(warnRule.getActions()));
        thinglinksWarnConfig.setName(warnRule.getName());
        thinglinksWarnConfig.setRuleJson(JSONObject.toJSONString(warnRule));
        thinglinksWarnConfig.setId(warnRule.getId());
        thinglinksWarnConfigService.updateById(thinglinksWarnConfig);
        CacheUtils.updateDeviceWarnRule(thinglinksWarnConfig.getBelongSn());
        return AjaxResult.success();
    }

    /**
     * 删除告警配置
     */
    @Log(title = "告警配置", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable String[] ids)
    {
        return toAjax(thinglinksWarnConfigService.deleteThinglinksWarnConfigByIds(ids));
    }

    /**
     * 修改告警配置
     */
    @Log(title = "告警配置", businessType = BusinessType.UPDATE)
    @PutMapping("/toggleRuleStatus")
    public AjaxResult toggleRuleStatus(@RequestBody WarnRule warnRule)
    {
        ThinglinksWarnConfig old = thinglinksWarnConfigService.getById(warnRule.getId());
        WarnRule oldRule = JSONObject.parseObject(old.getRuleJson(),WarnRule.class);
        oldRule.setEnable(warnRule.getEnable());
        ThinglinksWarnConfig thinglinksWarnConfig = new ThinglinksWarnConfig();
        thinglinksWarnConfig.setId(warnRule.getId());
        thinglinksWarnConfig.setIsEnable(warnRule.getEnable()?"1":"0");
        thinglinksWarnConfig.setRuleJson(JSONObject.toJSONString(oldRule));
        thinglinksWarnConfigService.updateById(thinglinksWarnConfig);
        CacheUtils.updateDeviceWarnRule(old.getBelongSn());
        return AjaxResult.success();
    }

    /**
     * 同步到所有设备
     */
    @PostMapping("/syncWarnConfigToDevice")
    public AjaxResult syncWarnConfigToDevice(@RequestParam String productSn){
        List<ThinglinksWarnConfig> warnConfigList = thinglinksWarnConfigService.list(new LambdaQueryWrapper<ThinglinksWarnConfig>()
                .eq(ThinglinksWarnConfig::getBelongSn,productSn));
        List<ThinglinksDevice> deviceList = thinglinksDeviceService.list(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getProductSn,productSn));
        deviceList.forEach(device->{
            //删除设备所有规则
            thinglinksWarnConfigService.remove(new LambdaUpdateWrapper<ThinglinksWarnConfig>()
                    .eq(ThinglinksWarnConfig::getBelongSn,device.getDeviceSn())
                    .eq(ThinglinksWarnConfig::getBelongType,"1"));
            //添加新的规则
            warnConfigList.forEach(config->{
                config.setId(IdWorker.getIdStr());
                config.setBelongSn(device.getDeviceSn());
                config.setBelongType("1");
                config.setCreateTime(new Date());
                config.setCreateBy(SecurityUtils.getUsername());
                WarnRule rule =  JSONObject.parseObject(config.getRuleJson(),WarnRule.class);
                rule.setBelongSn(config.getBelongSn());
                rule.setBelongType(config.getBelongType());
                rule.setId(config.getId());
                config.setRuleJson(JSONObject.toJSONString(rule));
            });
            thinglinksWarnConfigService.saveBatch(warnConfigList);
            CacheUtils.updateDeviceWarnRule(device.getDeviceSn());
        });
        return AjaxResult.success();
    }
}
