<template>
  <div id="app" class="dashboard">
    <!-- 主内容区域 -->
    <div class="main-content">
      <!-- 欢迎区域 -->
      <div class="welcome-section">
        <h1>物联网平台控制中心</h1>
        <p>监控和管理您的所有物联网设备与数据</p>
        <div class="status-indicator">
          <div class="pulse"></div>
          <span>系统运行正常</span>
        </div>
      </div>

      <!-- 数据统计卡片 -->
      <div class="stats-grid">
        <div class="stat-card" v-for="stat in stats" :key="stat.title" :class="stat.type">
          <div class="card-glow"></div>
          <div class="card-content">
            <div class="stat-icon">
              <i :class="stat.icon"></i>
            </div>
            <div class="stat-info">
              <h3>{{ stat.title }}</h3>
              <div class="stat-value" v-if="stat.type==='products'">{{ totalData.productCount }}</div>
              <div class="stat-value" v-if="stat.type==='devices'">{{ totalData.deviceCount }}</div>
              <div class="stat-value" v-if="stat.type==='components'">{{ totalData.componentCount }}</div>
              <div class="stat-value" v-if="stat.type==='protocols'">{{ totalData.protocolCount }}</div>
              <div class="stat-value" v-if="stat.type==='messages'">{{ totalData.todayMessageCount }}</div>
              <div v-if="stat.type === 'devices'" class="device-details">
                <div class="detail-item">
                  <span class="label">在线</span>
                  <span class="value online">{{ totalData.deviceOnlineCount }}</span>
                </div>
                <div class="detail-item">
                  <span class="label">离线</span>
                  <span class="value offline">{{ totalData.deviceOfflineCount }}</span>
                </div>
              </div>
              <div v-else class="stat-trend">
                <i class="fas fa-arrow-up"></i>
                <span>&nbsp;</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 主要内容区域 -->
      <div class="content-area">
        <!-- 设备接入流程 -->
        <div class="content-card process-card">
          <div class="card-header">
            <h2>设备接入流程</h2>
            <!--            <button class="btn-ghost">查看详情 <i class="fas fa-arrow-right"></i></button>-->
          </div>
          <div class="process-steps">
            <div v-for="(step, index) in steps" :key="index" class="step">
              <div class="step-number">{{ index + 1 }}</div>
              <div class="step-content">
                <h3>{{ step.title }}</h3>
                <p>{{ step.description }}</p>
              </div>
              <div v-if="index < steps.length - 1" class="step-connector">
                <i class="fas fa-arrow-right"></i>
              </div>
            </div>
          </div>
        </div>

        <!-- 平台架构图 -->
        <div class="content-card architecture-card">
          <div class="card-header">
            <h2>平台架构图</h2>
<!--            <button class="btn-ghost">放大查看 <i class="fas fa-expand"></i></button>-->
          </div>
          <div class="architecture-diagram">
            <div class="layer application-layer">
              <div class="layer-label">应用层</div>
              <div class="node app-node">业务应用</div>
            </div>

            <div class="connector vertical"></div>

            <div class="layer platform-layer">
              <div class="layer-label">平台层</div>
              <div class="nodes-row">
                <div class="node platform-node">数据存储</div>
                <div class="node platform-node">规则引擎</div>
                <div class="node platform-node">预警系统</div>
                <div class="node platform-node">指令下发</div>
              </div>
            </div>

            <div class="connector vertical"></div>

            <div class="layer protocol-layer">
              <div class="layer-label">协议层</div>
              <div class="node protocol-node">协议解析</div>
            </div>

            <div class="connector vertical"></div>

            <div class="layer component-layer">
              <div class="layer-label">组件层</div>
              <div class="nodes-row">
                <div class="node component-node">MQTT</div>
                <div class="node component-node">HTTP</div>
                <div class="node component-node">TCP</div>
                <div class="node component-node">UDP</div>
                <div class="node component-node">CoAP</div>
                <div class="node component-node">WS</div>
                <div class="node component-node">MODBUS(规划中)</div>
              </div>
            </div>

            <div class="connector vertical"></div>

            <div class="layer device-layer">
              <div class="layer-label">设备层</div>
              <div class="nodes-row">
                <div class="node device-node">传感器</div>
                <div class="node device-node">控制器</div>
                <div class="node device-node">网关</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 告警信息 -->
      <div class="content-area">
        <!-- 最新告警 -->
        <div class="content-card warn-card">
          <div class="card-header">
            <h2>最新告警</h2>
          </div>
          <div class="warn-list">
            <div v-for="(warn, index) in warnRecord" :key="index" class="warn-item">
              <div class="warn-main">
                <div class="warn-title-time">
                  <span class="warn-name">{{ warn.configName }}</span>
                  <span class="warn-date">{{ formatDate(warn.createTime) }}</span>
                </div>
                <span class="warn-level-tag" :class="getLevelType(warn.warnLevel)">
                  {{ getLevelText(warn.warnLevel) }}
                </span>
              </div>
              <div class="warn-message">
                {{ warn.warnMessage }}
              </div>
            </div>
          </div>
        </div>

        <!-- 系统状态 -->
        <div class="content-card system-card">
          <div class="card-header">
            <h2>系统状态</h2>
            <div class="status-indicators">
              <div class="status-dot online"></div>
              <span>运行中</span>
            </div>
          </div>
          <div class="system-metrics">
            <div class="metric">
              <div class="metric-info">
                <span class="label">CPU使用率</span>
                <span class="value">24%</span>
              </div>
              <div class="progress-bar">
                <div class="progress-fill" style="width: 24%"></div>
              </div>
            </div>
            <div class="metric">
              <div class="metric-info">
                <span class="label">内存使用率</span>
                <span class="value">62%</span>
              </div>
              <div class="progress-bar">
                <div class="progress-fill" style="width: 62%"></div>
              </div>
            </div>
            <div class="metric">
              <div class="metric-info">
                <span class="label">存储使用率</span>
                <span class="value">38%</span>
              </div>
              <div class="progress-bar">
                <div class="progress-fill" style="width: 38%"></div>
              </div>
            </div>
            <div class="metric">
              <div class="metric-info">
                <span class="label">网络吞吐量</span>
                <span class="value">1.2 Gb/s</span>
              </div>
              <div class="progress-bar">
                <div class="progress-fill" style="width: 45%"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {indexStatics} from "@/api/business/product";
import {listWarnRecord} from '@/api/business/warnRecord';

export default {
  name: 'IoTDashboard',
  created() {
    this.getIndexStatics();
    this.getWarnRecord();
  },
  data() {
    return {
      stats: [
        {
          title: '产品总数',
          value: '24',
          type: 'products',
          icon: 'fas fa-cube',
          trend: 12
        },
        {
          title: '设备总数',
          value: '156',
          type: 'devices',
          icon: 'fas fa-microchip',
          online: '142',
          offline: '14'
        },
        {
          title: '组件数量',
          value: '8',
          type: 'components',
          icon: 'fas fa-puzzle-piece',
          trend: 5
        },
        {
          title: '协议数量',
          value: '12',
          type: 'protocols',
          icon: 'fas fa-file-contract',
          trend: 8
        },
        {
          title: '今日消息',
          value: '3,247',
          type: 'messages',
          icon: 'fas fa-bell',
          trend: 15
        }
      ],
      steps: [
        {
          title: '创建产品',
          description: '在平台中创建产品定义，设置产品属性和功能'
        },
        {
          title: '添加设备',
          description: '为产品添加具体设备，设置设备独有配置'
        },
        {
          title: '配置组件',
          description: '设置设备连接的网络组件和通信协议'
        },
        {
          title: '设备接入',
          description: '设备通过组件连接到平台，开始上报数据'
        },
        {
          title: '数据处理',
          description: '平台解析设备数据，存储并触发相关规则'
        }
      ],
      activities: [
        {
          type: 'device',
          icon: 'fas fa-microchip',
          message: '新设备 "智能温控器-023" 已成功接入平台',
          time: '10分钟前',
          status: 'success',
          statusText: '成功'
        },
        {
          type: 'alert',
          icon: 'fas fa-exclamation-triangle',
          message: '设备 "环境监测-015" 触发温度预警',
          time: '25分钟前',
          status: 'warning',
          statusText: '警告'
        },
        {
          type: 'message',
          icon: 'fas fa-envelope',
          message: '今日已接收 3,247 条设备消息',
          time: '1小时前',
          status: 'info',
          statusText: '信息'
        },
        {
          type: 'product',
          icon: 'fas fa-cube',
          message: '新产品 "智能安防套装" 已创建',
          time: '2小时前',
          status: 'success',
          statusText: '成功'
        }
      ],
      totalData: {},
      warnRecord: []
    }
  },
  methods: {
    formatDate(dateString) {
      if (!dateString) return ''
      const date = new Date(dateString)
      const year = date.getFullYear()
      const month = String(date.getMonth() + 1).padStart(2, '0')
      const day = String(date.getDate()).padStart(2, '0')
      const hours = String(date.getHours()).padStart(2, '0')
      const minutes = String(date.getMinutes()).padStart(2, '0')
      const seconds = String(date.getSeconds()).padStart(2, '0')

      return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
    },
    getLevelType(level) {
      const typeMap = {
        '1': 'danger',     // 紧急 - 红色
        '2': 'warning',    // 严重 - 橙色
        '3': 'normal',       // 警告 - 蓝色
        '4': 'success'     // 正常 - 绿色
      };
      return typeMap[level] || 'info';
    },
    getLevelText(level) {
      const textMap = {
        '1': '紧急',
        '2': '严重',
        '3': '警告',
        '4': '正常'
      };
      return textMap[level] || '未知';
    },
    getIndexStatics() {
      indexStatics().then(res => {
        if (res?.code != 200) {
          this.$message.error("统计数据获取失败");
        } else {
          this.totalData = res?.data
        }
      })
    },
    getWarnRecord() {
      listWarnRecord().then(res => {
        if (res?.code != 200) {
          this.$message.error("数据获取失败");
        } else {
          this.warnRecord = res?.rows
        }
      })
    },
    particleStyle(index) {
      const size = Math.random() * 6 + 2;
      const duration = Math.random() * 20 + 10;
      const delay = Math.random() * 5;
      const left = Math.random() * 100;

      return {
        width: `${size}px`,
        height: `${size}px`,
        left: `${left}%`,
        animationDuration: `${duration}s`,
        animationDelay: `${delay}s`
      };
    }
  }
}
</script>

<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
  background-color: #f8fafc;
  color: #334155;
  overflow-x: hidden;
}

.dashboard {
  min-height: 100vh;
  background: linear-gradient(135deg, #ffffff 0%, #f1f5f9 100%);
  position: relative;
  overflow: hidden;
}

/* 导航栏 */
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 40px;
  position: relative;
  z-index: 10;
  border-bottom: 1px solid #e2e8f0;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
}

.logo {
  display: flex;
  align-items: center;
  font-size: 24px;
  font-weight: 700;
  color: #3b82f6;
}

.logo i {
  margin-right: 10px;
  font-size: 28px;
}

.nav-center {
  display: flex;
  gap: 30px;
}

.nav-item {
  padding: 10px 20px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s;
  font-weight: 500;
  color: #64748b;
}

.nav-item:hover {
  background: #f1f5f9;
  color: #334155;
}

.nav-item.active {
  background: #3b82f6;
  color: white;
}

.nav-right {
  display: flex;
  align-items: center;
  gap: 20px;
}

.notification {
  position: relative;
  font-size: 20px;
  cursor: pointer;
  padding: 10px;
  border-radius: 50%;
  transition: background 0.3s;
  color: #64748b;
}

.notification:hover {
  background: #f1f5f9;
}

.badge {
  position: absolute;
  top: 5px;
  right: 5px;
  background: #ef4444;
  color: white;
  border-radius: 50%;
  width: 18px;
  height: 18px;
  font-size: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.user-profile img {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #e2e8f0;
}

/* 主内容区域 */
.main-content {
  position: relative;
  z-index: 1;
  padding: 0 40px 40px;
}

.welcome-section {
  margin: 30px 0 40px;
  text-align: center;
}

.welcome-section h1 {
  font-size: 36px;
  font-weight: 700;
  margin-bottom: 10px;
  color: #1e293b;
}

.welcome-section p {
  font-size: 18px;
  color: #64748b;
  margin-bottom: 20px;
}

.status-indicator {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  padding: 8px 16px;
  background: #dcfce7;
  border: 1px solid #bbf7d0;
  border-radius: 20px;
  font-size: 14px;
  color: #166534;
}

.pulse {
  width: 10px;
  height: 10px;
  background: #22c55e;
  border-radius: 50%;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% {
    box-shadow: 0 0 0 0 rgba(34, 197, 94, 0.7);
  }
  70% {
    box-shadow: 0 0 0 10px rgba(34, 197, 94, 0);
  }
  100% {
    box-shadow: 0 0 0 0 rgba(34, 197, 94, 0);
  }
}

/* 数据统计卡片 */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 20px;
  margin-bottom: 40px;
}

.stat-card {
  background: white;
  border-radius: 16px;
  padding: 24px;
  position: relative;
  overflow: hidden;
  border: 1px solid #e2e8f0;
  transition: all 0.3s;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}

.stat-card:hover {
  transform: translateY(-5px);
  border-color: #3b82f6;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
}

.card-glow {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: radial-gradient(circle at center, rgba(59, 130, 246, 0.05) 0%, transparent 70%);
  opacity: 0;
  transition: opacity 0.3s;
}

.stat-card:hover .card-glow {
  opacity: 1;
}

.card-content {
  display: flex;
  align-items: center;
  position: relative;
  z-index: 2;
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 16px;
  font-size: 24px;
}

.products .stat-icon {
  background: rgba(139, 92, 246, 0.1);
  color: #8b5cf6;
}

.devices .stat-icon {
  background: rgba(59, 130, 246, 0.1);
  color: #3b82f6;
}

.components .stat-icon {
  background: rgba(14, 165, 233, 0.1);
  color: #0ea5e9;
}

.protocols .stat-icon {
  background: rgba(245, 158, 11, 0.1);
  color: #f59e0b;
}

.messages .stat-icon {
  background: rgba(236, 72, 153, 0.1);
  color: #ec4899;
}

.stat-info h3 {
  font-size: 14px;
  color: #64748b;
  margin-bottom: 8px;
  font-weight: 500;
}

.stat-value {
  font-size: 28px;
  font-weight: 700;
  margin-bottom: 8px;
  color: #1e293b;
}

.device-details {
  display: flex;
  gap: 16px;
}

.detail-item {
  display: flex;
  flex-direction: column;
}

.detail-item .label {
  font-size: 12px;
  color: #64748b;
  margin-bottom: 4px;
}

.detail-item .value {
  font-size: 16px;
  font-weight: 600;
}

.value.online {
  color: #22c55e;
}

.value.offline {
  color: #ef4444;
}

.stat-trend {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 14px;
  color: #22c55e;
}

/* 内容区域 */
.content-area {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
  margin-bottom: 24px;
}

.content-card {
  background: white;
  border-radius: 16px;
  padding: 24px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.card-header h2 {
  font-size: 20px;
  font-weight: 600;
  color: #1e293b;
}

.btn-ghost {
  background: transparent;
  border: 1px solid #e2e8f0;
  color: #64748b;
  padding: 8px 16px;
  border-radius: 8px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: all 0.3s;
  font-size: 14px;
}

.btn-ghost:hover {
  background: #f8fafc;
  color: #334155;
  border-color: #cbd5e1;
}

/* 流程步骤 */
.process-steps {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.step {
  display: flex;
  align-items: center;
}

.step-number {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: rgba(59, 130, 246, 0.1);
  color: #3b82f6;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  margin-right: 16px;
  flex-shrink: 0;
}

.step-content {
  flex: 1;
}

.step-content h3 {
  font-size: 16px;
  margin-bottom: 4px;
  color: #1e293b;
}

.step-content p {
  font-size: 14px;
  color: #64748b;
}

.step-connector {
  margin-left: 16px;
  color: #cbd5e1;
}

/* 架构图 */
.architecture-diagram {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
}

.layer {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
}

.layer-label {
  font-size: 14px;
  color: #64748b;
  margin-bottom: 12px;
  font-weight: 500;
}

.nodes-row {
  display: flex;
  gap: 16px;
}

.node {
  padding: 12px 20px;
  border-radius: 8px;
  font-weight: 500;
  text-align: center;
  min-width: 100px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.app-node {
  background: rgba(139, 92, 246, 0.1);
  border: 1px solid rgba(139, 92, 246, 0.2);
  color: #8b5cf6;
}

.platform-node {
  background: rgba(59, 130, 246, 0.1);
  border: 1px solid rgba(59, 130, 246, 0.2);
  color: #3b82f6;
}

.protocol-node {
  background: rgba(245, 158, 11, 0.1);
  border: 1px solid rgba(245, 158, 11, 0.2);
  color: #f59e0b;
}

.component-node {
  background: rgba(14, 165, 233, 0.1);
  border: 1px solid rgba(14, 165, 233, 0.2);
  color: #0ea5e9;
}

.device-node {
  background: rgba(236, 72, 153, 0.1);
  border: 1px solid rgba(236, 72, 153, 0.2);
  color: #ec4899;
}

.connector {
  width: 2px;
  height: 30px;
  background: #e2e8f0;
}

.connector.vertical {
  width: 2px;
  height: 30px;
}

/* 系统状态 */
.status-indicators {
  display: flex;
  align-items: center;
  gap: 8px;
}

.status-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
}

.status-dot.online {
  background: #22c55e;
  animation: pulse 2s infinite;
}

.system-metrics {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.metric {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.metric-info {
  display: flex;
  justify-content: space-between;
}

.metric-info .label {
  font-size: 14px;
  color: #64748b;
}

.metric-info .value {
  font-size: 14px;
  font-weight: 600;
  color: #1e293b;
}

.progress-bar {
  height: 6px;
  background: #f1f5f9;
  border-radius: 3px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #3b82f6, #0ea5e9);
  border-radius: 3px;
  transition: width 0.5s;
}

/* 最新告警样式 */
.warn-card {
  background: white;
  border-radius: 16px;
  padding: 24px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}

.warn-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.warn-item {
  padding: 16px;
  background: #f8fafc;
  border-radius: 12px;
  border: 1px solid #f1f5f9;
  transition: all 0.3s ease;
}

.warn-item:hover {
  background: #f1f5f9;
  border-color: #e2e8f0;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.warn-main {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 8px;
}

.warn-title-time {
  flex: 1;
}

.warn-name {
  display: block;
  font-size: 15px;
  font-weight: 600;
  color: #1e293b;
  margin-bottom: 4px;
  line-height: 1.4;
}

.warn-date {
  font-size: 12px;
  color: #64748b;
  font-weight: 400;
}

.warn-level-tag {
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-left: 12px;
  white-space: nowrap;
}

.warn-level-tag.danger {
  background: linear-gradient(135deg, #ef4444, #dc2626);
  color: white;
  box-shadow: 0 2px 4px rgba(239, 68, 68, 0.2);
}

.warn-level-tag.warning {
  background: linear-gradient(135deg, #f59e0b, #d97706);
  color: white;
  box-shadow: 0 2px 4px rgba(245, 158, 11, 0.2);
}

.warn-level-tag.normal {
  background: linear-gradient(135deg, #3b82f6, #2563eb);
  color: white;
  box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
}

.warn-level-tag.success {
  background: linear-gradient(135deg, #10b981, #059669);
  color: white;
  box-shadow: 0 2px 4px rgba(16, 185, 129, 0.2);
}

.warn-message {
  font-size: 14px;
  color: #475569;
  line-height: 1.5;
  word-break: break-word;
  padding-left: 4px;
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .content-area {
    grid-template-columns: 1fr;
  }

  .architecture-diagram .nodes-row {
    flex-wrap: wrap;
    justify-content: center;
  }
}

@media (max-width: 768px) {
  .navbar {
    padding: 15px 20px;
    flex-direction: column;
    gap: 15px;
  }

  .nav-center {
    gap: 10px;
  }

  .main-content {
    padding: 0 20px 20px;
  }

  .stats-grid {
    grid-template-columns: 1fr;
  }

  .welcome-section h1 {
    font-size: 28px;
  }

  .step {
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
  }

  .step-connector {
    display: none;
  }

  .warn-main {
    flex-direction: column;
    gap: 8px;
  }

  .warn-level-tag {
    align-self: flex-start;
    margin-left: 0;
  }
}
</style>
