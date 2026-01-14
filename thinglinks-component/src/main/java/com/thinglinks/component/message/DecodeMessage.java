package com.thinglinks.component.message;

import lombok.Data;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Description: 解码后的消息
 * @Author: thinglinks
 * @CreateTime: 2025-09-19
 */
@Data
public class DecodeMessage {
    /**设备sn*/
    private String deviceSn;
    /**设备属性，请与物模型保持一致*/
    private Map<String,Object> properties;
    /**上报时间-协议中不设置则默认当前时间*/
    private Date reportTime;

    //========设备自注册，需要注册时，开关和数据都需要设置
    /**是否需要注册设备，默认不注册，需要注册设置为true，请尽量避免注册过的设备反复注册，浪费服务器性能*/
    private Boolean isRegister = false;
    /**设备自注册列表*/
    private List<DeviceRegister> deviceRegister;

    //========下列配置常规情况下不用修改，可根据设备情况进行修改
    /**是否存储，默认存储，用于协议判断该消息是否有用，无用消息可以选择不存储，例如心跳消息等*/
    private Boolean isStore = true;
    /**是否在线，默认在线，设置为false则为离线*/
    private Boolean isOnline = true;

    //======COAP协议可配置，其他协议配置无效
    /**是否回复*/
    private Boolean coapIsRecover = false;
    /**回复内容*/
    private String coapRecoverContent = null;

    //======HTTP回复体
    /**是否需要回复*/
    private Boolean httpNeedReply = false;
    /**回复内容*/
    private Object httpReply;
}
