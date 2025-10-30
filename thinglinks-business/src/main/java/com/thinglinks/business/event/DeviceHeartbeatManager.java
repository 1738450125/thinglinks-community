package com.thinglinks.business.event;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.thinglinks.business.domain.ThinglinksDevice;
import com.thinglinks.business.domain.ThinglinksDeviceLogs;
import com.thinglinks.business.domain.enums.DeviceLogType;
import com.thinglinks.business.service.IThinglinksDeviceLogsService;
import com.thinglinks.business.service.IThinglinksDeviceService;
import com.thinglinks.business.utils.CacheUtils;
import com.thinglinks.common.utils.spring.SpringUtils;

import java.util.Date;
import java.util.concurrent.*;

public class DeviceHeartbeatManager {
    private static final ConcurrentHashMap<String, Device> deviceMap = new ConcurrentHashMap<>();
    private static final DelayQueue<TimeoutTask> timeoutQueue = new DelayQueue<>();
    private static volatile boolean initialized = false;

    // 静态初始化块
    static {
        startManager();
    }

    public static class Device {
        final String deviceSn;
        volatile String status; // 1在线 0离线
        volatile long lastHeartbeatTime;
        final long timeoutSeconds;
        volatile TimeoutTask currentTask;

        Device(String deviceSn, long timeoutSeconds) {
            this.deviceSn = deviceSn;
            this.timeoutSeconds = timeoutSeconds;
            this.lastHeartbeatTime = System.currentTimeMillis();
            this.status = "1";
        }
    }

    public static class TimeoutTask implements Delayed {
        final String deviceSn;
        final long executeTime;

        TimeoutTask(String deviceSn, long delayMs) {
            this.deviceSn = deviceSn;
            this.executeTime = System.currentTimeMillis() + delayMs*1000;
        }

        @Override
        public long getDelay(TimeUnit unit) {
            return unit.convert(executeTime - System.currentTimeMillis(), TimeUnit.MILLISECONDS);
        }

        @Override
        public int compareTo(Delayed other) {
            return Long.compare(this.executeTime, ((TimeoutTask) other).executeTime);
        }
    }

    /**
     * 启动管理器
     */
    private static void startManager() {
        if (initialized) {
            return;
        }
        Thread timeoutCheckerThread = new Thread(() -> {
            while (!Thread.currentThread().isInterrupted()) {
                try {
                    TimeoutTask task = timeoutQueue.take();
                    processTimeout(task);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    break;
                }
            }
        }, "Heartbeat-Checker");

        timeoutCheckerThread.setDaemon(true);
        timeoutCheckerThread.start();
        initialized = true;

        System.out.println("DeviceHeartbeatManager static initialization completed!");
    }

    /**
     * 更新设备心跳 - 静态方法，随处可调用
     */
    public static void updateHeartbeat(String deviceSn, String status, long timeoutSeconds) {
        Device device = deviceMap.compute(deviceSn, (sn, existing) -> {
            if (existing != null) {
                // 更新现有设备
                existing.lastHeartbeatTime = System.currentTimeMillis();
                existing.status = status;

                // 取消旧任务
                if (existing.currentTask != null) {
                    existing.currentTask = null;
                }
                return existing;
            } else {
                // 新设备
                return new Device(deviceSn, timeoutSeconds);
            }
        });

        // 设置新的超时任务
        TimeoutTask newTask = new TimeoutTask(deviceSn, timeoutSeconds);
        device.currentTask = newTask;
        timeoutQueue.offer(newTask);
    }

    /**
     * 处理超时任务
     */
    private static void processTimeout(TimeoutTask task) {
        Device device = deviceMap.get(task.deviceSn);
        if (device == null || device.currentTask != task) {
            return;
        }

        long timeSinceLastHeartbeat = System.currentTimeMillis() - device.lastHeartbeatTime;
        if (timeSinceLastHeartbeat >= device.timeoutSeconds*1000) {
            // 设备超时，设置为离线
            device.status = "0";
            device.currentTask = null;
            //保存下线消息
            ThinglinksDeviceLogs logs = new ThinglinksDeviceLogs();
            logs.setDeviceSn(device.deviceSn);
            logs.setLogType(DeviceLogType.OFFLINE.name());
            Date date = new Date();
            logs.setCreateTime(date);
            logs.setReportTime(date);
            SpringUtils.getBean(IThinglinksDeviceLogsService.class).save(logs);
            SpringUtils.getBean(IThinglinksDeviceService.class).update(new LambdaUpdateWrapper<ThinglinksDevice>()
                    .eq(ThinglinksDevice::getDeviceSn,device.deviceSn)
                    .set(ThinglinksDevice::getStatus,"0"));
            CacheUtils.updateDeviceStatusCache(device.deviceSn,false);
        } else {
            // 重新计算剩余时间
            long remainingTime = device.timeoutSeconds*1000 - timeSinceLastHeartbeat;
            if (remainingTime > 0) {
                TimeoutTask newTask = new TimeoutTask(task.deviceSn, remainingTime);
                device.currentTask = newTask;
                timeoutQueue.offer(newTask);
            }
        }
    }

    /**
     * 获取设备状态 - 静态方法
     */
    public static String getDeviceStatus(String deviceSn) {
        Device device = deviceMap.get(deviceSn);
        return device != null ? device.status : "0";
    }

    /**
     * 强制设置设备离线
     */
    public static void setDeviceOffline(String deviceSn) {
        Device device = deviceMap.get(deviceSn);
        if (device != null) {
            device.status = "0";
            if (device.currentTask != null) {
                device.currentTask = null;
            }
        }
    }

    /**
     * 获取设备最后心跳时间
     */
    public static long getLastHeartbeatTime(String deviceSn) {
        Device device = deviceMap.get(deviceSn);
        return device != null ? device.lastHeartbeatTime : 0;
    }

    /**
     * 获取所有在线设备数量
     */
    public static int getOnlineDeviceCount() {
        return (int) deviceMap.values().stream()
                .filter(device -> "1".equals(device.status))
                .count();
    }

    /**
     * 获取总设备数量
     */
    public static int getTotalDeviceCount() {
        return deviceMap.size();
    }
}