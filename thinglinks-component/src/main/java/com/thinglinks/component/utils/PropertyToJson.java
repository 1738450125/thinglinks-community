package com.thinglinks.component.utils;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-22
 */
import com.alibaba.fastjson2.JSONObject;
import com.thinglinks.component.message.PropertyNode;
import org.springframework.util.CollectionUtils;

import java.util.*;

public class PropertyToJson {
    /**
     * 设备属性数结构
     */
    public final static Map<String,List<PropertyNode>> PROPERTY_TREE = new HashMap<>();

    /**
     * 将物模型属性列表和多层级MAP转换为JSON
     */
    public static String convertToJson(List<PropertyNode> propertyTree, Map<String, Object> dataMap) {

        // 将属性树转换为JSON对象，同时处理多层级的dataMap
        JSONObject result = convertTreeToJson(propertyTree, dataMap);

        return result.toJSONString();
    }

    /**
     * 将属性树转换为JSON对象，处理多层级的dataMap
     */
    private static JSONObject convertTreeToJson(List<PropertyNode> nodes, Map<String, Object> dataMap) {
        JSONObject jsonObject = new JSONObject();

        for (PropertyNode node : nodes) {
            if ("struct".equals(node.getDataType()) && !CollectionUtils.isEmpty(node.getChildren())) {
                // 结构体类型，递归处理子节点
                // 从dataMap中获取对应的结构体数据
                Object structData = dataMap.get(node.getIdentifier());
                if (structData instanceof Map) {
                    @SuppressWarnings("unchecked")
                    Map<String, Object> structMap = (Map<String, Object>) structData;
                    JSONObject structObject = convertTreeToJson(node.getChildren(), structMap);
                    jsonObject.put(node.getIdentifier(), structObject);
                } else {
                    // 如果没有对应的结构体数据，创建一个空的结构体
                    JSONObject structObject = convertTreeToJson(node.getChildren(), new HashMap<>());
                    jsonObject.put(node.getIdentifier(), structObject);
                }
            } else if ("array".equals(node.getDataType())) {
                // 数组类型处理
                Object arrayData = dataMap.get(node.getIdentifier());
                jsonObject.put(node.getIdentifier(), arrayData != null ? arrayData : new ArrayList<>());
            } else {
                // 基本数据类型，直接从dataMap中取值
                Object value = dataMap.get(node.getIdentifier());
                if(value!=null){
                    jsonObject.put(node.getIdentifier(), value);
                }
            }
        }

        return jsonObject;
    }

    /**
     * 获取数据类型的默认值
     */
    private static Object getDefaultValue(String dataType) {
        switch (dataType) {
            case "int": return 0;
            case "double": return 0.0;
            case "bool": return false;
            case "string": return "";
            case "array": return new ArrayList<>();
            case "struct": return new JSONObject();
            default: return null;
        }
    }
}