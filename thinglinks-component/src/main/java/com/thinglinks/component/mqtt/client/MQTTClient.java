package com.thinglinks.component.mqtt.client;

import com.alibaba.fastjson2.JSONObject;
import com.thinglinks.common.utils.spring.SpringUtils;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
     * 设置是否自动重连
     * @param automaticReconnect 是否自动重连
     */
    public void setAutomaticReconnect(boolean automaticReconnect) {
        this.automaticReconnect = automaticReconnect;
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
            MqttConnectOptions options = new MqttConnectOptions();
            options.setCleanSession(true);
            options.setConnectionTimeout(connectionTimeout);
            options.setKeepAliveInterval(keepAliveInterval);
            options.setAutomaticReconnect(automaticReconnect);

            if (username != null && password != null) {
                options.setUserName(username);
                options.setPassword(password.toCharArray());
            }

            mqttClient = new MqttClient(brokerUrl, clientId, new MemoryPersistence());

            // 设置回调
            mqttClient.setCallback(new MqttCallbackExtended() {
                @Override
                public void connectComplete(boolean reconnect, String serverURI) {
                    logger.info("MQTT连接成功: {}", serverURI);
                    if (reconnect) {
                        // 重连后重新订阅所有主题
                        resubscribeAllTopics();
                        // 设置默认消息处理器
                        setDefaultMessageListener((topic, message) -> {
                            try {
                                SpringUtils.getBean(MqttClientConsumer.class).message(clientId,topic, message);
                            } catch (Exception ignore) {
                            }
                        });
                    }
                }

                @Override
                public void connectionLost(Throwable cause) {
                    logger.warn("MQTT连接丢失: {}", cause.getMessage());
                }

                @Override
                public void messageArrived(String topic, MqttMessage message) throws Exception {
                    handleIncomingMessage(topic, message);
                }

                @Override
                public void deliveryComplete(IMqttDeliveryToken token) {
                    // 消息发布完成回调
                    if (token.getException() != null) {
                        logger.error("消息发布失败: {}", token.getException().getMessage());
                    } else {
                        logger.debug("消息发布成功");
                    }
                }
            });

            mqttClient.connect(options);
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
    public void subscribe(String topic,int qos) throws MqttException {
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
     * 重新订阅所有已注册的主题
     */
    private void resubscribeAllTopics() {
        //订阅所有topic
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
     * 清理资源
     */
    public void close() {
        try {
            if (mqttClient != null && mqttClient.isConnected()) {
                mqttClient.disconnect();
            }
            if (mqttClient != null) {
                mqttClient.close();
            }
            logger.info("MQTT客户端已关闭");
        } catch (MqttException e) {
            logger.error("关闭MQTT客户端时发生错误: {}", e.getMessage());
        }
    }
}
