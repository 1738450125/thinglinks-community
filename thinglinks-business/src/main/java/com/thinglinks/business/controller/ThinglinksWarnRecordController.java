package com.thinglinks.business.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.thinglinks.business.domain.ThinglinksWarnRecord;
import com.thinglinks.business.service.IThinglinksWarnRecordService;
import com.thinglinks.common.annotation.Log;
import com.thinglinks.common.core.controller.BaseController;
import com.thinglinks.common.core.domain.AjaxResult;
import com.thinglinks.common.core.page.TableDataInfo;
import com.thinglinks.common.enums.BusinessType;
import com.thinglinks.common.utils.PageUtils;
import com.thinglinks.common.utils.StringUtils;
import com.thinglinks.common.utils.poi.ExcelUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

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
    @GetMapping("/list")
    public TableDataInfo list(ThinglinksWarnRecord thinglinksWarnRecord)
    {
        QueryWrapper<ThinglinksWarnRecord> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("status");
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
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id)
    {
        return success(thinglinksWarnRecordService.getById(id));
    }

    /**
     * 新增告警记录
     */
    @Log(title = "告警记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ThinglinksWarnRecord thinglinksWarnRecord)
    {
        return toAjax(thinglinksWarnRecordService.insertThinglinksWarnRecord(thinglinksWarnRecord));
    }

    /**
     * 修改告警记录
     */
    @Log(title = "告警记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ThinglinksWarnRecord thinglinksWarnRecord)
    {
        return toAjax(thinglinksWarnRecordService.updateThinglinksWarnRecord(thinglinksWarnRecord));
    }

    /**
     * 删除告警记录
     */
    @Log(title = "告警记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable String[] ids)
    {
        return toAjax(thinglinksWarnRecordService.deleteThinglinksWarnRecordByIds(ids));
    }

    /**
     * 标记处理状态
     */
    @Log(title = "标记处理状态", businessType = BusinessType.UPDATE)
    @PutMapping("/deal/{id}")
    public AjaxResult deal(@PathVariable String id)
    {
        thinglinksWarnRecordService.update(new LambdaUpdateWrapper<ThinglinksWarnRecord>()
                .eq(ThinglinksWarnRecord::getId,id)
                .set(ThinglinksWarnRecord::getStatus,"1")
        );
        return AjaxResult.success();
    }
}
