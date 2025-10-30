package com.thinglinks.component.tcp;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import static com.thinglinks.component.tcp.TCPClientManager.*;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-16
 */
@Slf4j
@Component
public class TCPServerConsumer {
    @Autowired
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Autowired
    private EventBus eventBus;

    public void message(String componentId,String clientId, String message) {
        threadPoolTaskExecutor.execute(() -> {
            try {
                handleMessage(componentId,clientId, message);
            } catch (InvocationTargetException | IllegalAccessException e) {
                throw new RuntimeException(e);
            }
        });
    }

    /**
     * 消息处理
     *
     * @param clientId
     * @param message
     */
    public void handleMessage(String componentId,String clientId, String message) throws InvocationTargetException, IllegalAccessException {
        threadPoolTaskExecutor.execute(() -> {
            WebSocketServer.broadcast("component", componentId, message);
        });
        String protocolId = ProtocolManager.PROTOCOL_MAP.getOrDefault(componentId, null);
        if (StringUtils.isNotEmpty(protocolId)) {
            Method method = ProtocolManager.DECODE_METHOD.get(protocolId);
            Object object = ProtocolManager.CLASS_INSTANCE.get(protocolId);
            try {
                Object data = method.invoke(object, message);
                DecodeMessage decodeMessage = MessageUtils.parseMessage(data);
                if (decodeMessage == null) {
                    return;
                }
                if(StringUtils.isNotEmpty(decodeMessage.getDeviceSn())){
                    TCPServerInstance tcpServerInstance = TCPServerManager.getServerInstance(componentId);
                    if(tcpServerInstance!=null){
                        DEVICE_CLIENT.put(decodeMessage.getDeviceSn(),tcpServerInstance.getClientByClientId(clientId));
                        CLIENT_DEVICE.put(clientId, decodeMessage.getDeviceSn());
                    }
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
