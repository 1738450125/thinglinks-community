package com.thinglinks.component.utils;

/**
 * @Description: 消息处理工具类
 * @Author: thinglinks
 * @CreateTime: 2025-10-14
 */
public class MessageUtils {
    /**
     * 将字符串转换为十六进制
     */
    public static String stringToHex(String input) {
        if (input == null) {
            return "null";
        }

        StringBuilder hexString = new StringBuilder();
        for (char c : input.toCharArray()) {
            String hex = Integer.toHexString(c);
            // 确保每个字符都是2位十六进制
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex).append(' ');
        }
        return hexString.toString().trim();
    }
}
