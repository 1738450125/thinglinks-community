package com.thinglinks.business.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thinglinks.business.domain.ThinglinksDeviceLogs;

/**
 * 设备日志Mapper接口
 *
 * @author thinglinks
 * @date 2025-09-22
 */
public interface ThinglinksDeviceLogsMapper extends BaseMapper<ThinglinksDeviceLogs>
{
    /**
     * 查询设备日志
     *
     * @param id 设备日志主键
     * @return 设备日志
     */
    public ThinglinksDeviceLogs selectThinglinksDeviceLogsById(Long id);

    /**
     * 查询设备日志列表
     *
     * @param thinglinksDeviceLogs 设备日志
     * @return 设备日志集合
     */
    public List<ThinglinksDeviceLogs> selectThinglinksDeviceLogsList(ThinglinksDeviceLogs thinglinksDeviceLogs);

    /**
     * 新增设备日志
     *
     * @param thinglinksDeviceLogs 设备日志
     * @return 结果
     */
    public int insertThinglinksDeviceLogs(ThinglinksDeviceLogs thinglinksDeviceLogs);

    /**
     * 修改设备日志
     *
     * @param thinglinksDeviceLogs 设备日志
     * @return 结果
     */
    public int updateThinglinksDeviceLogs(ThinglinksDeviceLogs thinglinksDeviceLogs);

    /**
     * 删除设备日志
     *
     * @param id 设备日志主键
     * @return 结果
     */
    public int deleteThinglinksDeviceLogsById(Long id);

    /**
     * 批量删除设备日志
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteThinglinksDeviceLogsByIds(Long[] ids);
}
