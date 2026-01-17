package com.thinglinks.component.mqtt.client;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-15
 */

import com.thinglinks.common.utils.spring.SpringUtils;
import lombok.Data;
import org.eclipse.paho.client.mqttv3.MqttException;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@Data
public class MqttClientManager {
    public static Map<String, MQTTClient> clientMap = new ConcurrentHashMap<>();
    public static Map<String, MqttClientConfig> configMap = new ConcurrentHashMap<>();
    public static Map<String, Set<String>> CLIENT_DEVICE = new HashMap<>();
    // 添加MQTT连接
    public static boolean addConnection(MqttClientConfig config) {
        try {
            MQTTClient mqttClient;
            mqttClient = new MQTTClient(config.getBrokerUrl(), config.getClientId());
            mqttClient.setCredentials(config.getUsername(), config.getPassword());
            // 设置默认消息处理器
            mqttClient.setDefaultMessageListener((topic, message) -> {
                try {
                    SpringUtils.getBean(MqttClientConsumer.class).message(config.getClientId(),topic, message);
                } catch (Exception ignore) {
                }
            });
            mqttClient.connect();
            if(config.getTopics()!=null&&config.getTopics().size()>0){
                config.getTopics().forEach(topic->{
                    try {
                        mqttClient.subscribe(topic,0);
                    } catch (MqttException e) {
                        throw new RuntimeException(e);
                    }
                });
            }else {
                mqttClient.subscribe("#",0);
            }
            if(mqttClient.isConnected()){
                clientMap.put(config.getClientId(),mqttClient);
                mqttClient.setAutomaticReconnect(true);
            }
            return mqttClient.isConnected();
        }catch (Exception e){
            return false;
        }
    }
    // 删除mqtt连接
    public static boolean deleteConnection(String clientId) throws MqttException {
        MQTTClient mqttClient = clientMap.getOrDefault(clientId,null);
        if(mqttClient==null){
            return true;
        }
        mqttClient.disconnect();
        clientMap.remove(clientId);
        return true;
    }
    //发送消息
    public static boolean publishMessage(String clientId,String topic,byte[] message) throws MqttException {
        return publishMessage(clientId,topic,message,0,false);
    }

    public static boolean publishMessage(String clientId,String topic,byte[] message,int qos,boolean retain) throws MqttException {
        try {
            MQTTClient mqttClient = clientMap.getOrDefault(clientId,null);
            if(mqttClient==null){
                return false;
            }
            mqttClient.publish(topic,message,qos,retain);
            return true;
        }catch (Exception e){
            return false;
        }
    }
    /**
     * 绑定设备
     */
    public static void bindDevice(String clientId,String deviceSn){
        Set<String> set = CLIENT_DEVICE.getOrDefault(clientId,null);
        if(set!=null){
            set.add(deviceSn);
        }else {
            Set<String> deviceSet = new HashSet<>();
            deviceSet.add(deviceSn);
            CLIENT_DEVICE.put(clientId,deviceSet);
        }
    }
}
