import request from '@/utils/request'

// 查询告警配置
export function listWarnConfig(query) {
  return request({
    url: '/business/warnConfig/list',
    method: 'get',
    params: query
  })
}

// 获取告警配置详情
export function getWarnConfig(id) {
  return request({
    url: '/business/warnConfig/' + id,
    method: 'get'
  })
}

// 新增告警配置
export function addWarnConfig(data) {
  return request({
    url: '/business/warnConfig',
    method: 'post',
    data: data
  })
}

// 修改告警配置
export function updateWarnConfig(data) {
  return request({
    url: '/business/warnConfig',
    method: 'put',
    data: data
  })
}

// 删除告警配置
export function delWarnConfig(id) {
  return request({
    url: '/business/warnConfig/' + id,
    method: 'delete'
  })
}

// 切换告警配置状态
export function toggleRuleStatus(data) {
  return request({
    url: '/business/warnConfig/toggleRuleStatus',
    method: 'put',
    data: data
  })
}

// 同步告警配置到设备
export function syncWarnConfigToDevice(productSn) {
  return request({
    url: '/business/warnConfig/syncWarnConfigToDevice?productSn='+productSn,
    method: 'post',
    data: {}
  })
}

