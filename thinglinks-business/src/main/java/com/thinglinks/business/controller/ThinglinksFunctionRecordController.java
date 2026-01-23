package com.thinglinks.business.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.thinglinks.common.utils.StringUtils;
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
import com.thinglinks.business.domain.ThinglinksFunctionRecord;
import com.thinglinks.business.service.IThinglinksFunctionRecordService;
import com.thinglinks.common.utils.poi.ExcelUtil;
import com.thinglinks.common.core.page.TableDataInfo;

/**
 * 指令下发记录Controller
 *
 * @author ruoyi
 * @date 2025-10-29
 */
@RestController
@RequestMapping("/business/functionRecord")
public class ThinglinksFunctionRecordController extends BaseController
{
    @Autowired
    private IThinglinksFunctionRecordService ThinglinksFunctionRecordService;

    /**
     * 查询指令下发记录列表
     */
    @GetMapping("/list")
    public TableDataInfo list(ThinglinksFunctionRecord thinglinksFunctionRecord)
    {
        QueryWrapper<ThinglinksFunctionRecord> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("create_time");
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksFunctionRecord.getFunctionCode()),"function_code", thinglinksFunctionRecord.getFunctionCode());
        queryWrapper.eq(StringUtils.isNotEmpty(thinglinksFunctionRecord.getDeviceSn()),"device_sn", thinglinksFunctionRecord.getDeviceSn());
        Page<ThinglinksFunctionRecord> page = new Page<ThinglinksFunctionRecord>(PageUtils.getPageNum(),PageUtils.getPageSize());
        Page<ThinglinksFunctionRecord> pageList = ThinglinksFunctionRecordService.page(page,queryWrapper);
        return getDataTable(pageList);
    }

    /**
     * 导出指令下发记录列表
     */
    @Log(title = "指令下发记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ThinglinksFunctionRecord thinglinksFunctionRecord)
    {
        List<ThinglinksFunctionRecord> list = ThinglinksFunctionRecordService.selectThinglinksFunctionRecordList(thinglinksFunctionRecord);
        ExcelUtil<ThinglinksFunctionRecord> util = new ExcelUtil<ThinglinksFunctionRecord>(ThinglinksFunctionRecord.class);
        util.exportExcel(response, list, "指令下发记录数据");
    }

    /**
     * 获取指令下发记录详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id)
    {
        return success(ThinglinksFunctionRecordService.getById(id));
    }

    /**
     * 新增指令下发记录
     */
    @Log(title = "指令下发记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ThinglinksFunctionRecord thinglinksFunctionRecord)
    {
        return toAjax(ThinglinksFunctionRecordService.save(thinglinksFunctionRecord));
    }

    /**
     * 修改指令下发记录
     */
    @Log(title = "指令下发记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ThinglinksFunctionRecord thinglinksFunctionRecord)
    {
        return toAjax(ThinglinksFunctionRecordService.updateById(thinglinksFunctionRecord));
    }

    /**
     * 删除指令下发记录
     */
    @Log(title = "指令下发记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable String[] ids)
    {
        return toAjax(ThinglinksFunctionRecordService.deleteThinglinksFunctionRecordByIds(ids));
    }
}
