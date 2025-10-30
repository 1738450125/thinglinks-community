package com.thinglinks.business.service;

import java.util.List;
import com.thinglinks.business.domain.ThinglinksDeviceLogs;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 设备日志Service接口
 *
 * @author thinglinks
 * @date 2025-09-22
 */
public interface IThinglinksDeviceLogsService extends IService<ThinglinksDeviceLogs>
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
     * 批量删除设备日志
     *
     * @param ids 需要删除的设备日志主键集合
     * @return 结果
     */
    public int deleteThinglinksDeviceLogsByIds(Long[] ids);

    /**
     * 删除设备日志信息
     *
     * @param id 设备日志主键
     * @return 结果
     */
    public int deleteThinglinksDeviceLogsById(Long id);
}
