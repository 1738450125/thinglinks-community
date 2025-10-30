import request from '@/utils/request'

// 查询指令下发记录列表
export function listFunctionRecord(query) {
  return request({
    url: '/business/functionRecord/list',
    method: 'get',
    params: query
  })
}

// 查询指令下发记录详细
export function getFunctionRecord(id) {
  return request({
    url: '/business/functionRecord/' + id,
    method: 'get'
  })
}

// 新增指令下发记录
export function addFunctionRecord(data) {
  return request({
    url: '/business/functionRecord',
    method: 'post',
    data: data
  })
}

// 修改指令下发记录
export function updateFunctionRecord(data) {
  return request({
    url: '/business/functionRecord',
    method: 'put',
    data: data
  })
}

// 删除指令下发记录
export function delFunctionRecord(id) {
  return request({
    url: '/business/functionRecord/' + id,
    method: 'delete'
  })
}
