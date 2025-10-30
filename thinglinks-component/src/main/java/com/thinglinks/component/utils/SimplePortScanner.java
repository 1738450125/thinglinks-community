package com.thinglinks.component.utils;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-22
 */
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SimplePortScanner {

    public static List<Integer> getOpenPorts() {
        List<Integer> ports = new ArrayList<>();
        String os = System.getProperty("os.name").toLowerCase();
        String command = os.contains("win") ?
                "netstat -ano | findstr LISTENING" :
                "ss -tuln | grep LISTEN";

        try {
            Process process = Runtime.getRuntime().exec(
                    os.contains("win") ? new String[]{"cmd.exe", "/c", command} :
                            new String[]{"sh", "-c", command}
            );

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(process.getInputStream()));

            String line;
            Pattern pattern = Pattern.compile(":(\\d+)");

            while ((line = reader.readLine()) != null) {
                Matcher matcher = pattern.matcher(line);
                if (matcher.find()) {
                    try {
                        int port = Integer.parseInt(matcher.group(1));
                        if (!ports.contains(port)) { // 简单去重
                            ports.add(port);
                        }
                    } catch (NumberFormatException e) {
                        // 忽略解析错误
                    }
                }
            }

            process.waitFor();
            ports.sort(Integer::compareTo); // 排序

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }

        return ports;
    }

    public static void main(String[] args) {
        List<Integer> ports = getOpenPorts();
        System.out.println("开放端口列表: " + ports);
        System.out.println("端口数量: " + ports.size());
    }
}
