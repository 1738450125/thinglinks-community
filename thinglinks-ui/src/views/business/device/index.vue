<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="设备名称" prop="deviceName">
        <el-input
          v-model="queryParams.deviceName"
          placeholder="请输入设备名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="设备SN" prop="deviceSn">
        <el-input
          v-model="queryParams.deviceSn"
          placeholder="请输入设备SN"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['business:device:add']"
        >新增
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 卡片展示区域 -->
    <div class="device-card-container">
      <el-row :gutter="20">
        <el-col
          v-for="(item, index) in deviceList"
          :key="index"
          :xs="24"
          :sm="12"
          :md="8"
          :lg="6"
          :xl="4"
          class="card-col"
        >
          <div class="device-card-wrapper">
            <el-card
              class="device-card"
              shadow="never"
              :body-style="{ padding: 0 }"
              :class="item.status == 1 ? 'online-status' : 'offline-status'"
            >

              <!-- 卡片内容 -->
              <div class="card-main-content" @click="openDetail(item.id)">
                <!-- 状态标签 -->
                <div class="card-status" :class="item.status == 1 ? 'active' : 'inactive'">
                  <div class="status-dot"></div>
                  <span>{{ item.status == 1 ? '在线' : '离线' }}</span>
                </div>

                <div class="device-header">
                  <div class="device-icon" :class="item.status == 1 ? 'online' : 'offline'">
                    <i :class="item.status == 1 ? 'el-icon-s-platform' : 'el-icon-s-release'"></i>
                  </div>
                  <div class="device-title">
                    <h4 class="device-name">{{ item.deviceName }}</h4>
                    <p class="device-sn">SN: {{ item.deviceSn }}</p>
                  </div>
                </div>

                <div class="device-info-grid">
                  <div class="info-item">
                    <div class="info-label">
                      <i class="el-icon-s-management"></i>
                      <span>产品名称</span>
                    </div>
                    <div class="info-value">{{ item.productName || '未关联产品' }}</div>
                  </div>
                  <div class="info-item">
                    <div class="info-label">
                      <i class="el-icon-s-data"></i>
                      <span>设备类型</span>
                    </div>
                    <div class="info-value highlight">{{ deviceTypeText(item.deviceType) }}</div>
                  </div>
                  <div class="info-item">
                    <div class="info-label">
                      <i class="el-icon-time"></i>
                      <span>创建时间</span>
                    </div>
                    <div class="info-value time">{{ formatTime(item.createTime) }}</div>
                  </div>
                  <div class="info-item">
                    <div class="info-label">
                      <i class="el-icon-s-tools"></i>
                      <span>网络组件</span>
                    </div>
                    <div class="info-value">{{ item.componentName }}</div>
                  </div>
                </div>

              </div>

              <!-- 底部操作按钮 -->
              <div class="card-footer-actions">
                <el-button
                  type="text"
                  icon="el-icon-view"
                  @click.stop="openDetail(item.id)"
                  class="footer-btn"
                >查看详情</el-button>
                <el-button
                  type="text"
                  icon="el-icon-edit"
                  @click.stop="handleUpdate(item)"
                  v-hasPermi="['business:device:edit']"
                  class="footer-btn"
                >编辑</el-button>
                <el-button
                  type="text"
                  icon="el-icon-delete"
                  @click.stop="handleDelete(item)"
                  v-hasPermi="['business:device:remove']"
                  class="footer-btn delete"
                >删除</el-button>
              </div>
            </el-card>
          </div>
        </el-col>
      </el-row>

      <!-- 空状态 -->
      <div v-if="deviceList.length === 0" class="empty-state">
        <div class="empty-icon">
          <i class="el-icon-s-platform"></i>
        </div>
        <h3 class="empty-title">暂无设备数据</h3>
        <p class="empty-desc">点击"新增设备"按钮创建第一个设备</p>
      </div>
    </div>

    <!-- 分页 -->
    <div class="pagination-wrapper">
      <pagination
        v-show="total>0"
        :total="total"
        :page-sizes="[12, 24, 48, 96]"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
      />
    </div>
    <!-- 将对话框改为抽屉 -->
    <el-drawer
      :title="title"
      :visible.sync="open"
      direction="rtl"
      size="40%"
      :before-close="cancel"
      class="component-drawer"
    >
      <div class="drawer-content">
        <!-- 添加或修改设备对话框 -->
        <el-form ref="form" :model="form" :rules="rules" label-width="100px">
          <el-form-item label="设备名称" prop="deviceName" required>
            <el-input v-model="form.deviceName" placeholder="请输入设备名称" />
          </el-form-item>
          <el-form-item label="设备编码" prop="deviceSn" required>
            <el-input v-model="form.deviceSn" placeholder="请输入设备编码" :disabled="form.id"/>
          </el-form-item>
          <el-form-item label="关联产品" prop="productId" required>
            <el-select v-model="form.productId" placeholder="请选择" :disabled="form.id" @change="handleProductChange" >
              <el-option
                v-for="item in productList"
                :key="item.id"
                :label="item.productName"
                :value="item.id">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="心跳时间(S)" prop="timeoutSeconds" required v-if="selectedDeviceType=='2'">
            <el-input type="number" v-model="form.timeoutSeconds" placeholder="心跳时间(S)" />
          </el-form-item>
        </el-form>
        <div class="notes-section">
          <h4 class="notes-title">注意事项</h4>
          <ul class="notes-list">
            <li class="note-item">1、设备SN必须是唯一标识，不可与其他设备以及产品SN重复。</li>
            <li class="note-item">2、设备类型会从产品直接继承，并且不可更改。</li>
            <li class="note-item">3、物模型属性默认从产品直接继承，但设备可以自己添加独有属性，切记产品同步物模型时会覆盖设备独有属性。</li>
            <li class="note-item">4、告警配置规则默认从产品直接继承，但设备可以自己添加独有规则，切记产品同步告警规则时会覆盖设备独有告警规则。</li>
            <li class="note-item">5、指令下发配置默认从产品直接继承，但设备可以自己添加独有指令，切记产品同步指令下发时会覆盖设备独有指令。</li>
            <li class="note-item">
              <div class="device-type-item">
                <span class="item-number">6、设备类型：</span>
                <div class="device-type-details">
                  <div class="type-option">
                    <span class="type-name">直连设备：</span>
                    <span class="type-desc">用于长连接设备，断开连接时平台将自动把设备置为离线状态。</span>
                  </div>
                  <div class="type-option">
                    <span class="type-name">网关设备：</span>
                    <span class="type-desc">用于网关设备，设备状态完全由协议管理，协议中可以返回设备的在离线状态。</span>
                  </div>
                  <div class="type-option">
                    <span class="type-name">无状态设备：</span>
                    <span class="type-desc">用于短链接或者无法获取状态的设备，无状态设备可以设置一段时间（心跳时间）未收到消息则自动离线。</span>
                  </div>
                </div>
              </div>
            </li>
          </ul>
        </div>
        <div class="drawer-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </div>
    </el-drawer>
  </div>
</template>

<script>
import {listDevice, getDevice, delDevice, addDevice, updateDevice} from "@/api/business/device"
import {listProduct} from "@/api/business/product";
export default {
  name: "Device",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 选中的卡片
      selectedCards: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 设备表格数据
      deviceList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      mapDialogVisible: false, // 地图弹框显示状态
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 12,
        deviceSn: null,
        deviceName: null,
        productId: null,
        productName: null,
        productSn: null,
        linkMethodId: null,
        linkMethodName: null,
        protocolId: null,
        protocolName: null,
        status: null
      },
      //产品列表
      productList: [],
      // 表单参数
      form: {},
      // 表单校验
      rules: {},
      selectedDeviceType:null,
      isEdit:false
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询设备列表 */
    getList() {
      this.loading = true
      listDevice(this.queryParams).then(response => {
        this.deviceList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 可选：点击输入框区域也打开弹框
    handleInputClick(e) {
      // 避免点击输入框时和图标事件冲突（可选）
      this.mapDialogVisible = true;
    },
    deviceTypeText(deviceType) {
      const typeMap = {
        "0": '直连设备',
        "1": '网关设备',
        "2": '无状态设备'
      }
      return typeMap[deviceType] || '未知类型'
    },
    formatTime(time) {
      if (!time) return '--'
      return time.substring(0, 16).replace('T', ' ')
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        deviceSn: null,
        deviceName: null,
        productId: null,
        productName: null,
        productSn: null,
        createTime: null,
        createBy: null,
        updateTime: null,
        updateBy: null,
        linkMethodId: null,
        linkMethodName: null,
        protocolId: null,
        protocolName: null,
        status: null
      }
      this.selectedDeviceType = null
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 卡片选择变化
    handleCardSelectionChange(selection) {
      this.ids = selection
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.isEdit = false;
      this.open = true
      listProduct({pageNum: 1, pageSize: 10000}).then(res => {
        this.productList = res.rows
      })
      this.title = "添加设备"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      this.isEdit = true;
      listProduct({pageNum: 1, pageSize: 10000}).then(res => {
        this.productList = res.rows
      })
      const id = row.id || this.ids[0]
      getDevice(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改设备"
        this.handleProductChange(this.form.productId)
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateDevice(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addDevice(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除设备编号为"' + ids + '"的数据项？').then(function () {
        return delDevice(ids)
      }).then(() => {
        this.getList()
        this.selectedCards = []
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('business/device/export', {
        ...this.queryParams
      }, `device_${new Date().getTime()}.xlsx`)
    },
    openDetail(id) {
      this.$router.push({
        path: '/deviceManage/device/detail/index',
        query: {
          id: id
        }
      });
    },
    handleProductChange(productId) {
      // 根据选中的产品ID获取对应的产品信息
      const selectedProduct = this.productList.find(item => item.id === productId)
      if (selectedProduct) {
        this.selectedDeviceType = selectedProduct.deviceType
        if(!this.isEdit){
          this.form.timeoutSeconds = selectedProduct.timeoutSeconds
        }
      }
    }
  }
}
</script>

<style scoped lang="scss">
.app-container {
  padding: 20px;
  min-height: calc(100vh - 50px);
}

.device-card-container {
  padding: 20px 0;
}

.card-col {
  margin-bottom: 24px;
}

.device-card-wrapper {
  height: 100%;
  transition: all 0.3s ease;

  &:hover {
    transform: translateY(-4px);

    .device-card {
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12) !important;
    }
  }
}

.device-card {
  border-radius: 12px !important;
  border: 1px solid #e4e7ed !important;
  overflow: hidden;
  height: 100%;
  transition: all 0.3s ease;
  background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);

  &:hover {
    border-color: #c0c4cc !important;
  }
}

.card-status {
  position: absolute;
  top: 10px;
  right: 16px;
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 500;
  z-index: 10;

  &.active {
    background: rgba(103, 194, 58, 0.1);
    color: #67c23a;

    .status-dot {
      background: #67c23a;
    }
  }

  &.inactive {
    background: rgba(245, 108, 108, 0.1);
    color: #f56c6c;

    .status-dot {
      background: #f56c6c;
    }
  }
}

.status-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
}

.card-main-content {
  padding: 24px 20px;
  cursor: pointer;
  transition: all 0.2s;

  &:hover {
    background: rgba(245, 247, 250, 0.5);
  }
}

.device-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 24px;
}

.device-icon {
  width: 56px;
  height: 56px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;

  &.online {
    background: linear-gradient(135deg, #67c23a 0%, #85ce61 100%);
  }

  &.offline {
    background: linear-gradient(135deg, #909399 0%, #a6a9ad 100%);
  }

  i {
    font-size: 24px;
    color: white;
  }
}

.device-title {
  flex: 1;
}

.device-name {
  margin: 0 0 8px 0;
  font-size: 18px;
  font-weight: 600;
  color: #303133;
  line-height: 1.3;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.device-sn {
  margin: 0;
  font-size: 13px;
  color: #909399;
  font-family: 'Monaco', 'Consolas', monospace;
}

.device-info-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  margin-bottom: 24px;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.info-label {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: #909399;

  i {
    font-size: 14px;
  }
}

.info-value {
  font-size: 14px;
  font-weight: 500;
  color: #303133;
  line-height: 1.4;

  &.highlight {
    color: #409EFF;
    font-size: 16px;
    font-weight: 600;
  }

  &.time {
    font-size: 12px;
    color: #909399;
    font-family: 'Monaco', 'Consolas', monospace;
  }

  &.online-text {
    color: #67c23a;
    font-weight: 600;
  }

  &.offline-text {
    color: #f56c6c;
    font-weight: 600;
  }
}

.card-footer-actions {
  display: flex;
  justify-content: space-around;
  padding: 16px 20px;
  background: #f8fafc;
  border-top: 1px solid #f0f2f5;
}

.footer-btn {
  color: #606266;
  font-size: 13px;
  font-weight: 500;
  padding: 4px 8px;

  &:hover {
    color: #409EFF;
  }

  &.delete:hover {
    color: #f56c6c;
  }

  i {
    margin-right: 4px;
  }
}

.empty-state {
  text-align: center;
  padding: 80px 20px;

  .empty-icon {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, #f0f9ff 0%, #e6f7ff 100%);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 20px;

    i {
      font-size: 40px;
      color: #409EFF;
    }
  }

  .empty-title {
    margin: 0 0 12px 0;
    font-size: 20px;
    font-weight: 600;
    color: #303133;
  }

  .empty-desc {
    margin: 0;
    font-size: 14px;
    color: #909399;
  }
}

.pagination-wrapper {
  position: fixed;
  bottom: 20px;
  right: 20px;
  padding: 10px 15px;
  z-index: 1000;
}

::v-deep .el-pagination {
  background: transparent !important;
}

.drawer-content {
  padding: 24px;
  height: 100%;
  display: flex;
  flex-direction: column;

  .el-form {
    flex: 0 0 auto;
  }
}

::v-deep .el-drawer {
  .el-drawer__header {
    margin-bottom: 24px;
    padding: 24px 24px 0;
    font-weight: 600;
    font-size: 18px;

    span {
      color: #303133;
    }
  }
}

.notes-section {
  margin: 20px 0;
  padding: 16px;
  background-color: #f8f9fa;
  border-radius: 6px;
  border-left: 4px solid #838383;
}

.notes-title {
  margin: 0 0 12px 0;
  font-size: 16px;
  font-weight: 600;
  color: #303133;
}

.notes-list {
  margin: 0;
  padding-left: 20px;
}

.note-item {
  margin-bottom: 12px;
  font-size: 13px;
  color: #606266;
  line-height: 1.5;
}

.note-item:last-child {
  margin-bottom: 0;
}

.device-type-item {
  line-height: 1.6;
}

.item-number {
  font-weight: 500;
  color: #303133;
}

.device-type-details {
  margin-top: 8px;
  margin-left: 8px;
}

.type-option {
  margin-bottom: 10px;
  padding: 8px 12px;
  background: white;
  border-radius: 4px;
  border: 1px solid #e4e7ed;
}

.type-option:last-child {
  margin-bottom: 0;
}

.type-name {
  font-weight: 500;
  color: #409eff;
  display: inline-block;
  min-width: 80px;
}

.type-desc {
  color: #606266;
}

.drawer-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  margin-top: auto;
  padding-top: 24px;
  border-top: 1px solid #e4e7ed;
}

// 响应式调整
@media screen and (max-width: 1200px) {
  .device-info-grid {
    grid-template-columns: 1fr;
  }
}

@media screen and (max-width: 768px) {
  .app-container {
    padding: 16px;
  }

  .card-col {
    margin-bottom: 16px;
  }

  .device-header {
    flex-direction: column;
    text-align: center;
    gap: 12px;
  }

  .device-icon {
    width: 48px;
    height: 48px;

    i {
      font-size: 20px;
    }
  }

  .device-name {
    font-size: 16px;
  }

  .card-footer-actions {
    flex-wrap: wrap;
    gap: 8px;
  }

  .pagination-wrapper {
    position: static;
    margin-top: 20px;
    box-shadow: none;
    background: transparent;
    padding: 0;
  }
}

// 动画效果
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.device-card-wrapper {
  animation: fadeIn 0.3s ease-out;
  animation-fill-mode: both;

  @for $i from 1 through 20 {
    &:nth-child(#{$i}) {
      animation-delay: $i * 0.05s;
    }
  }
}
</style>
