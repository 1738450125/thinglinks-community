package com.thinglinks.business.utils;

import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.thinglinks.business.domain.*;
import com.thinglinks.business.service.IThinglinksDeviceService;
import com.thinglinks.business.service.IThinglinksFunctionService;
import com.thinglinks.business.service.IThinglinksWarnConfigService;
import com.thinglinks.business.warn.WarnRule;
import com.thinglinks.common.utils.StringUtils;
import com.thinglinks.common.utils.spring.SpringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

/**
 * @Description: 缓存工具
 * @Author: thinglinks
 * @CreateTime: 2025-10-10
 */
public class CacheUtils {
    /**
     * 设备实例数据缓存
     */
    /**
     * 设备实例数据缓存
     */
    public final static ConcurrentMap<String, ThinglinksDevice> DEVICE_MAP = new ConcurrentHashMap<>();

    /**
     * 产品数据缓存
     */
    public final static ConcurrentMap<String, ThinglinksProduct> PRODUCT_MAP = new ConcurrentHashMap<>();

    /**
     * 设备在离线状态缓存
     */
    public final static ConcurrentMap<String,Boolean> DEVICE_STATUS = new ConcurrentHashMap<>();

    /**
     * 设备某个规则上一次告警时间
     */
    public final static ConcurrentMap<String,Long> DEVICE_WARN_TIME = new ConcurrentHashMap<>();

    /**
     * 设备告警规则
     */
    public final static ConcurrentMap<String,List<WarnRule>> DEVICE_WARN_RULE = new ConcurrentHashMap<>();

    /**
     * 设备联动告警规则
     */
    public final static ConcurrentMap<String,List<WarnRule>> DEVICE_LINK_WARN_RULE = new ConcurrentHashMap<>();

    /**
     * 设备自注册开关
     */
    public static String DEVICE_REGISTER_SWITCH = "false";

    /**
     * 设备指令缓存
     */
    public static ConcurrentMap<String,List<ThinglinksFunction>> DEVICE_FUNCTION = new ConcurrentHashMap<>();

    /**
     * 网络组件缓存
     */
    public static ConcurrentMap<String, ThinglinksComponent> COMPONENT_MAP = new ConcurrentHashMap<>();

    /**
     * 更新所有设备实例数据
     */
    public static void updateAllDeviceCache(){
        List<ThinglinksDevice> list = SpringUtils.getBean(IThinglinksDeviceService.class).list();
        DEVICE_MAP.clear();
        list.forEach(device->{
            DEVICE_MAP.put(device.getDeviceSn(),device);
        });
    }

    /**
     * 更新设备实例数据根据产品
     */
    public static void updateDeviceCacheByProductSn(String productSn){
        List<ThinglinksDevice> list = SpringUtils.getBean(IThinglinksDeviceService.class).list(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getProductSn,productSn));
        DEVICE_MAP.clear();
        list.forEach(device->{
            DEVICE_MAP.put(device.getDeviceSn(),device);
        });
    }

    /**
     * 更新所有设备实例数据
     */
    public static void updateAllDeviceCache(List<ThinglinksDevice> list){
        DEVICE_MAP.clear();
        list.forEach(device->{
            DEVICE_MAP.put(device.getDeviceSn(),device);
        });
    }

    /**
     * 更新单个设备实例数据
     */
    public static void updateDeviceCache(String deviceSn){
        ThinglinksDevice device = SpringUtils.getBean(IThinglinksDeviceService.class).getOne(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getDeviceSn,deviceSn));
        DEVICE_MAP.put(device.getDeviceSn(),device);
    }

    /**
     * 更新单个设备自定义配置
     */
    public static void updateDeviceCustomConfig(String deviceSn,String customConfig){
        ThinglinksDevice device = DEVICE_MAP.get(deviceSn);
        device.setCustomConfig(customConfig);
    }

    /**
     * 更新产品下所有设备自定义配置
     */
    public static void updateDeviceCustomConfigByProductSn(String productSn,String customConfig){
        List<ThinglinksDevice> list = SpringUtils.getBean(IThinglinksDeviceService.class).list(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getProductSn,productSn));
        list.forEach(device -> {
            ThinglinksDevice o = DEVICE_MAP.get(device.getDeviceSn());
            o.setCustomConfig(customConfig);
        });
    }

    /**
     * 更新单个设备实例数据
     */
    public static void updateDeviceCache(ThinglinksDevice device){
        DEVICE_MAP.put(device.getDeviceSn(),device);
    }

    /**
     * 获取设备实例数据
     */
    public static ThinglinksDevice getDeviceBySn(String deviceSn){
        return DEVICE_MAP.getOrDefault(deviceSn,null);
    }

    /**
     * 获取设备实例数据
     */
    public static List<ThinglinksDevice> getDeviceByProductSn(String productSn){
        List<ThinglinksDevice> list = new ArrayList<>();
        DEVICE_MAP.values().forEach(device->{
            if(productSn.equals(device.getProductSn())){
                list.add(device);
            }
        });
        return list;
    }

    /**
     * 更新所有设备状态
     */
    public static void updateAllDeviceStatusCache(){
        List<ThinglinksDevice> list = SpringUtils.getBean(IThinglinksDeviceService.class).list();
        list.forEach(device->{
            DEVICE_STATUS.put(device.getDeviceSn(),"1".equals(device.getStatus()));
        });
    }

    /**
     * 更新单个设备状态
     */
    public static void updateDeviceStatusCache(ThinglinksDevice device){
        DEVICE_STATUS.put(device.getDeviceSn(), "1".equals(device.getStatus()));
    }

    /**
     * 更新单个设备状态
     */
    public static void updateDeviceStatusCache(String deviceSn){
        ThinglinksDevice device = SpringUtils.getBean(IThinglinksDeviceService.class).getOne(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getDeviceSn,deviceSn));
        DEVICE_STATUS.put(device.getDeviceSn(), "1".equals(device.getStatus()));
    }

    /**
     * 更新单个设备状态
     */
    public static void updateDeviceStatusCache(String deviceSn,boolean status){
        DEVICE_STATUS.put(deviceSn, status);
    }

    /**
     * 更新单个设备状态
     */
    public static boolean getDeviceStatusBySn(String deviceSn){
        return DEVICE_STATUS.getOrDefault(deviceSn, false);
    }

    /**
     * 更新设备规则上一次告警时间
     */
    public static void updateDeviceRuleWarnTime(String deviceSn,String warnKey,long time){
        DEVICE_WARN_TIME.put(deviceSn+"_"+warnKey,time);
    }

    /**
     * 获取设备规则上一次告警时间
     */
    public static long getDeviceRuleWarnTime(String deviceSn,String warnKey){
        return DEVICE_WARN_TIME.getOrDefault(deviceSn+"_"+warnKey,0L);
    }

    /**
     * 更新所有设备告警规则
     */
    public static void updateAllDeviceWarnRule(){
        List<ThinglinksWarnConfig> allList = SpringUtils.getBean(IThinglinksWarnConfigService.class).list();
        // 按 deviceSn 分组
        Map<String, List<ThinglinksWarnConfig>> groupedByDeviceSn = allList.stream()
                .collect(Collectors.groupingBy(ThinglinksWarnConfig::getBelongSn));
        // 清空原有缓存
        DEVICE_WARN_RULE.clear();
        // 逐个放入缓存
        for (Map.Entry<String, List<ThinglinksWarnConfig>> entry : groupedByDeviceSn.entrySet()) {
            String deviceSn = entry.getKey();
            List<ThinglinksWarnConfig> configList = entry.getValue();
            List<WarnRule> list = new ArrayList<>();
            configList.forEach(config->{
                WarnRule rule =  JSONObject.parseObject(config.getRuleJson(),WarnRule.class);
                rule.setId(config.getId());
                rule.setWarnType("0");
                if(rule.getConditions()!=null&&rule.getConditions().size()>0){
                    rule.getConditions().forEach(condition->{
                        if("device_online".equals(condition.getType())){
                            condition.setAttribute("device_online");
                            condition.setOperator("eq");
                            condition.setValue("1");
                            rule.setWarnType("1");
                        }
                        if("device_offline".equals(condition.getType())){
                            condition.setAttribute("device_offline");
                            condition.setOperator("eq");
                            condition.setValue("1");
                            rule.setWarnType("2");
                        }
                    });
                    if(!"0".equals(rule.getWarnType())){
                        SpringUtils.getBean(IThinglinksWarnConfigService.class).update(new LambdaUpdateWrapper<ThinglinksWarnConfig>()
                                .eq(ThinglinksWarnConfig::getId,config.getId())
                                .set(ThinglinksWarnConfig::getWarnType,rule.getWarnType()));
                    }
                }
                list.add(rule);
            });
            DEVICE_WARN_RULE.put(deviceSn, list);
        }
    }

    /**
     * 更新设备告警规则
     */
    public static void updateDeviceWarnRule(String deviceSn){
        List<ThinglinksWarnConfig> configList = SpringUtils.getBean(IThinglinksWarnConfigService.class).list(new LambdaQueryWrapper<ThinglinksWarnConfig>()
                .eq(ThinglinksWarnConfig::getBelongSn,deviceSn));
        List<WarnRule> list = new ArrayList<>();
        configList.forEach(config->{
            WarnRule rule =  JSONObject.parseObject(config.getRuleJson(),WarnRule.class);
            rule.setId(config.getId());
            rule.setWarnType("0");
            if(rule.getConditions()!=null&&rule.getConditions().size()>0){
                rule.getConditions().forEach(condition->{
                    if("device_online".equals(condition.getType())){
                        condition.setAttribute("device_online");
                        condition.setOperator("eq");
                        condition.setValue("1");
                        rule.setWarnType("1");
                    }
                    if("device_offline".equals(condition.getType())){
                        condition.setAttribute("device_offline");
                        condition.setOperator("eq");
                        condition.setValue("1");
                        rule.setWarnType("2");
                    }
                });
                if(!"0".equals(rule.getWarnType())){
                    SpringUtils.getBean(IThinglinksWarnConfigService.class).update(new LambdaUpdateWrapper<ThinglinksWarnConfig>()
                            .eq(ThinglinksWarnConfig::getId,config.getId())
                            .set(ThinglinksWarnConfig::getWarnType,rule.getWarnType()));
                }
            }
            list.add(rule);
        });
        DEVICE_WARN_RULE.put(deviceSn,list);
    }

    /**
     * 更新设备告警规则
     */
    public static void updateDeviceWarnRule(String deviceSn,List<ThinglinksWarnConfig> configList){
        List<WarnRule> list = new ArrayList<>();
        configList.forEach(config->{
            WarnRule rule =  JSONObject.parseObject(config.getRuleJson(),WarnRule.class);
            rule.setId(config.getId());
            list.add(rule);
        });
        DEVICE_WARN_RULE.put(deviceSn,list);
    }

    /**
     * 获取设备告警规则
     * @param deviceSn
     */
    public static List<WarnRule> getDeviceWarnRule(String deviceSn){
        return DEVICE_WARN_RULE.getOrDefault(deviceSn,new ArrayList<>());
    }

    /**
     * 更新设备指令缓存
     */
    public static void updateDeviceFunctionCache(String deviceSn){
        List<ThinglinksFunction> list = SpringUtils.getBean(IThinglinksFunctionService.class).list(new LambdaQueryWrapper<ThinglinksFunction>()
                .eq(ThinglinksFunction::getBelongSn,deviceSn));
        if(list.isEmpty()){
            return;
        }
        DEVICE_FUNCTION.put(deviceSn,list);
    }

    /**
     * 设置设备指令缓存
     */
    public static void setDeviceFunctionCache(String deviceSn,List<ThinglinksFunction> list){
        if(StringUtils.isEmpty(deviceSn)||list.isEmpty()){
            return;
        }
        DEVICE_FUNCTION.put(deviceSn,list);
    }

    /**
     * 获取设备指令缓存
     */
    public static ThinglinksFunction getDeviceFunctionCache(String deviceSn,String functionCode){
        if(StringUtils.isEmpty(functionCode)||StringUtils.isEmpty(deviceSn)){
            return null;
        }
        List<ThinglinksFunction> functions = DEVICE_FUNCTION.getOrDefault(deviceSn,null);
        if(functions==null||functions.isEmpty()){
            return null;
        }
        for (int i = 0; i < functions.size(); i++) {
            if(functionCode.equals(functions.get(i).getFunctionCode())){
                return functions.get(i);
            }
        }
        return null;
    }

    /**
     * 更新网络组件缓存
     */
    public static void setComponentCache(String componentId,ThinglinksComponent thinglinksComponent){
        COMPONENT_MAP.put(componentId,thinglinksComponent);
    }

    /**
     * 获取网络组件缓存
     */
    public static ThinglinksComponent getComponentCache(String componentId){
        return COMPONENT_MAP.getOrDefault(componentId,null);
    }

    /**
     * 删除网络组件缓存
     */
    public static void removeComponentCache(String componentId){
        COMPONENT_MAP.remove(componentId);
    }

}
