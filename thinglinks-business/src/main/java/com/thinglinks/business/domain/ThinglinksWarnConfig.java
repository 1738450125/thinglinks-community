package com.thinglinks.business.domain;

import com.thinglinks.common.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.baomidou.mybatisplus.annotation.TableName;

import java.util.Date;

/**
 * 告警配置对象 thinglinks_warn_config
 *
 * @author thinglinks
 * @date 2025-10-05
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "thinglinks_warn_config")
public class ThinglinksWarnConfig
{
    private static final long serialVersionUID = 1L;

    /** id */
    private String id;
    /** 告警名称 */
    @Excel(name = "告警名称")
    private String name;
    /** 产品/设备sn */
    @Excel(name = "产品/设备sn")
    private String belongSn;
    /** 来源 0-产品 1-设备 */
    @Excel(name = "来源 0-产品 1-设备")
    private String belongType;
    /** 规则json */
    @Excel(name = "规则json")
    private String ruleJson;
    /** 告警消息模板 */
    @Excel(name = "告警消息模板")
    private String warnMessage;
    /** 告警等级 1-紧急 2-严重 3-警告 4-正常 */
    private String warnLevel;
    /** 创建时间 */
    private Date createTime;
    /** 创建人 */
    private String createBy;
    /** 修改时间 */
    private Date updateTime;
    /** 修改人 */
    private String updateBy;
    /** 执行动作json */
    private String executeAction;
    /** 是否启用 0-否 1-是*/
    private String isEnable;
    /** 告警类型 0-属性告警 1-在线告警 2-离线告警 */
    private String warnType;
}
