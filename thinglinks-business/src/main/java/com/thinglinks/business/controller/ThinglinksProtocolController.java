package com.thinglinks.business.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.thinglinks.business.domain.ThinglinksComponent;
import com.thinglinks.business.service.IThinglinksComponentService;
import com.thinglinks.common.annotation.Anonymous;
import com.thinglinks.common.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.thinglinks.common.annotation.Log;
import com.thinglinks.common.core.controller.BaseController;
import com.thinglinks.common.core.domain.AjaxResult;
import com.thinglinks.common.enums.BusinessType;
import com.thinglinks.business.domain.ThinglinksProtocol;
import com.thinglinks.business.service.IThinglinksProtocolService;
import com.thinglinks.common.utils.poi.ExcelUtil;
import com.thinglinks.common.core.page.TableDataInfo;
import org.springframework.web.multipart.MultipartFile;

/**
 * 协议管理Controller
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@RestController
@RequestMapping("/business/protocol")
public class ThinglinksProtocolController extends BaseController
{
    @Autowired
    private IThinglinksProtocolService thinglinksProtocolService;
    @Autowired
    private IThinglinksComponentService thinglinksComponentService;
    /**
     * 查询协议管理列表
     */
    @GetMapping("/list")
    public TableDataInfo list(ThinglinksProtocol thinglinksProtocol)
    {
        QueryWrapper<ThinglinksProtocol> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("create_time");
        Page<ThinglinksProtocol> page = new Page<ThinglinksProtocol>(PageUtils.getPageNum(),PageUtils.getPageSize());
        Page<ThinglinksProtocol> pageList = thinglinksProtocolService.page(page,queryWrapper);
        return getDataTable(pageList);
    }

    /**
     * 导出协议管理列表
     */
    @PostMapping("/export")
    public void export(HttpServletResponse response, ThinglinksProtocol thinglinksProtocol)
    {
        List<ThinglinksProtocol> list = thinglinksProtocolService.selectThinglinksProtocolList(thinglinksProtocol);
        ExcelUtil<ThinglinksProtocol> util = new ExcelUtil<ThinglinksProtocol>(ThinglinksProtocol.class);
        util.exportExcel(response, list, "协议管理数据");
    }

    /**
     * 获取协议管理详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id)
    {
        return success(thinglinksProtocolService.getById(id));
    }

    /**
     * 新增协议管理
     */
    @PostMapping
    public AjaxResult add(ThinglinksProtocol thinglinksProtocol, MultipartFile protocolFile) throws Exception {
        return AjaxResult.success(thinglinksProtocolService.insertThinglinksProtocol(thinglinksProtocol,protocolFile));
    }

    /**
     * 修改协议管理
     */
    @PutMapping
    public AjaxResult edit(ThinglinksProtocol thinglinksProtocol, MultipartFile protocolFile) throws Exception {
        return toAjax(thinglinksProtocolService.updateThinglinksProtocol(thinglinksProtocol,protocolFile));
    }

    /**
     * 删除协议管理
     */
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable String id)
    {
        List<ThinglinksComponent> list = thinglinksComponentService.list(new LambdaQueryWrapper<ThinglinksComponent>()
                .eq(ThinglinksComponent::getProtocolId,id));
        if(list!=null&&!list.isEmpty()){
            List<String> names = list.stream().map(ThinglinksComponent::getName).collect(Collectors.toList());
            return AjaxResult.warn("删除失败，以下网络组件使用了该协议："+String.join(",",names));
        }
        return toAjax(thinglinksProtocolService.removeById(id));
    }
}
