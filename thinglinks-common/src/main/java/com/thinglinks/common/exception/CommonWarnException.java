package com.thinglinks.common.exception;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-22
 */
public class CommonWarnException extends Exception{
    private static final long serialVersionUID = 1L;
    private final String msg;
    public CommonWarnException(String msg)
    {
        this.msg = msg;
    }
    public String getMessage() {
        return msg;
    }
}
