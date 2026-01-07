package com.thinglinks.component.message;

import com.alibaba.fastjson2.JSONObject;

import java.util.Date;

/**
 * @Description: 消息处理类
 * @Author: thinglinks
 * @CreateTime: 2025-10-09
 */
public class MessageUtils {

    public static DecodeMessage parseMessage(Object data){
        if(data==null){
            return null;
        }
        String json = JSONObject.toJSONString(data);
        DecodeMessage decodeMessage = JSONObject.parseObject(json,DecodeMessage.class);
        if(decodeMessage.getReportTime()==null){
            decodeMessage.setReportTime(new Date());
        }
        return decodeMessage;
    }
}
