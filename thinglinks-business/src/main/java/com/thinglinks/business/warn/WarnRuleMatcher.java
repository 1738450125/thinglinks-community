package com.thinglinks.business.warn;

import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.JSONArray;
import lombok.extern.slf4j.Slf4j;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
public class WarnRuleMatcher {

    /**
     * 检查JSON数据是否满足告警规则
     */
    public static boolean matchesRule(JSONObject jsonData, WarnRule rule) {
        if (rule == null || !Boolean.TRUE.equals(rule.getEnable())) {
            return false;
        }

        List<WarnRuleItem> conditions = rule.getConditions();
        if (conditions == null || conditions.isEmpty()) {
            return false;
        }

        // 获取JSON数据的所有最外层key
        Set<String> jsonKeys = jsonData.keySet();

        // 单个规则直接判断
        if (conditions.size() == 1) {
            return matchesCondition(jsonData, jsonKeys, conditions.get(0));
        }

        // 多个规则根据relation判断
        String relation = rule.getRelation();
        if ("and".equalsIgnoreCase(relation)) {
            // 所有条件都必须满足
            return conditions.stream()
                    .allMatch(condition -> matchesCondition(jsonData, jsonKeys, condition));
        } else if ("or".equalsIgnoreCase(relation)) {
            // 任意一个条件满足
            return conditions.stream()
                    .anyMatch(condition -> matchesCondition(jsonData, jsonKeys, condition));
        } else {
            log.warn("Unknown relation: {}, default to AND", relation);
            return conditions.stream()
                    .allMatch(condition -> matchesCondition(jsonData, jsonKeys, condition));
        }
    }

    /**
     * 检查单个条件是否满足
     */
    private static boolean matchesCondition(JSONObject jsonData, Set<String> jsonKeys, WarnRuleItem condition) {
        String attribute = condition.getAttribute();
        String operator = condition.getOperator();
        String value = condition.getValue();

        // 检查属性是否存在
        if (!jsonKeys.contains(attribute)) {
            return false;
        }

        Object actualValue = jsonData.get(attribute);
        if (actualValue == null) {
            return false;
        }

        // 根据操作符进行匹配
        try {
            switch (operator) {
                case "gt":
                    return compareGreaterThan(actualValue, value);
                case "ge":
                    return compareGreaterThanOrEqual(actualValue, value);
                case "eq":
                    return compareEqual(actualValue, value);
                case "ne":
                    return compareNotEqual(actualValue, value);
                case "lt":
                    return compareLessThan(actualValue, value);
                case "le":
                    return compareLessThanOrEqual(actualValue, value);
                case "contains":
                    return compareContains(actualValue, value);
                case "notContains":
                    return compareNotContains(actualValue, value);
                case "like":
                    return compareLike(actualValue, value);
                case "notLike":
                    return compareNotLike(actualValue, value);
                case "in":
                    return compareIn(actualValue, value);
                case "notin":
                    return compareNotIn(actualValue, value);
                default:
                    log.warn("Unknown operator: {}", operator);
                    return false;
            }
        } catch (Exception e) {
            log.error("Error comparing condition: attribute={}, operator={}, value={}",
                    attribute, operator, value, e);
            return false;
        }
    }

    // 比较方法实现
    private static boolean compareGreaterThan(Object actual, String expected) {
        if (actual instanceof Number && isNumeric(expected)) {
            return ((Number) actual).doubleValue() > Double.parseDouble(expected);
        }
        return false;
    }

    private static boolean compareGreaterThanOrEqual(Object actual, String expected) {
        if (actual instanceof Number && isNumeric(expected)) {
            return ((Number) actual).doubleValue() >= Double.parseDouble(expected);
        }
        return false;
    }

    private static boolean compareEqual(Object actual, String expected) {
        return String.valueOf(actual).equals(expected);
    }

    private static boolean compareNotEqual(Object actual, String expected) {
        return !String.valueOf(actual).equals(expected);
    }

    private static boolean compareLessThan(Object actual, String expected) {
        if (actual instanceof Number && isNumeric(expected)) {
            return ((Number) actual).doubleValue() < Double.parseDouble(expected);
        }
        return false;
    }

    private static boolean compareLessThanOrEqual(Object actual, String expected) {
        if (actual instanceof Number && isNumeric(expected)) {
            return ((Number) actual).doubleValue() <= Double.parseDouble(expected);
        }
        return false;
    }

    private static boolean compareContains(Object actual, String expected) {
        String actualStr = String.valueOf(actual);
        return actualStr.contains(expected);
    }

    private static boolean compareNotContains(Object actual, String expected) {
        return !compareContains(actual, expected);
    }

    private static boolean compareLike(Object actual, String expected) {
        String actualStr = String.valueOf(actual);
        return expected.contains(actualStr);
    }

    private static boolean compareNotLike(Object actual, String expected) {
        return !compareLike(actual, expected);
    }

    private static boolean compareIn(Object actual, String valueList) {
        String actualStr = String.valueOf(actual);
        String[] values = valueList.split(",");
        return Arrays.stream(values)
                .map(String::trim)
                .anyMatch(val -> val.equals(actualStr));
    }

    private static boolean compareNotIn(Object actual, String valueList) {
        return !compareIn(actual, valueList);
    }

    private static boolean isNumeric(String str) {
        try {
            Double.parseDouble(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * 批量检查规则，返回满足的规则列表
     */
    public static List<WarnRule> findMatchedRules(JSONObject jsonData, List<WarnRule> rules) {
        if (rules == null || rules.isEmpty()) {
            return Collections.emptyList();
        }

        return rules.stream()
                .filter(rule -> matchesRule(jsonData, rule))
                .collect(Collectors.toList());
    }

    /**
     * 生成告警消息
     */
    public static String generateAlertMessage(JSONObject jsonData, WarnRule rule) {
        if (rule.getMessage() == null) {
            return "未配置告警消息";
        }

        String message = rule.getMessage();
        // 简单的变量替换，例如 ${attribute} 替换为实际值
        for (String key : jsonData.keySet()) {
            String placeholder = "${" + key + "}";
            if (message.contains(placeholder)) {
                message = message.replace(placeholder, String.valueOf(jsonData.get(key)));
            }
        }
        return message;
    }

    public static void main(String[] args) {
        // 模拟JSON数据
        JSONObject jsonData = JSONObject.of(
                "temperature", 99,
                "humidity", 60,
                "status", "error",
                "pressure", 100.2
        );
        long start = System.currentTimeMillis();
        // 创建告警规则
        List<WarnRuleItem> conditions = Arrays.asList(
                new WarnRuleItem("temperature", "gt", "80"),
                new WarnRuleItem("temperature", "lt", "100"),
                new WarnRuleItem("status", "eq", "error"),
                new WarnRuleItem("status", "contains", "er")
        );

        WarnRule rule = new WarnRule();
        rule.setId("rule1");
        rule.setName("高温告警");
        rule.setConditions(conditions);
        rule.setRelation("and");
        rule.setLevel("warn");
        rule.setMessage("设备温度过高: ${temperature}℃，状态: ${status}，湿度: ${humidity}");
        rule.setEnable(true);

        // 检查规则匹配
        boolean matched = WarnRuleMatcher.matchesRule(jsonData, rule);
        System.out.println("规则匹配结果: " + matched);

        if (matched) {
            String message = WarnRuleMatcher.generateAlertMessage(jsonData, rule);
            System.out.println("告警消息: " + message);
        }
        // 测试其他操作符
//        testOperators();
    }

    private static void testOperators() {
        JSONObject data = JSONObject.of("value", 50, "status", "running");

        // 测试各种操作符
        List<WarnRuleItem> testConditions = Arrays.asList(
                new WarnRuleItem("value", "gt", "40"),  // true
                new WarnRuleItem("value", "lt", "60"),  // true
                new WarnRuleItem("status", "eq", "running"), // true
                new WarnRuleItem("status", "in", "running,error") // true
        );

        WarnRule testRule = new WarnRule();
        testRule.setConditions(testConditions);
        testRule.setRelation("and");
        testRule.setEnable(true);

        boolean result = WarnRuleMatcher.matchesRule(data, testRule);
        System.out.println("复杂规则匹配结果: " + result);
    }
}