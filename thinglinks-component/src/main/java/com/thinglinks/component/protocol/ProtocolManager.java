package com.thinglinks.component.protocol;

import com.alibaba.fastjson2.JSONArray;
import com.thinglinks.common.utils.spring.SpringUtils;
import org.springframework.data.redis.core.RedisTemplate;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.*;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

/**
 * @Description: 协议管理
 * @Author: thinglinks
 * @CreateTime: 2025-09-19
 */
public class ProtocolManager {
    /**
     * key:协议id value:解码方法
     */
    public static Map<String,Method> DECODE_METHOD = new HashMap<>();
    /**
     * key:协议id value:指令方法
     */
    public static Map<String,Method> ENCODE_METHOD = new HashMap<>();
    /**
     * key:协议id value:协议包实例
     */
    public static Map<String,Object> CLASS_INSTANCE = new HashMap<>();
    /**
     * key:组件id value:协议id列表
     */
    public static Map<String,String> PROTOCOL_MAP = new HashMap<>();
    /**
     * 类加载器
     */
    public static Map<String,URLClassLoader> CLASSLOADER_MAP = new HashMap<>();
    public static String redisPath = "com.thinglinks.protocol.utils.RedisContextHolder";
    public static boolean addProtocol(String id,String protocolType,String path,String mainClass) throws Exception {
        File file = new File(path);
        URL url = file.toURI().toURL();
        URL[] urls = new URL[]{url};
        URLClassLoader classLoader = new URLClassLoader(urls, Thread.currentThread().getContextClassLoader());
        Class<?> interfaceClass = classLoader.loadClass(mainClass);
        List<Class<?>> implementations = findImplementations(file, interfaceClass, classLoader);
        RedisTemplate<String, Object> redisTemplate = SpringUtils.getBean("redisTemplate");
        try {
            Class<?> redisContextClass = classLoader.loadClass(redisPath);
            Method setRedisTemplateMethod = redisContextClass.getMethod(
                    "setRedisTemplate",
                    RedisTemplate.class  // 方法的参数类型
            );
            setRedisTemplateMethod.invoke(redisContextClass, redisTemplate);
        }catch (Exception e){
            e.printStackTrace();
        }
        if (!implementations.isEmpty()) {
            // 使用第一个找到的实现类
            Class<?> implementationClass = implementations.get(0);
            Object instance = implementationClass.getDeclaredConstructor().newInstance();
            Method decodeMethod = null;
            Method encodeMethod = null;
            // 反射调用方法
            switch (protocolType){
                case "MQTT_CLIENT":
                    decodeMethod = implementationClass.getMethod("decode",String.class,String.class);
                    encodeMethod = implementationClass.getMethod("encode",String.class,String.class,Map.class,String.class,String.class);
                    break;
                case "TCP_SERVER":
                    decodeMethod = implementationClass.getMethod("decode",String.class);
                    encodeMethod = implementationClass.getMethod("encode",String.class,String.class,Map.class,String.class,String.class);
                    break;
                default:
            }
            CLASS_INSTANCE.put(id,instance);
            DECODE_METHOD.put(id,decodeMethod);
            ENCODE_METHOD.put(id,encodeMethod);
            CLASSLOADER_MAP.put(id, classLoader); // 存储 ClassLoader 引用
        } else {
            System.out.println("未找到实现类");
        }
        return true;
    }

    // 卸载方法
    public static boolean removeProtocol(String protocolId) {
        URLClassLoader classLoader = CLASSLOADER_MAP.remove(protocolId);
        if (classLoader != null) {
            try {
                classLoader.close(); // 关闭 ClassLoader（Java 7+）
                // 同时清理其他相关资源
                CLASS_INSTANCE.remove(protocolId);
                DECODE_METHOD.remove(protocolId);
                ENCODE_METHOD.remove(protocolId);
                return true;
            } catch (IOException e) {
                System.err.println("关闭 ClassLoader 失败: " + e.getMessage());
                return false;
            }
        }
        return false;
    }

    // 卸载通过组件id
    public static boolean removeProtocolByComponentId(String componentId) {
        String protocolId = PROTOCOL_MAP.remove(componentId);
        if(protocolId==null){
            return true;
        }
        URLClassLoader classLoader = CLASSLOADER_MAP.remove(protocolId);
        if (classLoader != null) {
            try {
                classLoader.close(); // 关闭 ClassLoader（Java 7+）
                // 同时清理其他相关资源
                CLASS_INSTANCE.remove(protocolId);
                DECODE_METHOD.remove(protocolId);
            } catch (IOException e) {
                System.err.println("关闭 ClassLoader 失败: " + e.getMessage());
            }
        }
        return true;
    }

    // 查找JAR包中所有实现指定接口的类
    private static List<Class<?>> findImplementations(File jarFile, Class<?> interfaceClass, URLClassLoader classLoader)
            throws Exception {
        List<Class<?>> implementations = new ArrayList<>();

        try (JarFile jar = new JarFile(jarFile)) {
            Enumeration<JarEntry> entries = jar.entries();

            while (entries.hasMoreElements()) {
                JarEntry entry = entries.nextElement();
                if (entry.getName().endsWith(".class")) {
                    String className = entry.getName()
                            .replace("/", ".")
                            .replace(".class", "");

                    try {
                        Class<?> clazz = classLoader.loadClass(className);
                        if (!clazz.isInterface() &&
                                interfaceClass.isAssignableFrom(clazz) &&
                                !clazz.equals(interfaceClass)) {
                            implementations.add(clazz);
                        }
                    } catch (NoClassDefFoundError | Exception e) {
                        // 忽略无法加载的类
                    }
                }
            }
        }

        return implementations;
    }
}
