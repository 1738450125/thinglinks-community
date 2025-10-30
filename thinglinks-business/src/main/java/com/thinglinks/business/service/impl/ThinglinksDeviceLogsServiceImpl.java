package com.thinglinks.business.service.impl;

import java.util.List;

import com.thinglinks.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinglinks.business.mapper.ThinglinksDeviceLogsMapper;
import com.thinglinks.business.domain.ThinglinksDeviceLogs;
import com.thinglinks.business.service.IThinglinksDeviceLogsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 设备日志Service业务层处理
 *
 * @author thinglinks
 * @date 2025-09-22
 */
@Service
public class ThinglinksDeviceLogsServiceImpl extends ServiceImpl<ThinglinksDeviceLogsMapper, ThinglinksDeviceLogs> implements IThinglinksDeviceLogsService {
    @Autowired
    private ThinglinksDeviceLogsMapper thinglinksDeviceLogsMapper;

    /**
     * 查询设备日志
     *
     * @param id 设备日志主键
     * @return 设备日志
     */
    @Override
    public ThinglinksDeviceLogs selectThinglinksDeviceLogsById(Long id) {
        return thinglinksDeviceLogsMapper.selectThinglinksDeviceLogsById(id);
    }

    /**
     * 查询设备日志列表
     *
     * @param thinglinksDeviceLogs 设备日志
     * @return 设备日志
     */
    @Override
    public List<ThinglinksDeviceLogs> selectThinglinksDeviceLogsList(ThinglinksDeviceLogs thinglinksDeviceLogs) {
        return thinglinksDeviceLogsMapper.selectThinglinksDeviceLogsList(thinglinksDeviceLogs);
    }

    /**
     * 新增设备日志
     *
     * @param thinglinksDeviceLogs 设备日志
     * @return 结果
     */
    @Override
    public int insertThinglinksDeviceLogs(ThinglinksDeviceLogs thinglinksDeviceLogs) {
        return thinglinksDeviceLogsMapper.insertThinglinksDeviceLogs(thinglinksDeviceLogs);
    }

    /**
     * 修改设备日志
     *
     * @param thinglinksDeviceLogs 设备日志
     * @return 结果
     */
    @Override
    public int updateThinglinksDeviceLogs(ThinglinksDeviceLogs thinglinksDeviceLogs) {
        return thinglinksDeviceLogsMapper.updateThinglinksDeviceLogs(thinglinksDeviceLogs);
    }

    /**
     * 批量删除设备日志
     *
     * @param ids 需要删除的设备日志主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksDeviceLogsByIds(Long[] ids) {
        return thinglinksDeviceLogsMapper.deleteThinglinksDeviceLogsByIds(ids);
    }

    /**
     * 删除设备日志信息
     *
     * @param id 设备日志主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksDeviceLogsById(Long id) {
        return thinglinksDeviceLogsMapper.deleteThinglinksDeviceLogsById(id);
    }
}
