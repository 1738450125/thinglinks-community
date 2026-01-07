package com.thinglinks.component.tcp;
import com.thinglinks.common.utils.spring.SpringUtils;
import com.thinglinks.common.utils.uuid.UUID;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * TCP服务器实例
 */
public class TCPServerInstance implements Runnable {
    private final int port;
    private final String id;

    private final ServerHandler handler;
    private ServerSocket serverSocket;
    private final AtomicBoolean isRunning = new AtomicBoolean(true);
    private final ConcurrentHashMap<String, ClientHandler> clients = new ConcurrentHashMap<>();

    public TCPServerInstance(String id,int port, ServerHandler handler) throws IOException {
        this.id = id;
        this.port = port;
        this.handler = handler;
        this.serverSocket = new ServerSocket(port);
    }

    @Override
    public void run() {
        System.out.println("TCP服务器开始监听端口: " + port);

        try {
            while (isRunning.get()) {
                Socket clientSocket = serverSocket.accept();
                String clientId = UUID.randomUUID().toString();
                ClientHandler clientHandler = new ClientHandler(id,clientSocket, clientId, handler);
                clients.put(clientId, clientHandler);

                // 在线程池中处理客户端连接
                SpringUtils.getBean(ThreadPoolTaskExecutor.class).execute(clientHandler);

            }
        } catch (IOException e) {
            if (isRunning.get()) {
                System.err.println("服务器异常，端口: " + port + ", 错误: " + e.getMessage());
            }
        } finally {
            closeServer();
        }
    }

    /**
     * 停止服务器
     */
    public void stop() {
        isRunning.set(false);
        closeServer();
    }

    /**
     * 关闭服务器和所有客户端连接
     */
    private void closeServer() {
        try {
            if (serverSocket != null && !serverSocket.isClosed()) {
                serverSocket.close();
            }

            // 关闭所有客户端连接
            clients.forEach((id, client) -> client.close());
            clients.clear();

        } catch (IOException e) {
            System.err.println("关闭服务器时出错，端口: " + port + ", 错误: " + e.getMessage());
        }
    }

    /**
     * 向指定客户端发送消息
     */
    public void sendToClient(String clientId, String message) {
        ClientHandler client = clients.get(clientId);
        if (client != null) {
            client.sendMessage(message);
        }
    }

    /**
     * 广播消息给所有客户端
     */
    public void broadcast(String message) {
        clients.forEach((clientId, client) -> client.sendMessage(message));
    }

    /**
     * 通过clientId获取客户端
     */
    public ClientHandler getClientByClientId(String clientId){
        return clients.get(clientId);
    }

    /**
     * 获取连接客户端数量
     */
    public int getClientCount() {
        return clients.size();
    }

    public int getPort() {
        return port;
    }

    public boolean isRunning() {
        return isRunning.get();
    }
}
