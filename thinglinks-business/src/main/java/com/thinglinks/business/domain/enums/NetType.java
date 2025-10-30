package com.thinglinks.business.domain.enums;

import java.util.Arrays;

/**
 * @Description: 网络组件枚举
 * @Author: thinglinks
 * @CreateTime: 2025-09-18
 */
public enum NetType {
    /**
     * MQTT客户端
     */
    MQTT_CLIENT,
    /**
     * MQTT服务端
     */
    MQTT_BROKER,
    /**
     * TCP客户端
     */
    TCP_CLIENT,
    /**
     * TCP服务端
     */
    TCP_SERVER,
    /**
     * UDP客户端
     */
    UDP_CLIENT,
    /**
     * UDP服务端
     */
    UDP_SERVER,
    /**
     * HTTP服务端
     */
    HTTP_SERVER,
    /**
     * MODBUS_TCP
     */
    MODBUS_TCP;
}
