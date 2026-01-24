<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="协议名称" prop="protocolName">
        <el-input
          v-model="queryParams.protocolName"
          placeholder="请输入协议名称"
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
          v-hasPermi="['business:protocol:add']"
        >新增
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 卡片展示区域 -->
    <div class="protocol-card-container">
      <el-checkbox-group v-model="selectedCards" @change="handleCardSelectionChange">
        <el-row :gutter="15">
          <el-col
            v-for="(item, index) in protocolList"
            :key="index"
            :xs="12"
            :sm="8"
            :md="6"
            :lg="4"
            class="card-col"
          >
            <el-card class="protocol-card" shadow="hover">
              <div slot="header" class="card-header">
                <h4 class="protocol-name">{{ item.protocolName || '未知协议' }}</h4>
              </div>
              <div class="card-content">
                <div class="card-item">
                  <i class="el-icon-folder"></i>
                  <span class="value">{{ item.localUrl || '未设置路径' }}</span>
                </div>
                <div class="card-item">
                  <i class="el-icon-cpu"></i>
                  <span class="value">{{ item.mainClassPath || '未设置入口类' }}</span>
                </div>
                <div class="card-item">
                  <i class="el-icon-document"></i>
                  <span class="value">{{ item.originName || '未设置原始名称' }}</span>
                </div>
                <div class="card-item">
                  <i class="el-icon-edit-outline"></i>
                  <span class="value">{{ item.newName || '未设置新名称' }}</span>
                </div>
                <div class="card-item">
                  <i class="el-icon-collection-tag"></i>
                  <span class="value">{{ item.type === 0 ? 'JAR包' : '其他类型' }}</span>
                </div>
              </div>
              <div class="card-actions">
                <el-button
                  size="mini"
                  class="action-btn edit-btn"
                  icon="el-icon-edit"
                  @click.stop="handleUpdate(item)"
                  v-hasPermi="['business:protocol:edit']"
                >修改
                </el-button>
                <el-button
                  size="mini"
                  class="action-btn delete-btn"
                  icon="el-icon-delete"
                  @click.stop="handleDelete(item)"
                  v-hasPermi="['business:protocol:remove']"
                >删除
                </el-button>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </el-checkbox-group>
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
      class="protocol-drawer"
    >
      <div class="drawer-content">
        <el-form ref="form" :model="form" :rules="rules" label-width="120px">
          <el-form-item label="协议名称" prop="protocolName" required>
            <el-input v-model="form.protocolName" placeholder="请输入协议名称"/>
          </el-form-item>
          <el-form-item label="类型" prop="type" required>
            <el-select v-model="form.type" placeholder="请选择类型">
              <el-option label="JAR包" value="jar"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="网络类型" prop="protocolType" required>
            <el-select v-model="form.protocolType" placeholder="网络类型">
              <el-option label="MQTT_BROKER" value="MQTT_BROKER"></el-option>
              <el-option label="MQTT_CLIENT" value="MQTT_CLIENT"></el-option>
              <el-option label="TCP_SERVER" value="TCP_SERVER"></el-option>
              <el-option label="UDP_SERVER" value="UDP_SERVER"></el-option>
              <el-option label="COAP_SERVER" value="COAP_SERVER"></el-option>
              <el-option label="HTTP_SERVER" value="HTTP_SERVER"></el-option>
              <el-option label="WEBSOCKET_SERVER" value="WEBSOCKET_SERVER"></el-option>
              <el-option label="MODBUS_TCP" value="MODBUS_TCP"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="上传JAR包" prop="file">
            <el-upload
              class="upload-demo"
              drag
              accept=".jar"
              :limit="1"
              :on-change="handleChange"
              :on-exceed="handleExceed"
              :on-remove="handleRemove"
              action="#"
              :auto-upload="false"
              multiple>
              <i class="el-icon-upload"></i>
              <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
              <div class="el-upload__tip" slot="tip">只能上传JAR文件，且不超过100MB</div>
            </el-upload>
          </el-form-item>
        </el-form>
        <div class="drawer-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </div>
    </el-drawer>
  </div>
</template>

<script>
import {listProtocol, getProtocol, delProtocol, addProtocol, updateProtocol} from "@/api/business/protocol"

export default {
  name: "Protocol",
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
      // 协议管理表格数据
      protocolList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 12,
        protocolName: null,
        localUrl: null,
        mainClassPath: null,
        originName: null,
        protocolType: null,
        type: null,
        newName: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {}
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询协议管理列表 */
    getList() {
      this.loading = true
      listProtocol(this.queryParams).then(response => {
        this.protocolList = response.rows
        this.total = response.total
        this.loading = false
      })
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
        protocolName: null,
        localUrl: null,
        mainClassPath: null,
        originName: null,
        type: null,
        newName: null
      }
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
      this.open = true
      this.title = "添加协议管理"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids[0]
      getProtocol(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改协议管理"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            const formData = new FormData();
            formData.append("protocolFile", this.form.protocolFile);
            // 遍历this.form的所有属性
            for (const key in this.form) {
              // 确保只遍历对象自身的属性，不包括原型链上的属性
              if (this.form.hasOwnProperty(key) && key !== "protocolFile") {
                formData.append(key, this.form[key]);
              }
            }
            updateProtocol(formData).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            const formData = new FormData();
            formData.append("protocolFile", this.form.protocolFile);
            // 遍历this.form的所有属性
            for (const key in this.form) {
              // 确保只遍历对象自身的属性，不包括原型链上的属性
              if (this.form.hasOwnProperty(key) && key !== "protocolFile") {
                formData.append(key, this.form[key]);
              }
            }
            addProtocol(formData).then(response => {
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
      this.$modal.confirm('是否确认删除协议管理编号为"' + ids + '"的数据项？').then(function () {
        return delProtocol(ids)
      }).then(() => {
        this.getList()
        this.selectedCards = []
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('business/protocol/export', {
        ...this.queryParams
      }, `protocol_${new Date().getTime()}.xlsx`)
    },
    handleChange(file, fileList) {
      // file 参数就是当前变化的文件对象
      this.form.protocolFile = file.raw  // 获取原始文件对象
    },
    handleExceed(files, fileList) {
      // 当超过限制时，用新文件替换旧文件
      this.fileList = [files[0]] // 只保留最新选择的文件
      this.form.protocolFile = files[0] // 更新表单数据
    },

    handleRemove(file, fileList) {
      // 文件被移除时的处理
      this.fileList = fileList
      this.form.protocolFile = null
    }
  }
}
</script>

<style scoped>
.protocol-card-container {
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

.protocol-card {
  width: 100%;
  height: 100%;
  border-radius: 12px;
  overflow: hidden;
  transition: all 0.3s ease;
  position: relative;
  border: 1px solid #e6e8eb;
  background: #fff;
}

.protocol-card:hover {
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
  border-color: #c0c4cc;
}

.protocol-card {
  position: relative;
  overflow: hidden;
}

.protocol-card::before {
  content: '';
  position: absolute;
  top: 0;
  right: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, rgba(103, 194, 58, 0.15) 0%, rgba(103, 194, 58, 0.05) 20%, rgba(103, 194, 58, 0) 40%);
  pointer-events: none;
  z-index: 1;
}

.card-header {
  padding: 15px;
  border-bottom: 1px solid #f0f2f5;
  position: relative;
  z-index: 2;
}

.protocol-name {
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
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  flex: 1;
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

/* 添加分页容器样式 */
.pagination-wrapper {
  position: fixed;
  bottom: 20px;
  right: 20px;
  padding: 10px 15px;
  z-index: 1000;
}

/* 调整卡片容器底部边距，避免内容被分页遮挡 */
.protocol-card-container {
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
.protocol-drawer ::v-deep .el-drawer {
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
  .protocol-drawer ::v-deep .el-drawer {
    width: 85% !important;
  }
}
</style>
