package com.thinglinks.business.scheduled;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.thinglinks.business.domain.ThinglinksComponent;
import com.thinglinks.business.domain.ThinglinksDevice;
import com.thinglinks.business.domain.ThinglinksDeviceLogs;
import com.thinglinks.business.domain.ThinglinksProtocol;
import com.thinglinks.business.event.DeviceHeartbeatManager;
import com.thinglinks.business.service.IThinglinksComponentService;
import com.thinglinks.business.service.IThinglinksDeviceLogsService;
import com.thinglinks.business.service.IThinglinksDeviceService;
import com.thinglinks.business.service.IThinglinksProtocolService;
import com.thinglinks.business.utils.CacheUtils;
import com.thinglinks.common.exception.CommonWarnException;
import com.thinglinks.common.utils.StringUtils;
import com.thinglinks.component.protocol.ProtocolManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

import static com.thinglinks.business.service.impl.ThinglinksProtocolServiceImpl.PROTOCOL_PATH;
import static com.thinglinks.business.utils.CacheUtils.updateAllDeviceCache;

/**
 * @Description: 定时任务和初始化数据
 * @Author: thinglinks
 * @CreateTime: 2025-09-22
 */
@Component
public class TimerTask {
    @Autowired
    private IThinglinksComponentService thinglinksComponentService;
    @Autowired
    private IThinglinksProtocolService thinglinksProtocolService;
    @Autowired
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Autowired
    private IThinglinksDeviceService thinglinksDeviceService;
    @Autowired
    private IThinglinksDeviceLogsService thinglinksDeviceLogsService;
    /**
     * 初始化组件和协议
     */
    @PostConstruct
    public void initComponentAndProtocol() {
        threadPoolTaskExecutor.execute(() -> {
            List<ThinglinksComponent> components = thinglinksComponentService.list(new LambdaQueryWrapper<ThinglinksComponent>()
                    .eq(ThinglinksComponent::getStatus, "1"));
            components.forEach(component -> {
                //先加载相关协议
                if (StringUtils.isNotEmpty(component.getProtocolId())) {
                    ThinglinksProtocol protocol = thinglinksProtocolService.getById(component.getProtocolId());
                    try {
                        ProtocolManager.addProtocol(protocol.getId(),protocol.getProtocolType(), PROTOCOL_PATH + File.separator + protocol.getNewName(), protocol.getMainClassPath());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                try {
                    thinglinksComponentService.openComponent(component.getId());
                } catch (IOException | CommonWarnException e) {
                    throw new RuntimeException(e);
                }
            });
        });
    }

    /**
     * 初始化设备属性缓存和状态缓存
     */
    @PostConstruct
    public void initDeviceProperty() {
        List<ThinglinksDevice> thinglinksDevice = thinglinksDeviceService.list();
        thinglinksDevice.forEach(device -> {
            threadPoolTaskExecutor.execute(() -> {
                CacheUtils.updateDeviceCache(device);
                thinglinksDeviceService.cacheDeviceProperties(device.getDeviceSn());
            });
        });
        thinglinksDevice.forEach(device -> {
            threadPoolTaskExecutor.execute(() -> {
                CacheUtils.updateDeviceStatusCache(device);
                //无状态设备状态管理
                if("2".equals(device.getDeviceType())&&"1".equals(device.getStatus())) {
                    DeviceHeartbeatManager.updateHeartbeat(device.getDeviceSn(), device.getStatus(), device.getTimeoutSeconds());
                }
            });
        });
        updateAllDeviceCache(thinglinksDevice);
    }

    /**
     * 初始化设备告警规则缓存
     */
    @PostConstruct
    public void initDeviceWarnRule(){
        threadPoolTaskExecutor.execute(CacheUtils::updateAllDeviceWarnRule);
    }

    /**
     * 定时清理设备数据,每个小时一次
     */
    @Scheduled(cron = "0 0 * * * ?")
    public void cleanDeviceData(){
        List<ThinglinksDevice> deviceList = thinglinksDeviceService.list(new LambdaUpdateWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getRegularCleaning,"1"));
        deviceList.forEach(device->{
            LocalDateTime startTime = LocalDateTime.now();
            if("hour".equals(device.getRetentionUnit())){
                startTime = startTime.minusHours(device.getRetentionTime());
            }
            if("day".equals(device.getRetentionUnit())){
                startTime = startTime.minusDays(device.getRetentionTime());
            }
            if("week".equals(device.getRetentionUnit())){
                startTime = startTime.minusWeeks(device.getRetentionTime());
            }
            if("month".equals(device.getRetentionUnit())){
                startTime = startTime.minusMonths(device.getRetentionTime());
            }
            if("year".equals(device.getRetentionUnit())){
                startTime = startTime.minusYears(device.getRetentionTime());
            }
            thinglinksDeviceLogsService.remove(new LambdaUpdateWrapper<ThinglinksDeviceLogs>()
                    .eq(ThinglinksDeviceLogs::getDeviceSn,device.getDeviceSn())
                    .lt(ThinglinksDeviceLogs::getCreateTime,startTime));
        });
    }

}
