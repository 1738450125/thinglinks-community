package com.thinglinks.business.service.impl;

import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.thinglinks.business.domain.ThinglinksDevice;
import com.thinglinks.business.service.IThinglinksDeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinglinks.business.mapper.ThinglinksProductMapper;
import com.thinglinks.business.domain.ThinglinksProduct;
import com.thinglinks.business.service.IThinglinksProductService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 产品Service业务层处理
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@Service
public class ThinglinksProductServiceImpl extends ServiceImpl<ThinglinksProductMapper, ThinglinksProduct> implements IThinglinksProductService
{
    @Autowired
    private ThinglinksProductMapper thinglinksProductMapper;
    @Autowired
    private IThinglinksDeviceService thinglinksDeviceService;
    /**
     * 查询产品
     *
     * @param id 产品主键
     * @return 产品
     */
    @Override
    public ThinglinksProduct selectThinglinksProductById(String id)
    {
        return thinglinksProductMapper.selectThinglinksProductById(id);
    }

    /**
     * 查询产品列表
     *
     * @param thinglinksProduct 产品
     * @return 产品
     */
    @Override
    public List<ThinglinksProduct> selectThinglinksProductList(ThinglinksProduct thinglinksProduct)
    {
        return thinglinksProductMapper.selectThinglinksProductList(thinglinksProduct);
    }

    /**
     * 新增产品
     *
     * @param thinglinksProduct 产品
     * @return 结果
     */
    @Override
    public int insertThinglinksProduct(ThinglinksProduct thinglinksProduct)
    {
            return thinglinksProductMapper.insertThinglinksProduct(thinglinksProduct);
    }

    /**
     * 修改产品
     *
     * @param thinglinksProduct 产品
     * @return 结果
     */
    @Override
    public int updateThinglinksProduct(ThinglinksProduct thinglinksProduct)
    {
        return thinglinksProductMapper.updateThinglinksProduct(thinglinksProduct);
    }

    /**
     * 批量删除产品
     *
     * @param ids 需要删除的产品主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksProductByIds(String[] ids)
    {
        return thinglinksProductMapper.deleteThinglinksProductByIds(ids);
    }

    /**
     * 删除产品信息
     *
     * @param id 产品主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksProductById(String id)
    {
        return thinglinksProductMapper.deleteThinglinksProductById(id);
    }

    @Override
    public void syncDeviceCount(String productSn) {
        long countDevice = thinglinksDeviceService.count(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getProductSn,productSn));
        ThinglinksProduct thinglinksProduct = new ThinglinksProduct();
        thinglinksProduct.setProductSn(productSn);
        thinglinksProduct.setDeviceCount(countDevice);
        thinglinksProductMapper.update(thinglinksProduct,new LambdaUpdateWrapper<ThinglinksProduct>()
                .eq(ThinglinksProduct::getProductSn,thinglinksProduct.getProductSn())
                .set(ThinglinksProduct::getDeviceCount,thinglinksProduct.getDeviceCount()));
    }
}
