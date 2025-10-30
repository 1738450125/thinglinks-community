package com.thinglinks.business.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.thinglinks.business.domain.*;
import com.thinglinks.business.service.*;
import com.thinglinks.business.utils.CacheUtils;
import com.thinglinks.common.utils.PageUtils;
import com.thinglinks.common.utils.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.thinglinks.common.annotation.Log;
import com.thinglinks.common.core.controller.BaseController;
import com.thinglinks.common.core.domain.AjaxResult;
import com.thinglinks.common.enums.BusinessType;
import com.thinglinks.common.utils.poi.ExcelUtil;
import com.thinglinks.common.core.page.TableDataInfo;

/**
 * 产品Controller
 *
 * @author thinglinks
 * @date 2025-09-18
 */
@RestController
@RequestMapping("/business/product")
public class ThinglinksProductController extends BaseController {
    @Autowired
    private IThinglinksProductService thinglinksProductService;
    @Autowired
    private IThinglinksDeviceService thinglinksDeviceService;
    @Autowired
    private IThinglinksPropertiesService thinglinksPropertiesService;
    @Autowired
    private IThinglinksComponentService thinglinksComponentService;
    @Autowired
    private IThinglinksProtocolService thinglinksProtocolService;
    @Autowired
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Autowired
    private IThinglinksDeviceLogsService thinglinksDeviceLogsService;


    /**
     * 查询产品列表
     */
    @GetMapping("/list")
    public TableDataInfo list(ThinglinksProduct thinglinksProduct) {
        QueryWrapper<ThinglinksProduct> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("create_time");
        Page<ThinglinksProduct> page = new Page<ThinglinksProduct>(PageUtils.getPageNum(), PageUtils.getPageSize());
        Page<ThinglinksProduct> pageList = thinglinksProductService.page(page, queryWrapper);
        return getDataTable(pageList.getRecords());
    }

    /**
     * 导出产品列表
     */
    @PostMapping("/export")
    public void export(HttpServletResponse response, ThinglinksProduct thinglinksProduct) {
        List<ThinglinksProduct> list = thinglinksProductService.selectThinglinksProductList(thinglinksProduct);
        ExcelUtil<ThinglinksProduct> util = new ExcelUtil<ThinglinksProduct>(ThinglinksProduct.class);
        util.exportExcel(response, list, "产品数据");
    }

    /**
     * 获取产品详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id) {
        return success(thinglinksProductService.getById(id));
    }

    /**
     * 新增产品
     */
    @PostMapping
    public AjaxResult add(@RequestBody ThinglinksProduct thinglinksProduct) {
        //不可与产品sn重复
        long count = thinglinksDeviceService.count(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getDeviceSn, thinglinksProduct.getProductSn()));
        if (count > 0) {
            return AjaxResult.warn("产品sn已经被设备使用，请更换产品sn");
        }
        thinglinksProduct.setCreateTime(new Date());
        if(StringUtils.isNotEmpty(thinglinksProduct.getComponentId())){
            ThinglinksComponent component = thinglinksComponentService.getById(thinglinksProduct.getComponentId());
            thinglinksProduct.setProtocolId(component.getProtocolId());
            thinglinksProduct.setProtocolName(component.getProtocolName());
        }
        return toAjax(thinglinksProductService.save(thinglinksProduct));
    }

    /**
     * 修改产品
     */
    @PutMapping
    public AjaxResult edit(@RequestBody ThinglinksProduct thinglinksProduct) {
        if(StringUtils.isNotEmpty(thinglinksProduct.getComponentId())){
            ThinglinksComponent component = thinglinksComponentService.getById(thinglinksProduct.getComponentId());
            thinglinksProduct.setProtocolId(component.getProtocolId());
            thinglinksProduct.setProtocolName(component.getProtocolName());
            thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                    .eq(ThinglinksDevice::getProductSn,thinglinksProduct.getProductSn())
                    .set(ThinglinksDevice::getComponentId,component.getId())
                    .set(ThinglinksDevice::getComponentName,component.getName())
                    .set(ThinglinksDevice::getProtocolId,component.getProtocolId())
                    .set(ThinglinksDevice::getProtocolName,component.getProtocolName()));
        }
        return toAjax(thinglinksProductService.updateById(thinglinksProduct));
    }

    /**
     * 删除产品
     */
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable String[] ids) {
        for (String id : ids) {
            ThinglinksProduct product = thinglinksProductService.getById(id);
            if(product.getDeviceCount()>0){
                return AjaxResult.warn("请先删除产品关联的设备");
            }
            thinglinksProductService.removeById(id);
        }
        return AjaxResult.success();
    }

    /**
     * 同步物模型到设备
     */
    @PostMapping("/syncToDevice")
    public AjaxResult syncToDevice(@RequestBody ThinglinksProduct thinglinksProduct) {
        List<ThinglinksDevice> deviceList = thinglinksDeviceService.list(new LambdaQueryWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getProductSn, thinglinksProduct.getProductSn()));
        List<ThinglinksProperties> propertiesList = thinglinksPropertiesService.list(new LambdaQueryWrapper<ThinglinksProperties>()
                .eq(ThinglinksProperties::getBelongSn, thinglinksProduct.getProductSn()));
        List<ThinglinksProperties> saveList = new ArrayList<>();
        deviceList.forEach(o -> {
            thinglinksPropertiesService.remove(new LambdaUpdateWrapper<ThinglinksProperties>()
                    .eq(ThinglinksProperties::getBelongSn, o.getDeviceSn()));
            propertiesList.forEach(vo -> {
                ThinglinksProperties properties = new ThinglinksProperties();
                BeanUtils.copyProperties(vo, properties);
                properties.setBelongSn(o.getDeviceSn());
                properties.setBelongType("1");
                properties.setFromType("0");
                properties.setId(null);
                saveList.add(properties);
            });
        });
        thinglinksPropertiesService.saveBatch(saveList);
        //缓存物模型
        deviceList.forEach(o -> {
            thinglinksDeviceService.cacheDeviceProperties(o.getDeviceSn());
        });
        return AjaxResult.success();
    }

    /**
     * 同步数据保存时间到设备
     */
    @PostMapping("/syncRetentionTimeToDevice")
    public AjaxResult syncRetentionTimeToDevice(@RequestBody ThinglinksProduct thinglinksProduct) {
        if (StringUtils.isEmpty(thinglinksProduct.getProductSn())
                || StringUtils.isEmpty(thinglinksProduct.getRegularCleaning())
                || thinglinksProduct.getRetentionTime() == null) {
            return AjaxResult.warn("配置信息填写不完整！");
        }
        thinglinksProductService.update(new LambdaUpdateWrapper<ThinglinksProduct>()
                .eq(ThinglinksProduct::getProductSn,thinglinksProduct.getProductSn())
                .set(ThinglinksProduct::getRegularCleaning,thinglinksProduct.getRegularCleaning())
                .set(ThinglinksProduct::getRetentionTime,thinglinksProduct.getRetentionTime())
                .set(ThinglinksProduct::getRetentionUnit,thinglinksProduct.getRetentionUnit()));
        thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getProductSn,thinglinksProduct.getProductSn())
                .set(ThinglinksDevice::getRegularCleaning,thinglinksProduct.getRegularCleaning())
                .set(ThinglinksDevice::getRetentionTime,thinglinksProduct.getRetentionTime())
                .set(ThinglinksDevice::getRetentionUnit,thinglinksProduct.getRetentionUnit()));
        return AjaxResult.success("同步成功");
    }

    /**
     * 修改自定义配置
     */
    @PostMapping("/syncCustomConfigToDevice")
    public AjaxResult syncCustomConfigToDevice(@RequestBody ThinglinksProduct thinglinksProduct){
        if (StringUtils.isEmpty(thinglinksProduct.getProductSn())
                || StringUtils.isEmpty(thinglinksProduct.getCustomConfig())) {
            return AjaxResult.warn("配置信息填写不完整！");
        }
        thinglinksProductService.update(new LambdaUpdateWrapper<ThinglinksProduct>()
                .eq(ThinglinksProduct::getProductSn,thinglinksProduct.getProductSn())
                .set(ThinglinksProduct::getCustomConfig,thinglinksProduct.getCustomConfig()));
        thinglinksDeviceService.update(new LambdaUpdateWrapper<ThinglinksDevice>()
                .eq(ThinglinksDevice::getProductSn,thinglinksProduct.getProductSn())
                .set(ThinglinksDevice::getCustomConfig,thinglinksProduct.getCustomConfig()));
        CacheUtils.updateDeviceCustomConfigByProductSn(thinglinksProduct.getProductSn(),thinglinksProduct.getCustomConfig());
        return AjaxResult.success("同步成功");
    }

    /**
     * 统计
     */
    @GetMapping("/indexStatics")
    public AjaxResult indexStatics() {
        // 创建计数器
        CountDownLatch latch = new CountDownLatch(4);

        // 使用原子类保证线程安全
        AtomicLong productCount = new AtomicLong(0);
        AtomicLong deviceOnlineCount = new AtomicLong(0);
        AtomicLong deviceCount = new AtomicLong(0);
        AtomicLong componentCount = new AtomicLong(0);
        AtomicLong protocolCount = new AtomicLong(0);
        AtomicLong todayMessageCount = new AtomicLong(0);
        // 执行任务
        threadPoolTaskExecutor.execute(() -> {
            try {
                productCount.set(thinglinksProductService.count());
            } finally {
                latch.countDown();
            }
        });
        threadPoolTaskExecutor.execute(() -> {
            try {
                deviceOnlineCount.set(thinglinksDeviceService.count(new LambdaQueryWrapper<ThinglinksDevice>()
                        .eq(ThinglinksDevice::getStatus, "1")));
                deviceCount.set(thinglinksDeviceService.count());
            } finally {
                latch.countDown();
            }
        });
        threadPoolTaskExecutor.execute(() -> {
            try {
                componentCount.set(thinglinksComponentService.count());
            } finally {
                latch.countDown();
            }
        });
        threadPoolTaskExecutor.execute(() -> {
            try {
                protocolCount.set(thinglinksProtocolService.count());
            } finally {
                latch.countDown();
            }
        });
        threadPoolTaskExecutor.execute(() -> {
            try {
                todayMessageCount.set(thinglinksDeviceLogsService.count(new LambdaQueryWrapper<ThinglinksDeviceLogs>()
                        .ge(ThinglinksDeviceLogs::getCreateTime, LocalDate.now().atStartOfDay())));
            } finally {
                latch.countDown();
            }
        });
        try {
            // 等待所有任务完成，设置超时时间避免无限等待
            boolean completed = latch.await(10, TimeUnit.SECONDS);
            if (!completed) {
                return AjaxResult.error("查询超时");
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return AjaxResult.error("查询被中断");
        }
        JSONObject result = new JSONObject();
        result.put("productCount", productCount.get());
        result.put("deviceOnlineCount", deviceOnlineCount.get());
        result.put("deviceCount", deviceCount.get());
        result.put("deviceOfflineCount", deviceCount.get() - deviceOnlineCount.get());
        result.put("componentCount", componentCount.get());
        result.put("protocolCount", protocolCount.get());
        result.put("todayMessageCount", todayMessageCount.get());
        return AjaxResult.success(result);
    }
}
