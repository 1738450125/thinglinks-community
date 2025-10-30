package com.thinglinks.business.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.thinglinks.common.utils.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
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
import com.thinglinks.business.domain.ThinglinksDeviceLogs;
import com.thinglinks.business.service.IThinglinksDeviceLogsService;
import com.thinglinks.common.utils.poi.ExcelUtil;
import com.thinglinks.common.core.page.TableDataInfo;

/**
 * 设备日志Controller
 * 
 * @author thinglinks
 * @date 2025-09-22
 */
@RestController
@RequestMapping("/business/deviceLogs")
public class ThinglinksDeviceLogsController extends BaseController
{
    @Autowired
    private IThinglinksDeviceLogsService thinglinksDeviceLogsService;

    /**
     * 查询设备日志列表
     */
    @PreAuthorize("@ss.hasPermi('business:logs:list')")
    @GetMapping("/list")
    public TableDataInfo list(ThinglinksDeviceLogs thinglinksDeviceLogs)
    {
        QueryWrapper<ThinglinksDeviceLogs> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("create_time");
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksDeviceLogs.getLogType()),"log_type",thinglinksDeviceLogs.getLogType());
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksDeviceLogs.getDeviceSn()),"device_sn",thinglinksDeviceLogs.getDeviceSn());
        Page<ThinglinksDeviceLogs> page = new Page<ThinglinksDeviceLogs>(PageUtils.getPageNum(),PageUtils.getPageSize());
        Page<ThinglinksDeviceLogs> pageList = thinglinksDeviceLogsService.page(page,queryWrapper);
        return getDataTable(pageList);
    }

    /**
     * 导出设备日志列表
     */
    @PreAuthorize("@ss.hasPermi('business:logs:export')")
    @Log(title = "设备日志", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ThinglinksDeviceLogs thinglinksDeviceLogs)
    {
        List<ThinglinksDeviceLogs> list = thinglinksDeviceLogsService.selectThinglinksDeviceLogsList(thinglinksDeviceLogs);
        ExcelUtil<ThinglinksDeviceLogs> util = new ExcelUtil<ThinglinksDeviceLogs>(ThinglinksDeviceLogs.class);
        util.exportExcel(response, list, "设备日志数据");
    }

    /**
     * 获取设备日志详细信息
     */
    @PreAuthorize("@ss.hasPermi('business:logs:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(thinglinksDeviceLogsService.getById(id));
    }

    /**
     * 新增设备日志
     */
    @PreAuthorize("@ss.hasPermi('business:logs:add')")
    @Log(title = "设备日志", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ThinglinksDeviceLogs thinglinksDeviceLogs)
    {
        return toAjax(thinglinksDeviceLogsService.insertThinglinksDeviceLogs(thinglinksDeviceLogs));
    }

    /**
     * 修改设备日志
     */
    @PreAuthorize("@ss.hasPermi('business:logs:edit')")
    @Log(title = "设备日志", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ThinglinksDeviceLogs thinglinksDeviceLogs)
    {
        return toAjax(thinglinksDeviceLogsService.updateThinglinksDeviceLogs(thinglinksDeviceLogs));
    }

    /**
     * 删除设备日志
     */
    @PreAuthorize("@ss.hasPermi('business:logs:remove')")
    @Log(title = "设备日志", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(thinglinksDeviceLogsService.deleteThinglinksDeviceLogsByIds(ids));
    }
}
