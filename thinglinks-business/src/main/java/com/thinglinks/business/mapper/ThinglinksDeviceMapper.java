package com.thinglinks.business.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thinglinks.business.domain.ThinglinksDevice;

/**
 * 设备Mapper接口
 *
 * @author thinglinks
 * @date 2025-09-18
 */
public interface ThinglinksDeviceMapper extends BaseMapper<ThinglinksDevice>
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
     * 删除设备
     *
     * @param id 设备主键
     * @return 结果
     */
    public int deleteThinglinksDeviceById(String id);

    /**
     * 批量删除设备
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteThinglinksDeviceByIds(String[] ids);
}
