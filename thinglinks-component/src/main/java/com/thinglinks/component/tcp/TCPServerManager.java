package com.thinglinks.component.tcp;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import static com.thinglinks.component.tcp.TCPClientManager.DEVICE_CLIENT;

/**
 * TCP服务器管理器 - 支持动态添加和管理多个TCP服务器
 */
public class TCPServerManager {
    private final ExecutorService executor = Executors.newCachedThreadPool();

    private static TCPServerManager instance;

    public static Map<String,TCPServerInstance> tcpServerInstanceMap = new HashMap<>();

    private TCPServerManager() {}

    public static synchronized TCPServerManager getInstance() {
        if (instance == null) {
            instance = new TCPServerManager();
        }
        return instance;
    }

    /**
     * 动态添加TCP服务器 - 静态方法
     */
    public static boolean addServer(String id,int port, ServerHandler handler) {
        return getInstance().addServerInstance(id,port, handler);
    }

    /**
     * 实例方法 - 供静态方法内部调用
     */
    private boolean addServerInstance(String id,int port, ServerHandler handler) {

        try {
            TCPServerInstance serverInstance = new TCPServerInstance(id,port, handler);
            tcpServerInstanceMap.put(id,serverInstance);
            executor.execute(serverInstance);
            System.out.println("TCP服务器启动成功，端口: " + port);
            return true;
        } catch (IOException e) {
            System.err.println("启动TCP服务器失败，端口: " + port + ", 错误: " + e.getMessage());
            return false;
        }
    }

    /**
     * 移除TCP服务器 - 静态方法
     */
    public static boolean removeServer(String id) {
        return getInstance().removeServerInstance(id);
    }

    private boolean removeServerInstance(String id) {
        TCPServerInstance server = tcpServerInstanceMap.get(id);;
        if (server != null) {
            server.stop();
            tcpServerInstanceMap.remove(id);
            return true;
        }
        return false;
    }

    /**
     * 获取所有运行的服务器id - 静态方法
     */
    public static java.util.Set<String> getRunningServers() {
        return tcpServerInstanceMap.keySet();
    }

    /**
     * 停止所有服务器 - 静态方法
     */
    public static void stopAllServers() {
        getInstance().stopAllServersInstance();
    }

    private void stopAllServersInstance() {
        tcpServerInstanceMap.forEach((port, server) -> server.stop());
        tcpServerInstanceMap.clear();
        executor.shutdown();
        System.out.println("所有TCP服务器已停止");
    }

    /**
     * 获取服务器实例 - 静态方法
     */
    public static TCPServerInstance getServerInstance(String id) {
        return tcpServerInstanceMap.get(id);
    }

    /**
     * 向设备发送消息
     */
    public static boolean sendMessageToDevice(String deviceSn,String message){
        ClientHandler clientHandler = DEVICE_CLIENT.getOrDefault(deviceSn,null);
        if(clientHandler!=null){
            clientHandler.sendMessage(message);
            return true;
        }
        return false;
    }
}