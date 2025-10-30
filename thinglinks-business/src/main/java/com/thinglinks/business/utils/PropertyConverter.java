package com.thinglinks.business.utils;

import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.thinglinks.business.domain.ThinglinksProperties;
import com.thinglinks.component.message.PropertyNode;
import com.thinglinks.component.utils.PropertyToJson;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-22
 */
public class PropertyConverter {

    /**
     * 构建属性树形结构
     */
    public static List<PropertyNode> buildPropertyTree(List<ThinglinksProperties> properties) {

        // 构建节点映射
        Map<String, PropertyNode> nodeMap = new HashMap<>();
        for (ThinglinksProperties property : properties) {
            nodeMap.put(property.getId(), new PropertyNode(property.getId(),
                    property.getIdentifier(),
                    property.getName(),
                    property.getDataType(),
                    property.getParentId(),
                    property.getSortNum()));
        }

        // 构建树形结构
        List<PropertyNode> rootNodes = new ArrayList<>();
        for (ThinglinksProperties property : properties) {
            PropertyNode node = nodeMap.get(property.getId());

            if ("0".equals(property.getParentId())) {
                rootNodes.add(node);
            } else {
                PropertyNode parentNode = nodeMap.get(property.getParentId());
                if (parentNode != null) {
                    if (parentNode.getChildren() == null) {
                        parentNode.setChildren(new ArrayList<>());
                    }
                    parentNode.getChildren().add(node);
                }
            }
        }

        // 按sortNum排序
        rootNodes.sort(Comparator.comparing(PropertyNode::getSortNum));
        sortChildrenRecursively(rootNodes);

        return rootNodes;
    }

    /**
     * 递归排序子节点
     */
    private static void sortChildrenRecursively(List<PropertyNode> nodes) {
        if (CollectionUtils.isEmpty(nodes)) {
            return;
        }

        nodes.sort(Comparator.comparing(PropertyNode::getSortNum));

        for (PropertyNode node : nodes) {
            if (!CollectionUtils.isEmpty(node.getChildren())) {
                sortChildrenRecursively(node.getChildren());
            }
        }
    }

    public static void main(String[] args) throws InterruptedException {
        long tcurrent = System.currentTimeMillis();
        for (int z = 0; z < 60; z++) {
            Thread.sleep(1000);
            long current = System.currentTimeMillis();
            for (int i = 0; i < 10000; i++) {
                // 模拟物模型属性
                List<PropertyNode> properties = Arrays.asList(
                        new PropertyNode("1" , "temperature" , "温度" , "double" , "0" , 1L),
                        new PropertyNode("2" , "humidity" , "湿度" , "double" , "0" , 2L),
                        new PropertyNode("3" , "status" , "状态" , "struct" , "0" , 3L),
                        new PropertyNode("4" , "power" , "电源状态" , "bool" , "3" , 1L),
                        new PropertyNode("5" , "mode" , "工作模式" , "string" , "3" , 2L)
                );
                List<PropertyNode> propertie2 = new ArrayList<>();
                propertie2.add(properties.get(3));
                propertie2.add(properties.get(4));
                properties.get(2).setChildren(propertie2);

                // 模拟设备上报数据
                Map<String, Object> dataMap = new HashMap<>();
                dataMap.put("temperature" , 25.6);
                dataMap.put("humidity" , 65.2);
                Map<String, Object> status = new HashMap<>();
                status.put("power" , true);
                status.put("mode" , "auto");
                dataMap.put("status" , status);

                // 转换JSON
                String json = PropertyToJson.convertToJson(properties, dataMap);
            }
            System.out.println(System.currentTimeMillis() - current);
        }
        System.out.println(System.currentTimeMillis() - tcurrent);
    }
}
