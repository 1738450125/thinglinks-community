// src/utils/websocket.js

/**
 * 获取 WebSocket 连接地址
 * @param {string} type - 连接类型 (component, device, system)
 * @param {string} id - 组件/设备 ID
 * @returns {string} WebSocket URL
 */
export function getWebSocketUrl(type, id = '') {
  const baseUrl = process.env.VUE_APP_WS_BASE_URL || 'ws://127.0.0.1:8080'
  const pathMap = {
    component: '/ws/component/',
    device: '/ws/device/',
    system: '/ws/system/'
  }

  const path = pathMap[type] || '/ws/'
  return `${baseUrl.replace(/\/$/, '')}${path}${id}`
}

/**
 * 创建 WebSocket 连接
 * @param {string} type - 连接类型
 * @param {string} id - 组件/设备 ID
 * @param {Object} callbacks - 回调函数
 * @returns {WebSocket} WebSocket 实例
 */
export function createWebSocket(type, id, callbacks = {}) {
  const url = getWebSocketUrl(type, id)
  const ws = new WebSocket(url)

  const { onOpen, onMessage, onClose, onError } = callbacks

  if (onOpen) ws.onopen = onOpen
  if (onMessage) ws.onmessage = onMessage
  if (onClose) ws.onclose = onClose
  if (onError) ws.onerror = onError

  return ws
}
