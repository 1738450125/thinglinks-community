package com.thinglinks.business.service;

import java.util.List;
import com.thinglinks.business.domain.ThinglinksProduct;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 产品Service接口
 *
 * @author thinglinks
 * @date 2025-09-18
 */
public interface IThinglinksProductService extends IService<ThinglinksProduct>
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
     * 批量删除产品
     *
     * @param ids 需要删除的产品主键集合
     * @return 结果
     */
    public int deleteThinglinksProductByIds(String[] ids);

    /**
     * 删除产品信息
     *
     * @param id 产品主键
     * @return 结果
     */
    public int deleteThinglinksProductById(String id);

    /**
     * 同步产品总设备数量
     */
    public void syncDeviceCount(String productSn);
}
