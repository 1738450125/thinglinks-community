<template>
  <div v-if="visible" class="dialog-overlay" @click="handleOverlayClick">
    <div class="dialog-container" @click.stop>
      <!-- 弹窗头部 -->
      <div class="dialog-header">
        <div class="header-content">
          <h3>{{ componentName }}</h3>
          <div class="component-basic-info">
            <span class="component-id">ID: {{ componentId }}</span>
            <!--            <span class="component-status" :class="componentStatus">-->
            <!--              {{ componentStatusText }}-->
            <!--            </span>-->
          </div>
        </div>
        <button class="close-btn" @click="handleClose">×</button>
      </div>

      <!-- 弹窗内容 -->
      <div class="dialog-content">
        <!-- 组件基本信息 -->
        <div class="component-info-section" v-if="component">
          <div class="info-grid">
            <div class="info-item">
              <label>组件类型:</label>
              <span>{{ componentType }}</span>
            </div>
          </div>
        </div>

        <!-- WebSocket 连接状态 -->
        <div class="websocket-section">
          <h4>WebSocket 连接</h4>
          <div class="status-section">
            <div class="status-indicator" :class="connectionStatus">
              <span class="status-dot"></span>
              {{ statusText }}
            </div>

            <div class="connection-controls">
              <button
                @click="connectWebSocket"
                :disabled="isConnected || !component"
                class="btn btn-connect"
              >
                连接
              </button>
              <button
                @click="disconnectWebSocket"
                :disabled="!isConnected"
                class="btn btn-disconnect"
              >
                断开
              </button>
              <button
                @click="clearMessages"
                class="btn btn-clear"
              >
                清空消息
              </button>
            </div>
          </div>

          <!--          &lt;!&ndash; 消息发送区域 &ndash;&gt;-->
          <!--          <div class="message-send-section" v-if="isConnected">-->
          <!--            <div class="input-group">-->
          <!--              <textarea-->
          <!--                v-model="messageToSend"-->
          <!--                placeholder="输入要发送的消息..."-->
          <!--                class="message-input"-->
          <!--                rows="2"-->
          <!--              ></textarea>-->
          <!--            </div>-->
          <!--            <button-->
          <!--              @click="sendMessage"-->
          <!--              :disabled="!messageToSend.trim()"-->
          <!--              class="btn btn-send"-->
          <!--            >-->
          <!--              发送消息-->
          <!--            </button>-->
          <!--          </div>-->

          <!-- 消息显示区域 -->
          <div class="messages-section">
            <div class="section-header">
              <h5>消息记录</h5>
              <span class="message-count">共 {{ messages.length }} 条</span>
            </div>
            <div class="messages-container">
              <div
                v-for="(message, index) in messages"
                :key="index"
                :class="['message', message.type]"
              >
                <div class="message-header">
                  <span class="timestamp">{{ message.timestamp }}</span>
                  <span class="message-type">{{ getMessageTypeText(message.type) }}</span>
                </div>
                <div class="message-content">{{ message.content }}</div>
              </div>
              <div v-if="messages.length === 0" class="empty-message">
                暂无消息记录
              </div>
            </div>
          </div>

          <!-- 统计信息 -->
          <div class="stats-section">
            <div class="stats">
              <div class="stat-item">
                <span class="stat-label">连接时间:</span>
                <span class="stat-value">{{ currentDuration }}</span>
              </div>
              <div class="stat-item">
                <span class="stat-label">消息数量:</span>
                <span class="stat-value">{{ messages.length }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "ComponentDetailDialog",
  props: {
    visible: {
      type: Boolean,
      default: false
    },
    component: {
      type: Object,
      default: () => ({})
    }
  },
  data() {
    const baseUrl = process.env.VUE_APP_WS_BASE_URL || 'ws://127.0.0.1:8080'
    return {
      websocket: null,
      messages: [],
      websocketUrl: `${baseUrl}/ws/component/`,
      isConnected: false,
      connectionStatus: 'disconnected',
      messageToSend: '',
      connectTime: null,
      timer: null,
      currentDuration: '00:00:00',
      isManualClose: false, // 标记是否手动关闭
      reconnectAttempts: 0, // 重连次数
      maxReconnectAttempts: 3 // 最大重连次数
    }
  },
  computed: {
    // 安全的组件属性访问
    componentName() {
      return this.component?.name || '组件详情'
    },
    componentId() {
      return this.component?.id || '未知'
    },
    componentType() {
      return this.component?.netType || '未知'
    },
    statusText() {
      const statusMap = {
        disconnected: '未连接',
        connecting: '连接中...',
        connected: '已连接',
        error: '连接错误'
      }
      return statusMap[this.connectionStatus] || '未知'
    }
  },
  watch: {
    visible: {
      immediate: true,
      handler(newVal) {
        if (newVal && this.component && this.component.id) {
          this.$nextTick(() => {
            this.connectWebSocket()
          })
        } else {
          this.safeDisconnect()
        }
      }
    },
    component: {
      deep: true,
      handler(newComponent) {
        if (newComponent && newComponent.id && this.visible) {
          this.safeDisconnect()
          this.$nextTick(() => {
            this.connectWebSocket()
          })
        }
      }
    },
    isConnected: {
      handler(newVal) {
        if (newVal) {
          this.startTimer()
        } else {
          this.stopTimer()
          this.currentDuration = '00:00:00'
        }
      },
      immediate: true
    }
  },
  methods: {
    // 安全的断开连接方法
    safeDisconnect() {
      this.isManualClose = true
      this.reconnectAttempts = 0 // 重置重连计数
      this.disconnectWebSocket()
    },

    handleClose() {
      this.safeDisconnect()
      this.$emit('close')
    },

    startTimer() {
      this.stopTimer() // 先停止可能的旧计时器
      this.timer = setInterval(() => {
        this.updateDuration()
      }, 1000)
    },

    stopTimer() {
      if (this.timer) {
        clearInterval(this.timer)
        this.timer = null
      }
    },

    updateDuration() {
      if (!this.connectTime) {
        this.currentDuration = '00:00:00'
        return
      }

      const now = new Date()
      const diff = Math.floor((now - this.connectTime) / 1000)

      const hours = Math.floor(diff / 3600)
      const minutes = Math.floor((diff % 3600) / 60)
      const seconds = diff % 60

      this.currentDuration =
        hours.toString().padStart(2, '0') + ':' +
        minutes.toString().padStart(2, '0') + ':' +
        seconds.toString().padStart(2, '0')
    },

    handleOverlayClick(event) {
      if (event.target === event.currentTarget) {
        this.handleClose()
      }
    },

    connectWebSocket() {
      // 如果已经连接或正在连接，先断开
      if (this.websocket) {
        this.cleanupWebSocket()
      }

      if (this.isConnected || !this.component || !this.component.id) return

      this.connectionStatus = 'connecting'
      this.isManualClose = false

      try {
        const wsUrl = this.websocketUrl + this.component.id
        console.log('正在连接 WebSocket:', wsUrl)

        this.websocket = new WebSocket(wsUrl)

        // 设置连接超时
        const connectionTimeout = setTimeout(() => {
          if (this.websocket && this.websocket.readyState === WebSocket.CONNECTING) {
            console.warn('WebSocket 连接超时')
            this.websocket.close()
          }
        }, 10000)

        this.websocket.onopen = () => {
          clearTimeout(connectionTimeout)
          this.isConnected = true
          this.connectionStatus = 'connected'
          this.connectTime = new Date()
          this.reconnectAttempts = 0 // 连接成功时重置重连计数
          this.addMessage('系统', 'WebSocket 连接已建立', 'system')
        }

        this.websocket.onmessage = (event) => {
          this.addMessage('服务器', event.data, 'received')
        }

        this.websocket.onclose = (event) => {
          clearTimeout(connectionTimeout)
          this.isConnected = false
          this.connectionStatus = 'disconnected'
          this.connectTime = null

          if (!this.isManualClose) {
            const reason = event.reason || '未知原因'
            this.addMessage('系统', `连接意外断开: ${event.code} ${reason}`, 'system')

            // 自动重连逻辑
            if (this.reconnectAttempts < this.maxReconnectAttempts) {
              this.reconnectAttempts++
              this.addMessage('系统', `尝试重新连接 (${this.reconnectAttempts}/${this.maxReconnectAttempts})...`, 'system')

              setTimeout(() => {
                if (this.visible && !this.isManualClose) {
                  this.connectWebSocket()
                }
              }, 2000 * this.reconnectAttempts) // 重连延迟递增
            } else {
              this.addMessage('系统', '重连次数已达上限，请手动连接', 'system')
            }
          } else {
            this.addMessage('系统', '连接已手动关闭', 'system')
          }

          this.cleanupWebSocket()
        }

        this.websocket.onerror = (error) => {
          clearTimeout(connectionTimeout)
          this.connectionStatus = 'error'
          this.addMessage('系统', 'WebSocket 连接错误', 'system')
          console.error('WebSocket error:', error)
          this.cleanupWebSocket()
        }

      } catch (error) {
        this.connectionStatus = 'error'
        this.addMessage('系统', `连接失败: ${error.message}`, 'system')
        this.cleanupWebSocket()
      }
    },

    disconnectWebSocket() {
      if (this.websocket) {
        try {
          // 根据 WebSocket 状态进行不同的关闭操作
          switch (this.websocket.readyState) {
            case WebSocket.OPEN:
              this.websocket.close(1000, '正常关闭')
              break
            case WebSocket.CONNECTING:
              this.websocket.close(1000, '取消连接')
              break
            default:
              this.cleanupWebSocket()
          }
        } catch (error) {
          console.warn('关闭 WebSocket 时出错:', error)
          this.cleanupWebSocket()
        }
      } else {
        this.cleanupWebSocket()
      }
    },

    // 彻底清理 WebSocket 资源
    cleanupWebSocket() {
      if (this.websocket) {
        // 移除所有事件监听器，防止内存泄漏
        this.websocket.onopen = null
        this.websocket.onmessage = null
        this.websocket.onclose = null
        this.websocket.onerror = null

        // 如果还在连接中，强制关闭
        if (this.websocket.readyState === WebSocket.CONNECTING ||
          this.websocket.readyState === WebSocket.OPEN) {
          try {
            this.websocket.close(1000, '组件卸载')
          } catch (e) {
            // 忽略关闭错误
          }
        }

        this.websocket = null
      }
      this.isConnected = false
      this.connectionStatus = 'disconnected'
    },

    addMessage(sender, content, type) {
      const timestamp = new Date().toLocaleTimeString()
      this.messages.push({
        sender,
        content,
        type,
        timestamp
      })

      if (this.messages.length > 100) {
        this.messages = this.messages.slice(-50)
      }

      this.$nextTick(() => {
        const container = this.$el.querySelector('.messages-container')
        if (container) {
          container.scrollTop = container.scrollHeight
        }
      })
    },

    clearMessages() {
      this.messages = []
    },

    getMessageTypeText(type) {
      const typeMap = {
        sent: '发送',
        received: '接收',
        system: '系统'
      }
      return typeMap[type] || type
    }
  },

  // 添加页面可见性监听
  mounted() {
    // 监听页面可见性变化
    document.addEventListener('visibilitychange', this.handleVisibilityChange)

    // 监听页面卸载
    window.addEventListener('beforeunload', this.handleBeforeUnload)
  },

  beforeDestroy() {
    this.safeDisconnect()
    this.stopTimer()

    // 移除事件监听器
    document.removeEventListener('visibilitychange', this.handleVisibilityChange)
    window.removeEventListener('beforeunload', this.handleBeforeUnload)
  },

  // 如果使用 keep-alive
  deactivated() {
    this.safeDisconnect()
    this.stopTimer()
  },

  activated() {
    // 重新激活时，如果可见且有组件，重新连接
    if (this.visible && this.component && this.component.id) {
      this.$nextTick(() => {
        this.connectWebSocket()
      })
    }
  },

  // 处理页面可见性变化
  handleVisibilityChange() {
    if (document.hidden) {
      // 页面隐藏时，如果是生产环境可以考虑断开连接节省资源
      if (process.env.NODE_ENV === 'production') {
        this.safeDisconnect()
      }
    } else {
      // 页面重新显示时，重新连接
      if (this.visible && this.component && this.component.id && !this.isConnected) {
        this.connectWebSocket()
      }
    }
  },

  // 处理页面关闭/刷新
  handleBeforeUnload() {
    this.safeDisconnect()
  }
}
</script>

<style scoped>
.dialog-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.dialog-container {
  background: white;
  border-radius: 8px;
  width: 90%;
  max-width: 900px;
  max-height: 90vh;
  display: flex;
  flex-direction: column;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.dialog-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 20px;
  border-bottom: 1px solid #ebeef5;
  background: #f5f7fa;
  border-radius: 8px 8px 0 0;
}

.header-content h3 {
  margin: 0 0 8px 0;
  color: #303133;
  font-size: 18px;
}

.component-basic-info {
  display: flex;
  align-items: center;
  gap: 16px;
}

.component-id {
  color: #606266;
  font-size: 14px;
}

.component-status {
  padding: 2px 8px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: bold;
}

.component-status.在线 {
  background: #f0f9ff;
  color: #1890ff;
}

.component-status.离线 {
  background: #fff2f0;
  color: #ff4d4f;
}

.close-btn {
  background: none;
  border: none;
  font-size: 20px;
  cursor: pointer;
  color: #909399;
  width: 30px;
  height: 30px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.close-btn:hover {
  background-color: #f4f4f5;
  color: #409EFF;
}

.dialog-content {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
}

.component-info-section {
  margin-bottom: 24px;
  padding: 16px;
  background: #f8f9fa;
  border-radius: 6px;
}

.component-info-section h4 {
  margin: 0 0 12px 0;
  color: #303133;
}

.info-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.info-item.full-width {
  grid-column: 1 / -1;
}

.info-item label {
  font-size: 12px;
  color: #909399;
  font-weight: bold;
}

.info-item span {
  color: #606266;
  font-size: 14px;
}

.websocket-section h4 {
  margin: 0 0 16px 0;
  color: #303133;
}

.status-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 16px;
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 6px;
}

.status-indicator {
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: bold;
}

.status-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  display: inline-block;
}

.status-indicator.disconnected .status-dot {
  background-color: #dc3545;
}

.status-indicator.connecting .status-dot {
  background-color: #ffc107;
  animation: pulse 1.5s infinite;
}

.status-indicator.connected .status-dot {
  background-color: #28a745;
}

.status-indicator.error .status-dot {
  background-color: #dc3545;
  animation: pulse 1.5s infinite;
}

.connection-controls {
  display: flex;
  gap: 10px;
}

.btn {
  padding: 8px 16px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.3s;
}

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.btn-connect {
  background-color: #28a745;
  color: white;
}

.btn-disconnect {
  background-color: #dc3545;
  color: white;
}

.btn-clear {
  background-color: #6c757d;
  color: white;
}

.btn-send {
  background-color: #409EFF;
  color: white;
  align-self: flex-end;
}

.message-send-section {
  margin-bottom: 20px;
  display: flex;
  gap: 10px;
  align-items: flex-end;
}

.input-group {
  flex: 1;
}

.message-input {
  width: 100%;
  padding: 8px 12px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  font-size: 14px;
  resize: vertical;
  font-family: inherit;
}

.messages-section {
  margin-bottom: 20px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.section-header h5 {
  margin: 0;
  color: #303133;
}

.message-count {
  font-size: 12px;
  color: #909399;
}

.messages-container {
  max-height: 300px;
  overflow-y: auto;
  background: white;
  border-radius: 6px;
  padding: 16px;
  border: 1px solid #ebeef5;
}

.message {
  margin-bottom: 12px;
  padding: 12px;
  border-radius: 6px;
  border-left: 4px solid;
}

.message.sent {
  background-color: #e3f2fd;
  border-left-color: #2196f3;
}

.message.received {
  background-color: #f3e5f5;
  border-left-color: #9c27b0;
}

.message.system {
  background-color: #fff3cd;
  border-left-color: #ffc107;
}

.message-header {
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color: #666;
  margin-bottom: 6px;
}

.message-content {
  word-break: break-word;
  font-size: 14px;
}

.empty-message {
  text-align: center;
  color: #999;
  font-style: italic;
  padding: 40px 20px;
}

.stats-section {
  padding: 16px;
  background: #f8f9fa;
  border-radius: 6px;
}

.stats {
  display: flex;
  justify-content: space-around;
  text-align: center;
}

.stat-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.stat-label {
  font-size: 12px;
  color: #666;
  text-transform: uppercase;
}

.stat-value {
  font-size: 18px;
  font-weight: bold;
  color: #333;
}

@keyframes pulse {
  0% { opacity: 1; }
  50% { opacity: 0.5; }
  100% { opacity: 1; }
}
</style>
