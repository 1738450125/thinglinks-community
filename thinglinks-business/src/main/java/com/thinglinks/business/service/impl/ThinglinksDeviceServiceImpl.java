package com.thinglinks.business.service.impl;

import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.thinglinks.business.domain.ThinglinksProperties;
import com.thinglinks.business.service.IThinglinksProductService;
import com.thinglinks.business.service.IThinglinksPropertiesService;
import com.thinglinks.business.utils.PropertyConverter;
import com.thinglinks.component.message.PropertyNode;
import com.thinglinks.component.utils.PropertyToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinglinks.business.mapper.ThinglinksDeviceMapper;
import com.thinglinks.business.domain.ThinglinksDevice;
import com.thinglinks.business.service.IThinglinksDeviceService;
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
}
