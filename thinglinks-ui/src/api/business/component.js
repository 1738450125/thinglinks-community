import request from '@/utils/request'

// 查询网络组件列表
export function listComponent(query) {
  return request({
    url: '/business/component/list',
    method: 'get',
    params: query
  })
}

// 查询网络组件详细
export function getComponent(id) {
  return request({
    url: '/business/component/' + id,
    method: 'get'
  })
}

// 新增网络组件
export function addComponent(data) {
  return request({
    url: '/business/component',
    method: 'post',
    data: data
  })
}

// 修改网络组件
export function updateComponent(data) {
  return request({
    url: '/business/component',
    method: 'put',
    data: data
  })
}

// 删除网络组件
export function delComponent(id) {
  return request({
    url: '/business/component/' + id,
    method: 'delete'
  })
}

// 修改网络组件
export function control(data) {
  return request({
    url: '/business/component/control?id='+data.id+"&status="+data.status,
    method: 'put',
    data: {}
  })
}
