package com.thinglinks.business.warn;

import com.thinglinks.business.domain.ThinglinksFunction;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


/**
 * 一条大规则只能单独存在与/或，不可同时存在与/或
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class WarnRule {
    //规则ID
    private String id;
    //规则名称
    private String name;
    //规则列表
    private List<WarnRuleItem> conditions;
    //规则之间与或关系 and-与 or-或
    private String relation;
    //告警等级 warn/critical
    private String level;
    //告警消息模板
    private String message;
    //执行动作
    private List<ThinglinksFunction> actions;
    //是否启用
    private Boolean enable;
    //产品/设备sn
    private String belongSn;
    //0-产品 1-设备
    private String belongType;
    //多少秒内不重复告警
    private Integer delayTime;
}
