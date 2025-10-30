package com.thinglinks.common.exception;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-22
 */
public class CommonErrorException extends Exception{
    private static final long serialVersionUID = 1L;
    private final String msg;
    public CommonErrorException(String msg)
    {
        this.msg = msg;
    }
    public String getMessage() {
        return msg;
    }
}
