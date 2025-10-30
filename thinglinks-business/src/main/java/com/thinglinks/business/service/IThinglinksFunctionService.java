package com.thinglinks.business.service;

import java.util.List;
import com.thinglinks.business.domain.ThinglinksFunction;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 设备指令下发Service接口
 *
 * @author ruoyi
 * @date 2025-10-24
 */
public interface IThinglinksFunctionService extends IService<ThinglinksFunction>
{
    /**
     * 查询设备指令下发
     *
     * @param id 设备指令下发主键
     * @return 设备指令下发
     */
    public ThinglinksFunction selectThinglinksFunctionById(String id);

    /**
     * 查询设备指令下发列表
     *
     * @param thinglinksFunction 设备指令下发
     * @return 设备指令下发集合
     */
    public List<ThinglinksFunction> selectThinglinksFunctionList(ThinglinksFunction thinglinksFunction);

    /**
     * 新增设备指令下发
     *
     * @param thinglinksFunction 设备指令下发
     * @return 结果
     */
    public int insertThinglinksFunction(ThinglinksFunction thinglinksFunction);

    /**
     * 修改设备指令下发
     *
     * @param thinglinksFunction 设备指令下发
     * @return 结果
     */
    public int updateThinglinksFunction(ThinglinksFunction thinglinksFunction);

    /**
     * 批量删除设备指令下发
     *
     * @param ids 需要删除的设备指令下发主键集合
     * @return 结果
     */
    public int deleteThinglinksFunctionByIds(String[] ids);

    /**
     * 删除设备指令下发信息
     *
     * @param id 设备指令下发主键
     * @return 结果
     */
    public int deleteThinglinksFunctionById(String id);
}
