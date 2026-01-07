import request from '@/utils/request'

// 查询产品列表
export function listProduct(query) {
  return request({
    url: '/business/product/list',
    method: 'get',
    params: query
  })
}

// 查询产品详细
export function getProduct(id) {
  return request({
    url: '/business/product/' + id,
    method: 'get'
  })
}

// 新增产品
export function addProduct(data) {
  return request({
    url: '/business/product',
    method: 'post',
    data: data
  })
}

// 修改产品
export function updateProduct(data) {
  return request({
    url: '/business/product',
    method: 'put',
    data: data
  })
}

// 删除产品
export function delProduct(id) {
  return request({
    url: '/business/product/' + id,
    method: 'delete'
  })
}

// 同步设备物模型
export function syncProperties(data) {
  return request({
    url: '/business/product/syncToDevice',
    method: 'post',
    data: data
  })
}

// 同步设备定时清理数据配置
export function syncRetentionTimeToDevice(data) {
  return request({
    url: '/business/product/syncRetentionTimeToDevice',
    method: 'post',
    data: data
  })
}

// 同步设备自定义配置
export function syncCustomConfigToDevice(data) {
  return request({
    url: '/business/product/syncCustomConfigToDevice',
    method: 'post',
    data: data
  })
}

// 首页数量统计
export function indexStatics() {
  return request({
    url: '/business/product/indexStatics',
    method: 'get'
  })
}

// 在线设备统计
export function onlineStatics(data) {
  return request({
    url: '/business/product/onlineDeviceCount?productSn='+data,
    method: 'get'
  })
}

