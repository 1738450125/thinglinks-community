package com.thinglinks.business.service;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import com.thinglinks.business.domain.ThinglinksProtocol;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

/**
 * 协议管理Service接口
 *
 * @author thinglinks
 * @date 2025-09-18
 */
public interface IThinglinksProtocolService extends IService<ThinglinksProtocol>
{
    /**
     * 查询协议管理
     *
     * @param id 协议管理主键
     * @return 协议管理
     */
    public ThinglinksProtocol selectThinglinksProtocolById(String id);

    /**
     * 查询协议管理列表
     *
     * @param thinglinksProtocol 协议管理
     * @return 协议管理集合
     */
    public List<ThinglinksProtocol> selectThinglinksProtocolList(ThinglinksProtocol thinglinksProtocol);

    /**
     * 新增协议管理
     *
     * @param thinglinksProtocol 协议管理
     * @return 结果
     */
    public String insertThinglinksProtocol(ThinglinksProtocol thinglinksProtocol, MultipartFile protocolFile) throws Exception;

    /**
     * 修改协议管理
     *
     * @param thinglinksProtocol 协议管理
     * @return 结果
     */
    public int updateThinglinksProtocol(ThinglinksProtocol thinglinksProtocol, MultipartFile protocolFil) throws Exception;

    /**
     * 批量删除协议管理
     *
     * @param ids 需要删除的协议管理主键集合
     * @return 结果
     */
    public int deleteThinglinksProtocolByIds(String[] ids);

    /**
     * 删除协议管理信息
     *
     * @param id 协议管理主键
     * @return 结果
     */
    public int deleteThinglinksProtocolById(String id);
}
