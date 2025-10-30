import request from '@/utils/request'

// 查询告警记录
export function listWarnRecord(query) {
  return request({
    url: '/business/warnRecord/list',
    method: 'get',
    params: query
  })
}

// 获取告警记录详情
export function getWarnRecord(id) {
  return request({
    url: '/business/warnRecord/' + id,
    method: 'get'
  })
}

// 新增告警记录
export function addWarnRecord(data) {
  return request({
    url: '/business/warnRecord',
    method: 'post',
    data: data
  })
}

// 修改告警记录
export function updateWarnRecord(data) {
  return request({
    url: '/business/warnRecord',
    method: 'put',
    data: data
  })
}

// 删除告警记录
export function delWarnRecord(id) {
  return request({
    url: '/business/warnRecord/' + id,
    method: 'delete'
  })
}
