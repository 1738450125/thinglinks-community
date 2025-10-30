import request from '@/utils/request'

// 查询规则引擎
export function listRuleEngine(query) {
  return request({
    url: '/business/ruleEngine/list',
    method: 'get',
    params: query
  })
}

// 获取规则引擎详情
export function getRuleEngine(id) {
  return request({
    url: '/business/ruleEngine/' + id,
    method: 'get'
  })
}

// 新增规则引擎
export function addRuleEngine(data) {
  return request({
    url: '/business/ruleEngine',
    method: 'post',
    data: data
  })
}

// 修改规则引擎
export function updateRuleEngine(data) {
  return request({
    url: '/business/ruleEngine',
    method: 'put',
    data: data
  })
}

// 删除规则引擎
export function delRuleEngine(id) {
  return request({
    url: '/business/ruleEngine/' + id,
    method: 'delete'
  })
}

// 开关规则引擎
export function control(data) {
  return request({
    url: '/business/ruleEngine/control?id='+data.id+"&isEnable="+data.status,
    method: 'put',
    data: {}
  })
}
