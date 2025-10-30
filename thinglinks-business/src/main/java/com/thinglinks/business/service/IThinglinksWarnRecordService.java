package com.thinglinks.business.service;

import java.util.List;
import com.thinglinks.business.domain.ThinglinksWarnRecord;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 告警记录Service接口
 *
 * @author thinglinks
 * @date 2025-10-05
 */
public interface IThinglinksWarnRecordService extends IService<ThinglinksWarnRecord>
{
    /**
     * 查询告警记录
     *
     * @param id 告警记录主键
     * @return 告警记录
     */
    public ThinglinksWarnRecord selectThinglinksWarnRecordById(String id);

    /**
     * 查询告警记录列表
     *
     * @param thinglinksWarnRecord 告警记录
     * @return 告警记录集合
     */
    public List<ThinglinksWarnRecord> selectThinglinksWarnRecordList(ThinglinksWarnRecord thinglinksWarnRecord);

    /**
     * 新增告警记录
     *
     * @param thinglinksWarnRecord 告警记录
     * @return 结果
     */
    public int insertThinglinksWarnRecord(ThinglinksWarnRecord thinglinksWarnRecord);

    /**
     * 修改告警记录
     *
     * @param thinglinksWarnRecord 告警记录
     * @return 结果
     */
    public int updateThinglinksWarnRecord(ThinglinksWarnRecord thinglinksWarnRecord);

    /**
     * 批量删除告警记录
     *
     * @param ids 需要删除的告警记录主键集合
     * @return 结果
     */
    public int deleteThinglinksWarnRecordByIds(String[] ids);

    /**
     * 删除告警记录信息
     *
     * @param id 告警记录主键
     * @return 结果
     */
    public int deleteThinglinksWarnRecordById(String id);
}
