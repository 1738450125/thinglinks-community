package com.thinglinks.component.message;

import lombok.Data;

/**
 * @Description: 设备自注册
 * @Author: thinglinks
 * @CreateTime: 2025-09-19
 */
@Data
public class DeviceRegister {
    /**产品sn*/
    private String productSn;
    /**设备sn*/
    private String deviceSn;
    /**设备名称*/
    private String deviceName;
    /**TODO 其他属性*/
}
