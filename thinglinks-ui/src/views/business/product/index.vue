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
      <el-row :gutter="15">
        <el-col
          v-for="(item, index) in productList"
          :key="index"
          :xs="12"
          :sm="8"
          :md="6"
          :lg="4"
          class="card-col"
        >
          <el-card class="product-card" shadow="hover"
                   :class="'active-status'">
            <!-- 梯形状态标识 -->
<!--            <div class="status-trapezoid" :class="'active'">-->
<!--              {{ item.status == 1 ? '启用' : '停用' }}-->
<!--            </div>-->
            <div @click="openProductDetail(item.id)">
            <div slot="header" class="card-header">
              <h4 class="product-name">{{ item.productName }}</h4>
            </div>
            <div class="card-content">
              <div class="card-item">
                <i>SN：</i>
                <span class="value">{{ item.productSn }}</span>
              </div>
              <div class="card-item">
                <i>设备数量：</i>
                <span class="value device-count">{{ item.deviceCount || 0 }}</span>
              </div>
              <div class="card-item">
                <i>设备类型：</i>
                <span class="value">{{ deviceTypeText(item.deviceType)}}</span>
              </div>
              <div class="card-item">
                <i>网络组件：</i>
                <span class="value">{{ item.componentName}}</span>
              </div>
            </div>
            </div>
            <div class="card-actions">
              <el-button
                size="mini"
                class="action-btn edit-btn"
                icon="el-icon-edit"
                @click.stop="handleUpdate(item)"
                v-hasPermi="['business:product:edit']"
              >修改
              </el-button>
              <el-button
                size="mini"
                class="action-btn delete-btn"
                icon="el-icon-delete"
                @click.stop="handleDelete(item)"
                v-hasPermi="['business:product:remove']"
              >删除
              </el-button>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </div>
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
<!--          <el-form-item label="协议id" prop="protocolId">-->
<!--            <el-input v-model="form.protocolId" placeholder="请输入协议id"/>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="协议名称" prop="protocolName">-->
<!--            <el-input v-model="form.protocolName" placeholder="请输入协议名称"/>-->
<!--          </el-form-item>-->
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
      // 产品表格数据
      productList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
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
      // 表单参数
      form: {},
      // 表单校验
      rules: {},
      selectedDeviceType:null,
      isEdit:false,
      componentList:[]
    }
  },
  created() {
    this.getList();
    this.initComponentList();
  },
  methods: {
    /** 查询产品列表 */
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
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        productSn: null,
        productName: null,
        linkMethodId: null,
        linkMethodName: null,
        protocolId: null,
        protocolName: null,
        deviceCount: null,
        deviceType: null,
        remark: null,
        createTime: null,
        updateTime: null,
        createBy: null,
        updateBy: null,
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
    async initComponentList(){
      listComponent({pageNum:1,pageSize:100000}).then(res=>{
        this.componentList = res?.rows;
      })
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.isEdit = false;
      this.open = true
      this.title = "添加产品"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      this.isEdit = true;
      const id = row.id || this.ids[0]
      getProduct(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改产品"
        this.handleProductChange(this.form.deviceType);
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if(this.form.componentId){
            let component = this.componentList.find(item=>item.id===this.form.componentId);
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
    /** 删除按钮操作 */
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
    /** 导出按钮操作 */
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
      if (!this.isEdit) {
        this.form.timeoutSeconds = 60
      }
    }
  }
}
</script>
<style scoped>
.product-card-container {
  margin-bottom: 30px;
}

.card-col {
  margin-bottom: 20px;
  transition: transform 0.3s;
}

.card-col:hover {
  transform: translateY(-5px);
}

.card-checkbox {
  display: block;
  width: 100%;
  position: relative;
}

.card-checkbox ::v-deep .el-checkbox__label {
  width: 100%;
  padding: 0;
}

.product-card {
  width: 100%;
  height: 100%;
  border-radius: 12px;
  overflow: hidden;
  transition: all 0.3s ease;
  position: relative;
  border: 1px solid #e6e8eb;
  background: #fff;
}

.product-card:hover {
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
  border-color: #c0c4cc;
}

/* 启用状态渐变背景 */
.product-card.active-status {
  position: relative;
  overflow: hidden;
}

.product-card.active-status::before {
  content: '';
  position: absolute;
  top: 0;
  right: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, rgba(64, 158, 255, 0.15) 0%, rgba(64, 158, 255, 0.05) 20%, rgba(64, 158, 255, 0) 40%);
  pointer-events: none;
  z-index: 1;
}

/* 停用状态渐变背景 */
.product-card.inactive-status {
  position: relative;
  overflow: hidden;
}

.product-card.inactive-status::before {
  content: '';
  position: absolute;
  top: 0;
  right: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, rgba(245, 108, 108, 0.1) 0%, rgba(245, 108, 108, 0.05) 15%, rgba(245, 108, 108, 0) 30%);
  pointer-events: none;
  z-index: 1;
}

/* 梯形状态标识 */
.status-trapezoid {
  position: absolute;
  top: 12px;
  right: -18px;
  width: 70px;
  padding: 4px 0;
  color: white;
  text-align: center;
  font-size: 12px;
  font-weight: bold;
  transform: rotate(45deg);
  z-index: 10;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

.status-trapezoid.active {
  background: linear-gradient(135deg, #67c23a 0%, #85ce61 100%);
}

.status-trapezoid.inactive {
  background: linear-gradient(135deg, #f56c6c 0%, #f78989 100%);
}

.card-header {
  padding: 15px;
  border-bottom: 1px solid #f0f2f5;
  position: relative;
  z-index: 2;
}

.product-name {
  margin: 0;
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.card-content {
  padding: 15px;
  position: relative;
  z-index: 2;
}

.card-item {
  display: flex;
  align-items: center;
  margin-bottom: 12px;
  font-size: 13px;
}

.card-item i {
  margin-right: 8px;
  color: #909399;
  font-size: 14px;
}

.card-item .value {
  color: #606266;
  font-weight: 500;
}

.device-count {
  color: #409EFF !important;
  font-size: 14px;
  font-weight: 600 !important;
}

.card-actions {
  padding: 12px 15px;
  border-top: 1px solid #f0f2f5;
  text-align: center;
  display: flex;
  justify-content: space-around;
  position: relative;
  z-index: 2;
}

.action-btn {
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  padding: 6px 10px;
  transition: all 0.2s;
  font-size: 12px;
}

.edit-btn {
  background: linear-gradient(to bottom, #f0f9ff, #e6f7ff);
  border-color: #91d5ff;
  color: #1890ff;
}

.edit-btn:hover {
  background: linear-gradient(to bottom, #e6f7ff, #d3eefe);
  border-color: #69c0ff;
  color: #096dd9;
}

.delete-btn {
  background: linear-gradient(to bottom, #fff2f0, #fff0ed);
  border-color: #ffccc7;
  color: #ff4d4f;
}

.delete-btn:hover {
  background: linear-gradient(to bottom, #fff0ed, #ffeae8);
  border-color: #ffa39e;
  color: #f5222d;
}

/* 复选框样式调整 */
::v-deep .el-checkbox__input {
  position: absolute;
  top: 10px;
  left: 10px;
  z-index: 11;
}

::v-deep .el-checkbox__inner {
  width: 18px;
  height: 18px;
  border-radius: 4px;
}

::v-deep .el-checkbox__inner::after {
  height: 9px;
  left: 6px;
  top: 2px;
}

/* 空数据提示 */
.no-data {
  text-align: center;
  padding: 40px 0;
  color: #909399;
  font-size: 14px;
}

.no-data i {
  font-size: 40px;
  margin-bottom: 10px;
  display: block;
}

/* 添加分页容器样式 */
.pagination-wrapper {
  position: fixed;
  bottom: 20px;
  right: 20px;
  padding: 10px 15px;
  z-index: 1000;
}

/* 调整卡片容器底部边距，避免内容被分页遮挡 */
.product-card-container {
  margin-bottom: 80px;
}

/* 可选：如果需要进一步美化分页组件本身 */
::v-deep .el-pagination {
  background: transparent;
}

::v-deep .el-pagination .btn-prev,
::v-deep .el-pagination .btn-next,
::v-deep .el-pagination .number {
  background: #fff;
  border: 1px solid #ddd;
  border-radius: 4px;
}

::v-deep .el-pagination .number.active {
  background: #409EFF;
  color: #fff;
  border-color: #409EFF;
}

/* 抽屉样式 */
.component-drawer ::v-deep .el-drawer {
  overflow-y: auto;
}

.drawer-content {
  padding: 20px;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.drawer-footer {
  margin-top: auto;
  padding: 20px 0;
  text-align: right;
}

/* 响应式调整 */
@media screen and (max-width: 768px) {
  .component-drawer ::v-deep .el-drawer {
    width: 85% !important;
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
</style>
