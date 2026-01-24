package com.thinglinks.business.event;

import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.thinglinks.business.domain.*;
import com.thinglinks.business.domain.enums.DeviceLogType;
import com.thinglinks.business.down.DeviceDownUtils;
import com.thinglinks.business.service.IThinglinksComponentService;
import com.thinglinks.business.service.IThinglinksDeviceLogsService;
import com.thinglinks.business.service.IThinglinksDeviceService;
import com.thinglinks.business.service.IThinglinksWarnRecordService;
import com.thinglinks.business.utils.CacheUtils;
import com.thinglinks.business.warn.WarnRule;
import com.thinglinks.business.warn.WarnRuleMatcher;
import com.thinglinks.common.utils.StringUtils;
import com.thinglinks.common.utils.spring.SpringUtils;
import com.thinglinks.component.event.EventBus;
import com.thinglinks.component.event.MessageUpEvent;
import com.thinglinks.component.message.*;
import com.thinglinks.component.utils.PropertyToJson;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.lang.reflect.InvocationTargetException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-25
 */
@Component
@Slf4j
public class DeviceUpListener {

    @Autowired
    private EventBus eventBus;
    @Autowired
    private IThinglinksDeviceLogsService thinglinksDeviceLogsService;
    @Autowired
    private IThinglinksDeviceService thinglinksDeviceService;
    @Autowired
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Autowired
    private IThinglinksWarnRecordService thinglinksWarnRecordService;

    @PostConstruct
    public void subscribeToEvents() {
        // 订阅所有设备消息
        eventBus.subscribe("device.up", this::dealDeviceUp);
        eventBus.subscribe("device.offline", this::directlyConnectedOffline);
    }

    public void dealDeviceUp(Object event) {
        if (event instanceof MessageUpEvent) {
            MessageUpEvent message = (MessageUpEvent) event;
            if (message.getData() instanceof DecodeMessage) {
                DecodeMessage decodeMessage = (DecodeMessage) message.getData();
                saveMessage(decodeMessage);
                deviceStatus(decodeMessage);
                ruleWarn(message);
            }
        }
    }

    /**
     * 存储消息日志
     */
    public void saveMessage(DecodeMessage decodeMessage) {
        if (decodeMessage.getIsStore()) {
            // 保存设备消息
            ThinglinksDeviceLogs logs = new ThinglinksDeviceLogs();
            logs.setDeviceSn(decodeMessage.getDeviceSn());
            logs.setLogType(DeviceLogType.PROPERTY.name());
            logs.setCreateTime(new Date());
            logs.setReportTime(decodeMessage.getReportTime());
            logs.setProperties(JSONObject.toJSONString(decodeMessage));
            thinglinksDeviceLogsService.save(logs);
        }
    }

    /**
     * 设备状态处理
     */
    public void deviceStatus(DecodeMessage decodeMessage) {
        ThinglinksDevice device = CacheUtils.getDeviceBySn(decodeMessage.getDeviceSn());
        //心跳设备
        if (device != null && "2".equals(device.getDeviceType())) {
            boolean status = CacheUtils.getDeviceStatusBySn(decodeMessage.getDeviceSn());
            if (!status) {
                threadPoolTaskExecutor.execute(() -> {
                    CacheUtils.updateDeviceStatusCache(decodeMessage.getDeviceSn(), true);
                    thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                            .eq(ThinglinksDevice::getDeviceSn, decodeMessage.getDeviceSn())
                            .set(ThinglinksDevice::getStatus, "1"));
                    //保存上线消息
                    ThinglinksDeviceLogs logs = new ThinglinksDeviceLogs();
                    logs.setDeviceSn(decodeMessage.getDeviceSn());
                    logs.setLogType(DeviceLogType.ONLINE.name());
                    logs.setCreateTime(new Date());
                    logs.setReportTime(decodeMessage.getReportTime());
                    thinglinksDeviceLogsService.save(logs);
                    decodeMessage.getProperties().put("device_online", "1");
                    ruleWarn(new MessageUpEvent("deviceStatusWarn", null, decodeMessage.getDeviceSn(), decodeMessage));
                });
            }
            //自动离线计时
            DeviceHeartbeatManager.updateHeartbeat(device.getDeviceSn(), "1", device.getTimeoutSeconds());
        } else {
            //网关设备和直连设备
            boolean status = CacheUtils.getDeviceStatusBySn(decodeMessage.getDeviceSn());
            if (status != decodeMessage.getIsOnline()) {
                threadPoolTaskExecutor.execute(() -> {
                    //更新状态
                    thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                            .eq(ThinglinksDevice::getDeviceSn, decodeMessage.getDeviceSn())
                            .set(ThinglinksDevice::getStatus, decodeMessage.getIsOnline() ? "1" : "0"));
                    CacheUtils.updateDeviceStatusCache(decodeMessage.getDeviceSn(), decodeMessage.getIsOnline());
                    //保存上下线消息
                    ThinglinksDeviceLogs logs = new ThinglinksDeviceLogs();
                    logs.setDeviceSn(decodeMessage.getDeviceSn());
                    if (decodeMessage.getIsOnline()) {
                        logs.setLogType(DeviceLogType.ONLINE.name());
                        decodeMessage.getProperties().put("device_online", "1");
                    } else {
                        logs.setLogType(DeviceLogType.OFFLINE.name());
                        decodeMessage.getProperties().put("device_offline", "1");
                    }
                    logs.setCreateTime(new Date());
                    logs.setReportTime(decodeMessage.getReportTime());
                    thinglinksDeviceLogsService.save(logs);
                    ruleWarn(new MessageUpEvent("deviceStatusWarn", null, decodeMessage.getDeviceSn(), decodeMessage));
                });
            }
        }
    }

    /**
     * 规则告警
     */
    public void ruleWarn(MessageUpEvent message) {
        if (message.getData() instanceof DecodeMessage) {
            DecodeMessage decodeMessage = (DecodeMessage) message.getData();
            //用全属性缓存来计算 TODO
//                    DecodeMessage lastData = MessageCache.getDeviceLastData(decodeMessage.getDeviceSn());
            DecodeMessage lastData = decodeMessage;
            List<PropertyNode> propertyNodes = PropertyToJson.PROPERTY_TREE.get(decodeMessage.getDeviceSn());
            if (propertyNodes == null) {
                return;
            }
            String propertyJson = PropertyToJson.convertToJson(propertyNodes, lastData.getProperties());
            List<WarnRule> originRules = CacheUtils.getDeviceWarnRule(decodeMessage.getDeviceSn());
            List<WarnRule> rules = new ArrayList<>();
            if ("deviceStatusWarn".equals(message.getSource())) {
                rules.addAll(originRules.stream().filter(o -> !"0".equals(o.getWarnType())).collect(Collectors.toList()));
            } else {
                rules.addAll(originRules.stream().filter(o -> "0".equals(o.getWarnType())).collect(Collectors.toList()));
            }
            rules.removeIf(rule -> !rule.getEnable());
            if (!rules.isEmpty()) {
                threadPoolTaskExecutor.execute(() -> {
                    rules.forEach(rule -> {
                        long lastWarnTime = CacheUtils.getDeviceRuleWarnTime(rule.getBelongSn(), rule.getId());
                        //规定时间内不再重复告警
                        if (System.currentTimeMillis() - lastWarnTime < rule.getDelayTime() * 1000) {
                            return;
                        }
                        JSONObject propertyData = JSONObject.parseObject(propertyJson);
                        Map<String, Object> msgProperty = decodeMessage.getProperties();
                        if (msgProperty != null) {
                            if (msgProperty.containsKey("device_online")) {
                                propertyData.put("device_online", msgProperty.get("device_online"));
                            }
                            if (msgProperty.containsKey("device_offline")) {
                                propertyData.put("device_offline", msgProperty.get("device_offline"));
                            }
                        }
                        boolean isWarn = WarnRuleMatcher.matchesRule(propertyData, rule);
                        if (isWarn) {
                            String warnMessage = WarnRuleMatcher.generateAlertMessage(JSONObject.parseObject(propertyJson), rule);
                            ThinglinksWarnRecord warnRecord = new ThinglinksWarnRecord();
                            warnRecord.setWarnMessage(warnMessage);
                            warnRecord.setCreateTime(new Date());
                            warnRecord.setBelongSn(rule.getBelongSn());
                            propertyData.remove("device_online");
                            propertyData.remove("device_offline");
                            warnRecord.setWarnData(propertyData.toJSONString());
                            warnRecord.setWarnLevel(rule.getLevel());
                            warnRecord.setConfigId(rule.getId());
                            warnRecord.setConfigName(rule.getName());
                            warnRecord.setStatus("0");
                            warnRecord.setWarnType(rule.getWarnType());
                            thinglinksWarnRecordService.save(warnRecord);
                            SpringUtils.getBean(EventBus.class).publish("device.warn", warnRecord);
                            CacheUtils.updateDeviceRuleWarnTime(rule.getBelongSn(), rule.getId(), System.currentTimeMillis());
                        }
                    });
                });
            }
        }
    }

    /**
     * 直连设备离线处理
     */
    public void directlyConnectedOffline(Object event) {
        threadPoolTaskExecutor.execute(() -> {
            if (event instanceof String) {
                String deviceSn = (String) event;
                thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                        .eq(ThinglinksDevice::getDeviceSn, deviceSn)
                        .set(ThinglinksDevice::getStatus, "0"));
                CacheUtils.updateDeviceStatusCache(deviceSn, false);
                //保存上下线消息
                ThinglinksDeviceLogs logs = new ThinglinksDeviceLogs();
                logs.setDeviceSn(deviceSn);
                logs.setLogType(DeviceLogType.OFFLINE.name());
                logs.setCreateTime(new Date());
                logs.setReportTime(new Date());
                thinglinksDeviceLogsService.save(logs);
                DecodeMessage decodeMessage = new DecodeMessage();
                decodeMessage.setIsStore(true);
                decodeMessage.setDeviceSn(deviceSn);
                decodeMessage.setProperties(new HashMap<>());
                decodeMessage.getProperties().put("device_offline", "1");
                MessageUpEvent event1 = new MessageUpEvent("deviceStatusWarn", null, deviceSn, decodeMessage);
                ruleWarn(event1);
            }
            if (event instanceof Set) {
                Set<String> deviceSnList = (Set<String>) event;
                thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                        .in(ThinglinksDevice::getDeviceSn, deviceSnList)
                        .set(ThinglinksDevice::getStatus, "0"));
                deviceSnList.forEach(deviceSn -> {
                    CacheUtils.updateDeviceStatusCache(deviceSn, false);
                    //保存上下线消息
                    ThinglinksDeviceLogs logs = new ThinglinksDeviceLogs();
                    logs.setDeviceSn(deviceSn);
                    logs.setLogType(DeviceLogType.OFFLINE.name());
                    logs.setCreateTime(new Date());
                    logs.setReportTime(new Date());
                    thinglinksDeviceLogsService.save(logs);
                    DecodeMessage decodeMessage = new DecodeMessage();
                    decodeMessage.setIsStore(true);
                    decodeMessage.setDeviceSn(deviceSn);
                    decodeMessage.setProperties(new HashMap<>());
                    decodeMessage.getProperties().put("device_offline", "1");
                    MessageUpEvent event1 = new MessageUpEvent("deviceStatusWarn", null, deviceSn, decodeMessage);
                    ruleWarn(event1);
                });
            }
        });
    }
}
