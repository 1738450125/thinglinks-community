package com.thinglinks.business.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.thinglinks.common.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 物模型属性定义对象 thinglinks_properties
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "thinglinks_properties")
public class ThinglinksProperties {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 归属Sn 产品/设备
     */
    @Excel(name = "归属Sn 产品/设备")
    private String belongSn;

    /**
     * 归属类型 0-产品 1-设备
     */
    @Excel(name = "归属类型 0-产品 1-设备")
    private String belongType;

    /**
     * 属性标识符，如 temperature, status
     */
    @Excel(name = "属性标识符，如 temperature, status")
    private String identifier;

    /**
     * 属性名称
     */
    @Excel(name = "属性名称")
    private String name;

    /**
     * 父属性ID，用于构建嵌套结构。0表示根级属性
     */
    @Excel(name = "父属性ID，用于构建嵌套结构。0表示根级属性")
    private String parentId;

    /**
     * 数据类型: int, double, bool, string, struct, array...
     */
    @Excel(name = "数据类型: int, double, bool, string, struct, array...")
    private String dataType;

    /**
     * 排序
     */
    @Excel(name = "排序")
    private Long sortNum;

    /**
     * 来源 0-产品继承 1-设备自定义(继承不可修改)
     */
    @Excel(name = "来源 0-产品继承 1-设备自定义(继承不可修改)")
    private String fromType;

    /** 备注 */
    private String remark;

    /**单位*/
    private String unit;

}
