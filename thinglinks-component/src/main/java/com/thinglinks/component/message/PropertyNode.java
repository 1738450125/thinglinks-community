package com.thinglinks.component.message;

/**
 * @Description:
 * @Author: thinglinks
 * @CreateTime: 2025-09-22
 */
import lombok.Data;
import java.util.List;

@Data
public class PropertyNode {
    private String id;
    private String identifier;
    private String name;
    private String dataType;
    private String parentId;
    private Long sortNum;

    private Object value; // 属性值

    private List<PropertyNode> children; // 子属性

    public PropertyNode(String id,String identifier,String name,String dataType,String parentId,Long sortNum) {
        this.id = id;
        this.identifier = identifier;
        this.name = name;
        this.dataType = dataType;
        this.parentId = parentId;
        this.sortNum = sortNum;
    }
}