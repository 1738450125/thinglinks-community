package com.thinglinks.business.service.impl;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.thinglinks.common.utils.uuid.UUID;
import com.thinglinks.component.protocol.ProtocolManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinglinks.business.mapper.ThinglinksProtocolMapper;
import com.thinglinks.business.domain.ThinglinksProtocol;
import com.thinglinks.business.service.IThinglinksProtocolService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

/**
 * 协议管理Service业务层处理
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@Service
public class ThinglinksProtocolServiceImpl extends ServiceImpl<ThinglinksProtocolMapper, ThinglinksProtocol> implements IThinglinksProtocolService {
    @Autowired
    private ThinglinksProtocolMapper thinglinksProtocolMapper;
    public static final Map<String,String> MAIN_CLASS_PATH = new HashMap<>();
    public static final String PROTOCOL_PATH = System.getProperty("user.dir")+ File.separator+"protocol";
    static {
        File file = new File(PROTOCOL_PATH);
        if(!file.exists()){
            file.mkdir();
        }
        MAIN_CLASS_PATH.put("MQTT_BROKER","com.thinglinks.protocol.parent.MqttBrokerProtocol");
        MAIN_CLASS_PATH.put("MQTT_CLIENT","com.thinglinks.protocol.parent.MqttClientProtocol");
        MAIN_CLASS_PATH.put("TCP_SERVER","com.thinglinks.protocol.parent.TcpServerProtocol");
        MAIN_CLASS_PATH.put("UDP_SERVER","com.thinglinks.protocol.parent.UdpServerProtocol");
        MAIN_CLASS_PATH.put("COAP_SERVER","com.thinglinks.protocol.parent.CoapServerProtocol");
        MAIN_CLASS_PATH.put("HTTP_SERVER","com.thinglinks.protocol.parent.HttpServerProtocol");
        MAIN_CLASS_PATH.put("WEBSOCKET_SERVER","com.thinglinks.protocol.parent.WsServerProtocol");
    }
    /**
     * 查询协议管理
     *
     * @param id 协议管理主键
     * @return 协议管理
     */
    @Override
    public ThinglinksProtocol selectThinglinksProtocolById(String id) {
        return thinglinksProtocolMapper.selectThinglinksProtocolById(id);
    }

    /**
     * 查询协议管理列表
     *
     * @param thinglinksProtocol 协议管理
     * @return 协议管理
     */
    @Override
    public List<ThinglinksProtocol> selectThinglinksProtocolList(ThinglinksProtocol thinglinksProtocol) {
        return thinglinksProtocolMapper.selectThinglinksProtocolList(thinglinksProtocol);
    }

    /**
     * 新增协议管理
     *
     * @param thinglinksProtocol 协议管理
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String insertThinglinksProtocol(ThinglinksProtocol thinglinksProtocol, MultipartFile protocolFile) throws Exception {
        String result = "0";
        if(protocolFile!=null&&!protocolFile.isEmpty()){
            if(Objects.requireNonNull(protocolFile.getOriginalFilename()).endsWith(".jar")){
                String fileNewName = UUID.randomUUID().toString()+".jar";
                String filePath = PROTOCOL_PATH + File.separator + fileNewName;
                protocolFile.transferTo(new File(filePath));
                thinglinksProtocol.setLocalUrl(filePath);
                thinglinksProtocol.setNewName(fileNewName);
                thinglinksProtocol.setType("jar");
                thinglinksProtocol.setOriginName(protocolFile.getOriginalFilename());
                thinglinksProtocol.setMainClassPath(MAIN_CLASS_PATH.getOrDefault(thinglinksProtocol.getProtocolType(),null));
                thinglinksProtocol.setId(IdWorker.getIdStr());
                thinglinksProtocolMapper.insert(thinglinksProtocol);
                ProtocolManager.addProtocol(thinglinksProtocol.getId(),thinglinksProtocol.getProtocolType(),thinglinksProtocol.getLocalUrl(),thinglinksProtocol.getMainClassPath());
                result = thinglinksProtocol.getId();
            }else {
                //其他类型
            }
        }
        return result;
    }

    /**
     * 修改协议管理
     *
     * @param thinglinksProtocol 协议管理
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateThinglinksProtocol(ThinglinksProtocol thinglinksProtocol, MultipartFile protocolFile) throws Exception {
        if(protocolFile!=null&&!protocolFile.isEmpty()){
            if(Objects.requireNonNull(protocolFile.getOriginalFilename()).endsWith(".jar")){
                String fileNewName = UUID.randomUUID().toString()+".jar";
                String filePath = PROTOCOL_PATH + File.separator + fileNewName;
                protocolFile.transferTo(new File(filePath));
                thinglinksProtocol.setLocalUrl(filePath);
                thinglinksProtocol.setNewName(fileNewName);
                thinglinksProtocol.setType("jar");
                thinglinksProtocol.setOriginName(protocolFile.getOriginalFilename());
                thinglinksProtocol.setMainClassPath(MAIN_CLASS_PATH.getOrDefault(thinglinksProtocol.getProtocolType(),null));
                thinglinksProtocolMapper.updateById(thinglinksProtocol);
                ProtocolManager.removeProtocol(thinglinksProtocol.getId());
                ProtocolManager.addProtocol(thinglinksProtocol.getId(),thinglinksProtocol.getProtocolType(),thinglinksProtocol.getLocalUrl(),thinglinksProtocol.getMainClassPath());
            }else {
                //其他类型
            }
        }
        return 1;
    }

    /**
     * 批量删除协议管理
     *
     * @param ids 需要删除的协议管理主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksProtocolByIds(String[] ids) {
        return thinglinksProtocolMapper.deleteThinglinksProtocolByIds(ids);
    }

    /**
     * 删除协议管理信息
     *
     * @param id 协议管理主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksProtocolById(String id) {
        return thinglinksProtocolMapper.deleteThinglinksProtocolById(id);
    }
}
