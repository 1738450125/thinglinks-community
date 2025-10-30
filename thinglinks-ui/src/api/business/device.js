import request from '@/utils/request'

// 查询设备列表
export function listDevice(query) {
  return request({
    url: '/business/device/list',
    method: 'get',
    params: query
  })
}

// 查询设备详细
export function getDevice(id) {
  return request({
    url: '/business/device/' + id,
    method: 'get'
  })
}

// 新增设备
export function addDevice(data) {
  return request({
    url: '/business/device',
    method: 'post',
    data: data
  })
}

// 修改设备
export function updateDevice(data) {
  return request({
    url: '/business/device',
    method: 'put',
    data: data
  })
}

// 删除设备
export function delDevice(id) {
  return request({
    url: '/business/device/' + id,
    method: 'delete'
  })
}

// 修改设备自定义配置
export function editCustomConfig(data) {
  return request({
    url: '/business/device/editCustomConfig',
    method: 'post',
    data: data
  })
}

// 修改设备定时删除数据配置
export function editRetentionTime(data) {
  return request({
    url: '/business/device/editRetentionTime',
    method: 'post',
    data: data
  })
}

// 根据产品sn获取设备列表
export function getDeviceByProductSn(ids) {
  return request({
    url: '/business/device/getDeviceByProductSn?productSnList=' + ids,
    method: 'get'
  })
}
