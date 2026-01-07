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
import com.thinglinks.common.utils.spring.SpringUtils;
import com.thinglinks.component.event.EventBus;
import com.thinglinks.component.event.MessageUpEvent;
import com.thinglinks.component.message.DecodeMessage;
import com.thinglinks.component.message.MessageCache;
import com.thinglinks.component.message.MessageUtils;
import com.thinglinks.component.message.PropertyNode;
import com.thinglinks.component.utils.PropertyToJson;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-25
 */
@Component
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
    public void subscribeToEvents(){
        // 订阅所有设备消息
        eventBus.subscribe("device.up", this::saveMessage);
        eventBus.subscribe("device.up", this::deviceStatus);
        eventBus.subscribe("device.up", this::ruleWarn);
        eventBus.subscribe("device.offline", this::directlyConnectedOffline);
    }

    /**
     * 存储消息日志
     * @param event
     */
    public void saveMessage(Object event) {
        threadPoolTaskExecutor.execute(()->{
            if (event instanceof MessageUpEvent) {
                MessageUpEvent message = (MessageUpEvent) event;
                if(message.getData() instanceof DecodeMessage) {
                    DecodeMessage decodeMessage = (DecodeMessage) message.getData();
                    if(decodeMessage.getIsStore()) {
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
            }
        });
    }
    /**
     * 设备状态处理
     */
    public void deviceStatus(Object event){
        threadPoolTaskExecutor.execute(()->{
            if (event instanceof MessageUpEvent) {
                MessageUpEvent message = (MessageUpEvent) event;
                if(message.getData() instanceof DecodeMessage) {
                    DecodeMessage decodeMessage = (DecodeMessage) message.getData();
                    ThinglinksDevice device = CacheUtils.getDeviceBySn(decodeMessage.getDeviceSn());
                    //心跳设备
                    if(device!=null&&"2".equals(device.getDeviceType())){
                        boolean status = CacheUtils.getDeviceStatusBySn(decodeMessage.getDeviceSn());
                        if(!status){
                            CacheUtils.updateDeviceStatusCache(decodeMessage.getDeviceSn(),true);
                            thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                                    .eq(ThinglinksDevice::getDeviceSn,decodeMessage.getDeviceSn())
                                    .set(ThinglinksDevice::getStatus,"1"));
                            //保存上线消息
                            ThinglinksDeviceLogs logs = new ThinglinksDeviceLogs();
                            logs.setDeviceSn(decodeMessage.getDeviceSn());
                            logs.setLogType(DeviceLogType.ONLINE.name());
                            logs.setCreateTime(new Date());
                            logs.setReportTime(decodeMessage.getReportTime());
                            thinglinksDeviceLogsService.save(logs);
                        }
                        //自动离线计时
                        DeviceHeartbeatManager.updateHeartbeat(device.getDeviceSn(),"1",device.getTimeoutSeconds());
                    }else {
                        //网关设备和直连设备
                        boolean status = CacheUtils.getDeviceStatusBySn(decodeMessage.getDeviceSn());
                        if (status != decodeMessage.getIsOnline()) {
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
                            } else {
                                logs.setLogType(DeviceLogType.OFFLINE.name());
                            }
                            logs.setCreateTime(new Date());
                            logs.setReportTime(decodeMessage.getReportTime());
                            thinglinksDeviceLogsService.save(logs);
                        }
                    }
                }
            }
        });
    }

    /**
     * 规则告警
     */
    public void ruleWarn(Object event){
        threadPoolTaskExecutor.execute(()->{
            if (event instanceof MessageUpEvent) {
                MessageUpEvent message = (MessageUpEvent) event;
                if(message.getData() instanceof DecodeMessage) {
                    DecodeMessage decodeMessage = (DecodeMessage) message.getData();
                    if(!decodeMessage.getIsStore()){
                        return;
                    }
                    //用全属性缓存来计算
                    DecodeMessage lastData = MessageCache.getDeviceLastData(decodeMessage.getDeviceSn());
                    List<PropertyNode> propertyNodes = PropertyToJson.PROPERTY_TREE.get(decodeMessage.getDeviceSn());
                    String propertyJson = PropertyToJson.convertToJson(propertyNodes,lastData.getProperties());
                    List<WarnRule> rules = CacheUtils.getDeviceWarnRule(decodeMessage.getDeviceSn());
                    rules.forEach(rule->{
                        if(!rule.getEnable()){
                            return;
                        }
                        long lastWarnTime = CacheUtils.getDeviceRuleWarnTime(rule.getBelongSn(),rule.getId());
                        //规定时间内不再重复告警
                        if(System.currentTimeMillis()-lastWarnTime<rule.getDelayTime()*1000){
                            return;
                        }
                        JSONObject propertyData = JSONObject.parseObject(propertyJson);
                        boolean isWarn = WarnRuleMatcher.matchesRule(propertyData,rule);
                        if(isWarn){
                            String warnMessage = WarnRuleMatcher.generateAlertMessage(JSONObject.parseObject(propertyJson),rule);
                            ThinglinksWarnRecord warnRecord = new ThinglinksWarnRecord();
                            warnRecord.setWarnMessage(warnMessage);
                            warnRecord.setCreateTime(new Date());
                            warnRecord.setBelongSn(rule.getBelongSn());
                            warnRecord.setWarnData(propertyData.toJSONString());
                            warnRecord.setWarnLevel(rule.getLevel());
                            warnRecord.setConfigId(rule.getId());
                            warnRecord.setConfigName(rule.getName());
                            thinglinksWarnRecordService.save(warnRecord);
                            CacheUtils.updateDeviceRuleWarnTime(rule.getBelongSn(),rule.getId(),System.currentTimeMillis());
                        }
                    });
                }
            }
        });
    }

    /**
     * 直连设备离线处理
     */
    public void directlyConnectedOffline(Object event){
        threadPoolTaskExecutor.execute(()->{
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
            }
            if (event instanceof Set) {
                Set<String> deviceSnList = (Set<String>) event;
                thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                        .in(ThinglinksDevice::getDeviceSn, deviceSnList)
                        .set(ThinglinksDevice::getStatus, "0"));
                deviceSnList.forEach(deviceSn->{
                    CacheUtils.updateDeviceStatusCache(deviceSn, false);
                    //保存上下线消息
                    ThinglinksDeviceLogs logs = new ThinglinksDeviceLogs();
                    logs.setDeviceSn(deviceSn);
                    logs.setLogType(DeviceLogType.OFFLINE.name());
                    logs.setCreateTime(new Date());
                    logs.setReportTime(new Date());
                    thinglinksDeviceLogsService.save(logs);
                });
            }
        });
    }

}
