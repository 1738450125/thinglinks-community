package com.thinglinks.component.event;

import org.springframework.context.ApplicationEvent;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-25
 */
public class MessageUpEvent extends ApplicationEvent {
    private final String topic;
    private final Object data;
    private final String deviceSn;
    public MessageUpEvent(Object source, String topic,String deviceSn, Object data) {
        super(source);
        this.topic = topic;
        this.data = data;
        this.deviceSn = deviceSn;
    }

    public String getTopic() { return topic; }
    public Object getData() { return data; }
    public String getDeviceSn() { return deviceSn; }
}
