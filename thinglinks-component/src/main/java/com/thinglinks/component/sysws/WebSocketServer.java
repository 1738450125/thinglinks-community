package com.thinglinks.component.sysws;

import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

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

    @OnOpen
    public void onOpen(Session session, @PathParam("type") String type,@PathParam("sign")String sign) {
        // 验证用户ID逻辑可以在这里添加
        String wsKey = type+"_"+sign;
        if(typeSessions.containsKey(wsKey)){
            Set<Session> sessions = typeSessions.get(wsKey);
            sessions.add(session);
        }else {
            Set<Session> sessions = new HashSet<>();
            sessions.add(session);
            typeSessions.put(wsKey,sessions);
        }
        sessionKeys.put(session,wsKey);
    }

    @OnClose
    public void onClose(Session session) {
        String key = sessionKeys.get(session);
        if (key != null) {
            // 从用户会话集合中移除当前session
            Set<Session> sessions = typeSessions.get(key);
            if (sessions != null) {
                sessions.remove(session);

                // 如果用户没有其他连接，则移除用户条目
                if (sessions.isEmpty()) {
                    typeSessions.remove(key);
                }
            }
            sessionKeys.remove(session);
        }
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        String key = sessionKeys.get(session);
        if (key != null) {
            // 从用户会话集合中移除当前session
            Set<Session> sessions = typeSessions.get(key);
            if (sessions != null) {
                sessions.remove(session);

                // 如果用户没有其他连接，则移除用户条目
                if (sessions.isEmpty()) {
                    typeSessions.remove(key);
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
//        sendToUser(username,new MessageEntity("type",new MessageEntity("test","test","test"),"1"));
    }

    // 广播消息给某个类型所有用户
    public static void broadcast(String type,String sign,String message) {
        Set<Session> sessions = typeSessions.getOrDefault(type+"_"+sign,null);
        if(sessions==null){
            return;
        }
        sessions.forEach(session -> {
            if (session.isOpen()) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException ignored) {}
            }
        });
    }
}