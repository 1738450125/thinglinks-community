package com.thinglinks.business.warn;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WarnRuleItem {
    //属性标识
    private String attribute;
    //比较符:gt,ge,eq,ne,lt,le,like,notLike,in,notIn,contains,notContains
    //in和notIn的值用逗号分隔
    private String operator;
    //比较值
    private String value;
    //类型 device_online、device_offline、device_property
    private String type;
}
