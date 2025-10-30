package com.thinglinks.component.event;

import org.springframework.context.ApplicationEvent;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-25
 */
public class MessageDownEvent extends ApplicationEvent {
    private final String topic;
    private final Object data;

    public MessageDownEvent(Object source, String topic, Object data) {
        super(source);
        this.topic = topic;
        this.data = data;
    }

    public String getTopic() { return topic; }
    public Object getData() { return data; }
}
