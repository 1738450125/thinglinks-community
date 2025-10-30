/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80200 (8.2.0)
 Source Host           : localhost:3306
 Source Schema         : thinglinks-community

 Target Server Type    : MySQL
 Target Server Version : 80200 (8.2.0)
 File Encoding         : 65001

 Date: 30/10/2025 11:49:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'thinglinks_component', '网络组件', NULL, NULL, 'ThinglinksComponent', 'crud', 'element-ui', 'com.thinglinks.business', 'business', 'component', '网络组件', 'ruoyi', '0', '/', '{}', 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18', NULL);
INSERT INTO `gen_table` VALUES (2, 'thinglinks_product', '产品表', NULL, NULL, 'ThinglinksProduct', 'crud', 'element-ui', 'com.thinglinks.business', 'business', 'product', '产品', 'ruoyi', '0', '/', '{}', 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26', NULL);
INSERT INTO `gen_table` VALUES (3, 'thinglinks_properties', '物模型属性定义表', NULL, NULL, 'ThinglinksProperties', 'crud', 'element-ui', 'com.thinglinks.business', 'business', 'properties', '物模型属性定义', 'ruoyi', '0', '/', '{}', 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:33', NULL);
INSERT INTO `gen_table` VALUES (4, 'thinglinks_protocol', '协议管理', NULL, NULL, 'ThinglinksProtocol', 'crud', 'element-ui', 'com.thinglinks.business', 'business', 'protocol', '协议管理', 'ruoyi', '0', '/', '{}', 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:39', NULL);
INSERT INTO `gen_table` VALUES (5, 'thingllinks_device', '设备表', NULL, NULL, 'ThingllinksDevice', 'crud', 'element-ui', 'com.thinglinks.business', 'business', 'device', '设备', 'ruoyi', '0', '/', '{}', 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45', NULL);
INSERT INTO `gen_table` VALUES (6, 'thinglinks_device_logs', '设备日志表', NULL, NULL, 'ThinglinksDeviceLogs', 'crud', 'element-ui', 'com.thinglinks.business', 'business', 'logs', '设备日志', 'ruoyi', '0', '/', '{}', 'admin', '2025-09-22 15:42:02', '', '2025-09-22 15:42:16', NULL);
INSERT INTO `gen_table` VALUES (7, 'thinglinks_warn_config', '告警配置表', NULL, NULL, 'ThinglinksWarnConfig', 'crud', 'element-ui', 'com.thinglinks.business', 'business', 'warnConfig', '告警配置', 'ruoyi', '0', '/', '{}', 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:05:48', NULL);
INSERT INTO `gen_table` VALUES (8, 'thinglinks_warn_record', '告警记录表', NULL, NULL, 'ThinglinksWarnRecord', 'crud', 'element-ui', 'com.thinglinks.business', 'business', 'warnRecord', '告警记录', 'ruoyi', '0', '/', '{}', 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:06:02', NULL);
INSERT INTO `gen_table` VALUES (9, 'thinglinks_rule_engine', '规则引擎配置', NULL, NULL, 'ThinglinksRuleEngine', 'crud', 'element-ui', 'com.thinglinks.business', 'business', 'engine', '规则引擎配置', 'ruoyi', '0', '/', '{}', 'admin', '2025-10-20 10:01:01', '', '2025-10-20 10:01:27', NULL);
INSERT INTO `gen_table` VALUES (10, 'thinglinks_function', '设备指令下发表', NULL, NULL, 'ThinglinksFunction', 'crud', 'element-ui', 'com.thinglinks.business', 'business', 'function', '设备指令下发', 'ruoyi', '0', '/', '{}', 'admin', '2025-10-24 17:01:11', '', '2025-10-24 17:01:25', NULL);
INSERT INTO `gen_table` VALUES (11, 'warn_function_record', '指令下发记录', NULL, NULL, 'WarnFunctionRecord', 'crud', 'element-ui', 'com.thinglinks.business', 'business', 'record', '指令下发记录', 'ruoyi', '0', '/', '{\"parentMenuId\":0}', 'admin', '2025-10-29 17:16:05', '', '2025-10-29 17:16:24', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'id', 'id', 'varchar(255)', 'String', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (2, 1, 'name', '组件名称', 'varchar(255)', 'String', 'name', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (3, 1, 'net_type', '网络类型', 'varchar(255)', 'String', 'netType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (4, 1, 'ip_addr', 'IP地址', 'varchar(255)', 'String', 'ipAddr', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (5, 1, 'port', '端口', 'int', 'Long', 'port', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (6, 1, 'open_tls', '是否开启TLS (0-否 1-是)', 'varchar(255)', 'String', 'openTls', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (7, 1, 'remark', '备注', 'text', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 7, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (8, 1, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (9, 1, 'create_by', '创建人', 'varchar(255)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (10, 1, 'update_time', '修改时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (11, 1, 'update_by', '修改人', 'varchar(255)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (12, 1, 'status', '0-停用 1-启用', 'varchar(255)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 12, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (13, 1, 'other_config', '其余配置(如账号密码等)', 'text', 'String', 'otherConfig', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 13, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (14, 1, 'protocol_id', '协议id', 'varchar(255)', 'String', 'protocolId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (15, 1, 'protocol_name', '协议名称', 'varchar(255)', 'String', 'protocolName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 15, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:18');
INSERT INTO `gen_table_column` VALUES (16, 2, 'id', 'id', 'varchar(255)', 'String', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (17, 2, 'product_sn', '产品编码', 'varchar(255)', 'String', 'productSn', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (18, 2, 'product_name', '产品名称', 'varchar(255)', 'String', 'productName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (19, 2, 'link_method_id', '接入方式id', 'varchar(255)', 'String', 'linkMethodId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (20, 2, 'link_method_name', '接入方式名称', 'varchar(255)', 'String', 'linkMethodName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (21, 2, 'protocol_id', '协议id', 'varchar(255)', 'String', 'protocolId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (22, 2, 'protocol_name', '协议名称', 'varchar(255)', 'String', 'protocolName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 7, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (23, 2, 'device_count', '设备数量', 'int', 'Long', 'deviceCount', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (24, 2, 'device_type', '设备类型 0-直连设备 1-网关设备', 'varchar(255)', 'String', 'deviceType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 9, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (25, 2, 'remark', '备注', 'text', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 10, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (26, 2, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (27, 2, 'update_time', '修改时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (28, 2, 'create_by', '创建人', 'varchar(255)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (29, 2, 'update_by', '修改人', 'varchar(255)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:26');
INSERT INTO `gen_table_column` VALUES (30, 2, 'status', '0-停用 1-启用', 'varchar(255)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 15, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:27');
INSERT INTO `gen_table_column` VALUES (31, 3, 'id', 'id', 'varchar(255)', 'String', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:33');
INSERT INTO `gen_table_column` VALUES (32, 3, 'belong_id', '归属id 产品/设备', 'varchar(50)', 'String', 'belongId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:33');
INSERT INTO `gen_table_column` VALUES (33, 3, 'belong_type', '归属类型 0-产品 1-设备', 'varchar(255)', 'String', 'belongType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:33');
INSERT INTO `gen_table_column` VALUES (34, 3, 'identifier', '属性标识符，如 temperature, status', 'varchar(100)', 'String', 'identifier', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:33');
INSERT INTO `gen_table_column` VALUES (35, 3, 'name', '属性名称', 'varchar(100)', 'String', 'name', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:33');
INSERT INTO `gen_table_column` VALUES (36, 3, 'parent_id', '父属性ID，用于构建嵌套结构。0表示根级属性', 'varchar(255)', 'String', 'parentId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:33');
INSERT INTO `gen_table_column` VALUES (37, 3, 'data_type', '数据类型: int, double, bool, string, struct, array...', 'varchar(50)', 'String', 'dataType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 7, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:33');
INSERT INTO `gen_table_column` VALUES (38, 3, 'sort_num', '排序', 'int', 'Long', 'sortNum', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:33');
INSERT INTO `gen_table_column` VALUES (39, 3, 'from_type', '来源 0-产品继承 1-设备自定义(继承不可修改)', 'varchar(255)', 'String', 'fromType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 9, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:33');
INSERT INTO `gen_table_column` VALUES (40, 4, 'id', 'id', 'varchar(255)', 'String', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:39');
INSERT INTO `gen_table_column` VALUES (41, 4, 'protocol_name', '协议名称', 'varchar(255)', 'String', 'protocolName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:39');
INSERT INTO `gen_table_column` VALUES (42, 4, 'local_url', '本地存储路径', 'text', 'String', 'localUrl', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:39');
INSERT INTO `gen_table_column` VALUES (43, 4, 'main_class_path', '解析类入口', 'text', 'String', 'mainClassPath', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:39');
INSERT INTO `gen_table_column` VALUES (44, 4, 'origin_name', '文件原始名字', 'text', 'String', 'originName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'textarea', '', 5, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:39');
INSERT INTO `gen_table_column` VALUES (45, 4, 'type', '0-jar包', 'varchar(255)', 'String', 'type', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 6, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:39');
INSERT INTO `gen_table_column` VALUES (46, 4, 'new_name', '文件重命名', 'text', 'String', 'newName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'textarea', '', 7, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:39');
INSERT INTO `gen_table_column` VALUES (47, 5, 'id', 'id', 'varchar(255)', 'String', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (48, 5, 'device_id', '设备id', 'varchar(255)', 'String', 'deviceId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (49, 5, 'device_sn', '设备编码', 'varchar(255)', 'String', 'deviceSn', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (50, 5, 'device_name', '设备名称', 'varchar(255)', 'String', 'deviceName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (51, 5, 'product_id', '关联产品id', 'varchar(255)', 'String', 'productId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (52, 5, 'product_name', '关联产品名称', 'varchar(255)', 'String', 'productName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (53, 5, 'product_sn', '关联产品编码', 'varchar(255)', 'String', 'productSn', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (54, 5, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (55, 5, 'create_by', '创建人', 'varchar(255)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (56, 5, 'update_time', '修改时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (57, 5, 'update_by', '修改人', 'varchar(255)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (58, 5, 'link_method_id', '接入方式id', 'varchar(255)', 'String', 'linkMethodId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (59, 5, 'link_method_name', '接入方式名称', 'varchar(255)', 'String', 'linkMethodName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 13, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (60, 5, 'protocol_id', '协议id', 'varchar(255)', 'String', 'protocolId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (61, 5, 'protocol_name', '协议名称', 'varchar(255)', 'String', 'protocolName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 15, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:45');
INSERT INTO `gen_table_column` VALUES (62, 5, 'status', '0-离线 1-在线', 'varchar(255)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 16, 'admin', '2025-09-18 13:41:42', '', '2025-09-18 13:46:46');
INSERT INTO `gen_table_column` VALUES (63, 6, 'id', 'id', 'bigint', 'Long', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-22 15:42:02', '', '2025-09-22 15:42:16');
INSERT INTO `gen_table_column` VALUES (64, 6, 'device_sn', '设备sn', 'varchar(255)', 'String', 'deviceSn', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-22 15:42:02', '', '2025-09-22 15:42:16');
INSERT INTO `gen_table_column` VALUES (65, 6, 'report_time', '上报时间', 'datetime', 'Date', 'reportTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2025-09-22 15:42:02', '', '2025-09-22 15:42:16');
INSERT INTO `gen_table_column` VALUES (66, 6, 'properties', '属性json', 'text', 'String', 'properties', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-09-22 15:42:02', '', '2025-09-22 15:42:16');
INSERT INTO `gen_table_column` VALUES (67, 6, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 5, 'admin', '2025-09-22 15:42:02', '', '2025-09-22 15:42:16');
INSERT INTO `gen_table_column` VALUES (68, 6, 'log_type', '日志类型', 'varchar(255)', 'String', 'logType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 6, 'admin', '2025-09-22 15:42:02', '', '2025-09-22 15:42:16');
INSERT INTO `gen_table_column` VALUES (69, 7, 'id', 'id', 'varchar(255)', 'String', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:05:48');
INSERT INTO `gen_table_column` VALUES (70, 7, 'name', '告警名称', 'varchar(255)', 'String', 'name', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:05:48');
INSERT INTO `gen_table_column` VALUES (71, 7, 'belong_sn', '产品/设备sn', 'varchar(255)', 'String', 'belongSn', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:05:48');
INSERT INTO `gen_table_column` VALUES (72, 7, 'belong_type', '来源 0-产品 1-设备', 'varchar(255)', 'String', 'belongType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:05:48');
INSERT INTO `gen_table_column` VALUES (73, 7, 'rule_json', '规则json', 'text', 'String', 'ruleJson', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:05:48');
INSERT INTO `gen_table_column` VALUES (74, 7, 'warn_message', '告警消息模板', 'text', 'String', 'warnMessage', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:05:48');
INSERT INTO `gen_table_column` VALUES (75, 7, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:05:48');
INSERT INTO `gen_table_column` VALUES (76, 7, 'create_by', '创建人', 'varchar(255)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:05:48');
INSERT INTO `gen_table_column` VALUES (77, 7, 'update_time', '修改时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:05:48');
INSERT INTO `gen_table_column` VALUES (78, 7, 'update_by', '修改人', 'varchar(255)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:05:48');
INSERT INTO `gen_table_column` VALUES (79, 8, 'id', 'id', 'varchar(255)', 'String', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:06:02');
INSERT INTO `gen_table_column` VALUES (80, 8, 'config_id', '告警配置id', 'varchar(255)', 'String', 'configId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:06:02');
INSERT INTO `gen_table_column` VALUES (81, 8, 'config_name', '告警配置名称', 'varchar(255)', 'String', 'configName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:06:02');
INSERT INTO `gen_table_column` VALUES (82, 8, 'warn_message', '告警内容', 'text', 'String', 'warnMessage', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:06:02');
INSERT INTO `gen_table_column` VALUES (83, 8, 'warn_data', '告警时全属性数据', 'text', 'String', 'warnData', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:06:02');
INSERT INTO `gen_table_column` VALUES (84, 8, 'belong_sn', '设备/产品sn', 'varchar(255)', 'String', 'belongSn', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:06:02');
INSERT INTO `gen_table_column` VALUES (85, 8, 'belong_type', '来源 0-产品 1-设备', 'varchar(255)', 'String', 'belongType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 7, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:06:02');
INSERT INTO `gen_table_column` VALUES (86, 8, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-10-05 00:04:56', '', '2025-10-05 00:06:02');
INSERT INTO `gen_table_column` VALUES (87, 9, 'id', 'id', 'varchar(255)', 'String', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-20 10:01:01', '', '2025-10-20 10:01:27');
INSERT INTO `gen_table_column` VALUES (88, 9, 'engine_name', '引擎名称', 'varchar(255)', 'String', 'engineName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-10-20 10:01:01', '', '2025-10-20 10:01:27');
INSERT INTO `gen_table_column` VALUES (89, 9, 'config_json', 'json配置', 'text', 'String', 'configJson', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2025-10-20 10:01:01', '', '2025-10-20 10:01:27');
INSERT INTO `gen_table_column` VALUES (90, 9, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 4, 'admin', '2025-10-20 10:01:01', '', '2025-10-20 10:01:27');
INSERT INTO `gen_table_column` VALUES (91, 9, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2025-10-20 10:01:01', '', '2025-10-20 10:01:27');
INSERT INTO `gen_table_column` VALUES (92, 10, 'id', 'id', 'varchar(255)', 'String', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-24 17:01:11', '', '2025-10-24 17:01:25');
INSERT INTO `gen_table_column` VALUES (93, 10, 'function_name', '功能名称', 'varchar(255)', 'String', 'functionName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-10-24 17:01:11', '', '2025-10-24 17:01:25');
INSERT INTO `gen_table_column` VALUES (94, 10, 'function_code', '功能编码', 'varchar(255)', 'String', 'functionCode', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-10-24 17:01:11', '', '2025-10-24 17:01:25');
INSERT INTO `gen_table_column` VALUES (95, 10, 'function_params', '自定义参数', 'text', 'String', 'functionParams', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-10-24 17:01:11', '', '2025-10-24 17:01:25');
INSERT INTO `gen_table_column` VALUES (96, 10, 'device_sn', '设备/产品sn', 'varchar(255)', 'String', 'deviceSn', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-10-24 17:01:11', '', '2025-10-24 17:01:25');
INSERT INTO `gen_table_column` VALUES (97, 10, 'protocol_id', '协议id', 'text', 'String', 'protocolId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2025-10-24 17:01:11', '', '2025-10-24 17:01:25');
INSERT INTO `gen_table_column` VALUES (98, 10, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2025-10-24 17:01:11', '', '2025-10-24 17:01:25');
INSERT INTO `gen_table_column` VALUES (99, 10, 'create_by', '创建人', 'varchar(255)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2025-10-24 17:01:11', '', '2025-10-24 17:01:25');
INSERT INTO `gen_table_column` VALUES (100, 11, 'id', 'id', 'varchar(255)', 'String', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-29 17:16:05', '', '2025-10-29 17:16:24');
INSERT INTO `gen_table_column` VALUES (101, 11, 'function_id', '功能id', 'varchar(255)', 'String', 'functionId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-29 17:16:05', '', '2025-10-29 17:16:24');
INSERT INTO `gen_table_column` VALUES (102, 11, 'function_code', '功能code', 'varchar(255)', 'String', 'functionCode', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-10-29 17:16:05', '', '2025-10-29 17:16:24');
INSERT INTO `gen_table_column` VALUES (103, 11, 'function_name', '功能名称', 'varchar(255)', 'String', 'functionName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2025-10-29 17:16:05', '', '2025-10-29 17:16:24');
INSERT INTO `gen_table_column` VALUES (104, 11, 'function_params', '参数', 'text', 'String', 'functionParams', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2025-10-29 17:16:05', '', '2025-10-29 17:16:24');
INSERT INTO `gen_table_column` VALUES (105, 11, 'is_success', '0-失败 1-成功', 'varchar(255)', 'String', 'isSuccess', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-10-29 17:16:05', '', '2025-10-29 17:16:24');
INSERT INTO `gen_table_column` VALUES (106, 11, 'create_time', '下发时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2025-10-29 17:16:05', '', '2025-10-29 17:16:24');
INSERT INTO `gen_table_column` VALUES (107, 11, 'device_sn', '设备sn', 'varchar(255)', 'String', 'deviceSn', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-10-29 17:16:05', '', '2025-10-29 17:16:24');
INSERT INTO `gen_table_column` VALUES (108, 11, 'device_name', '设备名称', 'varchar(255)', 'String', 'deviceName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 9, 'admin', '2025-10-29 17:16:05', '', '2025-10-29 17:16:24');
INSERT INTO `gen_table_column` VALUES (109, 11, 'trigger_type', '0-手动触发 1-告警触发', 'varchar(255)', 'String', 'triggerType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 10, 'admin', '2025-10-29 17:16:05', '', '2025-10-29 17:16:24');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-09-15 11:09:58', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-09-15 11:09:58', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-09-15 11:09:58', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2025-09-15 11:09:58', 'admin', '2025-09-18 13:40:46', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-09-15 11:09:58', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-09-15 11:09:58', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-09-15 11:09:58', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-09-15 11:09:58', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-09-15 11:09:58', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-09-15 11:09:58', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 168 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-18 11:50:22');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '验证码错误', '2025-09-18 13:40:20');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-18 13:40:27');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-09-18 13:40:51');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-18 13:40:53');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-09-18 13:59:02');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-18 13:59:05');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-18 17:10:06');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-20 22:37:41');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-20 22:38:06');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-20 22:47:44');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-21 16:43:30');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-21 22:27:24');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-22 10:38:55');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-22 15:41:26');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-22 20:46:45');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-23 09:23:02');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-09-23 10:16:26');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-23 10:16:28');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-23 11:38:52');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-23 13:35:45');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-23 13:40:14');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-09-24 09:07:19');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-03 14:14:14');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-08 23:07:10');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-11 09:31:29');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-13 09:14:01');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-14 09:53:49');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-10-14 09:54:59');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-14 09:55:01');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-15 15:09:36');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-18 09:43:06');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-20 09:47:57');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-21 09:38:40');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-22 09:17:26');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-23 10:23:42');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-24 17:00:53');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-25 10:37:04');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 21:15:35');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 21:55:08');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 21:56:41');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 21:56:41');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 21:56:48');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 21:56:48');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 21:57:28');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 21:57:28');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 21:58:50');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 21:58:50');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 22:02:37');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 22:02:37');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 22:03:00');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 22:03:01');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 22:03:15');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 22:03:15');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 22:04:17');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 22:04:18');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '106.92.105.125', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 22:04:30');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-29 10:03:23');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-10-29 10:26:15');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-29 10:40:42');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-10-29 10:40:49');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-29 11:02:36');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '125.80.201.66', 'XX XX', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-30 09:13:26');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '125.80.201.66', 'XX XX', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-10-30 10:31:45');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '125.80.201.66', 'XX XX', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-30 10:32:27');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '125.80.201.66', 'XX XX', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-30 11:06:52');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '125.80.201.66', 'XX XX', 'Firefox 14', 'Windows 10', '0', '登录成功', '2025-10-30 11:17:58');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-30 11:48:39');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2041 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-09-15 11:09:57', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-09-15 11:09:57', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-09-15 11:09:57', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2025-09-15 11:09:57', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-09-15 11:09:57', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-09-15 11:09:57', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-09-15 11:09:57', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-09-15 11:09:57', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-09-15 11:09:57', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-09-15 11:09:57', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-09-15 11:09:57', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-09-15 11:09:57', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-09-15 11:09:57', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-09-15 11:09:57', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-09-15 11:09:57', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-09-15 11:09:57', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-09-15 11:09:57', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-09-15 11:09:57', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-09-15 11:09:57', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-09-15 11:09:57', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-09-15 11:09:57', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-09-15 11:09:57', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-09-15 11:09:57', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-09-15 11:09:57', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-09-15 11:09:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '网络组件', 2037, 1, 'component', 'business/component/index', NULL, '', 1, 0, 'C', '0', '0', 'business:component:list', 'netComponent', 'admin', '2025-09-18 13:58:11', 'admin', '2025-10-30 11:19:43', '网络组件菜单');
INSERT INTO `sys_menu` VALUES (2001, '网络组件查询', 2000, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:component:query', '#', 'admin', '2025-09-18 13:58:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, '网络组件新增', 2000, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:component:add', '#', 'admin', '2025-09-18 13:58:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '网络组件修改', 2000, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:component:edit', '#', 'admin', '2025-09-18 13:58:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '网络组件删除', 2000, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:component:remove', '#', 'admin', '2025-09-18 13:58:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '网络组件导出', 2000, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:component:export', '#', 'admin', '2025-09-18 13:58:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '设备', 2036, 1, 'device', 'business/device/index', NULL, '', 1, 0, 'C', '0', '0', 'business:device:list', 'device', 'admin', '2025-09-18 13:58:25', 'admin', '2025-10-30 11:20:32', '设备菜单');
INSERT INTO `sys_menu` VALUES (2007, '设备查询', 2006, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:device:query', '#', 'admin', '2025-09-18 13:58:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '设备新增', 2006, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:device:add', '#', 'admin', '2025-09-18 13:58:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '设备修改', 2006, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:device:edit', '#', 'admin', '2025-09-18 13:58:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '设备删除', 2006, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:device:remove', '#', 'admin', '2025-09-18 13:58:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '设备导出', 2006, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:device:export', '#', 'admin', '2025-09-18 13:58:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '产品', 2036, 0, 'product', 'business/product/index', NULL, '', 1, 0, 'C', '0', '0', 'business:product:list', 'product', 'admin', '2025-09-18 13:58:31', 'admin', '2025-10-30 11:20:26', '产品菜单');
INSERT INTO `sys_menu` VALUES (2013, '产品查询', 2012, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:product:query', '#', 'admin', '2025-09-18 13:58:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '产品新增', 2012, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:product:add', '#', 'admin', '2025-09-18 13:58:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '产品修改', 2012, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:product:edit', '#', 'admin', '2025-09-18 13:58:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '产品删除', 2012, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:product:remove', '#', 'admin', '2025-09-18 13:58:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '产品导出', 2012, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:product:export', '#', 'admin', '2025-09-18 13:58:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '协议管理', 2037, 1, 'protocol', 'business/protocol/index', NULL, '', 1, 0, 'C', '0', '0', 'business:protocol:list', 'protocol', 'admin', '2025-09-18 14:00:37', 'admin', '2025-10-30 11:19:51', '协议管理菜单');
INSERT INTO `sys_menu` VALUES (2031, '协议管理查询', 2030, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:protocol:query', '#', 'admin', '2025-09-18 14:00:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '协议管理新增', 2030, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:protocol:add', '#', 'admin', '2025-09-18 14:00:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '协议管理修改', 2030, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:protocol:edit', '#', 'admin', '2025-09-18 14:00:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '协议管理删除', 2030, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:protocol:remove', '#', 'admin', '2025-09-18 14:00:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '协议管理导出', 2030, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'business:protocol:export', '#', 'admin', '2025-09-18 14:00:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '设备管理', 0, 0, '/deviceManage', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'device', 'admin', '2025-09-18 14:03:01', 'admin', '2025-10-30 11:20:19', '');
INSERT INTO `sys_menu` VALUES (2037, '网络组件', 0, 0, '/componentManage', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'netComponent', 'admin', '2025-09-18 14:04:33', 'admin', '2025-10-30 11:19:36', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-09-15 11:09:58', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-09-15 11:09:58', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 249 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '参数管理', 2, 'com.thinglinks.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/config', '127.0.0.1', '内网IP', '{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2025-09-15 11:09:58\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 13:40:46', 31);
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 6, 'com.thinglinks.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"thinglinks_protocol,thinglinks_component,thinglinks_properties,thinglinks_product,thingllinks_device\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 13:41:42', 276);
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"component\",\"className\":\"ThinglinksComponent\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"组件名称\",\"columnId\":2,\"columnName\":\"name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"NetType\",\"columnComment\":\"网络类型\",\"columnId\":3,\"columnName\":\"net_type\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"netType\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"IpAddr\",\"columnComment\":\"IP地址\",\"columnId\":4,\"columnName\":\"ip_addr\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"java', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 13:46:18', 87);
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"product\",\"className\":\"ThinglinksProduct\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":16,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProductSn\",\"columnComment\":\"产品编码\",\"columnId\":17,\"columnName\":\"product_sn\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"productSn\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProductName\",\"columnComment\":\"产品名称\",\"columnId\":18,\"columnName\":\"product_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"productName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"LinkMethodId\",\"columnComment\":\"接入方式id\",\"columnId\":19,\"columnName\":\"link_method_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 13:46:27', 69);
INSERT INTO `sys_oper_log` VALUES (104, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"properties\",\"className\":\"ThinglinksProperties\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":31,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BelongId\",\"columnComment\":\"归属id 产品/设备\",\"columnId\":32,\"columnName\":\"belong_id\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"belongId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BelongType\",\"columnComment\":\"归属类型 0-产品 1-设备\",\"columnId\":33,\"columnName\":\"belong_type\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"belongType\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Identifier\",\"columnComment\":\"属性标识符，如 temperature, status\",\"columnId\":34,\"columnName\":\"identifier\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isI', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 13:46:33', 42);
INSERT INTO `sys_oper_log` VALUES (105, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"protocol\",\"className\":\"ThinglinksProtocol\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":40,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProtocolName\",\"columnComment\":\"协议名称\",\"columnId\":41,\"columnName\":\"protocol_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"protocolName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"LocalUrl\",\"columnComment\":\"本地存储路径\",\"columnId\":42,\"columnName\":\"local_url\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"localUrl\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"MainClassPath\",\"columnComment\":\"解析类入口\",\"columnId\":43,\"columnName\":\"main_class_path\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 13:46:39', 34);
INSERT INTO `sys_oper_log` VALUES (106, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"device\",\"className\":\"ThingllinksDevice\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":47,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"DeviceId\",\"columnComment\":\"设备id\",\"columnId\":48,\"columnName\":\"device_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"deviceId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"DeviceSn\",\"columnComment\":\"设备编码\",\"columnId\":49,\"columnName\":\"device_sn\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"deviceSn\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"DeviceName\",\"columnComment\":\"设备名称\",\"columnId\":50,\"columnName\":\"device_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-18 13:41:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"i', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 13:46:46', 73);
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 8, 'com.thinglinks.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"thinglinks_component,thinglinks_product,thinglinks_properties,thinglinks_protocol,thingllinks_device\"}', NULL, 0, NULL, '2025-09-18 13:46:50', 428);
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2024', '127.0.0.1', '内网IP', '2024', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2025-09-18 14:00:07', 7);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2026', '127.0.0.1', '内网IP', '2026', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:00:12', 18);
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2025', '127.0.0.1', '内网IP', '2025', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:00:14', 23);
INSERT INTO `sys_oper_log` VALUES (111, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2027', '127.0.0.1', '内网IP', '2027', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:00:17', 17);
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2028', '127.0.0.1', '内网IP', '2028', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:00:19', 19);
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2029', '127.0.0.1', '内网IP', '2029', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:00:21', 18);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2024', '127.0.0.1', '内网IP', '2024', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:00:23', 18);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 1, 'com.thinglinks.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"international\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"设备管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"/deviceManage\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:03:01', 13);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"business/device/index\",\"createTime\":\"2025-09-18 13:58:25\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"设备\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2036,\"path\":\"device\",\"perms\":\"business:device:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:03:15', 13);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"business/product/index\",\"createTime\":\"2025-09-18 13:58:31\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"产品\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2036,\"path\":\"product\",\"perms\":\"business:product:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:03:21', 14);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 1, 'com.thinglinks.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"网络组件\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"/componentManage\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:04:33', 14);
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"business/component/index\",\"createTime\":\"2025-09-18 13:58:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"网络组件\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2037,\"path\":\"component\",\"perms\":\"business:component:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:05:12', 14);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"business/protocol/index\",\"createTime\":\"2025-09-18 14:00:37\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2030,\"menuName\":\"协议管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2037,\"path\":\"protocol\",\"perms\":\"business:protocol:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:05:33', 12);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2018', '127.0.0.1', '内网IP', '2018', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2025-09-18 14:05:40', 5);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2019', '127.0.0.1', '内网IP', '2019', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:05:44', 11);
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2020', '127.0.0.1', '内网IP', '2020', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:05:46', 11);
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2022', '127.0.0.1', '内网IP', '2022', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:05:48', 14);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2021', '127.0.0.1', '内网IP', '2021', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:05:50', 35);
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2023', '127.0.0.1', '内网IP', '2023', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:05:53', 16);
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2018', '127.0.0.1', '内网IP', '2018', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:05:55', 16);
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"business/product/index\",\"createTime\":\"2025-09-18 13:58:31\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"产品\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2036,\"path\":\"product\",\"perms\":\"business:product:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-18 14:06:07', 13);
INSERT INTO `sys_oper_log` VALUES (129, '代码生成', 6, 'com.thinglinks.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"thinglinks_device_logs\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 15:42:02', 58);
INSERT INTO `sys_oper_log` VALUES (130, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"logs\",\"className\":\"ThinglinksDeviceLogs\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":63,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-22 15:42:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"DeviceSn\",\"columnComment\":\"设备sn\",\"columnId\":64,\"columnName\":\"device_sn\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-22 15:42:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"deviceSn\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ReportTime\",\"columnComment\":\"上报时间\",\"columnId\":65,\"columnName\":\"report_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2025-09-22 15:42:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"reportTime\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Properties\",\"columnComment\":\"属性json\",\"columnId\":66,\"columnName\":\"properties\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-09-22 15:42:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequire', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 15:42:16', 37);
INSERT INTO `sys_oper_log` VALUES (131, '代码生成', 8, 'com.thinglinks.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"thinglinks_device_logs\"}', NULL, 0, NULL, '2025-09-22 15:42:30', 201);
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 1, 'com.thinglinks.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/business/component/detail\",\"createBy\":\"admin\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"组件详情\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2000,\"path\":\"/componentManage/component-detail\",\"routeName\":\"ComponentDetail\",\"status\":\"0\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-23 10:13:52', 28);
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/business/component/detail\",\"createTime\":\"2025-09-23 10:13:52\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2038,\"menuName\":\"组件详情\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2000,\"path\":\"/componentManage/component-detail\",\"perms\":\"\",\"routeName\":\"ComponentDetail\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-23 10:16:20', 21);
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/business/component/detail\",\"createTime\":\"2025-09-23 10:13:52\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2038,\"menuName\":\"组件详情\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2000,\"path\":\"/componentManage/component-detail\",\"perms\":\"\",\"routeName\":\"ComponentDetail\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-23 10:17:38', 13);
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/business/component/detail\",\"createTime\":\"2025-09-23 10:13:52\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2038,\"menuName\":\"组件详情\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2000,\"path\":\"component-detail\",\"perms\":\"\",\"routeName\":\"ComponentDetail\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-23 10:20:18', 13);
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 1, 'com.thinglinks.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/system/dict\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"213\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2037,\"path\":\"index\",\"routeName\":\"Index\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-23 10:21:30', 9);
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2039', '127.0.0.1', '内网IP', '2039', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-23 10:21:59', 22);
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2038', '127.0.0.1', '内网IP', '2038', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-23 10:22:05', 18);
INSERT INTO `sys_oper_log` VALUES (139, '用户头像', 2, 'com.thinglinks.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/09/23/efba96d828614e60a253242760159123.png\",\"code\":200}', 0, NULL, '2025-09-23 13:54:37', 81);
INSERT INTO `sys_oper_log` VALUES (140, '用户头像', 2, 'com.thinglinks.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/09/23/af3c376fcbff4bdc82c1ddbf4f6c3ea0.jpg\",\"code\":200}', 0, NULL, '2025-09-23 13:55:21', 21);
INSERT INTO `sys_oper_log` VALUES (141, '代码生成', 6, 'com.thinglinks.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"thinglinks_warn_record,thinglinks_warn_config\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-05 00:04:56', 114);
INSERT INTO `sys_oper_log` VALUES (142, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"warnConfig\",\"className\":\"ThinglinksWarnConfig\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":69,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-05 00:04:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"告警名称\",\"columnId\":70,\"columnName\":\"name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-05 00:04:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BelongSn\",\"columnComment\":\"产品/设备sn\",\"columnId\":71,\"columnName\":\"belong_sn\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-05 00:04:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"belongSn\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BelongType\",\"columnComment\":\"来源 0-产品 1-设备\",\"columnId\":72,\"columnName\":\"belong_type\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-05 00:04:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-05 00:05:48', 69);
INSERT INTO `sys_oper_log` VALUES (143, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"warnRecord\",\"className\":\"ThinglinksWarnRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":79,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-05 00:04:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ConfigId\",\"columnComment\":\"告警配置id\",\"columnId\":80,\"columnName\":\"config_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-05 00:04:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"configId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ConfigName\",\"columnComment\":\"告警配置名称\",\"columnId\":81,\"columnName\":\"config_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-05 00:04:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"configName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"WarnMessage\",\"columnComment\":\"告警内容\",\"columnId\":82,\"columnName\":\"warn_message\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-10-05 00:04:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-05 00:06:02', 49);
INSERT INTO `sys_oper_log` VALUES (144, '代码生成', 8, 'com.thinglinks.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"thinglinks_warn_config,thinglinks_warn_record\"}', NULL, 0, NULL, '2025-10-05 00:06:06', 380);
INSERT INTO `sys_oper_log` VALUES (145, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"id\":\"rule_001\",\"name\":\"温度过高告警规则\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:05:10', 20);
INSERT INTO `sys_oper_log` VALUES (146, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"id\":\"rule_001\",\"name\":\"温度过高告警规则\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:05:39', 9);
INSERT INTO `sys_oper_log` VALUES (147, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"id\":\"rule_001\",\"name\":\"温度过高告警规则\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:06:10', 20);
INSERT INTO `sys_oper_log` VALUES (148, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"id\":\"rule_001\",\"name\":\"温度过高告警规则\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:07:03', 18);
INSERT INTO `sys_oper_log` VALUES (149, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"id\":\"rule_001\",\"name\":\"温度过高告警规则\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:07:34', 8473);
INSERT INTO `sys_oper_log` VALUES (150, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"id\":\"rule_001\",\"name\":\"温度过高告警规则\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:34:54', 7);
INSERT INTO `sys_oper_log` VALUES (151, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"id\":\"rule_001\",\"name\":\"温度过高告警规则\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:35:28', 12);
INSERT INTO `sys_oper_log` VALUES (152, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"actionSign\":\"\",\"params\":\"\"}],\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"123\"}],\"level\":\"warning\",\"message\":\"哈哈哈\",\"name\":\"测试\",\"relation\":\"and\"}', NULL, 1, 'java.lang.NullPointerException\r\n	at com.thinglinks.business.controller.ThinglinksWarnConfigController.add(ThinglinksWarnConfigController.java:98)\r\n	at com.thinglinks.business.controller.ThinglinksWarnConfigController$$FastClassBySpringCGLIB$$c73aaee9.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:792)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:64)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.aop.framework.adapter.AfterReturningAdviceInterceptor.invoke(AfterReturningAdviceInterceptor.java:57)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.aop.framework.adapter.MethodBeforeAdviceInterceptor.invoke(MethodBeforeAdviceInterceptor.java:58)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.security.authorization.method.AuthorizationManagerBeforeMethodInterceptor.invoke(AuthorizationManagerBeforeMethodInterceptor.java:162)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framewo', '2025-10-11 10:36:32', 6);
INSERT INTO `sys_oper_log` VALUES (153, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"actionSign\":\"\",\"params\":\"\"}],\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"123\"}],\"level\":\"warning\",\"message\":\"213213\",\"name\":\"测试2\",\"relation\":\"and\"}', NULL, 1, 'java.lang.NullPointerException\r\n	at com.thinglinks.business.controller.ThinglinksWarnConfigController.add(ThinglinksWarnConfigController.java:98)\r\n	at com.thinglinks.business.controller.ThinglinksWarnConfigController$$FastClassBySpringCGLIB$$c73aaee9.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:792)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:64)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.aop.framework.adapter.AfterReturningAdviceInterceptor.invoke(AfterReturningAdviceInterceptor.java:57)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.aop.framework.adapter.MethodBeforeAdviceInterceptor.invoke(MethodBeforeAdviceInterceptor.java:58)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.security.authorization.method.AuthorizationManagerBeforeMethodInterceptor.invoke(AuthorizationManagerBeforeMethodInterceptor.java:162)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framewo', '2025-10-11 10:37:59', 8284);
INSERT INTO `sys_oper_log` VALUES (154, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"id\":\"rule_001\",\"name\":\"温度过高告警规则\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:38:58', 16);
INSERT INTO `sys_oper_log` VALUES (155, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"actionSign\":\"\",\"params\":\"\"}],\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"123\"}],\"enable\":true,\"level\":\"warning\",\"message\":\"3213\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:39:22', 24);
INSERT INTO `sys_oper_log` VALUES (156, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"name\":\"测试\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:41:09', 13);
INSERT INTO `sys_oper_log` VALUES (157, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"id\":\"123456\",\"name\":\"温度过高告警规则\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:50:08', 23);
INSERT INTO `sys_oper_log` VALUES (158, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":true,\"id\":\"123456\",\"level\":\"critical\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃213213\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:52:53', 52);
INSERT INTO `sys_oper_log` VALUES (159, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":true,\"id\":\"123456\",\"level\":\"critical\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:53:13', 16);
INSERT INTO `sys_oper_log` VALUES (160, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"actionSign\":\"\",\"params\":\"\"}],\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"10\"}],\"enable\":true,\"id\":\"1976843712109854721\",\"level\":\"critical\",\"message\":\"风速大于10,当前风速${windSpeed}\",\"name\":\"测试告警1\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:54:03', 19);
INSERT INTO `sys_oper_log` VALUES (161, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"actionSign\":\"\",\"params\":\"\"}],\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"10\"}],\"enable\":true,\"id\":\"1976843712109854721\",\"level\":\"critical\",\"message\":\"风速大于10,当前风速${windSpeed}\",\"name\":\"测试告警1\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:55:55', 16);
INSERT INTO `sys_oper_log` VALUES (162, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"actionSign\":\"\",\"params\":\"\"}],\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"10\"}],\"enable\":true,\"id\":\"1976843712109854721\",\"level\":\"critical\",\"message\":\"风速大于10,当前风速${windSpeed}\",\"name\":\"测试告警1\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:57:37', 23);
INSERT INTO `sys_oper_log` VALUES (163, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"actionSign\":\"\",\"params\":\"\"}],\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"5\"}],\"enable\":true,\"id\":\"1976844915975766017\",\"level\":\"warning\",\"message\":\"风速过高，当前风速${windSpeed}，大于预警值5\",\"name\":\"风速告警\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 10:58:50', 14);
INSERT INTO `sys_oper_log` VALUES (164, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"actionSign\":\"\",\"params\":\"\"}],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"5\"}],\"enable\":true,\"id\":\"1976846009544065026\",\"level\":\"warning\",\"message\":\"当前风速${windSpeed}，大于5\",\"name\":\"风速告警\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 11:03:11', 27);
INSERT INTO `sys_oper_log` VALUES (165, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"actionSign\":\"\",\"params\":\"\"}],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"5\"}],\"enable\":true,\"id\":\"1976846009544065026\",\"level\":\"warning\",\"message\":\"当前风速${windSpeed}，大于5，\",\"name\":\"风速告警\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 11:03:23', 14);
INSERT INTO `sys_oper_log` VALUES (166, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"actionSign\":\"\",\"params\":\"\"}],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"5\"}],\"enable\":true,\"id\":\"1976846009544065026\",\"level\":\"warning\",\"message\":\"当前风速${windSpeed}，大于5\",\"name\":\"风速告警\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 11:03:28', 14);
INSERT INTO `sys_oper_log` VALUES (167, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"actionSign\":\"\",\"params\":\"\"}],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"123\"}],\"enable\":true,\"id\":\"1976847153871826946\",\"level\":\"warning\",\"message\":\"测试\",\"name\":\"告警2\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 11:07:44', 21);
INSERT INTO `sys_oper_log` VALUES (168, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"111\"}],\"enable\":true,\"id\":\"1976847432528801794\",\"level\":\"warning\",\"message\":\"213\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 11:08:50', 15);
INSERT INTO `sys_oper_log` VALUES (169, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"111\"}],\"delayTime\":10,\"enable\":true,\"id\":\"1976847432528801794\",\"level\":\"warning\",\"message\":\"213\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 11:34:58', 29);
INSERT INTO `sys_oper_log` VALUES (170, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":false,\"id\":\"123456\",\"level\":\"critical\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 11:46:47', 43);
INSERT INTO `sys_oper_log` VALUES (171, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":true,\"id\":\"123456\",\"level\":\"critical\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 11:46:48', 17);
INSERT INTO `sys_oper_log` VALUES (172, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"111\"}],\"delayTime\":10,\"enable\":true,\"id\":\"1976847432528801794\",\"level\":\"warning\",\"message\":\"213\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 11:46:50', 23);
INSERT INTO `sys_oper_log` VALUES (173, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":false,\"id\":\"123456\",\"level\":\"critical\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 11:47:08', 13);
INSERT INTO `sys_oper_log` VALUES (174, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":false,\"id\":\"123456\",\"level\":\"critical\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 11:47:34', 13);
INSERT INTO `sys_oper_log` VALUES (175, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":false,\"id\":\"123456\",\"level\":\"critical\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 12:00:33', 30);
INSERT INTO `sys_oper_log` VALUES (176, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":true,\"id\":\"123456\",\"level\":\"critical\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 12:00:38', 30);
INSERT INTO `sys_oper_log` VALUES (177, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"111\"}],\"delayTime\":10,\"enable\":false,\"id\":\"1976847432528801794\",\"level\":\"warning\",\"message\":\"213\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 12:00:40', 22);
INSERT INTO `sys_oper_log` VALUES (178, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":false,\"id\":\"123456\",\"level\":\"critical\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 12:00:41', 25);
INSERT INTO `sys_oper_log` VALUES (179, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":true,\"id\":\"123456\",\"level\":\"critical\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 14:47:23', 25);
INSERT INTO `sys_oper_log` VALUES (180, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":true,\"id\":\"123456\",\"level\":\"1\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:08:54', 42);
INSERT INTO `sys_oper_log` VALUES (181, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"111\"}],\"delayTime\":10,\"enable\":false,\"id\":\"1976847432528801794\",\"level\":\"1\",\"message\":\"213\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:08:58', 16);
INSERT INTO `sys_oper_log` VALUES (182, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"111\"}],\"delayTime\":10,\"enable\":false,\"id\":\"1976847432528801794\",\"level\":\"1\",\"message\":\"213\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:09:01', 15);
INSERT INTO `sys_oper_log` VALUES (183, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":true,\"id\":\"123456\",\"level\":\"1\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:09:19', 16);
INSERT INTO `sys_oper_log` VALUES (184, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"111\"}],\"delayTime\":10,\"enable\":true,\"id\":\"1976847432528801794\",\"level\":\"1\",\"message\":\"213\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:09:20', 19);
INSERT INTO `sys_oper_log` VALUES (185, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"111\"}],\"delayTime\":10,\"enable\":true,\"id\":\"1976847432528801794\",\"level\":\"1\",\"message\":\"213\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:09:24', 17);
INSERT INTO `sys_oper_log` VALUES (186, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"111\"}],\"delayTime\":10,\"enable\":true,\"id\":\"1976847432528801794\",\"level\":\"1\",\"message\":\"213\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:09:25', 16);
INSERT INTO `sys_oper_log` VALUES (187, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":true,\"id\":\"123456\",\"level\":\"1\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:09:30', 14);
INSERT INTO `sys_oper_log` VALUES (188, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"111\"}],\"delayTime\":10,\"enable\":true,\"id\":\"1976847432528801794\",\"level\":\"1\",\"message\":\"213\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:09:32', 14);
INSERT INTO `sys_oper_log` VALUES (189, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-device01\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"35\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"6\"}],\"delayTime\":10,\"enable\":true,\"id\":\"123456\",\"level\":\"1\",\"message\":\"设备温度异常，当前温度${temperature}℃，超过阈值35℃\",\"name\":\"温度过高告警规则\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:10:47', 23);
INSERT INTO `sys_oper_log` VALUES (190, '告警配置', 3, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.remove()', 'DELETE', 1, 'admin', '研发部门', '/business/warnConfig/123456', '127.0.0.1', '内网IP', '[\"123456\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:13:31', 30);
INSERT INTO `sys_oper_log` VALUES (191, '告警配置', 3, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.remove()', 'DELETE', 1, 'admin', '研发部门', '/business/warnConfig/1976847432528801794', '127.0.0.1', '内网IP', '[\"1976847432528801794\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:13:35', 10);
INSERT INTO `sys_oper_log` VALUES (192, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"38\"},{\"attribute\":\"windSpeed\",\"operator\":\"lt\",\"value\":\"10\"}],\"delayTime\":10,\"enable\":true,\"id\":\"1976924520506019841\",\"level\":\"3\",\"message\":\"温度过高，当前温度${temperature}，超过预警值38\",\"name\":\"高温告警\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:15:09', 25);
INSERT INTO `sys_oper_log` VALUES (193, '告警配置', 3, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.remove()', 'DELETE', 1, 'admin', '研发部门', '/business/warnConfig/1976924520506019841', '127.0.0.1', '内网IP', '[\"1976924520506019841\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:42:57', 35);
INSERT INTO `sys_oper_log` VALUES (194, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"10\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1976932019586027521\",\"level\":\"1\",\"message\":\"123\",\"name\":\"ceshi\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 16:44:57', 16);
INSERT INTO `sys_oper_log` VALUES (195, '告警配置', 3, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.remove()', 'DELETE', 1, 'admin', '研发部门', '/business/warnConfig/1976932019586027521', '127.0.0.1', '内网IP', '[\"1976932019586027521\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 17:12:07', 21);
INSERT INTO `sys_oper_log` VALUES (196, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"100\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1976938887867826178\",\"level\":\"1\",\"message\":\"213213\",\"name\":\"312\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 17:12:15', 23);
INSERT INTO `sys_oper_log` VALUES (197, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"100\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1976938887867826178\",\"level\":\"3\",\"message\":\"213213\",\"name\":\"312\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 17:12:19', 21);
INSERT INTO `sys_oper_log` VALUES (198, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"100\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1976938887867826178\",\"level\":\"4\",\"message\":\"213213\",\"name\":\"312\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 17:12:21', 25);
INSERT INTO `sys_oper_log` VALUES (199, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"100\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1976938887867826178\",\"level\":\"2\",\"message\":\"213213\",\"name\":\"312\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 17:12:24', 12);
INSERT INTO `sys_oper_log` VALUES (200, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"100\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1976938887867826178\",\"level\":\"3\",\"message\":\"213213\",\"name\":\"312\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 17:12:27', 23);
INSERT INTO `sys_oper_log` VALUES (201, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"100\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1976938887867826178\",\"level\":\"2\",\"message\":\"213213\",\"name\":\"312\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 17:12:42', 18);
INSERT INTO `sys_oper_log` VALUES (202, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"100\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1976938887867826178\",\"level\":\"2\",\"message\":\"213213\",\"name\":\"312\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-11 17:14:33', 13);
INSERT INTO `sys_oper_log` VALUES (203, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"HTTP_PRODUCT\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"50\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1979485650587795457\",\"level\":\"2\",\"message\":\"告警啦\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-18 17:52:10', 27);
INSERT INTO `sys_oper_log` VALUES (204, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"100\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"100\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1976938887867826178\",\"level\":\"2\",\"message\":\"213213\",\"name\":\"312\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-19 14:07:53', 399);
INSERT INTO `sys_oper_log` VALUES (205, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"IOT-device01\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"gt\",\"value\":\"100\"},{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"100\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1976938887867826178\",\"level\":\"2\",\"message\":\"213213\",\"name\":\"312\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-19 14:07:57', 9);
INSERT INTO `sys_oper_log` VALUES (206, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"HTTP_PRODUCT\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"50\"}],\"delayTime\":0,\"enable\":false,\"id\":\"1979485650587795457\",\"level\":\"2\",\"message\":\"告警啦\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-19 14:13:34', 28);
INSERT INTO `sys_oper_log` VALUES (207, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"HTTP_PRODUCT\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"50\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1979485650587795457\",\"level\":\"2\",\"message\":\"告警啦\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-19 14:13:36', 19);
INSERT INTO `sys_oper_log` VALUES (208, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"HTTP_PRODUCT\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"50\"}],\"delayTime\":0,\"enable\":false,\"id\":\"1979485650587795457\",\"level\":\"2\",\"message\":\"告警啦\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-19 14:13:53', 25);
INSERT INTO `sys_oper_log` VALUES (209, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.toggleRuleStatus()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig/toggleRuleStatus', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"HTTP_PRODUCT\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"50\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1979485650587795457\",\"level\":\"2\",\"message\":\"告警啦\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-19 14:13:56', 19);
INSERT INTO `sys_oper_log` VALUES (210, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"HTTP_PRODUCT\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"ne\",\"value\":\"100\"}],\"delayTime\":20,\"enable\":true,\"id\":\"1979799048719896577\",\"level\":\"2\",\"message\":\"温度失衡\",\"name\":\"测试3\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-19 14:37:30', 26);
INSERT INTO `sys_oper_log` VALUES (211, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"HTTP_PRODUCT\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"windSpeed\",\"operator\":\"gt\",\"value\":\"50\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1979485650587795457\",\"level\":\"2\",\"message\":\"告警啦\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-19 16:12:20', 44);
INSERT INTO `sys_oper_log` VALUES (212, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[],\"belongSn\":\"HTTP_PRODUCT\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"temperature\",\"operator\":\"ne\",\"value\":\"100\"}],\"delayTime\":20,\"enable\":true,\"id\":\"1979799048719896577\",\"level\":\"2\",\"message\":\"温度失衡\",\"name\":\"测试3\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-19 16:12:21', 6);
INSERT INTO `sys_oper_log` VALUES (213, '菜单管理', 1, 'com.thinglinks.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"business/engine/index\",\"createBy\":\"admin\",\"icon\":\"druid\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuName\":\"规则引擎\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2037,\"path\":\"engine\",\"routeName\":\"Engine\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-19 18:11:02', 32);
INSERT INTO `sys_oper_log` VALUES (214, '代码生成', 6, 'com.thinglinks.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"thinglinks_rule_engine\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-20 10:01:01', 53);
INSERT INTO `sys_oper_log` VALUES (215, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"engine\",\"className\":\"ThinglinksRuleEngine\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":87,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-20 10:01:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EngineName\",\"columnComment\":\"引擎名称\",\"columnId\":88,\"columnName\":\"engine_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-20 10:01:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"engineName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ConfigJson\",\"columnComment\":\"json配置\",\"columnId\":89,\"columnName\":\"config_json\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-10-20 10:01:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"configJson\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CreateTime\",\"columnComment\":\"创建时间\",\"columnId\":90,\"columnName\":\"create_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2025-10-20 10:01:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"0\",\"isRequired\":\"0\",\"javaField\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-20 10:01:27', 30);
INSERT INTO `sys_oper_log` VALUES (216, '代码生成', 8, 'com.thinglinks.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"thinglinks_rule_engine\"}', NULL, 0, NULL, '2025-10-20 10:01:31', 232);
INSERT INTO `sys_oper_log` VALUES (217, '代码生成', 6, 'com.thinglinks.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"thinglinks_function\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-24 17:01:11', 129);
INSERT INTO `sys_oper_log` VALUES (218, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"function\",\"className\":\"ThinglinksFunction\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":92,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-24 17:01:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FunctionName\",\"columnComment\":\"功能名称\",\"columnId\":93,\"columnName\":\"function_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-24 17:01:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"functionName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FunctionCode\",\"columnComment\":\"功能编码\",\"columnId\":94,\"columnName\":\"function_code\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-24 17:01:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"functionCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FunctionParams\",\"columnComment\":\"自定义参数\",\"columnId\":95,\"columnName\":\"function_params\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-10-24 17:01:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isL', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-24 17:01:25', 81);
INSERT INTO `sys_oper_log` VALUES (219, '代码生成', 8, 'com.thinglinks.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"thinglinks_function\"}', NULL, 0, NULL, '2025-10-24 17:01:32', 333);
INSERT INTO `sys_oper_log` VALUES (220, '设备指令下发', 1, 'com.thinglinks.business.controller.ThinglinksFunctionController.add()', 'POST', 1, 'admin', '研发部门', '/business/function', '127.0.0.1', '内网IP', '{\"functionCode\":\"TEST\",\"functionName\":\"测试指令\",\"functionParams\":\"123\"}', NULL, 1, 'java.lang.NullPointerException\r\n	at com.thinglinks.business.controller.ThinglinksFunctionController.add(ThinglinksFunctionController.java:110)\r\n	at com.thinglinks.business.controller.ThinglinksFunctionController$$FastClassBySpringCGLIB$$2de77e99.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:792)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:64)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.aop.framework.adapter.AfterReturningAdviceInterceptor.invoke(AfterReturningAdviceInterceptor.java:57)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.aop.framework.adapter.MethodBeforeAdviceInterceptor.invoke(MethodBeforeAdviceInterceptor.java:58)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:762)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:97)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(Cglib', '2025-10-25 11:39:55', 10);
INSERT INTO `sys_oper_log` VALUES (221, '设备指令下发', 1, 'com.thinglinks.business.controller.ThinglinksFunctionController.add()', 'POST', 1, 'admin', '研发部门', '/business/function', '127.0.0.1', '内网IP', '{\"belongSn\":\"IOT-0016\",\"belongType\":\"0\",\"functionCode\":\"TEST\",\"functionName\":\"测试指令\",\"functionParams\":\"123\",\"id\":\"1981929251066413058\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-25 11:42:10', 20);
INSERT INTO `sys_oper_log` VALUES (222, '设备指令下发', 1, 'com.thinglinks.business.controller.ThinglinksFunctionController.add()', 'POST', 1, 'admin', '研发部门', '/business/function', '127.0.0.1', '内网IP', '{\"belongSn\":\"123456\",\"belongType\":\"0\",\"functionCode\":\"TEST001\",\"functionName\":\"测试指令\",\"functionParams\":\"213123\",\"id\":\"1981933616963584002\",\"protocolId\":\"1981912979998031873\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-25 11:59:31', 18);
INSERT INTO `sys_oper_log` VALUES (223, '规则引擎配置', 2, 'com.thinglinks.business.controller.ThinglinksRuleEngineController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/ruleEngine', '106.92.105.125', 'XX XX', '{\"configJson\":\"213\",\"createTime\":\"2025-10-20 02:22:05\",\"engineName\":\"213\",\"id\":\"1\",\"isEnable\":\"undefined\",\"remark\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-28 21:17:10', 19);
INSERT INTO `sys_oper_log` VALUES (224, '规则引擎配置', 3, 'com.thinglinks.business.controller.ThinglinksRuleEngineController.remove()', 'DELETE', 1, 'admin', '研发部门', '/business/ruleEngine/1', '106.92.105.125', 'XX XX', '[\"1\"]', NULL, 1, 'Invalid bound statement (not found): com.thinglinks.business.mapper.ThinglinksRuleEngineMapper.deleteThinglinksRuleEngineByIds', '2025-10-28 21:17:15', 13);
INSERT INTO `sys_oper_log` VALUES (225, '设备指令下发', 1, 'com.thinglinks.business.controller.ThinglinksFunctionController.add()', 'POST', 1, 'admin', '研发部门', '/business/function', '106.92.105.125', 'XX XX', '{\"belongSn\":\"WOSHI\",\"belongType\":\"1\",\"functionCode\":\"TEST\",\"functionName\":\"测试指令\",\"id\":\"1983167664912101378\",\"protocolId\":\"1983163608265158657\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-28 21:43:11', 34);
INSERT INTO `sys_oper_log` VALUES (226, '设备指令下发', 1, 'com.thinglinks.business.controller.ThinglinksFunctionController.add()', 'POST', 1, 'admin', '研发部门', '/business/function', '127.0.0.1', '内网IP', '{\"belongSn\":\"cgq2\",\"belongType\":\"1\",\"functionCode\":\"Test\",\"functionName\":\"测试指令\",\"functionParams\":\"123123\",\"id\":\"1983419022980677633\",\"protocolId\":\"1983369352292122626\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 14:21:59', 35);
INSERT INTO `sys_oper_log` VALUES (227, '设备指令下发', 1, 'com.thinglinks.business.controller.ThinglinksFunctionController.add()', 'POST', 1, 'admin', '研发部门', '/business/function', '127.0.0.1', '内网IP', '{\"belongSn\":\"c2\",\"belongType\":\"0\",\"functionCode\":\"test\",\"functionName\":\"测试指令\",\"functionParams\":\"21312321\",\"id\":\"1983419242053369858\",\"protocolId\":\"1983369352292122626\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 14:22:52', 13);
INSERT INTO `sys_oper_log` VALUES (228, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"functionCode\":\"test\",\"functionParams\":\"213123\"}],\"belongSn\":\"c2\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"inTemperature\",\"operator\":\"gt\",\"value\":\"10\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1983420534217768962\",\"level\":\"1\",\"message\":\"告警啦\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 14:28:00', 28);
INSERT INTO `sys_oper_log` VALUES (229, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '127.0.0.1', '内网IP', '{\"actions\":[{\"functionCode\":\"test\",\"functionParams\":\"213123\"}],\"belongSn\":\"cgq2\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"inTemperature\",\"operator\":\"gt\",\"value\":\"10\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1983432800048869377\",\"level\":\"1\",\"message\":\"告警啦\",\"name\":\"测试\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 15:18:02', 22);
INSERT INTO `sys_oper_log` VALUES (230, '代码生成', 6, 'com.thinglinks.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"warn_function_record\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 17:16:05', 68);
INSERT INTO `sys_oper_log` VALUES (231, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"record\",\"className\":\"WarnFunctionRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":100,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-29 17:16:05\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FunctionId\",\"columnComment\":\"功能id\",\"columnId\":101,\"columnName\":\"function_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-29 17:16:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"functionId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FunctionCode\",\"columnComment\":\"功能code\",\"columnId\":102,\"columnName\":\"function_code\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-29 17:16:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"functionCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FunctionName\",\"columnComment\":\"功能名称\",\"columnId\":103,\"columnName\":\"function_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-29 17:16:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 17:16:16', 52);
INSERT INTO `sys_oper_log` VALUES (232, '代码生成', 2, 'com.thinglinks.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"record\",\"className\":\"WarnFunctionRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":100,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-29 17:16:05\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2025-10-29 17:16:16\",\"usableColumn\":false},{\"capJavaField\":\"FunctionId\",\"columnComment\":\"功能id\",\"columnId\":101,\"columnName\":\"function_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-29 17:16:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"functionId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2025-10-29 17:16:16\",\"usableColumn\":false},{\"capJavaField\":\"FunctionCode\",\"columnComment\":\"功能code\",\"columnId\":102,\"columnName\":\"function_code\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-29 17:16:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"functionCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2025-10-29 17:16:16\",\"usableColumn\":false},{\"capJavaField\":\"FunctionName\",\"columnComment\":\"功能名称\",\"columnId\":103,\"columnName\":\"function_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-29 17:16:05\",\"dictType\":\"\",\"edit\":true,', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 17:16:24', 50);
INSERT INTO `sys_oper_log` VALUES (233, '代码生成', 8, 'com.thinglinks.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"warn_function_record\"}', NULL, 0, NULL, '2025-10-29 17:16:29', 317);
INSERT INTO `sys_oper_log` VALUES (234, '规则引擎配置', 1, 'com.thinglinks.business.controller.ThinglinksRuleEngineController.add()', 'POST', 1, 'admin', '研发部门', '/business/ruleEngine', '125.80.201.66', 'XX XX', '{\"createTime\":\"2025-10-30 02:39:04\",\"id\":\"1983725311088422914\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 10:39:04', 20);
INSERT INTO `sys_oper_log` VALUES (235, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '125.80.201.66', 'XX XX', '{\"children\":[],\"createTime\":\"2025-09-18 06:04:33\",\"icon\":\"netComponent\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2037,\"menuName\":\"网络组件\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"/componentManage\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:19:36', 40);
INSERT INTO `sys_oper_log` VALUES (236, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '125.80.201.66', 'XX XX', '{\"children\":[],\"component\":\"business/component/index\",\"createTime\":\"2025-09-18 05:58:11\",\"icon\":\"netComponent\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"网络组件\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2037,\"path\":\"component\",\"perms\":\"business:component:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:19:43', 20);
INSERT INTO `sys_oper_log` VALUES (237, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '125.80.201.66', 'XX XX', '{\"children\":[],\"component\":\"business/protocol/index\",\"createTime\":\"2025-09-18 06:00:37\",\"icon\":\"protocol\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2030,\"menuName\":\"协议管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2037,\"path\":\"protocol\",\"perms\":\"business:protocol:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:19:51', 21);
INSERT INTO `sys_oper_log` VALUES (238, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '125.80.201.66', 'XX XX', '{\"children\":[],\"component\":\"business/engine/index\",\"createTime\":\"2025-10-19 10:11:02\",\"icon\":\"engine\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2040,\"menuName\":\"规则引擎\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2037,\"path\":\"engine\",\"perms\":\"\",\"routeName\":\"Engine\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:20:03', 23);
INSERT INTO `sys_oper_log` VALUES (239, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '125.80.201.66', 'XX XX', '{\"children\":[],\"createTime\":\"2025-09-18 06:03:01\",\"icon\":\"device\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"设备管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"/deviceManage\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:20:19', 18);
INSERT INTO `sys_oper_log` VALUES (240, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '125.80.201.66', 'XX XX', '{\"children\":[],\"component\":\"business/product/index\",\"createTime\":\"2025-09-18 05:58:31\",\"icon\":\"product\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"产品\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2036,\"path\":\"product\",\"perms\":\"business:product:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:20:26', 17);
INSERT INTO `sys_oper_log` VALUES (241, '菜单管理', 2, 'com.thinglinks.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '125.80.201.66', 'XX XX', '{\"children\":[],\"component\":\"business/device/index\",\"createTime\":\"2025-09-18 05:58:25\",\"icon\":\"device\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"设备\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2036,\"path\":\"device\",\"perms\":\"business:device:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:20:32', 13);
INSERT INTO `sys_oper_log` VALUES (242, '设备指令下发', 1, 'com.thinglinks.business.controller.ThinglinksFunctionController.add()', 'POST', 1, 'admin', '研发部门', '/business/function', '125.80.201.66', 'XX XX', '{\"belongSn\":\"product_001\",\"belongType\":\"0\",\"functionCode\":\"TEST\",\"functionName\":\"测试指令\",\"functionParams\":\"123456\",\"id\":\"1983737050999844865\",\"protocolId\":\"1983735910950268930\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:25:43', 40);
INSERT INTO `sys_oper_log` VALUES (243, '告警配置', 1, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.add()', 'POST', 1, 'admin', '研发部门', '/business/warnConfig', '125.80.201.66', 'XX XX', '{\"actions\":[{\"functionCode\":\"TEST\",\"functionParams\":\"测试\"}],\"belongSn\":\"product_001\",\"belongType\":\"0\",\"conditions\":[{\"attribute\":\"outTemperature\",\"operator\":\"gt\",\"value\":\"30\"},{\"attribute\":\"inTemperature\",\"operator\":\"gt\",\"value\":\"20\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1983737402524463106\",\"level\":\"2\",\"message\":\"室外温度和室内温度均达到预警值，请及时查看设备状态。\",\"name\":\"温湿度告警\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:27:07', 42);
INSERT INTO `sys_oper_log` VALUES (244, '告警配置', 2, 'com.thinglinks.business.controller.ThinglinksWarnConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/warnConfig', '125.80.201.66', 'XX XX', '{\"actions\":[{\"functionCode\":\"TEST\",\"functionParams\":\"测试\"}],\"belongSn\":\"WS_DEVICE_001\",\"belongType\":\"1\",\"conditions\":[{\"attribute\":\"outTemperature\",\"operator\":\"gt\",\"value\":\"30\"},{\"attribute\":\"inTemperature\",\"operator\":\"gt\",\"value\":\"20\"}],\"delayTime\":0,\"enable\":true,\"id\":\"1983737562021261313\",\"level\":\"2\",\"message\":\"室外温度和室内温度均达到预警值，请及时查看设备状态。\",\"name\":\"温湿度告警\",\"relation\":\"and\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:28:57', 13);
INSERT INTO `sys_oper_log` VALUES (245, '设备指令下发', 3, 'com.thinglinks.business.controller.ThinglinksFunctionController.remove()', 'DELETE', 1, 'admin', '研发部门', '/business/function/1983737553343246338', '125.80.201.66', 'XX XX', '[\"1983737553343246338\"]', NULL, 1, 'Invalid bound statement (not found): com.thinglinks.business.mapper.ThinglinksFunctionMapper.deleteThinglinksFunctionByIds', '2025-10-30 11:30:47', 9);
INSERT INTO `sys_oper_log` VALUES (246, '设备指令下发', 3, 'com.thinglinks.business.controller.ThinglinksFunctionController.remove()', 'DELETE', 1, 'admin', '研发部门', '/business/function/1983737461873864705', '125.80.201.66', 'XX XX', '[\"1983737461873864705\"]', NULL, 1, 'Invalid bound statement (not found): com.thinglinks.business.mapper.ThinglinksFunctionMapper.deleteThinglinksFunctionByIds', '2025-10-30 11:30:53', 1);
INSERT INTO `sys_oper_log` VALUES (247, '设备指令下发', 2, 'com.thinglinks.business.controller.ThinglinksFunctionController.edit()', 'PUT', 1, 'admin', '研发部门', '/business/function', '125.80.201.66', 'XX XX', '{\"belongSn\":\"WS_DEVICE_001\",\"belongType\":\"1\",\"functionCode\":\"TEST\",\"functionName\":\"测试指令\",\"functionParams\":\"123456\",\"id\":\"1983737461873864705\",\"protocolId\":\"1983735910950268930\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:31:43', 15);
INSERT INTO `sys_oper_log` VALUES (248, '菜单管理', 3, 'com.thinglinks.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2040', '127.0.0.1', '内网IP', '2040', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-30 11:49:21', 35);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-09-15 11:09:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-09-15 11:09:57', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-09-15 11:09:57', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '/profile/avatar/2025/09/23/af3c376fcbff4bdc82c1ddbf4f6c3ea0.jpg', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-10-30 11:48:40', '2025-09-15 11:09:57', 'admin', '2025-09-15 11:09:57', '', '2025-09-23 13:55:21', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-09-15 11:09:57', '2025-09-15 11:09:57', 'admin', '2025-09-15 11:09:57', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

-- ----------------------------
-- Table structure for thinglinks_component
-- ----------------------------
DROP TABLE IF EXISTS `thinglinks_component`;
CREATE TABLE `thinglinks_component`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件名称',
  `net_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '网络类型',
  `ip_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `port` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '端口',
  `open_tls` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否开启TLS (0-否 1-是)',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改人',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '0-停用 1-启用',
  `other_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '其余配置(如账号密码等)',
  `protocol_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '协议id',
  `protocol_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '协议名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '网络组件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thinglinks_component
-- ----------------------------

-- ----------------------------
-- Table structure for thinglinks_device
-- ----------------------------
DROP TABLE IF EXISTS `thinglinks_device`;
CREATE TABLE `thinglinks_device`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'id',
  `device_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备编码',
  `device_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备名称',
  `product_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联产品id',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联产品名称',
  `product_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联产品编码',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改人',
  `link_method_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '接入方式id',
  `link_method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '接入方式名称',
  `protocol_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '协议id',
  `protocol_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '协议名称',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '0-离线 1-在线',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `timeout_seconds` int NULL DEFAULT 10 COMMENT '心跳超时时间(秒)',
  `device_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '设备类型 0-直连设备 1-网关设备 2-无状态设备',
  `regular_cleaning` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '数据是否定期清理 0-否 1-是',
  `retention_time` bigint NULL DEFAULT 1 COMMENT '数据保存时间',
  `retention_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '数据保存时间单位 hour-时 day-天 week-周 month-月 year-年',
  `component_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件id',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件名称',
  `custom_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '自定义配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `device_sn`(`device_sn` ASC) USING BTREE COMMENT '设备sn'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thinglinks_device
-- ----------------------------

-- ----------------------------
-- Table structure for thinglinks_device_logs
-- ----------------------------
DROP TABLE IF EXISTS `thinglinks_device_logs`;
CREATE TABLE `thinglinks_device_logs`  (
  `id` bigint NOT NULL COMMENT 'id',
  `device_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备sn',
  `report_time` timestamp NULL DEFAULT NULL COMMENT '上报时间',
  `properties` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '属性json',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `log_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志类型  PROPERTY-上行消息 OFFLINE-设备离线 ONLINE-设备上线',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `device_sn`(`device_sn` ASC) USING BTREE COMMENT '设备sn索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thinglinks_device_logs
-- ----------------------------

-- ----------------------------
-- Table structure for thinglinks_function
-- ----------------------------
DROP TABLE IF EXISTS `thinglinks_function`;
CREATE TABLE `thinglinks_function`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'id',
  `function_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '功能名称',
  `function_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '功能编码',
  `function_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '自定义参数',
  `belong_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备/产品sn',
  `protocol_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '协议id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `belong_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '归属类型 0-产品 1-设备',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备指令下发表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thinglinks_function
-- ----------------------------

-- ----------------------------
-- Table structure for thinglinks_function_record
-- ----------------------------
DROP TABLE IF EXISTS `thinglinks_function_record`;
CREATE TABLE `thinglinks_function_record`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'id',
  `function_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '功能id',
  `function_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '功能code',
  `function_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '功能名称',
  `function_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '参数',
  `is_success` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '0-失败 1-成功',
  `create_time` datetime NULL DEFAULT NULL COMMENT '下发时间',
  `device_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备sn',
  `device_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备名称',
  `trigger_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '0-手动触发 1-告警触发',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '指令下发记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thinglinks_function_record
-- ----------------------------

-- ----------------------------
-- Table structure for thinglinks_product
-- ----------------------------
DROP TABLE IF EXISTS `thinglinks_product`;
CREATE TABLE `thinglinks_product`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'id',
  `product_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品编码',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品名称',
  `link_method_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '接入方式id',
  `link_method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '接入方式名称',
  `protocol_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '协议id',
  `protocol_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '协议名称',
  `device_count` int NULL DEFAULT 0 COMMENT '设备数量',
  `device_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '设备类型 0-直连设备 1-网关设备 2-无状态设备',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改人',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '0-停用 1-启用',
  `timeout_seconds` int NULL DEFAULT 10 COMMENT '心跳时间(秒)',
  `regular_cleaning` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '数据是否定期清理 0-否 1-是',
  `retention_time` bigint NULL DEFAULT 1 COMMENT '数据保存时间',
  `retention_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '数据保存时间单位 hour-时 day-天 week-周 month-月 year-年',
  `component_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件id',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件名称',
  `custom_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '自定义配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `product_sn`(`product_sn` ASC) USING BTREE COMMENT '产品sn'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '产品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thinglinks_product
-- ----------------------------

-- ----------------------------
-- Table structure for thinglinks_properties
-- ----------------------------
DROP TABLE IF EXISTS `thinglinks_properties`;
CREATE TABLE `thinglinks_properties`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'id',
  `belong_sn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '归属id 产品/设备',
  `belong_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '归属类型 0-产品 1-设备',
  `identifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性标识符，如 temperature, status',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性名称',
  `parent_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '父属性ID，用于构建嵌套结构。0表示根级属性',
  `data_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '数据类型: int, double, bool, string, struct, array...',
  `sort_num` int NULL DEFAULT 0 COMMENT '排序',
  `from_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '来源 0-产品继承 1-设备自定义(继承不可修改)',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_product_key`(`belong_sn` ASC) USING BTREE,
  INDEX `idx_identifier`(`identifier` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '物模型属性定义表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thinglinks_properties
-- ----------------------------

-- ----------------------------
-- Table structure for thinglinks_protocol
-- ----------------------------
DROP TABLE IF EXISTS `thinglinks_protocol`;
CREATE TABLE `thinglinks_protocol`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'id',
  `protocol_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '协议名称',
  `local_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '本地存储路径',
  `main_class_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '解析类入口',
  `origin_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '文件原始名字',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '0-jar包',
  `new_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '文件重命名',
  `component_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '网络组件id',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '网络组件名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改人',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '0-停用 1-启用',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `protocol_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '协议类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '协议管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thinglinks_protocol
-- ----------------------------

-- ----------------------------
-- Table structure for thinglinks_warn_config
-- ----------------------------
DROP TABLE IF EXISTS `thinglinks_warn_config`;
CREATE TABLE `thinglinks_warn_config`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '告警名称',
  `belong_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品/设备sn',
  `belong_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '来源 0-产品 1-设备',
  `rule_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '规则json',
  `warn_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '告警消息模板',
  `warn_level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '告警等级 1-紧急 2-严重 3-警告 4-正常',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改人',
  `execute_action` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '执行动作json',
  `is_enable` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '是否启用 0-否 1-是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '告警配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thinglinks_warn_config
-- ----------------------------

-- ----------------------------
-- Table structure for thinglinks_warn_record
-- ----------------------------
DROP TABLE IF EXISTS `thinglinks_warn_record`;
CREATE TABLE `thinglinks_warn_record`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'id',
  `config_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '告警配置id',
  `config_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '告警配置名称',
  `warn_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '告警内容',
  `warn_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '告警时全属性数据',
  `belong_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备/产品sn',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `warn_level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '告警等级 1-紧急 2-严重 3-一般 4-警告 5-正常',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '0-未处理 1-已处理',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `belong_sn`(`belong_sn` ASC) USING BTREE,
  INDEX `create_time`(`create_time` DESC) USING BTREE,
  INDEX `warn_level`(`warn_level` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '告警记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thinglinks_warn_record
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
