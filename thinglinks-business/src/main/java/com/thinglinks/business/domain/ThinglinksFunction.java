package com.thinglinks.business.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.thinglinks.common.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import java.util.Date;
import lombok.NoArgsConstructor;
import com.baomidou.mybatisplus.annotation.TableName;

/**
 * 设备指令下发对象 thinglinks_function
 *
 * @author ruoyi
 * @date 2025-10-24
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "thinglinks_function")
public class ThinglinksFunction
{
private static final long serialVersionUID = 1L;

    /** id */
    private String id;
    /** 功能名称 */
    @Excel(name = "功能名称")
    private String functionName;
    /** 功能编码 */
    @Excel(name = "功能编码")
    private String functionCode;
    /** 自定义参数 */
    @Excel(name = "自定义参数")
    private String functionParams;
    /** 设备/产品sn */
    @Excel(name = "设备/产品sn")
    private String belongSn;
    /**归属类型 0-产品 1-设备*/
    @Excel(name = "归属类型 0-产品 1-设备")
    private String belongType;
    /** 协议id */
    @Excel(name = "协议id")
    private String protocolId;
    /** 创建时间 */
    private Date createTime;
    /** 创建人 */
    private String createBy;
}
