package com.thinglinks.business.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinglinks.common.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 协议管理对象 thinglinks_protocol
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "thinglinks_protocol")
public class ThinglinksProtocol {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 协议名称
     */
    @Excel(name = "协议名称")
    private String protocolName;

    /**
     * 本地存储路径
     */
    @Excel(name = "本地存储路径")
    private String localUrl;

    /**
     * 解析类入口
     */
    @Excel(name = "解析类入口")
    private String mainClassPath;

    /**
     * 文件原始名字
     */
    @Excel(name = "文件原始名字")
    private String originName;

    /**
     * 0-jar包
     */
    @Excel(name = "0-jar包")
    private String type;

    /**
     * 文件重命名
     */
    @Excel(name = "文件重命名")
    private String newName;

    /**
     * 组件id
     */
    private String componentId;

    /**
     * 组件名称
     */
    private String componentName;
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

    /**状态 0-停用 1-启用*/
    private String status;

    /**协议类型*/
    private String protocolType;
}
