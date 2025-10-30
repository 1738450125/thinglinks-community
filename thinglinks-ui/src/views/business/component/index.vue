<template>
  <div class="app-container">
    <!-- 搜索区域保持不变 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="组件名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入组件名称"
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
          v-hasPermi="['business:component:add']"
        >新增
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 卡片展示区域保持不变 -->
    <div class="component-card-container">
      <!-- 使用CSS Grid替代Element UI栅格系统 -->
      <div class="card-grid">
        <el-card
          v-for="(item, index) in componentList"
          :key="index"
          class="component-card"
          shadow="hover"
          :class="item.status == 1 ? 'active-status' : 'inactive-status'"
        >
          <!-- 梯形状态标识 -->
          <div class="status-trapezoid" :class="item.status == 1 ? 'active' : 'inactive'">
            {{ item.status == 1 ? '启用' : '停用' }}
          </div>
          <div slot="header" class="card-header">
            <h4 class="component-name">{{ item.name }}</h4>
          </div>
          <div class="card-content">
            <div class="card-item">
              <i>类型：</i>
              <span class="value">{{ item.netType || '未知' }}</span>
            </div>
            <div class="card-item">
              <i>地址：</i>
              <span class="value">{{ item.ipAddr || '未知' }}</span>
            </div>
            <div class="card-item">
              <i>端口：</i>
              <span class="value">{{ item.port || '未知' }}</span>
            </div>
<!--            <div class="card-item">-->
<!--              <i class="el-icon-link"></i>-->
<!--              <span class="value">{{ item.ipAddr }}:{{ item.port }}</span>-->
<!--            </div>-->
<!--            <div class="card-item">-->
<!--              <i class="el-icon-lock"></i>-->
<!--              <span class="value">{{ item.openTls == 1 ? 'TLS开启' : 'TLS关闭' }}</span>-->
<!--            </div>-->
<!--            <div class="card-item">-->
<!--              <i class="el-icon-document"></i>-->
<!--              <span class="value">{{ item.protocolName || '未知协议' }}</span>-->
<!--            </div>-->
          </div>
          <div class="card-actions">
            <!-- 状态切换按钮 -->
            <el-button
              size="mini"
              class="action-btn status-btn"
              :class="item.status == 1 ? 'stop-btn' : 'start-btn'"
              :icon="item.status == 1 ? 'el-icon-switch-button' : 'el-icon-open'"
              @click.stop="toggleStatus(item)"
            >
              {{ item.status == 1 ? '停止' : '启动' }}
            </el-button>
            <el-button
              size="mini"
              class="action-btn edit-btn"
              icon="el-icon-edit"
              @click.stop="handleUpdate(item)"
            >修改
            </el-button>
            <el-button
              size="mini"
              class="action-btn debug-btn"
              icon="el-icon-connection"
              @click.stop="showComponentDetail(item)"
            >调试
            </el-button>
            <el-button
              size="mini"
              class="action-btn delete-btn"
              icon="el-icon-delete"
              @click.stop="handleDelete(item)"
            >删除
            </el-button>
          </div>
        </el-card>
      </div>
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

    <!-- 抽屉组件 -->
    <el-drawer
      :title="title"
      :visible.sync="open"
      direction="rtl"
      size="40%"
      :before-close="cancel"
      class="component-drawer"
    >
      <div class="drawer-content">
        <el-form ref="form" :model="form" :rules="rules" label-width="120px">
          <el-form-item label="组件名称" prop="name">
            <el-input v-model="form.name" placeholder="请输入组件名称"/>
          </el-form-item>
          <el-form-item label="网络类型" prop="netType">
            <el-select v-model="form.netType" placeholder="请选择" @change="handleNetTypeChange">
              <el-option label="MQTT_CLIENT" value="MQTT_CLIENT"></el-option>
              <el-option label="TCP_SERVER" value="TCP_SERVER"></el-option>
            </el-select>
          </el-form-item>
<!--          <el-form-item label="IP地址" prop="ipAddr">-->
<!--            <el-input v-model="form.ipAddr" placeholder="请输入IP地址"/>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="端口" prop="port">-->
<!--            <el-input v-model="form.port" placeholder="请输入端口"/>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="是否开启TLS" prop="openTls">-->
<!--            <el-select v-model="form.openTls" placeholder="请选择">-->
<!--              <el-option label="是" value="1"></el-option>-->
<!--              <el-option label="否" value="0"></el-option>-->
<!--            </el-select>-->
<!--          </el-form-item>-->
          <el-form-item label="状态" prop="status">
            <el-select v-model="form.status" placeholder="请选择">
              <el-option label="启用" value="1"></el-option>
              <el-option label="停用" value="0"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="协议绑定">
            <el-select v-model="selectProtocolId" placeholder="请选择" @change="handleProtocolChange">
              <el-option
                v-for="item in protocolList"
                :key="item.id"
                :label="item.protocolName"
                :value="item.id">
              </el-option>
            </el-select>
          </el-form-item>

          <!-- 动态配置区域 -->
          <div class="dynamic-config-section">
            <div class="section-title">其余配置</div>
            <div class="dynamic-config-fields">
              <!-- MQTT 客户端配置 -->
              <template v-if="form.netType === 'MQTT_CLIENT'">
                <el-form-item label="服务器地址" prop="brokerUrl">
                  <el-input v-model="dynamicConfig.brokerUrl" placeholder="服务器地址"/>
                </el-form-item>
                <el-form-item label="用户名" prop="username">
                  <el-input v-model="dynamicConfig.username" placeholder="请输入用户名"/>
                </el-form-item>
                <el-form-item label="密码" prop="password">
                  <el-input v-model="dynamicConfig.password" type="password" placeholder="请输入密码" show-password/>
                </el-form-item>
                <el-form-item label="订阅主题">
                  <el-input v-model="dynamicConfig.topicStr" placeholder="用英文逗号分割,如：/#,/topic1/#,topic2"/>
                </el-form-item>
                <el-form-item label="Keep Alive(秒)">
                  <el-input-number v-model="dynamicConfig.keepAliveInterval" :min="0" :max="65535"/>
                </el-form-item>
              </template>


              <!-- TCP 服务器配置 -->
              <template v-else-if="form.netType === 'TCP_SERVER'">
                <el-form-item label="端口" prop="serverPort">
                  <el-input v-model="dynamicConfig.serverPort" placeholder="端口"/>
                </el-form-item>
              </template>

              <!-- 默认配置（当没有匹配的类型时） -->
              <template v-else>
                <el-form-item label="自定义配置">
                  <el-input
                    v-model="dynamicConfig.custom"
                    type="textarea"
                    :rows="3"
                    placeholder="请输入自定义配置（JSON格式）"
                  />
                </el-form-item>
              </template>
            </div>
          </div>

          <el-form-item label="备注" prop="remark">
            <el-input v-model="form.remark" type="textarea" placeholder="请输入备注信息"/>
          </el-form-item>
        </el-form>
        <div class="drawer-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </div>
    </el-drawer>

    <!-- 组件详情弹窗保持不变 -->
    <component-detail
      :visible="dialogVisible"
      :component="selectedComponent"
      @close="handleDialogClose"
    />
  </div>
</template>

<script>
import {listComponent, getComponent, delComponent, addComponent, updateComponent,control} from "@/api/business/component"
import {listProtocol} from "@/api/business/protocol";
import ComponentDetail from "@/views/business/component/detail";

export default {
  name: "ComponentView",
  components: {ComponentDetail},
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
      // 网络组件表格数据
      componentList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 12,
        name: null,
        netType: null,
        ipAddr: null,
        port: null,
        openTls: null,
        status: null,
        otherConfig: null,
        protocolId: null,
        protocolName: null
      },
      // 表单参数
      form: {
      },
      config: {},
      // 验证规则
      rules: {
      },
      protocolList: [],
      selectProtocolId:null,
      dialogVisible: false,
      selectedComponent: null, // 可以动态设置组件ID
      // 新增：动态配置对象
      dynamicConfig: {},

    }
  },
  created() {
    this.getList()
    this.getProtocolList()
  },
  methods: {
    /** 查询网络组件列表 */
    getList() {
      this.loading = true
      listComponent(this.queryParams).then(response => {
        this.componentList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    /**获取协议列表*/
    getProtocolList() {
      listProtocol().then(response => {
        this.protocolList = response.rows;
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
        name: null,
        netType: null,
        ipAddr: null,
        port: null,
        openTls: null,
        remark: null,
        createTime: null,
        createBy: null,
        updateTime: null,
        updateBy: null,
        status: null,
        otherConfig: null,
        protocolId: null,
        protocolName: null
      }
      // 重置动态配置
      this.dynamicConfig = {}
    },
    /** 网络类型变化处理 */
    handleNetTypeChange(netType) {
      // 重置动态配置
      this.dynamicConfig = {}

      // 根据网络类型设置默认值
      if (netType === 'MQTT_CLIENT') {
        this.dynamicConfig = {
          brokerUrl: '',
          username: '',
          password: '',
          topicStr: '',
          cleanSession: true,
          keepAliveInterval: 60
        }
      }else if (netType === 'TCP_SERVER') {
        this.dynamicConfig = {
          serverPort: ''
        }
      }
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
      this.form.status = '1'
      this.form.openTls = '0'
      this.title = "添加网络组件"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids[0]
      getComponent(id).then(response => {
        this.form = response.data
        if(this.form.protocolId){
          this.selectProtocolId = this.form?.protocolId
        }
        // 解析 otherConfig 到 dynamicConfig
        if (this.form.otherConfig) {
          try {
            this.dynamicConfig = JSON.parse(this.form.otherConfig)
          } catch (e) {
            this.dynamicConfig = {}
          }
        }

        this.open = true
        this.title = "修改网络组件"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          // MQTT Broker 特殊验证
          if (this.form.netType === 'MQTT_BROKER') {
            // 如果不允许匿名，必须填写用户名密码
            if (this.dynamicConfig.allowAnonymous === false) {
              if (!this.dynamicConfig.username || !this.dynamicConfig.password) {
                this.$modal.msgError('不允许匿名时，用户名和密码为必填项')
                return
              }
            }
          }
          // 将动态配置转换为 JSON 字符串
          this.form.otherConfig = JSON.stringify(this.dynamicConfig)
          this.form.protocolId = this.selectProtocolId
          let protocol = this.protocolList.find(item => item.id === this.form.protocolId)
          this.form.protocolName = protocol.protocolName
          if (this.form.id != null) {
            updateComponent(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addComponent(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除网络组件编号为"' + ids + '"的数据项？').then(function () {
        return delComponent(ids)
      }).then(() => {
        this.getList()
        this.selectedCards = []
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    toggleStatus(item){
      control({id:item.id,status:item.status==1?0:1}).then(res=>{
        if(res?.code==200){
          this.$message.success("操作成功")
          this.getList()
        }
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('business/component/export', {
        ...this.queryParams
      }, `component_${new Date().getTime()}.xlsx`)
    },
    handleProtocolChange(selectedIds) {
      if (!selectedIds || selectedIds.length === 0) {
        this.form.protocolName = ''
      }
    },
    showComponentDetail(component) {
      // 这里可以设置具体的组件ID
      this.selectedComponent = component // 或者从数据中获取
      this.dialogVisible = true
    },

    handleDialogClose() {
      this.dialogVisible = false
      this.selectedComponentId = ''
    }
  }
}
</script>

<style scoped>
.component-card-container {
  margin-bottom: 30px;
}

/* 使用 Grid 布局替代 Element UI 栅格 */
.card-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr); /* 每行4个卡片 */
  gap: 20px;
}

/* 响应式调整 */
@media (max-width: 1200px) {
  .card-grid {
    grid-template-columns: repeat(3, 1fr); /* 每行3个 */
  }
}

@media (max-width: 992px) {
  .card-grid {
    grid-template-columns: repeat(2, 1fr); /* 每行2个 */
  }
}

@media (max-width: 576px) {
  .card-grid {
    grid-template-columns: 1fr; /* 每行1个 */
  }
}

.card-col {
  margin-bottom: 0; /* Grid布局使用gap控制间距 */
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

.component-card {
  width: 100%;
  height: 100%;
  border-radius: 12px;
  overflow: hidden;
  transition: all 0.3s ease;
  position: relative;
  border: 1px solid #e6e8eb;
  background: #fff;
}

.component-card:hover {
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
  border-color: #c0c4cc;
}

/* 启用状态渐变背景 */
.component-card.active-status {
  position: relative;
  overflow: hidden;
}

.component-card.active-status::before {
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
.component-card.inactive-status {
  position: relative;
  overflow: hidden;
}

.component-card.inactive-status::before {
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

.component-name {
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
/* 动态配置区域样式 */
.dynamic-config-section {
  margin: 20px 0;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 8px;
  border: 1px solid #e9ecef;
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 15px;
  padding-bottom: 8px;
  border-bottom: 2px solid #409EFF;
}

.dynamic-config-fields {
  background: white;
  padding: 15px;
  border-radius: 6px;
  border: 1px solid #e6e8eb;
}

/* 响应式调整 */
@media screen and (max-width: 768px) {
  .component-drawer ::v-deep .el-drawer {
    width: 85% !important;
  }

  .dynamic-config-section {
    margin: 15px 0;
    padding: 10px;
  }

  .dynamic-config-fields {
    padding: 10px;
  }
}
</style>
