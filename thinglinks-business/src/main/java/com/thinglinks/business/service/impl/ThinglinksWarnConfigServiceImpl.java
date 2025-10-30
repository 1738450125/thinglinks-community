package com.thinglinks.business.service.impl;

import java.util.Date;
import java.util.List;

import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.thinglinks.business.warn.WarnRule;
import com.thinglinks.common.utils.DateUtils;
import com.thinglinks.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinglinks.business.mapper.ThinglinksWarnConfigMapper;
import com.thinglinks.business.domain.ThinglinksWarnConfig;
import com.thinglinks.business.service.IThinglinksWarnConfigService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 告警配置Service业务层处理
 *
 * @author thinglinks
 * @date 2025-10-05
 */
@Service
public class ThinglinksWarnConfigServiceImpl extends ServiceImpl<ThinglinksWarnConfigMapper, ThinglinksWarnConfig> implements IThinglinksWarnConfigService
{
    @Autowired
    private ThinglinksWarnConfigMapper thinglinksWarnConfigMapper;

    /**
     * 查询告警配置
     *
     * @param id 告警配置主键
     * @return 告警配置
     */
    @Override
    public ThinglinksWarnConfig selectThinglinksWarnConfigById(String id)
    {
        return thinglinksWarnConfigMapper.selectThinglinksWarnConfigById(id);
    }

    /**
     * 查询告警配置列表
     *
     * @param thinglinksWarnConfig 告警配置
     * @return 告警配置
     */
    @Override
    public List<ThinglinksWarnConfig> selectThinglinksWarnConfigList(ThinglinksWarnConfig thinglinksWarnConfig)
    {
        return thinglinksWarnConfigMapper.selectThinglinksWarnConfigList(thinglinksWarnConfig);
    }

    /**
     * 新增告警配置
     *
     * @param thinglinksWarnConfig 告警配置
     * @return 结果
     */
    @Override
    public int insertThinglinksWarnConfig(ThinglinksWarnConfig thinglinksWarnConfig)
    {
        thinglinksWarnConfig.setCreateTime(DateUtils.getNowDate());
        return thinglinksWarnConfigMapper.insertThinglinksWarnConfig(thinglinksWarnConfig);
    }

    /**
     * 修改告警配置
     *
     * @param thinglinksWarnConfig 告警配置
     * @return 结果
     */
    @Override
    public int updateThinglinksWarnConfig(ThinglinksWarnConfig thinglinksWarnConfig)
    {
                thinglinksWarnConfig.setUpdateTime(DateUtils.getNowDate());
        return thinglinksWarnConfigMapper.updateThinglinksWarnConfig(thinglinksWarnConfig);
    }

    /**
     * 批量删除告警配置
     *
     * @param ids 需要删除的告警配置主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksWarnConfigByIds(String[] ids)
    {
        return thinglinksWarnConfigMapper.deleteThinglinksWarnConfigByIds(ids);
    }

    /**
     * 删除告警配置信息
     *
     * @param id 告警配置主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksWarnConfigById(String id)
    {
        return thinglinksWarnConfigMapper.deleteThinglinksWarnConfigById(id);
    }
    /**
     * 从产品同步告警配置到指定设备
     * @param productSn
     * @return
     */
    @Override
    public void syncWarnConfigToDevice(String productSn, String deviceSn) {
        List<ThinglinksWarnConfig> configList = thinglinksWarnConfigMapper.selectList(new LambdaQueryWrapper<ThinglinksWarnConfig>()
                .eq(ThinglinksWarnConfig::getBelongSn,productSn));
        configList.forEach(config->{
            config.setId(IdWorker.getIdStr());
            config.setBelongSn(deviceSn);
            config.setBelongType("1");
            config.setCreateTime(new Date());
            config.setCreateBy(SecurityUtils.getUsername());
            WarnRule rule =  JSONObject.parseObject(config.getRuleJson(),WarnRule.class);
            rule.setBelongSn(config.getBelongSn());
            rule.setBelongType(config.getBelongType());
            rule.setId(config.getId());
            config.setRuleJson(JSONObject.toJSONString(rule));
            thinglinksWarnConfigMapper.insert(config);
        });
    }
}
