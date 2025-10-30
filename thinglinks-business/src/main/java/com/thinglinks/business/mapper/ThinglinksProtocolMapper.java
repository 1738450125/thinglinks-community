package com.thinglinks.business.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thinglinks.business.domain.ThinglinksProtocol;

/**
 * 协议管理Mapper接口
 *
 * @author thinglinks
 * @date 2025-09-18
 */
public interface ThinglinksProtocolMapper extends BaseMapper<ThinglinksProtocol>
{
    /**
     * 查询协议管理
     *
     * @param id 协议管理主键
     * @return 协议管理
     */
    public ThinglinksProtocol selectThinglinksProtocolById(String id);

    /**
     * 查询协议管理列表
     *
     * @param thinglinksProtocol 协议管理
     * @return 协议管理集合
     */
    public List<ThinglinksProtocol> selectThinglinksProtocolList(ThinglinksProtocol thinglinksProtocol);

    /**
     * 新增协议管理
     *
     * @param thinglinksProtocol 协议管理
     * @return 结果
     */
    public int insertThinglinksProtocol(ThinglinksProtocol thinglinksProtocol);

    /**
     * 修改协议管理
     *
     * @param thinglinksProtocol 协议管理
     * @return 结果
     */
    public int updateThinglinksProtocol(ThinglinksProtocol thinglinksProtocol);

    /**
     * 删除协议管理
     *
     * @param id 协议管理主键
     * @return 结果
     */
    public int deleteThinglinksProtocolById(String id);

    /**
     * 批量删除协议管理
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteThinglinksProtocolByIds(String[] ids);
}
