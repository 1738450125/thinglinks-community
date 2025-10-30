import request from '@/utils/request'

// 查询指令下发
export function listFunction(query) {
  return request({
    url: '/business/function/list',
    method: 'get',
    params: query
  })
}

// 获取指令下发详情
export function getFunction(id) {
  return request({
    url: '/business/function/' + id,
    method: 'get'
  })
}

// 新增指令下发
export function addFunction(data) {
  return request({
    url: '/business/function',
    method: 'post',
    data: data
  })
}

// 修改指令下发
export function updateFunction(data) {
  return request({
    url: '/business/function',
    method: 'put',
    data: data
  })
}

// 删除指令下发
export function delFunction(id) {
  return request({
    url: '/business/function/' + id,
    method: 'delete'
  })
}

// 指令下发控制
export function downFunction(data) {
  return request({
    url: '/business/function/downFunction',
    method: 'post',
    data: data
  })
}

// 同步产品指令配置到设备
export function syncProductToDevice(data) {
  return request({
    url: '/business/function/syncProductToDevice',
    method: 'post',
    data: data
  })
}
