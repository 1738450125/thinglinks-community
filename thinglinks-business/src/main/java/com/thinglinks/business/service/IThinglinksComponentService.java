package com.thinglinks.business.service;

import java.io.IOException;
import java.util.List;
import com.thinglinks.business.domain.ThinglinksComponent;
import com.baomidou.mybatisplus.extension.service.IService;
import com.thinglinks.common.exception.CommonWarnException;
import org.eclipse.paho.client.mqttv3.MqttException;

/**
 * 网络组件Service接口
 *
 * @author thinglinks
 * @date 2025-09-18
 */
public interface IThinglinksComponentService extends IService<ThinglinksComponent>
{
    /**
     * 查询网络组件
     *
     * @param id 网络组件主键
     * @return 网络组件
     */
    public ThinglinksComponent selectThinglinksComponentById(String id);

    /**
     * 查询网络组件列表
     *
     * @param thinglinksComponent 网络组件
     * @return 网络组件集合
     */
    public List<ThinglinksComponent> selectThinglinksComponentList(ThinglinksComponent thinglinksComponent);

    /**
     * 新增网络组件
     *
     * @param thinglinksComponent 网络组件
     * @return 结果
     */
    public int insertThinglinksComponent(ThinglinksComponent thinglinksComponent);

    /**
     * 修改网络组件
     *
     * @param thinglinksComponent 网络组件
     * @return 结果
     */
    public int updateThinglinksComponent(ThinglinksComponent thinglinksComponent);

    /**
     * 批量删除网络组件
     *
     * @param ids 需要删除的网络组件主键集合
     * @return 结果
     */
    public int deleteThinglinksComponentByIds(String[] ids);

    /**
     * 删除网络组件信息
     *
     * @param id 网络组件主键
     * @return 结果
     */
    public int deleteThinglinksComponentById(String id);

    /**
     * 启用网络组件
     */
    public boolean openComponent(String id) throws IOException, CommonWarnException;

    /**
     * 关闭网络组件
     */
    public boolean closeComponent(String id) throws IOException, MqttException;
}
