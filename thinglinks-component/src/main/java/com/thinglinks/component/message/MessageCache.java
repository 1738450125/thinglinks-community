package com.thinglinks.component.message;

import com.thinglinks.common.utils.StringUtils;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 设备最新数据缓存
 */
public class MessageCache {
    /**
     * key：设备sn
     * value：数据json
     */
    public final static Map<String, DecodeMessage> DEVICE_LAST_DATA = new HashMap<>();

    /**
     * 获取设备属性最新状态数据（全部属性,可能不同属性上传时间不同）
     */
    public static DecodeMessage getDeviceLastData(String deviceSn){
        return DEVICE_LAST_DATA.getOrDefault(deviceSn,null);
    }
    /**
     * 设置设备属性（可以只设置部分属性）
     */
    public static void setDeviceLastData(String deviceSn,DecodeMessage decodeMessage){
        DecodeMessage oldData = DEVICE_LAST_DATA.getOrDefault(deviceSn,null);
        if(oldData==null|| StringUtils.isEmpty(oldData.getDeviceSn())||oldData.getProperties()==null){
            decodeMessage.setReportTime(decodeMessage.getReportTime()==null?new Date():decodeMessage.getReportTime());
            DEVICE_LAST_DATA.put(deviceSn,decodeMessage);
        }else {
            decodeMessage.getProperties().keySet().forEach(key->{
                oldData.getProperties().put(key,decodeMessage.getProperties().get(key));
            });
            oldData.setDeviceSn(decodeMessage.getDeviceSn());
            oldData.setReportTime(decodeMessage.getReportTime()==null?new Date():decodeMessage.getReportTime());
            oldData.setDeviceRegister(decodeMessage.getDeviceRegister());
            oldData.setCoapIsRecover(decodeMessage.getCoapIsRecover());
            oldData.setIsStore(decodeMessage.getIsStore());
            oldData.setIsOnline(decodeMessage.getIsOnline());
            oldData.setIsRegister(decodeMessage.getIsRegister());
            oldData.setCoapRecoverContent(decodeMessage.getCoapRecoverContent());
            oldData.setHttpReply(decodeMessage.getHttpReply());
        }
    }
}
