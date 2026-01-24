package com.thinglinks.component.sysws;

import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.*;
import java.util.concurrent.locks.ReentrantLock;

/**
 * 系统自用ws
 * type: component:组件 device:设备
 * sign: 组件id/设备sn
 */
@Component
@ServerEndpoint("/ws/{type}/{sign}")
public class WebSocketServer {
    // 存储用户userName到多个Session的映射 (支持多设备同时在线)
    private static final Map<String, Set<Session>> typeSessions = new ConcurrentHashMap<>();

    // 存储Session的key
    private static final Map<Session, String> sessionKeys = new ConcurrentHashMap<>();

    // 为每个Session添加消息队列（解决并发发送问题）
    private static final Map<Session, BlockingQueue<String>> sessionQueues = new ConcurrentHashMap<>();

    // 为每个Session添加发送线程池
    private static final Map<Session, ExecutorService> sessionExecutors = new ConcurrentHashMap<>();

    // 线程池用于启动发送线程
    private static final ExecutorService executorService = Executors.newCachedThreadPool(r -> {
        Thread t = new Thread(r);
        t.setName("ws-sender-pool-" + t.getId());
        t.setDaemon(true);
        return t;
    });

    // 控制消息队列大小，防止内存溢出
    private static final int MAX_QUEUE_SIZE = 10000;

    @OnOpen
    public void onOpen(Session session, @PathParam("type") String type, @PathParam("sign") String sign) {
        String wsKey = type + "_" + sign;

        // 同步添加session到集合
        synchronized (typeSessions) {
            Set<Session> sessions = typeSessions.get(wsKey);
            if (sessions == null) {
                sessions = new HashSet<>();
                typeSessions.put(wsKey, sessions);
            }
            sessions.add(session);
        }

        sessionKeys.put(session, wsKey);

        // 为每个session初始化消息队列和发送线程
        initializeSessionQueue(session);

        System.out.println("WebSocket连接建立: " + wsKey + ", sessionId: " + session.getId());
    }

    @OnClose
    public void onClose(Session session) {
        String key = sessionKeys.get(session);
        if (key != null) {
            // 先清理消息队列和线程池
            cleanupSessionResources(session);

            // 从用户会话集合中移除当前session
            synchronized (typeSessions) {
                Set<Session> sessions = typeSessions.get(key);
                if (sessions != null) {
                    sessions.remove(session);

                    // 如果用户没有其他连接，则移除用户条目
                    if (sessions.isEmpty()) {
                        typeSessions.remove(key);
                    }
                }
            }
            sessionKeys.remove(session);

            System.out.println("WebSocket连接关闭: " + key + ", sessionId: " + session.getId());
        }
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        String key = sessionKeys.get(session);
        System.err.println("WebSocket错误 - key: " + key + ", sessionId: " + session.getId() + ", error: " + throwable.getMessage());

        if (key != null) {
            // 清理资源
            cleanupSessionResources(session);

            // 从用户会话集合中移除当前session
            synchronized (typeSessions) {
                Set<Session> sessions = typeSessions.get(key);
                if (sessions != null) {
                    sessions.remove(session);

                    // 如果用户没有其他连接，则移除用户条目
                    if (sessions.isEmpty()) {
                        typeSessions.remove(key);
                    }
                }
            }
            sessionKeys.remove(session);
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        String key = sessionKeys.get(session);
        System.out.println("收到来自 " + key + " 的消息: " + message);
        // 处理客户端发来的消息
        // sendToUser(username,new MessageEntity("type",new MessageEntity("test","test","test"),"1"));
    }

    // 广播消息给某个类型所有用户（保持方法签名不变）
    public static void broadcast(String type, String sign, String message) {
        String wsKey = type + "_" + sign;
        Set<Session> sessions = typeSessions.get(wsKey);

        if (sessions == null || sessions.isEmpty()) {
            return;
        }

        // 复制一份session集合，避免并发修改异常
        Set<Session> sessionsCopy;
        synchronized (typeSessions) {
            sessionsCopy = new HashSet<>(sessions);
        }

        // 异步发送消息，避免阻塞调用线程
        executorService.submit(() -> {
            for (Session session : sessionsCopy) {
                if (session.isOpen()) {
                    sendMessageToSession(session, message);
                }
            }
        });
    }

    /**
     * 发送消息到指定session（通过消息队列）
     */
    private static void sendMessageToSession(Session session, String message) {
        BlockingQueue<String> queue = sessionQueues.get(session);
        if (queue == null) {
            // 如果队列不存在，直接发送（兼容性处理）
            synchronized (session) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException ignored) {
                }
            }
            return;
        }

        // 将消息放入队列
        if (!queue.offer(message)) {
            // 队列满了，可以记录日志或采取其他策略
            System.err.println("消息队列已满，丢弃消息 - sessionId: " + session.getId());

            // 可选：尝试直接发送（应急处理）
            synchronized (session) {
                try {
                    if (session.isOpen()) {
                        session.getBasicRemote().sendText(message);
                    }
                } catch (IOException ignored) {
                }
            }
        }
    }

    /**
     * 初始化session的消息队列和发送线程
     */
    private void initializeSessionQueue(Session session) {
        // 创建有界队列
        BlockingQueue<String> queue = new LinkedBlockingQueue<>(MAX_QUEUE_SIZE);
        sessionQueues.put(session, queue);

        // 创建单线程执行器处理该session的消息发送
        ExecutorService executor = Executors.newSingleThreadExecutor(r -> {
            Thread t = new Thread(r);
            t.setName("ws-sender-" + session.getId());
            t.setDaemon(true);
            return t;
        });

        sessionExecutors.put(session, executor);

        // 启动消息发送线程
        executor.submit(() -> {
            processMessageQueue(session, queue);
        });
    }

    /**
     * 处理消息队列
     */
    private void processMessageQueue(Session session, BlockingQueue<String> queue) {
        String sessionId = session.getId();
        String key = sessionKeys.get(session);

        while (session.isOpen() && !Thread.currentThread().isInterrupted()) {
            try {
                // 从队列中获取消息，最多等待1秒
                String message = queue.poll(1, TimeUnit.SECONDS);

                if (message != null) {
                    // 同步发送，确保同一时间只有一个线程发送
                    synchronized (session) {
                        if (session.isOpen()) {
                            try {
                                session.getBasicRemote().sendText(message);
                            } catch (IOException e) {
                                System.err.println("发送消息失败 - key: " + key + ", sessionId: " + sessionId);
                                break; // 发送失败，退出循环
                            }
                        } else {
                            break; // session已关闭，退出循环
                        }
                    }
                }

                // 如果队列空了，可以稍微休息一下
                if (queue.isEmpty()) {
                    Thread.sleep(10);
                }

            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                break;
            } catch (Exception e) {
                System.err.println("处理消息队列异常 - sessionId: " + sessionId + ", error: " + e.getMessage());
                break;
            }
        }

        System.out.println("消息队列处理线程结束 - sessionId: " + sessionId);
    }

    /**
     * 清理session相关资源
     */
    private void cleanupSessionResources(Session session) {
        // 清理消息队列
        BlockingQueue<String> queue = sessionQueues.remove(session);
        if (queue != null) {
            queue.clear();
        }

        // 关闭执行器
        ExecutorService executor = sessionExecutors.remove(session);
        if (executor != null) {
            executor.shutdownNow();
            try {
                if (!executor.awaitTermination(5, TimeUnit.SECONDS)) {
                    System.err.println("Executor未能正常关闭 - sessionId: " + session.getId());
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }

    /**
     * 获取连接统计信息（用于监控）
     */
    public static Map<String, Object> getConnectionStats() {
        Map<String, Object> stats = new ConcurrentHashMap<>();
        stats.put("totalConnections", sessionKeys.size());
        stats.put("totalGroups", typeSessions.size());

        // 计算消息队列状态
        int totalQueuedMessages = sessionQueues.values().stream()
                .mapToInt(BlockingQueue::size)
                .sum();
        stats.put("totalQueuedMessages", totalQueuedMessages);

        // 统计每个group的连接数
        Map<String, Integer> groupStats = new ConcurrentHashMap<>();
        typeSessions.forEach((key, sessions) -> {
            groupStats.put(key, sessions.size());
        });
        stats.put("groupConnections", groupStats);

        return stats;
    }

    /**
     * 优雅关闭（在应用关闭时调用）
     */
    public static void shutdown() {
        // 关闭所有session的发送线程
        sessionExecutors.values().forEach(executor -> {
            executor.shutdownNow();
        });
        sessionExecutors.clear();

        // 清空所有队列
        sessionQueues.values().forEach(queue -> {
            queue.clear();
        });
        sessionQueues.clear();

        // 关闭线程池
        if (executorService != null && !executorService.isShutdown()) {
            executorService.shutdownNow();
            try {
                if (!executorService.awaitTermination(10, TimeUnit.SECONDS)) {
                    System.err.println("ExecutorService未能正常关闭");
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
}