package com.thinglinks.business.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import com.thinglinks.common.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 指令下发记录对象 thinglinks_function_record
 *
 * @author ruoyi
 * @date 2025-10-29
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "thinglinks_function_record")
public class ThinglinksFunctionRecord
{
private static final long serialVersionUID = 1L;

    /** id */
    private String id;
    /** 功能id */
    @Excel(name = "功能id")
    private String functionId;
    /** 功能code */
    @Excel(name = "功能code")
    private String functionCode;
    /** 功能名称 */
    @Excel(name = "功能名称")
    private String functionName;
    /** 参数 */
    @Excel(name = "参数")
    private String functionParams;
    /** 0-失败 1-成功 */
    @Excel(name = "0-失败 1-成功")
    private String isSuccess;
    /** 下发时间 */
    private Date createTime;
    /** 设备sn */
    @Excel(name = "设备sn")
    private String deviceSn;
    /** 设备名称 */
    @Excel(name = "设备名称")
    private String deviceName;
    /** 0-手动触发 1-告警触发 2-定时触发*/
    @Excel(name = "0-手动触发 1-告警触发 2-定时触发")
    private String triggerType;
}
