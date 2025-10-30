import request from '@/utils/request'

// 查询物模型属性定义列表
export function listProperties(query) {
  return request({
    url: '/business/properties/list',
    method: 'get',
    params: query
  })
}

// 查询物模型属性定义详细
export function getProperties(id) {
  return request({
    url: '/business/properties/' + id,
    method: 'get'
  })
}

// 新增物模型属性定义
export function addProperties(data) {
  return request({
    url: '/business/properties',
    method: 'post',
    data: data
  })
}

// 修改物模型属性定义
export function updateProperties(data) {
  return request({
    url: '/business/properties',
    method: 'put',
    data: data
  })
}

// 删除物模型属性定义
export function delProperties(id) {
  return request({
    url: '/business/properties/' + id,
    method: 'delete'
  })
}

// 新增物模型属性定义
export function saveBatch(data) {
  return request({
    url: '/business/properties/saveBatch',
    method: 'post',
    data: data
  })
}

// 查询设备最新数据状态
export function getDeviceLastData(deviceSn) {
  return request({
    url: '/business/properties/getDeviceLastData?deviceSn=' + deviceSn,
    method: 'get'
  })
}
// 查询物模型列表
export function getPropertyBySn(sn) {
  return request({
    url: '/business/properties/getPropertiesBySn?sn=' + sn,
    method: 'get'
  })
}

