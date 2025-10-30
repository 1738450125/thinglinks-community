package com.thinglinks.component.utils;

import java.io.IOException;
import java.net.*;
import java.util.List;
import java.util.Map;
import java.util.concurrent.*;

/**
 * 端口状态检测工具类
 */
public class PortChecker {

    /**
     * 检测TCP端口是否关闭
     */
    public static boolean isTcpPortClosed(String host, int port) {
        return isTcpPortClosed(host, port, 3000); // 默认3秒超时
    }

    public static boolean isTcpPortClosed(String host, int port, int timeoutMillis) {
        try (Socket socket = new Socket()) {
            socket.connect(new InetSocketAddress(host, port), timeoutMillis);
            return false; // 连接成功，端口开放
        } catch (ConnectException e) {
            // 连接被拒绝，端口关闭
            return true;
        } catch (SocketTimeoutException e) {
            // 连接超时，可能端口被防火墙阻挡
            return true;
        } catch (IOException e) {
            // 其他IO异常，视为端口关闭
            return true;
        }
    }

    /**
     * 检测UDP端口是否关闭（UDP检测不太可靠）
     */
    public static boolean isUdpPortClosed(String host, int port) {
        return isUdpPortClosed(host, port, 3000);
    }

    public static boolean isUdpPortClosed(String host, int port, int timeoutMillis) {
        try (DatagramSocket socket = new DatagramSocket()) {
            socket.setSoTimeout(timeoutMillis);

            // 发送一个空数据包
            InetAddress address = InetAddress.getByName(host);
            byte[] sendData = new byte[1]; // 空数据
            DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, address, port);
            socket.send(sendPacket);

            // 尝试接收响应（如果端口开放，可能会收到ICMP不可达错误）
            byte[] receiveData = new byte[1024];
            DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);

            try {
                socket.receive(receivePacket);
                // 收到响应，端口可能开放
                return false;
            } catch (SocketTimeoutException e) {
                // 超时，无法确定端口状态
                return true; // 保守估计为关闭
            }

        } catch (IOException e) {
            return true; // 发生异常，视为关闭
        }
    }

    /**
     * 异步检测TCP端口状态
     */
    public static CompletableFuture<Boolean> isTcpPortClosedAsync(String host, int port) {
        return isTcpPortClosedAsync(host, port, 3000);
    }

    public static CompletableFuture<Boolean> isTcpPortClosedAsync(String host, int port, int timeoutMillis) {
        return CompletableFuture.supplyAsync(() ->
                isTcpPortClosed(host, port, timeoutMillis)
        );
    }

    /**
     * 批量检测多个端口
     */
    public static Map<Integer, Boolean> checkMultiplePorts(String host, List<Integer> ports) {
        return checkMultiplePorts(host, ports, 3000);
    }

    public static Map<Integer, Boolean> checkMultiplePorts(String host, List<Integer> ports, int timeoutMillis) {
        Map<Integer, Boolean> results = new ConcurrentHashMap<>();
        ExecutorService executor = Executors.newFixedThreadPool(Math.min(ports.size(), 10));

        CountDownLatch latch = new CountDownLatch(ports.size());

        for (int port : ports) {
            executor.execute(() -> {
                boolean isClosed = isTcpPortClosed(host, port, timeoutMillis);
                results.put(port, isClosed);
                latch.countDown();
            });
        }

        try {
            latch.await(ports.size() * (timeoutMillis + 1000) / 1000, TimeUnit.SECONDS);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } finally {
            executor.shutdown();
        }

        return results;
    }

    /**
     * 检测本地端口是否可用
     */
    public static boolean isLocalPortAvailable(int port) {
        return isLocalPortAvailable(port, false);
    }

    public static boolean isLocalPortAvailable(int port, boolean checkUdp) {
        // 检查TCP端口
        try (ServerSocket tcpSocket = new ServerSocket(port)) {
            tcpSocket.setReuseAddress(true);
            // TCP端口可用
        } catch (IOException e) {
            return false; // TCP端口被占用
        }

        // 如果需要检查UDP端口
        if (checkUdp) {
            try (DatagramSocket udpSocket = new DatagramSocket(port)) {
                udpSocket.setReuseAddress(true);
                // UDP端口可用
            } catch (IOException e) {
                return false; // UDP端口被占用
            }
        }

        return true;
    }

    /**
     * 获取端口状态详情
     */
    public static PortStatus getPortStatus(String host, int port) {
        return getPortStatus(host, port, 3000);
    }

    public static PortStatus getPortStatus(String host, int port, int timeoutMillis) {
        try (Socket socket = new Socket()) {
            long startTime = System.currentTimeMillis();
            socket.connect(new InetSocketAddress(host, port), timeoutMillis);
            long endTime = System.currentTimeMillis();

            return new PortStatus(port, false, "开放", endTime - startTime,
                    socket.getInetAddress().getHostAddress());

        } catch (ConnectException e) {
            return new PortStatus(port, true, "关闭 - 连接被拒绝", 0, null);
        } catch (SocketTimeoutException e) {
            return new PortStatus(port, true, "关闭 - 连接超时", timeoutMillis, null);
        } catch (UnknownHostException e) {
            return new PortStatus(port, true, "关闭 - 未知主机", 0, null);
        } catch (IOException e) {
            return new PortStatus(port, true, "关闭 - IO异常: " + e.getMessage(), 0, null);
        }
    }

    /**
     * 端口状态信息类
     */
    public static class PortStatus {
        private final int port;
        private final boolean closed;
        private final String status;
        private final long responseTime;
        private final String ipAddress;

        public PortStatus(int port, boolean closed, String status, long responseTime, String ipAddress) {
            this.port = port;
            this.closed = closed;
            this.status = status;
            this.responseTime = responseTime;
            this.ipAddress = ipAddress;
        }

        // Getters
        public int getPort() { return port; }
        public boolean isClosed() { return closed; }
        public String getStatus() { return status; }
        public long getResponseTime() { return responseTime; }
        public String getIpAddress() { return ipAddress; }

        @Override
        public String toString() {
            return String.format("端口 %d: %s, 响应时间: %dms, IP: %s",
                    port, status, responseTime, ipAddress != null ? ipAddress : "N/A");
        }
    }

    public static void main(String[] args) {
        System.out.println(PortChecker.isLocalPortAvailable(12345));
    }
}
