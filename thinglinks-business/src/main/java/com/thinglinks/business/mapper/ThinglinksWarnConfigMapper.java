package com.thinglinks.business.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thinglinks.business.domain.ThinglinksWarnConfig;

/**
 * 告警配置Mapper接口
 *
 * @author thinglinks
 * @date 2025-10-05
 */
public interface ThinglinksWarnConfigMapper extends BaseMapper<ThinglinksWarnConfig>
{
    /**
     * 查询告警配置
     *
     * @param id 告警配置主键
     * @return 告警配置
     */
    public ThinglinksWarnConfig selectThinglinksWarnConfigById(String id);

    /**
     * 查询告警配置列表
     *
     * @param thinglinksWarnConfig 告警配置
     * @return 告警配置集合
     */
    public List<ThinglinksWarnConfig> selectThinglinksWarnConfigList(ThinglinksWarnConfig thinglinksWarnConfig);

    /**
     * 新增告警配置
     *
     * @param thinglinksWarnConfig 告警配置
     * @return 结果
     */
    public int insertThinglinksWarnConfig(ThinglinksWarnConfig thinglinksWarnConfig);

    /**
     * 修改告警配置
     *
     * @param thinglinksWarnConfig 告警配置
     * @return 结果
     */
    public int updateThinglinksWarnConfig(ThinglinksWarnConfig thinglinksWarnConfig);

    /**
     * 删除告警配置
     *
     * @param id 告警配置主键
     * @return 结果
     */
    public int deleteThinglinksWarnConfigById(String id);

    /**
     * 批量删除告警配置
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteThinglinksWarnConfigByIds(String[] ids);
}
