package com.thinglinks.component.tcp;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * @Description: 设备客户端管理器
 * @Author: ruoyi
 * @CreateTime: 2025-10-25
 */
public class TCPClientManager {
    public static final Map<String,ClientHandler> DEVICE_CLIENT = new HashMap<>();
    public static final Map<String, Set<String>> CLIENT_DEVICE = new HashMap<>();

    public static void bindDeviceSn(String componentId,String deviceSn){
        Set<String> set = CLIENT_DEVICE.getOrDefault(componentId,null);
        if(set!=null){
            set.add(deviceSn);
        }else {
            Set<String> deviceSet = new HashSet<>();
            deviceSet.add(deviceSn);
            CLIENT_DEVICE.put(componentId,deviceSet);
        }
    }
}
