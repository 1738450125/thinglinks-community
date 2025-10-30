package com.thinglinks.business.service;

import java.util.List;
import com.thinglinks.business.domain.ThinglinksWarnConfig;
import com.baomidou.mybatisplus.extension.service.IService;
import com.thinglinks.common.core.domain.AjaxResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 告警配置Service接口
 *
 * @author thinglinks
 * @date 2025-10-05
 */
public interface IThinglinksWarnConfigService extends IService<ThinglinksWarnConfig>
{
    /**
     * 查询告警配置
     *
     * @param id 告警配置主键
     * @return 告警配置
     */
    public ThinglinksWarnConfig selectThinglinksWarnConfigById(String id);

    /**
     * 查询告警配置列表
     *
     * @param thinglinksWarnConfig 告警配置
     * @return 告警配置集合
     */
    public List<ThinglinksWarnConfig> selectThinglinksWarnConfigList(ThinglinksWarnConfig thinglinksWarnConfig);

    /**
     * 新增告警配置
     *
     * @param thinglinksWarnConfig 告警配置
     * @return 结果
     */
    public int insertThinglinksWarnConfig(ThinglinksWarnConfig thinglinksWarnConfig);

    /**
     * 修改告警配置
     *
     * @param thinglinksWarnConfig 告警配置
     * @return 结果
     */
    public int updateThinglinksWarnConfig(ThinglinksWarnConfig thinglinksWarnConfig);

    /**
     * 批量删除告警配置
     *
     * @param ids 需要删除的告警配置主键集合
     * @return 结果
     */
    public int deleteThinglinksWarnConfigByIds(String[] ids);

    /**
     * 删除告警配置信息
     *
     * @param id 告警配置主键
     * @return 结果
     */
    public int deleteThinglinksWarnConfigById(String id);

    /**
     * 从产品同步告警配置到指定设备
     * @param productSn
     * @return
     */
    public void syncWarnConfigToDevice(String productSn,String deviceSn);
}
