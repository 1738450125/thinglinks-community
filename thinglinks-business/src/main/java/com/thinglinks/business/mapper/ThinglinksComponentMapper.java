package com.thinglinks.business.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thinglinks.business.domain.ThinglinksComponent;

/**
 * 网络组件Mapper接口
 *
 * @author thinglinks
 * @date 2025-09-18
 */
public interface ThinglinksComponentMapper extends BaseMapper<ThinglinksComponent>
{
    /**
     * 查询网络组件
     *
     * @param id 网络组件主键
     * @return 网络组件
     */
    public ThinglinksComponent selectThinglinksComponentById(String id);

    /**
     * 查询网络组件列表
     *
     * @param thinglinksComponent 网络组件
     * @return 网络组件集合
     */
    public List<ThinglinksComponent> selectThinglinksComponentList(ThinglinksComponent thinglinksComponent);

    /**
     * 新增网络组件
     *
     * @param thinglinksComponent 网络组件
     * @return 结果
     */
    public int insertThinglinksComponent(ThinglinksComponent thinglinksComponent);

    /**
     * 修改网络组件
     *
     * @param thinglinksComponent 网络组件
     * @return 结果
     */
    public int updateThinglinksComponent(ThinglinksComponent thinglinksComponent);

    /**
     * 删除网络组件
     *
     * @param id 网络组件主键
     * @return 结果
     */
    public int deleteThinglinksComponentById(String id);

    /**
     * 批量删除网络组件
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteThinglinksComponentByIds(String[] ids);
}
