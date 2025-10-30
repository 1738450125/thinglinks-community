package com.thinglinks.business.down;

import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.thinglinks.business.domain.ThinglinksDeviceLogs;
import com.thinglinks.business.domain.ThinglinksFunction;
import com.thinglinks.business.domain.ThinglinksFunctionRecord;
import com.thinglinks.business.service.IThinglinksDeviceLogsService;
import com.thinglinks.business.service.IThinglinksFunctionRecordService;
import com.thinglinks.business.service.IThinglinksFunctionService;
import com.thinglinks.common.core.domain.AjaxResult;
import com.thinglinks.common.utils.StringUtils;
import com.thinglinks.common.utils.spring.SpringUtils;
import com.thinglinks.component.message.DecodeMessage;
import com.thinglinks.component.message.MessageCache;
import com.thinglinks.component.mqtt.client.MqttClientManager;
import com.thinglinks.component.protocol.EncodeMessage;
import com.thinglinks.component.protocol.ProtocolManager;
import com.thinglinks.component.tcp.TCPServerManager;
import org.eclipse.paho.client.mqttv3.MqttException;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Map;

/**
 * @Description: 设备功能下发工具
 * @Author: chen tao
 * @CreateTime: 2025-10-25
 */
public class DeviceDownUtils {

    /**
     * 功能下发统一方法
     */
    public static boolean functionDown(String deviceSn,String functionCode,String params,String componentId,String componentType,String protocolId,String customConfig,String triggerType) throws InvocationTargetException, IllegalAccessException, MqttException {
        DecodeMessage decodeMessage = MessageCache.getDeviceLastData(deviceSn);
        if(decodeMessage==null){
            ThinglinksDeviceLogs log = SpringUtils.getBean(IThinglinksDeviceLogsService.class).getOne(new LambdaQueryWrapper<ThinglinksDeviceLogs>()
                    .eq(ThinglinksDeviceLogs::getDeviceSn,deviceSn)
                    .orderByDesc(ThinglinksDeviceLogs::getReportTime)
                    .eq(ThinglinksDeviceLogs::getLogType,"PROPERTY")
                    .last(" limit 1 "));
            if(log!=null){
                decodeMessage = JSONObject.parseObject(log.getProperties(),DecodeMessage.class);
                MessageCache.setDeviceLastData(deviceSn,decodeMessage);
            }else {
                decodeMessage = new DecodeMessage();
                MessageCache.setDeviceLastData(deviceSn,new DecodeMessage());
            }
        }
        boolean isOk = false;
        switch (componentType){
            case "MQTT_CLIENT":{
                isOk = mqttClientDown(deviceSn, functionCode,decodeMessage.getProperties(),params, componentId, protocolId,customConfig);
                break;
            }
            case "TCP_SERVER":{
                isOk = tcpServerDown(deviceSn, functionCode,decodeMessage.getProperties(),params, componentId, protocolId,customConfig);
                break;
            }
            default:
        }
        ThinglinksFunctionRecord record = new ThinglinksFunctionRecord();
        record.setDeviceSn(deviceSn);
        record.setFunctionCode(functionCode);
        record.setCreateTime(new Date());
        record.setFunctionParams(params);
        record.setIsSuccess(isOk?"1":"0");
        record.setTriggerType(triggerType);
        ThinglinksFunction function = SpringUtils.getBean(IThinglinksFunctionService.class).getOne(new LambdaQueryWrapper<ThinglinksFunction>()
                .eq(ThinglinksFunction::getFunctionCode,functionCode)
                .eq(ThinglinksFunction::getBelongSn,deviceSn));
        record.setFunctionId(function.getId());
        record.setFunctionName(function.getFunctionName());
        SpringUtils.getBean(IThinglinksFunctionRecordService.class).save(record);
        return isOk;
    }


    /**
     * MQTT_CLIENT功能下发
     */
    public static boolean mqttClientDown(String deviceSn, String functionCode, Map<String,Object> properties,String params, String componentId, String protocolId,String customConfig) throws InvocationTargetException, IllegalAccessException, MqttException {
        Method encodeMethod = ProtocolManager.ENCODE_METHOD.getOrDefault(protocolId,null);
        Object instance = ProtocolManager.CLASS_INSTANCE.getOrDefault(protocolId,null);
        Object result = encodeMethod.invoke(instance,functionCode,deviceSn,properties,params,customConfig);
        EncodeMessage encodeMessage = JSONObject.parseObject(JSONObject.toJSONString(result), EncodeMessage.class);
        if(!encodeMessage.getIsSend()){
            return true;
        }
        return MqttClientManager.publishMessage(componentId,encodeMessage.getTopic(),encodeMessage.getContent(), encodeMessage.getQos(), encodeMessage.getRetain());
    }

    /**
     * TCP_SERVER功能下发
     */
    public static boolean tcpServerDown(String deviceSn, String functionCode, Map<String,Object> properties,String params, String componentId, String protocolId,String customConfig) throws InvocationTargetException, IllegalAccessException, MqttException {
        Method encodeMethod = ProtocolManager.ENCODE_METHOD.getOrDefault(protocolId,null);
        Object instance = ProtocolManager.CLASS_INSTANCE.getOrDefault(protocolId,null);
        Object result = encodeMethod.invoke(instance,functionCode,deviceSn,properties,params,customConfig);
        EncodeMessage encodeMessage = JSONObject.parseObject(JSONObject.toJSONString(result), EncodeMessage.class);
        if(!encodeMessage.getIsSend()){
            return true;
        }
        return TCPServerManager.sendMessageToDevice(deviceSn,new String(encodeMessage.getContent()));
    }

}
