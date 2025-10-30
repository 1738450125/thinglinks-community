package com.thinglinks.business.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.thinglinks.common.annotation.Excel;

import java.util.Date;

/**
 * 产品对象 thinglinks_product
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "thinglinks_product")
public class ThinglinksProduct {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 产品编码
     */
    @Excel(name = "产品编码")
    private String productSn;

    /**
     * 产品名称
     */
    @Excel(name = "产品名称")
    private String productName;

    /**
     * 接入方式id
     */
    @Excel(name = "接入方式id")
    private String linkMethodId;

    /**
     * 接入方式名称
     */
    @Excel(name = "接入方式名称")
    private String linkMethodName;

    /**
     * 网络组件id
     */
    @Excel(name = "网络组件id")
    private String componentId;

    /**
     * 网络组件名称
     */
    @Excel(name = "网络组件名称")
    private String componentName;

    /**
     * 协议id
     */
    @Excel(name = "协议id")
    private String protocolId;

    /**
     * 协议名称
     */
    @Excel(name = "协议名称")
    private String protocolName;

    /**
     * 设备数量
     */
    @Excel(name = "设备数量")
    private Long deviceCount;

    /**
     * 设备类型 0-直连设备 1-网关设备 2-无状态设备
     */
    @Excel(name = "设备类型 0-直连设备 1-网关设备 2-无状态设备")
    private String deviceType;

    /**
     * 0-停用 1-启用
     */
    @Excel(name = "0-停用 1-启用")
    private String status;

    /** 创建者 */
    private String createBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /** 更新者 */
    private String updateBy;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    /** 备注 */
    private String remark;

    /**心跳超时时间*/
    private Integer timeoutSeconds;
    /**数据是否定期清理 0-否 1-是*/
    private String regularCleaning;
    /**数据保存时间*/
    private Long retentionTime;
    /**数据保存时间单位 hour-时 day-天 week-周 month-月 year-年*/
    private String retentionUnit;
    /**自定义配置*/
    private String customConfig;
}
