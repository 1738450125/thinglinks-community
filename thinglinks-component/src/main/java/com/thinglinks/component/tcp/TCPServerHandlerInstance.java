package com.thinglinks.component.tcp;

import com.thinglinks.common.utils.spring.SpringUtils;
import com.thinglinks.component.event.EventBus;

import static com.thinglinks.component.tcp.TCPClientManager.CLIENT_DEVICE;


/**
 * @Description: TCP服务处理类
 * @Author: thinglinks
 * @CreateTime: 2025-10-14
 */
public class TCPServerHandlerInstance implements ServerHandler{
    @Override
    public void onMessageReceived(String componentId,String clientId, String message) {
        SpringUtils.getBean(TCPServerConsumer.class).message(componentId,clientId,message);
    }

    @Override
    public void onClientConnected(String clientId) {
        System.out.println("连接");
    }

    @Override
    public void onClientDisconnected(String clientId) {
        if(CLIENT_DEVICE.getOrDefault(clientId,null)!=null){
            SpringUtils.getBean(EventBus.class).publish("device.offline",CLIENT_DEVICE.get(clientId));
        }
    }
}
