package com.thinglinks.business.controller;

import java.util.List;
import javax.annotation.PostConstruct;
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
import com.thinglinks.business.domain.ThinglinksWarnRecord;
import com.thinglinks.business.service.IThinglinksWarnRecordService;
import com.thinglinks.common.utils.poi.ExcelUtil;
import com.thinglinks.common.core.page.TableDataInfo;

/**
 * 告警记录Controller
 * 
 * @author thinglinks
 * @date 2025-10-05
 */
@RestController
@RequestMapping("/business/warnRecord")
public class ThinglinksWarnRecordController extends BaseController
{
    @Autowired
    private IThinglinksWarnRecordService thinglinksWarnRecordService;

    /**
     * 查询告警记录列表
     */
    @PreAuthorize("@ss.hasPermi('business:warnRecord:list')")
    @GetMapping("/list")
    public TableDataInfo list(ThinglinksWarnRecord thinglinksWarnRecord)
    {
        QueryWrapper<ThinglinksWarnRecord> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("create_time");
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksWarnRecord.getWarnLevel()),"warn_level",thinglinksWarnRecord.getWarnLevel());
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksWarnRecord.getBelongSn()),"belong_sn",thinglinksWarnRecord.getBelongSn());
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksWarnRecord.getStatus()),"status",thinglinksWarnRecord.getStatus());
        queryWrapper.like(StringUtils.isNotEmpty(thinglinksWarnRecord.getConfigName()),"config_name",thinglinksWarnRecord.getConfigName());
        Page<ThinglinksWarnRecord> page = new Page<ThinglinksWarnRecord>(PageUtils.getPageNum(),PageUtils.getPageSize());
        Page<ThinglinksWarnRecord> pageList = thinglinksWarnRecordService.page(page,queryWrapper);
        return getDataTable(pageList);
    }

    /**
     * 导出告警记录列表
     */
    @PreAuthorize("@ss.hasPermi('business:warnRecord:export')")
    @Log(title = "告警记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ThinglinksWarnRecord thinglinksWarnRecord)
    {
        List<ThinglinksWarnRecord> list = thinglinksWarnRecordService.selectThinglinksWarnRecordList(thinglinksWarnRecord);
        ExcelUtil<ThinglinksWarnRecord> util = new ExcelUtil<ThinglinksWarnRecord>(ThinglinksWarnRecord.class);
        util.exportExcel(response, list, "告警记录数据");
    }

    /**
     * 获取告警记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('business:warnRecord:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id)
    {
        return success(thinglinksWarnRecordService.getById(id));
    }

    /**
     * 新增告警记录
     */
    @PreAuthorize("@ss.hasPermi('business:warnRecord:add')")
    @Log(title = "告警记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ThinglinksWarnRecord thinglinksWarnRecord)
    {
        return toAjax(thinglinksWarnRecordService.insertThinglinksWarnRecord(thinglinksWarnRecord));
    }

    /**
     * 修改告警记录
     */
    @PreAuthorize("@ss.hasPermi('business:warnRecord:edit')")
    @Log(title = "告警记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ThinglinksWarnRecord thinglinksWarnRecord)
    {
        return toAjax(thinglinksWarnRecordService.updateThinglinksWarnRecord(thinglinksWarnRecord));
    }

    /**
     * 删除告警记录
     */
    @PreAuthorize("@ss.hasPermi('business:warnRecord:remove')")
    @Log(title = "告警记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable String[] ids)
    {
        return toAjax(thinglinksWarnRecordService.deleteThinglinksWarnRecordByIds(ids));
    }
}
