package com.thinglinks.business.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thinglinks.business.domain.ThinglinksProperties;

/**
 * 物模型属性定义Mapper接口
 *
 * @author thinglinks
 * @date 2025-09-18
 */
public interface ThinglinksPropertiesMapper extends BaseMapper<ThinglinksProperties>
{
    /**
     * 查询物模型属性定义
     *
     * @param id 物模型属性定义主键
     * @return 物模型属性定义
     */
    public ThinglinksProperties selectThinglinksPropertiesById(String id);

    /**
     * 查询物模型属性定义列表
     *
     * @param thinglinksProperties 物模型属性定义
     * @return 物模型属性定义集合
     */
    public List<ThinglinksProperties> selectThinglinksPropertiesList(ThinglinksProperties thinglinksProperties);

    /**
     * 新增物模型属性定义
     *
     * @param thinglinksProperties 物模型属性定义
     * @return 结果
     */
    public int insertThinglinksProperties(ThinglinksProperties thinglinksProperties);

    /**
     * 修改物模型属性定义
     *
     * @param thinglinksProperties 物模型属性定义
     * @return 结果
     */
    public int updateThinglinksProperties(ThinglinksProperties thinglinksProperties);

    /**
     * 删除物模型属性定义
     *
     * @param id 物模型属性定义主键
     * @return 结果
     */
    public int deleteThinglinksPropertiesById(String id);

    /**
     * 批量删除物模型属性定义
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteThinglinksPropertiesByIds(String[] ids);
}
