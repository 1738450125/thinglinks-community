package com.thinglinks.component.tcp;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 设备客户端管理器
 * @Author: chen tao
 * @CreateTime: 2025-10-25
 */
public class TCPClientManager {
    public static final Map<String,ClientHandler> DEVICE_CLIENT = new HashMap<>();
    public static final Map<String,String> CLIENT_DEVICE = new HashMap<>();
}
