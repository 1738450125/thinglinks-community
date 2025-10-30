package com.thinglinks.component.event;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-25
 */
@Component
public class SpringEventBus implements EventBus {
    private final Map<String, List<EventListener>> subscribers = new ConcurrentHashMap<>();
    private final Map<String, List<FilteredEventListener>> filteredSubscribers = new ConcurrentHashMap<>();

    private final ApplicationEventPublisher applicationEventPublisher;

    public SpringEventBus(ApplicationEventPublisher applicationEventPublisher) {
        this.applicationEventPublisher = applicationEventPublisher;
    }

    @Override
    public void publish(String topic,Object event) {
        // 发布到Spring事件机制
        applicationEventPublisher.publishEvent(event);

        // 同时处理直接订阅者
        notifySubscribers(topic, event);
    }

    @Override
    public void subscribe(String topic, EventListener listener) {
        subscribers.computeIfAbsent(topic, k -> new CopyOnWriteArrayList<>())
                .add(listener);
    }

    @Override
    public void unsubscribe(String topic, EventListener listener) {
        List<EventListener> topicSubscribers = subscribers.get(topic);
        if (topicSubscribers != null) {
            topicSubscribers.remove(listener);
        }
    }

    @Override
    public void subscribe(String topic, EventListener listener, EventFilter filter) {
        filteredSubscribers.computeIfAbsent(topic, k -> new CopyOnWriteArrayList<>())
                .add(new FilteredEventListener(listener, filter));
    }

    private void notifySubscribers(String topic, Object event) {
        // 通知普通订阅者
        List<EventListener> topicSubscribers = subscribers.get(topic);
        if (topicSubscribers != null) {
            topicSubscribers.forEach(listener -> {
                try {
                    listener.onEvent(event);
                } catch (Exception e) {
                    // 处理异常，避免影响其他订阅者
                    System.err.println("事件处理异常: " + e.getMessage());
                }
            });
        }

        // 通知过滤订阅者
        List<FilteredEventListener> filtered = filteredSubscribers.get(topic);
        if (filtered != null) {
            filtered.forEach(filteredListener -> {
                if (filteredListener.filter.accept(event)) {
                    try {
                        filteredListener.listener.onEvent(event);
                    } catch (Exception e) {
                        System.err.println("过滤事件处理异常: " + e.getMessage());
                    }
                }
            });
        }
    }

    private static class FilteredEventListener {
        final EventListener listener;
        final EventFilter filter;

        FilteredEventListener(EventListener listener, EventFilter filter) {
            this.listener = listener;
            this.filter = filter;
        }
    }
}
