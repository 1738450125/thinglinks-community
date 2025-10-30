package com.thinglinks.business.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinglinks.business.mapper.ThinglinksPropertiesMapper;
import com.thinglinks.business.domain.ThinglinksProperties;
import com.thinglinks.business.service.IThinglinksPropertiesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 物模型属性定义Service业务层处理
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@Service
public class ThinglinksPropertiesServiceImpl extends ServiceImpl<ThinglinksPropertiesMapper, ThinglinksProperties> implements IThinglinksPropertiesService {
    @Autowired
    private ThinglinksPropertiesMapper thinglinksPropertiesMapper;

    /**
     * 查询物模型属性定义
     *
     * @param id 物模型属性定义主键
     * @return 物模型属性定义
     */
    @Override
    public ThinglinksProperties selectThinglinksPropertiesById(String id) {
        return thinglinksPropertiesMapper.selectThinglinksPropertiesById(id);
    }

    /**
     * 查询物模型属性定义列表
     *
     * @param thinglinksProperties 物模型属性定义
     * @return 物模型属性定义
     */
    @Override
    public List<ThinglinksProperties> selectThinglinksPropertiesList(ThinglinksProperties thinglinksProperties) {
        return thinglinksPropertiesMapper.selectThinglinksPropertiesList(thinglinksProperties);
    }

    /**
     * 新增物模型属性定义
     *
     * @param thinglinksProperties 物模型属性定义
     * @return 结果
     */
    @Override
    public int insertThinglinksProperties(ThinglinksProperties thinglinksProperties) {
        return thinglinksPropertiesMapper.insertThinglinksProperties(thinglinksProperties);
    }

    /**
     * 修改物模型属性定义
     *
     * @param thinglinksProperties 物模型属性定义
     * @return 结果
     */
    @Override
    public int updateThinglinksProperties(ThinglinksProperties thinglinksProperties) {
        return thinglinksPropertiesMapper.updateThinglinksProperties(thinglinksProperties);
    }

    /**
     * 批量删除物模型属性定义
     *
     * @param ids 需要删除的物模型属性定义主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksPropertiesByIds(String[] ids) {
        return thinglinksPropertiesMapper.deleteThinglinksPropertiesByIds(ids);
    }

    /**
     * 删除物模型属性定义信息
     *
     * @param id 物模型属性定义主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksPropertiesById(String id) {
        return thinglinksPropertiesMapper.deleteThinglinksPropertiesById(id);
    }
}
