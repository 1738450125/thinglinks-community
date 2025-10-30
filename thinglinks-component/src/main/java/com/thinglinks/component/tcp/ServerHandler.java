package com.thinglinks.component.tcp;

import java.lang.reflect.InvocationTargetException;

/**
 * 服务器处理器接口 - 用户可以自定义实现
 */
public interface ServerHandler {
    /**
     * 当收到客户端消息时调用
     */
    void onMessageReceived(String componentId,String clientId, String message) throws InvocationTargetException, IllegalAccessException;

    /**
     * 当客户端连接时调用
     */
    void onClientConnected(String clientId);

    /**
     * 当客户端断开连接时调用
     */
    void onClientDisconnected(String clientId);

    /**
     * 当服务器发生错误时调用
     */
    default void onError(String clientId, Exception e) {
        System.err.println("客户端 " + clientId + " 发生错误: " + e.getMessage());
    }
}
