package com.thinglinks.component.protocol;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description: 下发消息
 * @Author: chen tao
 * @CreateTime: 2025-10-24
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class EncodeMessage {
    /**设备SN*/
    private String deviceSn;
    /**是否下发 默认false (有可能不需要平台操作，比如HTTP，只能是协议自己执行操作)*/
    private Boolean isSend = false;
    /**发送内容 全部转为字节数组，平台自行处理*/
    private byte[] content;

    //========以下是MQTT专属配置
    /**发送消息的topic*/
    private String topic;
    /**服务质量等级*/
    private Integer qos = 0;
    /**是否保留消息*/
    private Boolean retain = false;

}
