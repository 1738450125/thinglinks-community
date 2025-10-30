package com.thinglinks.business.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thinglinks.business.domain.ThinglinksProduct;

/**
 * 产品Mapper接口
 *
 * @author thinglinks
 * @date 2025-09-18
 */
public interface ThinglinksProductMapper extends BaseMapper<ThinglinksProduct>
{
    /**
     * 查询产品
     *
     * @param id 产品主键
     * @return 产品
     */
    public ThinglinksProduct selectThinglinksProductById(String id);

    /**
     * 查询产品列表
     *
     * @param thinglinksProduct 产品
     * @return 产品集合
     */
    public List<ThinglinksProduct> selectThinglinksProductList(ThinglinksProduct thinglinksProduct);

    /**
     * 新增产品
     *
     * @param thinglinksProduct 产品
     * @return 结果
     */
    public int insertThinglinksProduct(ThinglinksProduct thinglinksProduct);

    /**
     * 修改产品
     *
     * @param thinglinksProduct 产品
     * @return 结果
     */
    public int updateThinglinksProduct(ThinglinksProduct thinglinksProduct);

    /**
     * 删除产品
     *
     * @param id 产品主键
     * @return 结果
     */
    public int deleteThinglinksProductById(String id);

    /**
     * 批量删除产品
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteThinglinksProductByIds(String[] ids);
}
