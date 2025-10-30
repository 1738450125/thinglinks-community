package com.thinglinks.component.message;

/**
 * 协议包必须实现的统一接口。
 * 这个接口本身需要放在一个独立的模块中，或者直接放在主项目中。
 * 协议包JAR需要依赖这个接口。
 */
public interface ProtocolInterface {

    /**
     * 协议的唯一标识符，用于路由查找
     */
    String getProtocolCode();

    /**
     * 解析设备上传的数据
     * @param rawData 原始字节数据
     * @param clientIdentifier 客户端标识（如IP、设备SN等，用于路由）
     * @return 解析后的标准化数据（可以是JSON字符串、Map、自定义POJO）
     * @throws Exception 解析异常
     */
    Object decode(byte[] rawData, String clientIdentifier) throws Exception;

    /**
     * 编码下行指令（平台向设备发送数据）
     * @param command 平台下发的标准化指令
     * @param clientIdentifier 客户端标识
     * @return 编码后的字节数据
     * @throws Exception 编码异常
     */
    byte[] encode(Object command, String clientIdentifier) throws Exception;
}
