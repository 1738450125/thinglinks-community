<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="产品名称" prop="productName">
        <el-input
          v-model="queryParams.productName"
          placeholder="请输入产品名称"
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
          v-hasPermi="['business:product:add']"
        >新增
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 卡片展示区域 -->
    <div class="product-card-container">
      <el-row :gutter="20">
        <el-col
          v-for="(item, index) in productList"
          :key="index"
          :xs="24"
          :sm="12"
          :md="8"
          :lg="6"
          :xl="4"
          class="card-col"
        >
          <div class="product-card-wrapper">
            <el-card
              class="product-card"
              shadow="never"
              :body-style="{ padding: 0 }"
            >

              <!-- 卡片内容 -->
              <div class="card-main-content" @click="openProductDetail(item.id)">
                <div class="product-header">
                  <div class="product-icon">
                    <i class="el-icon-s-management"></i>
                  </div>
                  <div class="product-title">
                    <h4 class="product-name">{{ item.productName }}</h4>
                    <p class="product-sn">SN: {{ item.productSn }}</p>
                  </div>
                </div>

                <div class="product-info-grid">
                  <div class="info-item">
                    <div class="info-label">
                      <i class="el-icon-s-platform"></i>
                      <span>设备类型</span>
                    </div>
                    <div class="info-value">{{ deviceTypeText(item.deviceType) }}</div>
                  </div>
                  <div class="info-item">
                    <div class="info-label">
                      <i class="el-icon-s-data"></i>
                      <span>设备数量</span>
                    </div>
                    <div class="info-value highlight">{{ item.deviceCount || 0 }}</div>
                  </div>
                  <div class="info-item">
                    <div class="info-label">
                      <i class="el-icon-s-tools"></i>
                      <span>网络组件</span>
                    </div>
                    <div class="info-value">{{ item.componentName || '未配置' }}</div>
                  </div>
                  <div class="info-item">
                    <div class="info-label">
                      <i class="el-icon-time"></i>
                      <span>创建时间</span>
                    </div>
                    <div class="info-value time">{{ formatTime(item.createTime) }}</div>
                  </div>
                </div>

              </div>

              <!-- 底部操作按钮 -->
              <div class="card-footer-actions">
                <el-button
                  type="text"
                  icon="el-icon-view"
                  @click.stop="openProductDetail(item.id)"
                  class="footer-btn"
                >查看详情</el-button>
                <el-button
                  type="text"
                  icon="el-icon-edit"
                  @click.stop="handleUpdate(item)"
                  v-hasPermi="['business:product:edit']"
                  class="footer-btn"
                >编辑</el-button>
                <el-button
                  type="text"
                  icon="el-icon-delete"
                  @click.stop="handleDelete(item)"
                  v-hasPermi="['business:product:remove']"
                  class="footer-btn delete"
                >删除</el-button>
              </div>
            </el-card>
          </div>
        </el-col>
      </el-row>

      <!-- 空状态 -->
      <div v-if="productList.length === 0" class="empty-state">
        <div class="empty-icon">
          <i class="el-icon-s-management"></i>
        </div>
        <h3 class="empty-title">暂无产品数据</h3>
        <p class="empty-desc">点击"新增产品"按钮创建第一个产品</p>
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

    <!-- 新增/编辑抽屉 -->
    <el-drawer
      :title="title"
      :visible.sync="open"
      direction="rtl"
      size="40%"
      :before-close="cancel"
      class="component-drawer"
      :wrapperClosable="true"
    >
      <div class="drawer-content">
        <!-- 添加或修改产品对话框 -->
        <el-form ref="form" :model="form" :rules="rules" label-width="100px">
          <el-form-item label="产品名称" prop="productName" required>
            <el-input v-model="form.productName" placeholder="请输入产品名称"/>
          </el-form-item>
          <el-form-item label="产品SN" prop="productSn" required>
            <el-input v-model="form.productSn" placeholder="请输入产品SN" :disabled="form.id"/>
          </el-form-item>
          <!--          <el-form-item label="接入方式id" prop="linkMethodId">-->
          <!--            <el-input v-model="form.linkMethodId" placeholder="请输入接入方式id"/>-->
          <!--          </el-form-item>-->
          <el-form-item label="设备类型" prop="deviceType" required>
            <el-select v-model="form.deviceType" placeholder="设备类型" :disabled="form.id" @change="handleProductChange">
              <el-option label="直连设备" value="0"></el-option>
              <el-option label="网关设备" value="1"></el-option>
              <el-option label="无状态设备" value="2"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="网络组件">
            <el-select v-model="form.componentId" placeholder="请选择" :disabled="form.componentName">
              <el-option
                v-for="item in componentList"
                :key="item.id"
                :label="item.name"
                :value="item.id">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="心跳时间(S)" prop="timeoutSeconds" required v-if="selectedDeviceType=='2'">
            <el-input type="number" v-model="form.timeoutSeconds" placeholder="心跳时间(S)" />
          </el-form-item>
          <el-form-item label="备注" prop="remark">
            <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"/>
          </el-form-item>
        </el-form>
        <div class="notes-section">
          <h4 class="notes-title">注意事项</h4>
          <ul class="notes-list">
            <li class="note-item">1、产品SN必须是唯一标识，不可重复。</li>
            <li class="note-item">2、产品选择的设备类型会继承给设备，一个产品下面的设备只能是一个类型。</li>
            <li class="note-item">
              <div class="device-type-item">
                <span class="item-number">3、设备类型：</span>
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
                  <div class="type-option">
                    <span class="tixing">友情提醒：</span>
                    <span class="type-desc">只要设备会定时上报消息，并且上报消息就代表在线的情况，都可以选择为<span style="color: #409eff;">无状态设备</span>，这样协议中就不再需要管理设备状态，降低协议复杂度。</span>
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
import {listProduct, getProduct, delProduct, addProduct, updateProduct} from "@/api/business/product"
import {listComponent} from "@/api/business/component"
export default {
  name: "Product",
  data() {
    return {
      loading: true,
      ids: [],
      selectedCards: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      productList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 12,
        productSn: null,
        productName: null,
        linkMethodId: null,
        linkMethodName: null,
        protocolId: null,
        protocolName: null,
        deviceCount: null,
        deviceType: null,
        status: null
      },
      form: {},
      rules: {},
      selectedDeviceType: null,
      isEdit: false,
      componentList: []
    }
  },
  created() {
    this.getList();
    this.initComponentList();
  },
  methods: {
    getList() {
      this.loading = true
      listProduct(this.queryParams).then(response => {
        this.productList = response.rows
        this.total = response.total
        this.loading = false
      })
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
    cancel() {
      this.open = false
      this.reset()
    },
    reset() {
      this.form = {

      }
      this.selectedDeviceType = null
      this.resetForm("form")
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleCardSelectionChange(selection) {
      this.ids = selection
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    async initComponentList() {
      listComponent({pageNum: 1, pageSize: 100000}).then(res => {
        this.componentList = res?.rows;
      })
    },
    handleAdd() {
      this.reset()
      this.isEdit = false;
      this.open = true
      this.title = "新增产品"
    },
    handleUpdate(row) {
      this.reset()
      this.isEdit = true;
      const id = row.id || this.ids[0]
      getProduct(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "编辑产品"
        this.handleProductChange(this.form.deviceType);
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.componentId) {
            let component = this.componentList.find(item => item.id === this.form.componentId);
            this.form.componentName = component?.name;
          }
          if (this.form.id != null) {
            updateProduct(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addProduct(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除产品编号为"' + ids + '"的数据项？').then(function () {
        return delProduct(ids)
      }).then(() => {
        this.getList()
        this.selectedCards = []
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    handleExport() {
      this.download('business/product/export', {
        ...this.queryParams
      }, `product_${new Date().getTime()}.xlsx`)
    },
    openProductDetail(id) {
      this.$router.push({
        path: '/deviceManage/product/detail/index',
        query: {
          id: id
        }
      });
    },
    handleProductChange(deviceType) {
      this.selectedDeviceType = deviceType
      if (!this.isEdit && deviceType === '2') {
        this.form.timeoutSeconds = 60
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

.product-card-container {
  padding: 20px 0;
}

.card-col {
  margin-bottom: 24px;
}

.product-card-wrapper {
  height: 100%;
  transition: all 0.3s ease;

  &:hover {
    transform: translateY(-4px);

    .product-card {
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12) !important;
    }
  }
}

.product-card {
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

.card-top-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: linear-gradient(90deg, #f8fafc 0%, #ffffff 100%);
  border-bottom: 1px solid #f0f2f5;
}

.card-status {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 500;

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

.card-actions-mini {
  display: flex;
  gap: 4px;
}

.mini-action-btn {
  padding: 4px 8px;
  font-size: 14px;
  color: #909399;

  &:hover {
    color: #409EFF;
  }

  &.delete:hover {
    color: #f56c6c;
  }
}

.card-main-content {
  padding: 24px 20px;
  cursor: pointer;
  transition: all 0.2s;

  &:hover {
    background: rgba(245, 247, 250, 0.5);
  }
}

.product-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 24px;
}

.product-icon {
  width: 56px;
  height: 56px;
  background: linear-gradient(135deg, #409EFF 0%, #67c2ff 100%);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;

  i {
    font-size: 24px;
    color: white;
  }
}

.product-title {
  flex: 1;
}

.product-name {
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

.product-sn {
  margin: 0;
  font-size: 13px;
  color: #909399;
  font-family: 'Monaco', 'Consolas', monospace;
}

.product-info-grid {
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
}

.device-usage {
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px solid #f0f2f5;
}

.usage-info {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
  font-size: 12px;
  color: #909399;
}

::v-deep .el-progress-bar__outer {
  border-radius: 10px;
  background-color: #f0f2f5;
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
.tixing {
  font-weight: 500;
  color: #ff8c00;
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
  .product-info-grid {
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

  .product-header {
    flex-direction: column;
    text-align: center;
    gap: 12px;
  }

  .product-icon {
    width: 48px;
    height: 48px;

    i {
      font-size: 20px;
    }
  }

  .product-name {
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

.product-card-wrapper {
  animation: fadeIn 0.3s ease-out;
  animation-fill-mode: both;

  @for $i from 1 through 20 {
    &:nth-child(#{$i}) {
      animation-delay: $i * 0.05s;
    }
  }
}
</style>
