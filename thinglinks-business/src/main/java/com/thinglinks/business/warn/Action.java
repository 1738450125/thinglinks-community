package com.thinglinks.business.warn;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description: 执行动作
 * @Author: thinglinks
 * @CreateTime: 2025-10-09
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Action {
    //动作标识
    private String actionSign;
    //参数
    private String params;
}
