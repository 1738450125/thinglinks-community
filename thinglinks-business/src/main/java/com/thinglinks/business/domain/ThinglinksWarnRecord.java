package com.thinglinks.business.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.thinglinks.common.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.baomidou.mybatisplus.annotation.TableName;

import java.util.Date;

/**
 * 告警记录对象 thinglinks_warn_record
 *
 * @author thinglinks
 * @date 2025-10-05
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "thinglinks_warn_record")
public class ThinglinksWarnRecord
{
private static final long serialVersionUID = 1L;

    /** id */
    private String id;
    /** 告警配置id */
    @Excel(name = "告警配置id")
    private String configId;
    /** 告警配置名称 */
    @Excel(name = "告警配置名称")
    private String configName;
    /** 告警内容 */
    @Excel(name = "告警内容")
    private String warnMessage;
    /** 告警时全属性数据 */
    @Excel(name = "告警时全属性数据")
    private String warnData;
    /** 设备/产品sn */
    @Excel(name = "设备/产品sn")
    private String belongSn;
    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    /** 告警等级 1-紧急 2-严重 3-警告 4-正常 */
    private String warnLevel;
    /**处理状态 0-未处理 1-已处理*/
    private String status;
}
