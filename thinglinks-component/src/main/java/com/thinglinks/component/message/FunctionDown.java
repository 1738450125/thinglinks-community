package com.thinglinks.component.message;

import lombok.Data;

/**
 * @Description: 下发指令
 * @Author: thinglinks
 * @CreateTime: 2026-01-19
 */
@Data
public class FunctionDown {
    //默认当前消息的设备SN，可配置为任何设备的下发
    private String deviceSn;
    //指令CODE
    private String functionCode;
    //指令参数
    private String functionParams;
}