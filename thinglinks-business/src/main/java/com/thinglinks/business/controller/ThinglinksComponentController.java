package com.thinglinks.business.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.thinglinks.business.domain.ThinglinksProtocol;
import com.thinglinks.business.service.IThinglinksProtocolService;
import com.thinglinks.common.annotation.Anonymous;
import com.thinglinks.common.exception.CommonWarnException;
import com.thinglinks.common.utils.PageUtils;
import com.thinglinks.common.utils.StringUtils;
import com.thinglinks.component.utils.PortChecker;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import com.thinglinks.common.core.controller.BaseController;
import com.thinglinks.common.core.domain.AjaxResult;
import com.thinglinks.business.domain.ThinglinksComponent;
import com.thinglinks.business.service.IThinglinksComponentService;
import com.thinglinks.common.utils.poi.ExcelUtil;
import com.thinglinks.common.core.page.TableDataInfo;

/**
 * 网络组件Controller
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@RestController
@RequestMapping("/business/component")
public class ThinglinksComponentController extends BaseController
{
    @Autowired
    private IThinglinksComponentService thinglinksComponentService;
    @Autowired
    private IThinglinksProtocolService thinglinksProtocolService;

    /**
     * 查询网络组件列表
     */
    @GetMapping("/list")
    public TableDataInfo list(ThinglinksComponent thinglinksComponent)
    {
        QueryWrapper<ThinglinksComponent> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("create_time");
        Page<ThinglinksComponent> page = new Page<ThinglinksComponent>(PageUtils.getPageNum(),PageUtils.getPageSize());
        Page<ThinglinksComponent> pageList = thinglinksComponentService.page(page,queryWrapper);
        return getDataTable(pageList.getRecords());
    }

    /**
     * 导出网络组件列表
     */
    @PostMapping("/export")
    public void export(HttpServletResponse response, ThinglinksComponent thinglinksComponent)
    {
        List<ThinglinksComponent> list = thinglinksComponentService.selectThinglinksComponentList(thinglinksComponent);
        ExcelUtil<ThinglinksComponent> util = new ExcelUtil<ThinglinksComponent>(ThinglinksComponent.class);
        util.exportExcel(response, list, "网络组件数据");
    }

    /**
     * 获取网络组件详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id)
    {
        return success(thinglinksComponentService.getById(id));
    }

    /**
     * 新增网络组件
     */
    @PostMapping
    @Transactional(rollbackFor = Exception.class)
    public AjaxResult add(@RequestBody ThinglinksComponent thinglinksComponent) throws IOException, CommonWarnException {
        thinglinksComponentService.save(thinglinksComponent);
        if("1".equals(thinglinksComponent.getStatus())) {
            boolean isOk = thinglinksComponentService.openComponent(thinglinksComponent.getId());
            if (!isOk) {
                return AjaxResult.error("开启失败，请检查参数是否错误，端口是否占用");
            }
            if (StringUtils.isNotEmpty(thinglinksComponent.getProtocolId())) {
                bindProtocol(thinglinksComponent.getId(), thinglinksComponent.getProtocolId());
            }
        }
        return success();
    }

    /**
     * 修改网络组件
     */
    @PutMapping
    @Transactional(rollbackFor = Exception.class)
    public AjaxResult edit(@RequestBody ThinglinksComponent thinglinksComponent) throws CommonWarnException, IOException, MqttException {
        thinglinksComponentService.updateById(thinglinksComponent);
        if("1".equals(thinglinksComponent.getStatus())) {
            thinglinksComponentService.closeComponent(thinglinksComponent.getId());
            boolean isOk = thinglinksComponentService.openComponent(thinglinksComponent.getId());
            if (!isOk) {
                return AjaxResult.error("修改失败，请检查参数是否错误，端口是否占用");
            }
            if(StringUtils.isNotEmpty(thinglinksComponent.getProtocolId())){
                bindProtocol(thinglinksComponent.getId(),thinglinksComponent.getProtocolId());
            }
        }
        return AjaxResult.success();
    }

    /**
     * 删除网络组件
     */
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable String[] ids)
    {
        //先检查是否已经关闭
        List<String> idList = Arrays.asList(ids);
        long openCount = thinglinksComponentService.count(new LambdaQueryWrapper<ThinglinksComponent>()
                .in(ThinglinksComponent::getId,idList)
                .eq(ThinglinksComponent::getStatus,"1"));
        if(openCount>0){
            return AjaxResult.error("请先停用网络组件再删除");
        }
        thinglinksComponentService.removeBatchByIds(idList);
        return AjaxResult.success("删除成功");
    }

    /**
     * 开关网络组件
     * @param status 0-关 1-开
     */
    @PutMapping("/control")
    public AjaxResult controlComponent(@RequestParam String id,
                                       @RequestParam String status) throws MqttException, IOException, CommonWarnException {
        if("0".equals(status)){
            thinglinksComponentService.closeComponent(id);
        }else {
            thinglinksComponentService.openComponent(id);
        }
        return AjaxResult.success();
    }

    /**
     * 绑定协议
     * @param componentId 组件id
     * @param protocolId 协议id
     */
    @PutMapping("/bindProtocol")
    public AjaxResult bindProtocol(String componentId,String protocolId){
        if(StringUtils.isNotEmpty(componentId)&&StringUtils.isNotEmpty(protocolId)){
            ThinglinksComponent component = thinglinksComponentService.getById(componentId);
            if(component==null){
                return AjaxResult.error("网络组件不存在");
            }
            thinglinksComponentService.update(new LambdaUpdateWrapper<ThinglinksComponent>()
                    .eq(ThinglinksComponent::getId,componentId)
                    .set(ThinglinksComponent::getProtocolId,protocolId));
            thinglinksProtocolService.update(new LambdaUpdateWrapper<ThinglinksProtocol>()
                    .eq(ThinglinksProtocol::getId,protocolId)
                    .set(ThinglinksProtocol::getComponentId,componentId)
                    .set(ThinglinksProtocol::getComponentName,component.getName()));
            return AjaxResult.success("绑定成功");
        }else {
            return AjaxResult.error("请选择正确的网络组件和协议");
        }
    }

    /**
     * 检查端口占用
     */
    @PostMapping("/checkPort")
    public AjaxResult checkPort(@RequestParam Integer port){
        if(PortChecker.isLocalPortAvailable(port)){
            return AjaxResult.success("端口处于空闲状态");
        }else {
            return AjaxResult.error("端口已被占用，请选择其他端口");
        }
    }

}
