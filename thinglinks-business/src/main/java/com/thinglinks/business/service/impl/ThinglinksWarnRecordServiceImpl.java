package com.thinglinks.business.service.impl;

import java.util.List;
        import com.thinglinks.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinglinks.business.mapper.ThinglinksWarnRecordMapper;
import com.thinglinks.business.domain.ThinglinksWarnRecord;
import com.thinglinks.business.service.IThinglinksWarnRecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 告警记录Service业务层处理
 *
 * @author thinglinks
 * @date 2025-10-05
 */
@Service
public class ThinglinksWarnRecordServiceImpl extends ServiceImpl<ThinglinksWarnRecordMapper, ThinglinksWarnRecord> implements IThinglinksWarnRecordService
{
    @Autowired
    private ThinglinksWarnRecordMapper thinglinksWarnRecordMapper;

    /**
     * 查询告警记录
     *
     * @param id 告警记录主键
     * @return 告警记录
     */
    @Override
    public ThinglinksWarnRecord selectThinglinksWarnRecordById(String id)
    {
        return thinglinksWarnRecordMapper.selectThinglinksWarnRecordById(id);
    }

    /**
     * 查询告警记录列表
     *
     * @param thinglinksWarnRecord 告警记录
     * @return 告警记录
     */
    @Override
    public List<ThinglinksWarnRecord> selectThinglinksWarnRecordList(ThinglinksWarnRecord thinglinksWarnRecord)
    {
        return thinglinksWarnRecordMapper.selectThinglinksWarnRecordList(thinglinksWarnRecord);
    }

    /**
     * 新增告警记录
     *
     * @param thinglinksWarnRecord 告警记录
     * @return 结果
     */
    @Override
    public int insertThinglinksWarnRecord(ThinglinksWarnRecord thinglinksWarnRecord)
    {
        thinglinksWarnRecord.setCreateTime(DateUtils.getNowDate());
        return thinglinksWarnRecordMapper.insertThinglinksWarnRecord(thinglinksWarnRecord);
    }

    /**
     * 修改告警记录
     *
     * @param thinglinksWarnRecord 告警记录
     * @return 结果
     */
    @Override
    public int updateThinglinksWarnRecord(ThinglinksWarnRecord thinglinksWarnRecord)
    {
        return thinglinksWarnRecordMapper.updateThinglinksWarnRecord(thinglinksWarnRecord);
    }

    /**
     * 批量删除告警记录
     *
     * @param ids 需要删除的告警记录主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksWarnRecordByIds(String[] ids)
    {
        return thinglinksWarnRecordMapper.deleteThinglinksWarnRecordByIds(ids);
    }

    /**
     * 删除告警记录信息
     *
     * @param id 告警记录主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksWarnRecordById(String id)
    {
        return thinglinksWarnRecordMapper.deleteThinglinksWarnRecordById(id);
    }
}
