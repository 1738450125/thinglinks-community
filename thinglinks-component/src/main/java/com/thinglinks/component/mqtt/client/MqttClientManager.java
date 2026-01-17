package com.thinglinks.component.mqtt.client;

import com.thinglinks.common.utils.spring.SpringUtils;
import lombok.Data;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@Data
public class MqttClientManager {
    private static final Logger logger = LoggerFactory.getLogger(MqttClientManager.class);

    public static Map<String, MQTTClient> clientMap = new ConcurrentHashMap<>();
    public static Map<String, MqttClientConfig> configMap = new ConcurrentHashMap<>();
    // 修复：改为ConcurrentHashMap保证线程安全，避免并发修改异常
    public static Map<String, Set<String>> CLIENT_DEVICE = new ConcurrentHashMap<>();

    // 添加MQTT连接
    public static boolean addConnection(MqttClientConfig config) {
        // 前置清理：先删除旧客户端，避免ID冲突
        if (clientMap.containsKey(config.getClientId())) {
            try {
                deleteConnection(config.getClientId());
            } catch (MqttException e) {
                logger.error("清理旧客户端失败: {}", e.getMessage());
                return false;
            }
        }

        MQTTClient mqttClient = null;
        try {
            mqttClient = new MQTTClient(config.getBrokerUrl(), config.getClientId());
            mqttClient.setCredentials(config.getUsername(), config.getPassword());
            // 关键：提前设置自动重连（确保ConnectOptions生效）
            mqttClient.setAutomaticReconnect(true);
            // 设置默认消息处理器
            mqttClient.setDefaultMessageListener((topic, message) -> {
                try {
                    SpringUtils.getBean(MqttClientConsumer.class).message(config.getClientId(), topic, message);
                } catch (Exception ignore) {
                }
            });

            // 1. 先连接
            mqttClient.connect();
            if (!mqttClient.isConnected()) {
                logger.error("客户端连接失败: {}", config.getClientId());
                mqttClient.close(); // 清理资源
                return false;
            }

            // 2. 订阅Topic（前置校验+异常处理）
            boolean subscribeSuccess = true;
            if (config.getTopics() != null && !config.getTopics().isEmpty()) {
                for (String topic : config.getTopics()) {
                    // 前置校验Topic格式，避免非法Topic导致连接断开
                    if (!isValidTopic(topic)) {
                        logger.error("Topic格式非法: {}", topic);
                        subscribeSuccess = false;
                        break;
                    }
                    try {
                        mqttClient.subscribe(topic, 0);
                    } catch (MqttException e) {
                        logger.error("订阅Topic失败: {}", topic, e);
                        subscribeSuccess = false;
                        break;
                    }
                }
            } else {
                // 订阅所有Topic（仅测试用）
                mqttClient.subscribe("#", 0);
            }

            // 3. 订阅失败则断开连接，避免重连循环
            if (!subscribeSuccess) {
                mqttClient.disconnect();
                mqttClient.close();
                return false;
            }

            // 4. 存储客户端和配置（确保状态干净）
            clientMap.put(config.getClientId(), mqttClient);
            configMap.put(config.getClientId(), config); // 存储配置，用于重连订阅
            logger.info("客户端连接并订阅成功: {}", config.getClientId());
            return true;

        } catch (Exception e) {
            logger.error("添加MQTT连接失败", e);
            // 异常时彻底清理资源
            if (mqttClient != null) {
                try {
                    mqttClient.disconnect();
                    mqttClient.close();
                } catch (MqttException ex) {
                    logger.error("清理客户端资源失败", ex);
                }
            }
            return false;
        }
    }

    // 删除mqtt连接（彻底清理资源）
    public static boolean deleteConnection(String clientId) throws MqttException {
        MQTTClient mqttClient = clientMap.getOrDefault(clientId, null);
        if (mqttClient == null) {
            configMap.remove(clientId); // 清理配置
            return true;
        }
        // 1. 断开连接（强制断开）
        if (mqttClient.isConnected()) {
            mqttClient.disconnect();
        }
        // 2. 关闭客户端，释放底层资源
        mqttClient.close();
        // 3. 清理所有映射
        clientMap.remove(clientId);
        configMap.remove(clientId);
        CLIENT_DEVICE.remove(clientId);
        logger.info("客户端资源已彻底清理: {}", clientId);
        return true;
    }

    // 发送消息（增强异常处理）
    public static boolean publishMessage(String clientId, String topic, byte[] message) throws MqttException {
        return publishMessage(clientId, topic, message, 0, false);
    }

    public static boolean publishMessage(String clientId, String topic, byte[] message, int qos, boolean retain) throws MqttException {
        try {
            MQTTClient mqttClient = clientMap.getOrDefault(clientId, null);
            if (mqttClient == null || !mqttClient.isConnected()) {
                logger.warn("客户端未连接: {}", clientId);
                return false;
            }
            // 校验Topic合法性
            if (!isValidTopic(topic)) {
                logger.error("发布消息的Topic格式非法: {}", topic);
                return false;
            }
            mqttClient.publish(topic, message, qos, retain);
            return true;
        } catch (Exception e) {
            logger.error("发布消息失败", e);
            return false;
        }
    }

    /**
     * 绑定设备（线程安全）
     */
    public static void bindDevice(String clientId, String deviceSn) {
        // 利用ConcurrentHashMap的computeIfAbsent避免并发问题
        CLIENT_DEVICE.computeIfAbsent(clientId, k -> ConcurrentHashMap.newKeySet()).add(deviceSn);
    }

    /**
     * 校验MQTT Topic格式合法性
     */
    private static boolean isValidTopic(String topic) {
        if (topic == null || topic.isEmpty()) {
            return false;
        }
        // 规则1: #只能在最后，且单独占一层（如 hotel/power/# 合法，hotel/#/status 非法）
        if (topic.contains("#") && !topic.endsWith("#")) {
            return false;
        }
        // 规则2: +必须单独占一层（如 hotel/power/+/status 合法，hotel/power+status 非法）
        String[] levels = topic.split("/");
        for (String level : levels) {
            if (level.contains("+") && level.length() > 1) {
                return false;
            }
        }
        return true;
    }
}