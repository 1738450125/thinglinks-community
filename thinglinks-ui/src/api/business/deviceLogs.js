import request from '@/utils/request'

// 查询告警记录
export function listDeviceLogs(query) {
  return request({
    url: '/business/deviceLogs/list',
    method: 'get',
    params: query
  })
}

// 获取告警记录详情
export function getDeviceLogs(id) {
  return request({
    url: '/business/deviceLogs/' + id,
    method: 'get'
  })
}

// 新增告警记录
export function addDeviceLogs(data) {
  return request({
    url: '/business/deviceLogs',
    method: 'post',
    data: data
  })
}

// 修改告警记录
export function updateDeviceLogs(data) {
  return request({
    url: '/business/deviceLogs',
    method: 'put',
    data: data
  })
}

// 删除告警记录
export function delDeviceLogs(id) {
  return request({
    url: '/business/deviceLogs/' + id,
    method: 'delete'
  })
}
