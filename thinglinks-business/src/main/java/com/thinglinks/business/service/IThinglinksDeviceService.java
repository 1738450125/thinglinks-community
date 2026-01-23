package com.thinglinks.business.service;

import java.util.List;
import com.thinglinks.business.domain.ThinglinksDevice;
import com.baomidou.mybatisplus.extension.service.IService;
import com.thinglinks.common.core.domain.AjaxResult;

/**
 * 设备Service接口
 *
 * @author thinglinks
 * @date 2025-09-18
 */
public interface IThinglinksDeviceService extends IService<ThinglinksDevice>
{
    /**
     * 查询设备
     *
     * @param id 设备主键
     * @return 设备
     */
    public ThinglinksDevice selectThinglinksDeviceById(String id);

    /**
     * 查询设备列表
     *
     * @param thinglinksDevice 设备
     * @return 设备集合
     */
    public List<ThinglinksDevice> selectThinglinksDeviceList(ThinglinksDevice thinglinksDevice);

    /**
     * 新增设备
     *
     * @param thinglinksDevice 设备
     * @return 结果
     */
    public int insertThinglinksDevice(ThinglinksDevice thinglinksDevice);

    /**
     * 修改设备
     *
     * @param thinglinksDevice 设备
     * @return 结果
     */
    public int updateThinglinksDevice(ThinglinksDevice thinglinksDevice);

    /**
     * 批量删除设备
     *
     * @param ids 需要删除的设备主键集合
     * @return 结果
     */
    public int deleteThinglinksDeviceByIds(String[] ids);

    /**
     * 删除设备信息
     *
     * @param id 设备主键
     * @return 结果
     */
    public int deleteThinglinksDeviceById(String id);

    /**
     * 缓存设备属性
     */
    public boolean cacheDeviceProperties(String deviceSn);

    /**
     * 同步产品物模型属性到设备
     */
    public boolean syncPropertyToDevice(String deviceSn);
    /**
     * 同步指令到设备
     * @return
     */
    public boolean syncProductToDevice(String deviceSn);
    /**
     * 新增设备
     */
    public AjaxResult saveDevice(ThinglinksDevice device);
}
