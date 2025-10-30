package com.thinglinks.business.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson2.JSONObject;
import com.thinglinks.business.mapper.ThinglinksProtocolMapper;
import com.thinglinks.common.exception.CommonWarnException;
import com.thinglinks.common.utils.StringUtils;
import com.thinglinks.component.mqtt.client.MqttClientConfig;
import com.thinglinks.component.mqtt.client.MqttClientManager;
import com.thinglinks.component.protocol.ProtocolManager;
import com.thinglinks.component.tcp.TCPServerConfig;
import com.thinglinks.component.tcp.TCPServerHandlerInstance;
import com.thinglinks.component.tcp.TCPServerManager;
import com.thinglinks.component.utils.PortChecker;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinglinks.business.mapper.ThinglinksComponentMapper;
import com.thinglinks.business.domain.ThinglinksComponent;
import com.thinglinks.business.service.IThinglinksComponentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 网络组件Service业务层处理
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@Service
public class ThinglinksComponentServiceImpl extends ServiceImpl<ThinglinksComponentMapper, ThinglinksComponent> implements IThinglinksComponentService {
    @Autowired
    private ThinglinksComponentMapper thinglinksComponentMapper;
    @Autowired
    private ThinglinksProtocolMapper thinglinksProtocolMapper;
    /**
     * 查询网络组件
     *
     * @param id 网络组件主键
     * @return 网络组件
     */
    @Override
    public ThinglinksComponent selectThinglinksComponentById(String id) {
        return thinglinksComponentMapper.selectThinglinksComponentById(id);
    }

    /**
     * 查询网络组件列表
     *
     * @param thinglinksComponent 网络组件
     * @return 网络组件
     */
    @Override
    public List<ThinglinksComponent> selectThinglinksComponentList(ThinglinksComponent thinglinksComponent) {
        return thinglinksComponentMapper.selectThinglinksComponentList(thinglinksComponent);
    }

    /**
     * 新增网络组件
     *
     * @param thinglinksComponent 网络组件
     * @return 结果
     */
    @Override
    public int insertThinglinksComponent(ThinglinksComponent thinglinksComponent) {
        return thinglinksComponentMapper.insertThinglinksComponent(thinglinksComponent);
    }

    /**
     * 修改网络组件
     *
     * @param thinglinksComponent 网络组件
     * @return 结果
     */
    @Override
    public int updateThinglinksComponent(ThinglinksComponent thinglinksComponent) {
        return thinglinksComponentMapper.updateThinglinksComponent(thinglinksComponent);
    }

    /**
     * 批量删除网络组件
     *
     * @param ids 需要删除的网络组件主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksComponentByIds(String[] ids) {
        return thinglinksComponentMapper.deleteThinglinksComponentByIds(ids);
    }

    /**
     * 删除网络组件信息
     *
     * @param id 网络组件主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksComponentById(String id) {
        return thinglinksComponentMapper.deleteThinglinksComponentById(id);
    }

    @Override
    public boolean openComponent(String id) throws IOException, CommonWarnException {
        ThinglinksComponent component = thinglinksComponentMapper.selectById(id);
        if(component==null) {
            return false;
        }
        switch (component.getNetType()){
            //MQTT客户端
            case "MQTT_CLIENT" : {
                if(StringUtils.isNotEmpty(component.getOtherConfig())){
                    MqttClientConfig config = JSONObject.parseObject(component.getOtherConfig()).toJavaObject(MqttClientConfig.class);
                    config.setClientId(id);
                    boolean isOk = MqttClientManager.addConnection(config);
                    if(!isOk){
                        throw new CommonWarnException("连接失败，请检查配置信息是否正确");
                    }
                    if(StringUtils.isNotEmpty(component.getProtocolId())){
                        ProtocolManager.PROTOCOL_MAP.put(component.getId(),component.getProtocolId());
                    }
                    component.setStatus("1");
                    component.setIpAddr(config.getBrokerUrl());
                    thinglinksComponentMapper.updateById(component);
                    return true;
                }else {
                    return false;
                }
            }
            //TCP服务端
            case "TCP_SERVER" : {
                if(StringUtils.isNotEmpty(component.getOtherConfig())){
                    TCPServerConfig config = JSONObject.parseObject(component.getOtherConfig()).toJavaObject(TCPServerConfig.class);
                    if(!PortChecker.isLocalPortAvailable(config.getServerPort())){
                        throw new CommonWarnException("端口被占用");
                    }
                    boolean isOk = TCPServerManager.addServer(component.getId(), config.getServerPort(), new TCPServerHandlerInstance());
                    if(!isOk){
                        throw new CommonWarnException("开启失败，请检查配置信息是否正确");
                    }
                    component.setStatus("1");
                    if(StringUtils.isNotEmpty(component.getProtocolId())){
                        ProtocolManager.PROTOCOL_MAP.put(component.getId(),component.getProtocolId());
                    }
                    component.setIpAddr("0.0.0.0");
                    component.setPort(String.valueOf(config.getServerPort()));
                    thinglinksComponentMapper.updateById(component);
                    return true;
                }else {
                    return false;
                }
            }
            default: return false;
        }
    }

    @Override
    public boolean closeComponent(String id) throws IOException, MqttException {
        ThinglinksComponent component = thinglinksComponentMapper.selectById(id);
        if(component==null) {
            return false;
        }
        switch (component.getNetType()){
            //MQTT客户端
            case "MQTT_CLIENT" : {
                MqttClientManager.deleteConnection(component.getId());
                MqttClientManager.clientMap.remove(component.getId());
                component.setStatus("0");
                thinglinksComponentMapper.updateById(component);
                return true;
            }
            //TCP服务端
            case "TCP_SERVER" : {
                TCPServerManager.removeServer(component.getId());
                component.setStatus("0");
                thinglinksComponentMapper.updateById(component);
                return true;
            }
            default: return false;
        }
    }
}
