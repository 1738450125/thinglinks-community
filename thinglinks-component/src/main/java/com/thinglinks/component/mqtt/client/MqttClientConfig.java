package com.thinglinks.component.mqtt.client;

import lombok.Data;

import java.util.Arrays;
import java.util.List;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-15
 */
@Data
public class MqttClientConfig {
    private String clientId;
    private String brokerUrl;
    private String username;
    private String password;
    private List<String> topics;
    private String topicStr;
    private Boolean cleanSession = true;
    private Integer connectionTimeout = 30;
    private Integer keepAliveInterval = 60;

    // 构造函数、getter和setter方法
    public MqttClientConfig(String clientId, String brokerUrl, String username, String password,Integer keepAliveInterval, String topicStr) {
        this.clientId = clientId;
        this.brokerUrl = brokerUrl;
        this.username = username;
        this.password = password;
        this.keepAliveInterval = keepAliveInterval;
        this.topicStr = topicStr;
        this.topics = Arrays.asList(topicStr.split(","));
    }
}
