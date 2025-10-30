package com.thinglinks.component.event;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-25
 */
@FunctionalInterface
public interface EventFilter {
    boolean accept(Object event);
}