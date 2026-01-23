package com.thinglinks.component.mqtt.client;

import com.alibaba.fastjson2.JSONObject;
import com.thinglinks.common.utils.spring.SpringUtils;
import com.thinglinks.component.event.EventBus;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Set;

import static com.thinglinks.component.mqtt.client.MqttClientManager.*;

/**
 * @Description: MQTT客户端工具类
 * @Author: thinglinks
 * @CreateTime: 2025-08-23
 */
public class MQTTClient {
    private static final Logger logger = LoggerFactory.getLogger(MQTTClient.class);

    private MqttClient mqttClient;
    private String brokerUrl;
    private String clientId;
    private String username;
    private String password;
    private int connectionTimeout = 30;
    private int keepAliveInterval = 10;
    private boolean automaticReconnect = true;
    // 关键修复：保存ConnectOptions的引用，避免连接后无法修改
    private MqttConnectOptions connectOptions;

    // 存储默认消息处理器
    private IMqttMessageListener defaultMessageListener;

    /**
     * 构造函数
     * @param brokerUrl MQTT代理地址，格式：tcp://host:port
     * @param clientId 客户端ID
     */
    public MQTTClient(String brokerUrl, String clientId) {
        this.brokerUrl = brokerUrl;
        this.clientId = clientId;
    }

    /**
     * 设置认证信息
     * @param username 用户名
     * @param password 密码
     */
    public void setCredentials(String username, String password) {
        this.username = username;
        this.password = password;
    }

    /**
     * 设置连接超时时间
     * @param connectionTimeout 超时时间（秒）
     */
    public void setConnectionTimeout(int connectionTimeout) {
        this.connectionTimeout = connectionTimeout;
    }

    /**
     * 设置保活间隔
     * @param keepAliveInterval 保活间隔（秒）
     */
    public void setKeepAliveInterval(int keepAliveInterval) {
        this.keepAliveInterval = keepAliveInterval;
    }

    /**
     * 设置是否自动重连（关键修复：提前配置，连接后修改不生效）
     * @param automaticReconnect 是否自动重连
     */
    public void setAutomaticReconnect(boolean automaticReconnect) {
        this.automaticReconnect = automaticReconnect;
        // 若已创建ConnectOptions，同步更新（未连接时生效）
        if (this.connectOptions != null) {
            this.connectOptions.setAutomaticReconnect(automaticReconnect);
        }
    }

    /**
     * 设置默认消息处理器
     * @param listener 消息处理器
     */
    public void setDefaultMessageListener(IMqttMessageListener listener) {
        this.defaultMessageListener = listener;
    }

    /**
     * 连接到MQTT代理
     * @throws MqttException 连接异常
     */
    public void connect() throws MqttException {
        try {
            // 1. 初始化ConnectOptions并保存引用（关键修复）
            this.connectOptions = new MqttConnectOptions();
            // 修复：CleanSession改为false，保留订阅会话（避免重连后订阅丢失）
            this.connectOptions.setCleanSession(false);
            this.connectOptions.setConnectionTimeout(connectionTimeout);
            this.connectOptions.setKeepAliveInterval(keepAliveInterval);
            // 使用当前设置的automaticReconnect（确保配置生效）
            this.connectOptions.setAutomaticReconnect(this.automaticReconnect);

            if (username != null && password != null) {
                this.connectOptions.setUserName(username);
                this.connectOptions.setPassword(password.toCharArray());
            }

            mqttClient = new MqttClient(brokerUrl, clientId, new MemoryPersistence());

            // 设置回调（核心：重连后重新订阅）
            mqttClient.setCallback(new MqttCallbackExtended() {
                @Override
                public void connectComplete(boolean reconnect, String serverURI) {
                    logger.info("MQTT连接成功: {}, 重连标识: {}", serverURI, reconnect);
                    if (reconnect) {
                        // 重连后重新订阅所有Topic（关键修复）
                        resubscribeAllTopics();
                        // 重置消息处理器
                        setDefaultMessageListener((topic, message) -> {
                            try {
                                SpringUtils.getBean(MqttClientConsumer.class).message(clientId, topic, message);
                            } catch (Exception ignore) {
                            }
                        });
                    }
                }

                @Override
                public void connectionLost(Throwable cause) {
                    // 触发设备离线事件（线程安全）
                    Set<String> deviceSns = CLIENT_DEVICE.getOrDefault(clientId, null);
                    if (deviceSns != null && !deviceSns.isEmpty()) {
                        try {
                            SpringUtils.getBean(EventBus.class).publish("device.offline", deviceSns);
                        } catch (Exception e) {
                            logger.error("发布设备离线事件失败", e);
                        }
                    }
                    logger.warn("MQTT连接丢失: {}", cause.getMessage());
                }

                @Override
                public void messageArrived(String topic, MqttMessage message) throws Exception {
                    handleIncomingMessage(topic, message);
                }

                @Override
                public void deliveryComplete(IMqttDeliveryToken token) {
                    if (token.getException() != null) {
                        logger.error("消息发布失败: {}", token.getException().getMessage());
                    } else {
                        logger.debug("消息发布成功");
                    }
                }
            });

            // 2. 连接服务器
            mqttClient.connect(this.connectOptions);
            logger.info("成功连接到MQTT代理: {}", brokerUrl);

        } catch (MqttException e) {
            logger.error("连接MQTT代理失败: {}", e.getMessage());
            throw e;
        }
    }

    /**
     * 断开连接
     * @throws MqttException 断开连接异常
     */
    public void disconnect() throws MqttException {
        if (mqttClient != null && mqttClient.isConnected()) {
            mqttClient.disconnect();
            logger.info("MQTT连接已断开");
        }
    }

    /**
     * 订阅主题
     * @param topic 主题名称
     * @param qos 服务质量等级 (0, 1, 2)
     * @throws MqttException 订阅异常
     */
    public void subscribe(String topic, int qos) throws MqttException {
        if (mqttClient == null || !mqttClient.isConnected()) {
            throw new MqttException(MqttException.REASON_CODE_CLIENT_NOT_CONNECTED);
        }

        try {
            mqttClient.subscribe(topic, qos);
            logger.info("成功订阅主题: {}, QoS: {}", topic, qos);
        } catch (MqttException e) {
            logger.error("订阅主题失败: {}, error: {}", topic, e.getMessage());
            throw e;
        }
    }

    /**
     * 取消订阅
     * @param topic 主题名称
     * @throws MqttException 取消订阅异常
     */
    public void unsubscribe(String topic) throws MqttException {
        if (mqttClient == null || !mqttClient.isConnected()) {
            throw new MqttException(MqttException.REASON_CODE_CLIENT_NOT_CONNECTED);
        }

        try {
            mqttClient.unsubscribe(topic);
            logger.info("成功取消订阅主题: {}", topic);
        } catch (MqttException e) {
            logger.error("取消订阅主题失败: {}, error: {}", topic, e.getMessage());
            throw e;
        }
    }

    /**
     * 取消订阅多个主题
     * @param topics 主题数组
     * @throws MqttException 取消订阅异常
     */
    public void unsubscribe(String[] topics) throws MqttException {
        if (mqttClient == null || !mqttClient.isConnected()) {
            throw new MqttException(MqttException.REASON_CODE_CLIENT_NOT_CONNECTED);
        }

        try {
            mqttClient.unsubscribe(topics);
            logger.info("成功取消订阅多个主题");
        } catch (MqttException e) {
            logger.error("取消订阅多个主题失败: {}", e.getMessage());
            throw e;
        }
    }

    /**
     * 发布消息
     * @param topic 主题名称
     * @param payload 消息内容
     * @param qos 服务质量等级 (0, 1, 2)
     * @param retained 是否保留消息
     * @throws MqttException 发布异常
     */
    public void publish(String topic, byte[] payload, int qos, boolean retained) throws MqttException {
        if (mqttClient == null || !mqttClient.isConnected()) {
            throw new MqttException(MqttException.REASON_CODE_CLIENT_NOT_CONNECTED);
        }

        try {
            MqttMessage message = new MqttMessage(payload);
            message.setQos(qos);
            message.setRetained(retained);

            mqttClient.publish(topic, message);
            logger.debug("消息已发布到主题: {}", topic);
        } catch (MqttException e) {
            logger.error("发布消息到主题 {} 失败: {}", topic, e.getMessage());
            throw e;
        }
    }

    /**
     * 发布字符串消息
     * @param topic 主题名称
     * @param message 消息内容
     * @param qos 服务质量等级
     * @param retained 是否保留消息
     * @throws MqttException 发布异常
     */
    public void publishString(String topic, String message, int qos, boolean retained) throws MqttException {
        publish(topic, message.getBytes(), qos, retained);
    }

    /**
     * 发布JSON消息
     * @param topic 主题名称
     * @param jsonObject JSON对象
     * @param qos 服务质量等级
     * @param retained 是否保留消息
     * @throws MqttException 发布异常
     */
    public void publishJson(String topic, JSONObject jsonObject, int qos, boolean retained) throws MqttException {
        publish(topic, jsonObject.toJSONString().getBytes(), qos, retained);
    }

    /**
     * 检查连接状态
     * @return 是否已连接
     */
    public boolean isConnected() {
        return mqttClient != null && mqttClient.isConnected();
    }

    /**
     * 重新订阅所有已注册的主题（核心修复：从configMap获取配置）
     */
    private void resubscribeAllTopics() {
        MqttClientConfig config = configMap.get(this.clientId);
        if (config == null) {
            logger.warn("未找到客户端配置，无法重新订阅: {}", this.clientId);
            return;
        }
        try {
            if (config.getTopics() != null && !config.getTopics().isEmpty()) {
                for (String topic : config.getTopics()) {
                    // 仅订阅合法Topic
                    if (isValidTopic(topic)) {
                        this.subscribe(topic, 0);
                    }
                }
            } else {
                this.subscribe("#", 0);
            }
            logger.info("客户端重连后重新订阅完成: {}", this.clientId);
        } catch (Exception e) {
            logger.error("重连后订阅Topic失败", e);
        }
    }

    /**
     * 校验Topic格式（和MqttClientManager保持一致）
     */
    private boolean isValidTopic(String topic) {
        if (topic == null || topic.isEmpty()) {
            return false;
        }
        if (topic.contains("#") && !topic.endsWith("#")) {
            return false;
        }
        String[] levels = topic.split("/");
        for (String level : levels) {
            if (level.contains("+") && level.length() > 1) {
                return false;
            }
        }
        return true;
    }

    /**
     * 处理接收到的消息
     * @param topic 主题
     * @param message 消息
     */
    private void handleIncomingMessage(String topic, MqttMessage message) {
        try {
            if (defaultMessageListener != null) {
                defaultMessageListener.messageArrived(topic, message);
            } else {
                logger.warn("收到未处理的消息，主题: {}, 内容: {}", topic, new String(message.getPayload()));
            }
        } catch (Exception e) {
            logger.error("处理消息时发生异常，主题: {}, error: {}", topic, e.getMessage());
        }
    }

    /**
     * 清理资源（新增：彻底关闭客户端）
     */
    public void close() {
        try {
            if (mqttClient != null) {
                if (mqttClient.isConnected()) {
                    mqttClient.disconnect();
                }
                mqttClient.close();
                logger.info("MQTT客户端已关闭: {}", this.clientId);
            }
        } catch (MqttException e) {
            logger.error("关闭MQTT客户端时发生错误: {}", e.getMessage());
        }
    }
}