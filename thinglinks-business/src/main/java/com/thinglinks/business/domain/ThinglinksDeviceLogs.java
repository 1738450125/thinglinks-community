package com.thinglinks.business.domain;

import java.util.Date;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.thinglinks.common.annotation.Excel;

/**
 * 设备日志对象 thinglinks_device_logs
 *
 * @author thinglinks
 * @date 2025-09-22
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "thinglinks_device_logs")
public class ThinglinksDeviceLogs {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    private Long id;

    /**
     * 设备sn
     */
    @Excel(name = "设备sn")
    private String deviceSn;

    /**
     * 上报时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "上报时间" , width = 30, dateFormat = "yyyy-MM-dd")
    private Date reportTime;

    /**
     * 属性json
     */
    @Excel(name = "属性json")
    private String properties;

    /**
     * 日志类型
     */
    @Excel(name = "日志类型 PROPERTY-属性上报 ONLINE-上线 OFFLINE-下线")
    private String logType;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setDeviceSn(String deviceSn) {
        this.deviceSn = deviceSn;
    }

    public String getDeviceSn() {
        return deviceSn;
    }

    public void setReportTime(Date reportTime) {
        this.reportTime = reportTime;
    }

    public Date getReportTime() {
        return reportTime;
    }

    public void setProperties(String properties) {
        this.properties = properties;
    }

    public String getProperties() {
        return properties;
    }

    public void setLogType(String logType) {
        this.logType = logType;
    }

    public String getLogType() {
        return logType;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("id" , getId())
                .append("deviceSn" , getDeviceSn())
                .append("reportTime" , getReportTime())
                .append("properties" , getProperties())
                .append("logType" , getLogType())
                .toString();
    }
}
