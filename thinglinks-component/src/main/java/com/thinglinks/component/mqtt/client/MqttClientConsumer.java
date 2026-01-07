package com.thinglinks.component.mqtt.client;

import com.alibaba.fastjson2.JSONObject;
import com.thinglinks.common.utils.StringUtils;
import com.thinglinks.component.event.EventBus;
import com.thinglinks.component.event.MessageUpEvent;
import com.thinglinks.component.message.DecodeMessage;
import com.thinglinks.component.message.MessageCache;
import com.thinglinks.component.message.MessageUtils;
import com.thinglinks.component.protocol.ProtocolManager;
import com.thinglinks.component.sysws.WebSocketServer;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-16
 */
@Slf4j
@Component
public class MqttClientConsumer {
    @Autowired
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Autowired
    private EventBus eventBus;

    public void message(String clientId, String topic, MqttMessage message) {
        threadPoolTaskExecutor.execute(() -> {
            handleMessage(clientId, topic, new String(message.getPayload()));
        });
    }

    /**
     * 消息处理
     *
     * @param clientId
     * @param topic
     */
    public void handleMessage(String clientId, String topic, String message) {
        threadPoolTaskExecutor.execute(() -> {
            WebSocketServer.broadcast("component", clientId, message);
        });
        String protocolId = ProtocolManager.PROTOCOL_MAP.getOrDefault(clientId, null);
        if (StringUtils.isNotEmpty(protocolId)) {
            Method method = ProtocolManager.DECODE_METHOD.get(protocolId);
            Object object = ProtocolManager.CLASS_INSTANCE.get(protocolId);
            try {
                Object data = method.invoke(object, topic,message);
                DecodeMessage decodeMessage = MessageUtils.parseMessage(data);
                if (decodeMessage == null) {
                    return;
                }
                if(StringUtils.isNotEmpty(decodeMessage.getDeviceSn())){
                    MqttClientManager.bindDevice(clientId,decodeMessage.getDeviceSn());
                }
                threadPoolTaskExecutor.execute(() -> {
                    WebSocketServer.broadcast("device", decodeMessage.getDeviceSn(), JSONObject.toJSONString(decodeMessage));
                });
                MessageCache.setDeviceLastData(decodeMessage.getDeviceSn(), decodeMessage);
                eventBus.publish("device.up", new MessageUpEvent(this, "device.up", decodeMessage.getDeviceSn(), decodeMessage));
            } catch (IllegalAccessException | InvocationTargetException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
