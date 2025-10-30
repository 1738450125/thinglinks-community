package com.thinglinks.component.tcp;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.net.Socket;

/**
 * 客户端连接处理器
 */
public class ClientHandler implements Runnable {
    private final Socket clientSocket;
    private final String clientId;
    private final ServerHandler handler;
    private PrintWriter out;
    private BufferedReader in;
    private volatile boolean isConnected = true;
    private String componentId;

    public ClientHandler(String componentId,Socket socket, String clientId, ServerHandler handler) {
        this.clientSocket = socket;
        this.clientId = clientId;
        this.handler = handler;
        this.componentId = componentId;
    }

    @Override
    public void run() {
        try {
            out = new PrintWriter(clientSocket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

            // 通知处理器有新连接
            handler.onClientConnected(clientId);

            String inputLine;
            while (isConnected && (inputLine = in.readLine()) != null) {
                // 处理接收到的消息
                handler.onMessageReceived(componentId,clientId, inputLine);
            }

        } catch (IOException e) {
            if (isConnected) {
                System.err.println("客户端处理异常: " + clientId + ", 错误: " + e.getMessage());
            }
        } catch (InvocationTargetException | IllegalAccessException e) {
            throw new RuntimeException(e);
        } finally {
            close();
            handler.onClientDisconnected(clientId);
        }
    }

    /**
     * 发送消息到客户端
     */
    public void sendMessage(String message) {
        if (out != null && isConnected) {
            out.println(message);
            out.flush();
        }
    }

    /**
     * 关闭连接
     */
    public void close() {
        isConnected = false;
        try {
            if (in != null) in.close();
            if (out != null) out.close();
            if (clientSocket != null && !clientSocket.isClosed()) {
                clientSocket.close();
            }
        } catch (IOException e) {
            System.err.println("关闭客户端连接时出错: " + clientId);
        }
    }

    public String getClientId() {
        return clientId;
    }

    public boolean isConnected() {
        return isConnected;
    }
}