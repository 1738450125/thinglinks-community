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
 * 网络组件对象 thinglinks_component
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "thinglinks_component")
public class ThinglinksComponent {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 组件名称
     */
    @Excel(name = "组件名称")
    private String name;

    /**
     * 网络类型
     */
    @Excel(name = "网络类型")
    private String netType;

    /**
     * IP地址
     */
    @Excel(name = "IP地址")
    private String ipAddr;

    /**
     * 端口
     */
    @Excel(name = "端口")
    private String port;

    /**
     * 是否开启TLS (0-否 1-是)
     */
    @Excel(name = "是否开启TLS (0-否 1-是)")
    private String openTls;

    /**
     * 0-停用 1-启用
     */
    @Excel(name = "0-停用 1-启用")
    private String status;

    /**
     * 其余配置(如账号密码等)
     */
    @Excel(name = "其余配置(如账号密码等)")
    private String otherConfig;

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

}
