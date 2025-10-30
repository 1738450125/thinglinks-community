package com.thinglinks.business.domain.dto;

import com.thinglinks.business.domain.ThinglinksProperties;
import com.thinglinks.common.annotation.Excel;
import lombok.Data;

import java.util.List;

/**
 * @Description: 属性列表
 * @Author: thinglinks
 * @CreateTime: 2025-09-24
 */
@Data
public class PropertyListDTO {
    private List<ThinglinksProperties> propertyList;
    private String belongSn;
    private String belongType;
    private String fromType;
}
