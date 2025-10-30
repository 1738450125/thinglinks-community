package com.thinglinks.business.service.impl;

import java.util.List;
        import com.thinglinks.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinglinks.business.mapper.ThinglinksFunctionMapper;
import com.thinglinks.business.domain.ThinglinksFunction;
import com.thinglinks.business.service.IThinglinksFunctionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 设备指令下发Service业务层处理
 *
 * @author ruoyi
 * @date 2025-10-24
 */
@Service
public class ThinglinksFunctionServiceImpl extends ServiceImpl<ThinglinksFunctionMapper, ThinglinksFunction> implements IThinglinksFunctionService
{
    @Autowired
    private ThinglinksFunctionMapper thinglinksFunctionMapper;

    /**
     * 查询设备指令下发
     *
     * @param id 设备指令下发主键
     * @return 设备指令下发
     */
    @Override
    public ThinglinksFunction selectThinglinksFunctionById(String id)
    {
        return thinglinksFunctionMapper.selectThinglinksFunctionById(id);
    }

    /**
     * 查询设备指令下发列表
     *
     * @param thinglinksFunction 设备指令下发
     * @return 设备指令下发
     */
    @Override
    public List<ThinglinksFunction> selectThinglinksFunctionList(ThinglinksFunction thinglinksFunction)
    {
        return thinglinksFunctionMapper.selectThinglinksFunctionList(thinglinksFunction);
    }

    /**
     * 新增设备指令下发
     *
     * @param thinglinksFunction 设备指令下发
     * @return 结果
     */
    @Override
    public int insertThinglinksFunction(ThinglinksFunction thinglinksFunction)
    {
        thinglinksFunction.setCreateTime(DateUtils.getNowDate());
        return thinglinksFunctionMapper.insertThinglinksFunction(thinglinksFunction);
    }

    /**
     * 修改设备指令下发
     *
     * @param thinglinksFunction 设备指令下发
     * @return 结果
     */
    @Override
    public int updateThinglinksFunction(ThinglinksFunction thinglinksFunction)
    {
        return thinglinksFunctionMapper.updateThinglinksFunction(thinglinksFunction);
    }

    /**
     * 批量删除设备指令下发
     *
     * @param ids 需要删除的设备指令下发主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksFunctionByIds(String[] ids)
    {
        return thinglinksFunctionMapper.deleteThinglinksFunctionByIds(ids);
    }

    /**
     * 删除设备指令下发信息
     *
     * @param id 设备指令下发主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksFunctionById(String id)
    {
        return thinglinksFunctionMapper.deleteThinglinksFunctionById(id);
    }
}
