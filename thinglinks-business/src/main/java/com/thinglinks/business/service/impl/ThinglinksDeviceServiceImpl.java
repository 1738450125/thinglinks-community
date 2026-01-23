package com.thinglinks.business.service.impl;

import java.util.Date;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.thinglinks.business.domain.ThinglinksFunction;
import com.thinglinks.business.domain.ThinglinksProduct;
import com.thinglinks.business.domain.ThinglinksProperties;
import com.thinglinks.business.service.*;
import com.thinglinks.business.utils.CacheUtils;
import com.thinglinks.business.utils.PropertyConverter;
import com.thinglinks.common.core.domain.AjaxResult;
import com.thinglinks.common.utils.SecurityUtils;
import com.thinglinks.common.utils.StringUtils;
import com.thinglinks.component.message.PropertyNode;
import com.thinglinks.component.utils.PropertyToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinglinks.business.mapper.ThinglinksDeviceMapper;
import com.thinglinks.business.domain.ThinglinksDevice;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 设备Service业务层处理
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@Service
public class ThinglinksDeviceServiceImpl extends ServiceImpl<ThinglinksDeviceMapper, ThinglinksDevice> implements IThinglinksDeviceService {
    @Autowired
    private ThinglinksDeviceMapper thinglinksDeviceMapper;
    @Autowired
    private IThinglinksPropertiesService thinglinksPropertiesService;
    @Autowired
    private IThinglinksProductService thinglinksProductService;
    @Autowired
    private IThinglinksWarnConfigService thinglinksWarnConfigService;
    @Autowired
    private IThinglinksFunctionService thinglinksFunctionService;
    /**
     * 查询设备
     *
     * @param id 设备主键
     * @return 设备
     */
    @Override
    public ThinglinksDevice selectThinglinksDeviceById(String id) {
        return thinglinksDeviceMapper.selectThinglinksDeviceById(id);
    }

    /**
     * 查询设备列表
     *
     * @param thinglinksDevice 设备
     * @return 设备
     */
    @Override
    public List<ThinglinksDevice> selectThinglinksDeviceList(ThinglinksDevice thinglinksDevice) {
        return thinglinksDeviceMapper.selectThinglinksDeviceList(thinglinksDevice);
    }

    /**
     * 新增设备
     *
     * @param thinglinksDevice 设备
     * @return 结果
     */
    @Override
    public int insertThinglinksDevice(ThinglinksDevice thinglinksDevice) {
        return thinglinksDeviceMapper.insertThinglinksDevice(thinglinksDevice);
    }

    /**
     * 修改设备
     *
     * @param thinglinksDevice 设备
     * @return 结果
     */
    @Override
    public int updateThinglinksDevice(ThinglinksDevice thinglinksDevice) {
        return thinglinksDeviceMapper.updateThinglinksDevice(thinglinksDevice);
    }

    /**
     * 批量删除设备
     *
     * @param ids 需要删除的设备主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksDeviceByIds(String[] ids) {
        return thinglinksDeviceMapper.deleteThinglinksDeviceByIds(ids);
    }

    /**
     * 删除设备信息
     *
     * @param id 设备主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksDeviceById(String id) {
        return thinglinksDeviceMapper.deleteThinglinksDeviceById(id);
    }

    /**
     * 缓存设备属性
     */
    @Override
    public boolean cacheDeviceProperties(String deviceSn) {
        //查询设备全部属性
        List<ThinglinksProperties> properties = thinglinksPropertiesService.list(new LambdaQueryWrapper<ThinglinksProperties>()
                .eq(ThinglinksProperties::getBelongSn,deviceSn));
        List<PropertyNode> nodeList = PropertyConverter.buildPropertyTree(properties);
        PropertyToJson.PROPERTY_TREE.put(deviceSn,nodeList);
        return true;
    }

    @Override
    public boolean syncPropertyToDevice(String deviceSn) {
        ThinglinksDevice device = thinglinksDeviceMapper.selectOne(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getDeviceSn,deviceSn));
        List<ThinglinksProperties> properties = thinglinksPropertiesService.list(new LambdaQueryWrapper<ThinglinksProperties>()
                .eq(ThinglinksProperties::getBelongSn,device.getProductSn()));
        properties.forEach(property->{
            property.setId(null);
            property.setBelongType("1");
            property.setBelongSn(deviceSn);
            property.setFromType("0");
        });
        thinglinksPropertiesService.saveBatch(properties);
        cacheDeviceProperties(deviceSn);
        return true;
    }

    @Override
    public AjaxResult saveDevice(ThinglinksDevice thinglinksDevice) {
        if(StringUtils.isEmpty(thinglinksDevice.getProductId())){
            return AjaxResult.error("请选择产品");
        }
        //不可与产品sn重复
        long count = thinglinksProductService.count(new LambdaQueryWrapper<ThinglinksProduct>()
                .eq(ThinglinksProduct::getProductSn,thinglinksDevice.getDeviceSn()));
        if(count>0){
            return AjaxResult.warn("设备sn已经被产品使用，请更换设备sn");
        }
        ThinglinksProduct thinglinksProduct = thinglinksProductService.getById(thinglinksDevice.getProductId());
        thinglinksDevice.setProductName(thinglinksProduct.getProductName());
        thinglinksDevice.setProductSn(thinglinksProduct.getProductSn());
        thinglinksDevice.setCreateTime(new Date());
        thinglinksDevice.setCreateBy(SecurityUtils.getUsername());
        thinglinksDevice.setId(null);
        thinglinksDevice.setDeviceType(thinglinksProduct.getDeviceType());
        thinglinksDevice.setComponentId(thinglinksProduct.getComponentId());
        thinglinksDevice.setComponentName(thinglinksProduct.getComponentName());
        thinglinksDevice.setProtocolId(thinglinksProduct.getProtocolId());
        thinglinksDevice.setProtocolName(thinglinksProduct.getProtocolName());
        baseMapper.insert(thinglinksDevice);
        syncPropertyToDevice(thinglinksDevice.getDeviceSn());
        thinglinksWarnConfigService.syncWarnConfigToDevice(thinglinksProduct.getProductSn(),thinglinksDevice.getDeviceSn());
        thinglinksProductService.syncDeviceCount(thinglinksProduct.getProductSn());
        syncProductToDevice(thinglinksDevice.getDeviceSn());
        CacheUtils.updateDeviceCache(thinglinksDevice.getDeviceSn());
        return AjaxResult.success();
    }

    @Override
    public boolean syncProductToDevice(String deviceSn) {
        ThinglinksDevice device = thinglinksDeviceMapper.selectOne(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getDeviceSn,deviceSn));
        List<ThinglinksFunction> functionList = thinglinksFunctionService.list(new LambdaQueryWrapper<ThinglinksFunction>()
                .eq(ThinglinksFunction::getBelongSn,device.getProductSn()));
        functionList.forEach(property->{
            property.setId(null);
            property.setBelongType("1");
            property.setBelongSn(deviceSn);
            property.setCreateTime(new Date());
        });
        thinglinksFunctionService.saveBatch(functionList);
        CacheUtils.setDeviceFunctionCache(deviceSn,functionList);
        return true;
    }
}
