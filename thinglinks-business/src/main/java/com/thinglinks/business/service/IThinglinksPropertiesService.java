package com.thinglinks.business.service;

import java.util.List;
import com.thinglinks.business.domain.ThinglinksProperties;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 物模型属性定义Service接口
 *
 * @author thinglinks
 * @date 2025-09-18
 */
public interface IThinglinksPropertiesService extends IService<ThinglinksProperties>
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
     * 批量删除物模型属性定义
     *
     * @param ids 需要删除的物模型属性定义主键集合
     * @return 结果
     */
    public int deleteThinglinksPropertiesByIds(String[] ids);

    /**
     * 删除物模型属性定义信息
     *
     * @param id 物模型属性定义主键
     * @return 结果
     */
    public int deleteThinglinksPropertiesById(String id);
}
