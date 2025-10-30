<template>
  <div class="product-management">
    <!-- 顶部产品信息区域 -->
    <el-card class="product-info-card" shadow="hover">
      <div class="product-header">
        <div class="title-section">
          <h2 class="product-title">{{ product.productName }}</h2>
          <span class="product-model">{{ product.productSn }}</span>
        </div>
<!--        <el-switch-->
<!--          v-model="product.status==1"-->
<!--          active-text="已启用"-->
<!--          inactive-text="已停用"-->
<!--          active-color="#13ce66"-->
<!--          inactive-color="#ff4949"-->
<!--          @change="handleStatusChange"-->
<!--        />-->
      </div>

      <el-row :gutter="24" class="product-stats">
        <el-col :xs="12" :sm="6">
          <div class="stat-item">
            <div class="stat-icon">
              <i class="el-icon-cpu"></i>
            </div>
            <div class="stat-content">
              <div class="stat-label">设备数量</div>
              <div class="stat-value">{{ product.deviceCount }}</div>
            </div>
          </div>
        </el-col>
        <el-col :xs="12" :sm="6">
          <div class="stat-item">
            <div class="stat-icon online">
              <i class="el-icon-success"></i>
            </div>
            <div class="stat-content">
              <div class="stat-label">在线设备</div>
              <div class="stat-value">10</div>
            </div>
          </div>
        </el-col>
        <el-col :xs="12" :sm="6">
          <div class="stat-item">
            <div class="stat-icon">
              <i class="el-icon-s-management"></i>
            </div>
            <div class="stat-content">
              <div class="stat-label">产品型号</div>
              <div class="stat-value">{{ product.productSn }}</div>
            </div>
          </div>
        </el-col>
        <el-col :xs="12" :sm="6">
          <div class="stat-item">
            <div class="stat-icon">
              <i class="el-icon-time"></i>
            </div>
            <div class="stat-content">
              <div class="stat-label">创建日期</div>
              <div class="stat-value">{{ formatDate(product.createTime) }}</div>
            </div>
          </div>
        </el-col>
      </el-row>
    </el-card>

    <!-- 底部Tab切换区域 -->
    <el-card class="tab-card" shadow="hover">
      <el-tabs v-model="activeTab" @tab-click="handleTabClick" class="custom-tabs">
        <!-- 物模型部分 -->
        <el-tab-pane label="物模型" name="thingModel">
          <div class="tab-content">
            <div class="tab-header">
              <div class="tab-title">物模型管理</div>
              <div class="tab-actions">
                <el-button type="primary" icon="el-icon-plus" class="action-btn" @click="addThingModel">添加属性</el-button>
                <el-button type="primary" icon="el-icon-check" class="action-btn" @click="saveThingModel">全部保存
                </el-button>
                <el-button type="primary" icon="el-icon-refresh-right" class="action-btn" @click="syncThingModel">
                  同步到设备
                </el-button>
              </div>
            </div>

            <el-table
              :data="thingModelData"
              style="width: 100%"
              class="data-table"
              stripe
              border
            >
              <!-- 属性名称 - 可编辑 -->
              <el-table-column prop="name" label="属性名称" width="180">
                <template slot-scope="scope">
                  <el-input
                    v-model="scope.row.name"
                    size="mini"
                    placeholder="请输入功能名称"
                  />
                </template>
              </el-table-column>

              <!-- 标识符 - 可编辑 -->
              <el-table-column prop="identifier" label="标识符" width="180">
                <template slot-scope="scope">
                  <el-input
                    v-model="scope.row.identifier"
                    size="mini"
                    placeholder="请输入标识符"
                  />
                </template>
              </el-table-column>

              <!-- 数据类型 - 下拉选择 -->
              <el-table-column prop="type" label="数据类型" width="120">
                <template slot-scope="scope">
                  <el-select
                    v-model="scope.row.dataType"
                    size="mini"
                    placeholder="选择类型"
                  >
                    <el-option label="整数" value="int"/>
                    <el-option label="浮点数" value="float"/>
                    <el-option label="布尔值" value="bool"/>
                    <el-option label="字符串" value="string"/>
                    <!--                    <el-option label="枚举" value="enum" />-->
                    <el-option label="结构体" value="struct"/>
                  </el-select>
                </template>
              </el-table-column>
              <!-- 单位 - 可编辑 -->
              <el-table-column prop="description" label="单位" width="180">
                <template slot-scope="scope">
                  <el-input
                    v-model="scope.row.unit"
                    size="mini"
                    placeholder="请输入单位"
                  />
                </template>
              </el-table-column>
              <!-- 描述 - 可编辑 -->
              <el-table-column prop="description" label="描述">
                <template slot-scope="scope">
                  <el-input
                    v-model="scope.row.remark"
                    size="mini"
                    placeholder="请输入描述"
                  />
                </template>
              </el-table-column>

              <!-- 操作列 -->
              <el-table-column label="操作" width="200" fixed="right">
                <template slot-scope="scope">
                  <el-button
                    size="mini"
                    icon="el-icon-delete"
                    type="danger"
                    @click="deleteThingModel(scope.$index)"
                    class="table-action"
                  >删除
                  </el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>
        </el-tab-pane>

        <el-tab-pane label="指令下发" name="functionConfig">
          <div class="tab-content">
            <div class="tab-header">
              <div class="tab-title">指令下发配置</div>
              <div class="button-group">
                <el-button type="primary" icon="el-icon-plus" class="action-btn" @click="addFunction">添加指令
                </el-button>
                <el-button type="primary" icon="el-icon-refresh-right" class="action-btn"
                           @click="syncProductFunctionToDevice">同步到所有设备
                </el-button>
              </div>
            </div>
            <el-table :data="functionList" style="width: 100%" class="data-table" stripe>
              <el-table-column prop="functionName" label="指令名称" width="200"/>
              <el-table-column prop="functionCode" label="指令编码" width="200"/>
              <el-table-column prop="functionParams" label="自定义参数" width="200"/>
              <el-table-column prop="createTime" label="创建时间">
                <template slot-scope="scope">
                  <code class="condition-code">{{ formatDate(scope.row) }}</code>
                </template>
              </el-table-column>
              <el-table-column label="操作" width="180" fixed="right">
                <template slot-scope="scope">
                  <el-button size="mini" icon="el-icon-edit" @click="editFunction(scope.row)" class="table-action">编辑
                  </el-button>
                  <el-button size="mini" icon="el-icon-delete" type="danger" @click="deleteFunction(scope.row)"
                             class="table-action">删除
                  </el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>

          <!-- 添加/编辑告警规则弹窗 -->
          <el-dialog :title="functionIsEditing ? '编辑指令' : '添加指令'" :visible.sync="functionDialogVisible" width="800px">
            <el-form :model="currentFunction" label-width="100px">
              <el-form-item label="指令名称" required>
                <el-input v-model="currentFunction.functionName" placeholder="请输入指令名称"></el-input>
              </el-form-item>
              <el-form-item label="指令编码" required>
                <el-input v-model="currentFunction.functionCode" placeholder="请输入指令编码"></el-input>
              </el-form-item>
              <el-form-item label="自定义参数">
                <el-input v-model="currentFunction.functionParams" placeholder="请输入自定义参数"></el-input>
              </el-form-item>
            </el-form>

            <div slot="footer" class="dialog-footer">
              <el-button @click="dialogVisible = false">取 消</el-button>
              <el-button type="primary" @click="saveFunction">确 定</el-button>
            </div>
          </el-dialog>
        </el-tab-pane>

        <el-tab-pane label="告警配置" name="alarmConfig">
          <div class="tab-content">
            <div class="tab-header">
              <div class="tab-title">告警规则配置</div>
              <div class="button-group">
                <el-button type="primary" icon="el-icon-plus" class="action-btn" @click="addAlarmRule">添加告警规则
                </el-button>
                <el-button type="primary" icon="el-icon-refresh-right" class="action-btn"
                           @click="syncAlarmRuleToDevice">同步到所有设备
                </el-button>
              </div>
            </div>
            <el-table :data="alarmRules" style="width: 100%" class="data-table" stripe>
              <el-table-column prop="name" label="规则名称" width="200"/>
              <el-table-column prop="condition" label="触发条件">
                <template slot-scope="scope">
                  <code class="condition-code">{{ formatCondition(scope.row) }}</code>
                </template>
              </el-table-column>
              <el-table-column prop="level" label="告警级别" width="100">
                <template slot-scope="scope">
                  <el-tag :type="getLevelType(scope.row.level)" effect="dark" class="level-tag">
                    {{ getLevelText(scope.row.level) }}
                  </el-tag>
                </template>
              </el-table-column>
              <el-table-column prop="enable" label="状态" width="120">
                <template slot-scope="scope">
                  <el-switch
                    v-model="scope.row.enable"
                    @change="toggleAlarmRule(scope.row)"
                    active-color="#13ce66"
                    inactive-color="#ff4949"
                  />
                </template>
              </el-table-column>
              <el-table-column label="操作" width="180" fixed="right">
                <template slot-scope="scope">
                  <el-button size="mini" icon="el-icon-edit" @click="editAlarmRule(scope.row)" class="table-action">编辑
                  </el-button>
                  <el-button size="mini" icon="el-icon-delete" type="danger" @click="deleteAlarmRule(scope.row)"
                             class="table-action">删除
                  </el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>

          <!-- 添加/编辑告警规则弹窗 -->
          <el-dialog :title="isEditing ? '编辑告警规则' : '添加告警规则'" :visible.sync="dialogVisible" width="800px">
            <el-form :model="currentRule" label-width="100px">
              <el-form-item label="告警名称">
                <el-input v-model="currentRule.name" placeholder="请输入告警规则名称"></el-input>
              </el-form-item>

              <el-form-item label="告警条件">
                <div v-for="(condition, index) in currentRule.conditions" :key="index" class="rule-condition">
                  <div class="condition-row">
                    <el-select v-model="condition.attribute" placeholder="选择属性" style="width: 180px;">
                      <el-option v-for="attr in attributeOptions" :key="attr.identifier" :label="attr.name"
                                 :value="attr.identifier"></el-option>
                    </el-select>
                    <el-select v-model="condition.operator" placeholder="选择规则" style="width: 120px; margin-left: 10px;">
                      <el-option v-for="op in operatorOptions" :key="op.value" :label="op.label"
                                 :value="op.value"></el-option>
                    </el-select>
                    <el-input v-model="condition.value" placeholder="输入值"
                              style="width: 180px; margin-left: 10px;"></el-input>
                    <el-button v-if="currentRule.conditions.length > 1" type="danger" icon="el-icon-delete" circle
                               style="margin-left: 10px;" @click="removeCondition(index)"></el-button>
                  </div>

                  <!-- 关系选择按钮（仅在不是最后一个条件时显示） -->
                  <div v-if="index < currentRule.conditions.length - 1" class="relation-buttons">
                    <el-radio-group v-model="currentRule.relation" size="mini">
                      <el-radio-button label="and">并且</el-radio-button>
                      <el-radio-button label="or">或者</el-radio-button>
                    </el-radio-group>
                  </div>
                </div>

                <div style="margin-top: 10px;">
                  <el-button type="primary" icon="el-icon-plus" @click="addCondition">添加条件</el-button>
                </div>
              </el-form-item>

              <el-form-item label="告警级别">
                <el-radio-group v-model="currentRule.level">
                  <el-radio label="1">紧急</el-radio>
                  <el-radio label="2">严重</el-radio>
                  <el-radio label="3">警告</el-radio>
                  <el-radio label="4">正常</el-radio>
                </el-radio-group>
              </el-form-item>

              <el-form-item label="重复告警">
                <el-input type="number" v-model="currentRule.delayTime" style="width: 100px"/>
                秒内不重复告警
              </el-form-item>

              <el-form-item label="告警消息">
                <el-input type="textarea" v-model="currentRule.message" placeholder="请输入告警消息"></el-input>
              </el-form-item>

            </el-form>

            <div slot="footer" class="dialog-footer">
              <el-button @click="dialogVisible = false">取 消</el-button>
              <el-button type="primary" @click="saveAlarmRule">确 定</el-button>
            </div>
          </el-dialog>
        </el-tab-pane>

        <el-tab-pane label="其他配置" name="otherConfig">
          <div class="tab-content">
            <div class="tab-header">
              <div class="tab-title">其他配置</div>
            </div>

            <!-- 配置项列表 -->
            <div class="config-list">
              <!-- 数据定期删除配置 -->
              <div class="config-item">
                <div class="config-info">
                  <div class="config-title">
                    <span class="title-text">数据定期删除</span>
                    <el-tooltip
                      content="开启后系统将自动清理超过保留时间的数据，释放存储空间"
                      placement="top">
                      <i class="el-icon-info config-tip"></i>
                    </el-tooltip>
                  </div>
                  <div class="config-desc">定期清理过期数据，优化系统性能</div>
                </div>

                <div class="config-controls">
                  <el-switch
                    v-model="regularCleaningBoolean"
                    active-text="开启"
                    inactive-text="关闭"
                    active-color="#13ce66">
                  </el-switch>

                  <div v-if="regularCleaningBoolean" class="retention-config">
                    <span class="retention-label">保留时间：</span>
                    <el-input-number
                      v-model="retentionTime"
                      :min="1"
                      size="small"
                      controls-position="right"
                      class="retention-input">
                    </el-input-number>
                    <el-select
                      v-model="retentionUnit"
                      size="small"
                      class="unit-select gray-select">
                      <el-option label="时" value="hour"></el-option>
                      <el-option label="天" value="day"></el-option>
                      <el-option label="周" value="week"></el-option>
                      <el-option label="月" value="month"></el-option>
                      <el-option label="年" value="year"></el-option>
                    </el-select>
                  </div>
                </div>

                <!-- 单行保存按钮 -->
                <div class="item-actions">
                  <el-button
                    size="small"
                    type="primary"
                    icon="el-icon-check"
                    @click="saveRegularCleaningConfig">
                    保存
                  </el-button>
                  <el-button
                    size="small"
                    type="success"
                    icon="el-icon-refresh-right"
                    @click="saveAndSyncRegularCleaningConfig">
                    保存并同步到设备
                  </el-button>
                </div>
              </div>
              <!-- 自定义配置 -->
              <div class="config-item">
                <div class="config-info">
                  <div class="config-title">
                    <span class="title-text">自定义配置</span>
                    <el-tooltip
                      content="开启后系统将自动清理超过保留时间的数据，释放存储空间"
                      placement="top">
                      <i class="el-icon-info config-tip"></i>
                    </el-tooltip>
                  </div>
                  <div class="config-desc">自定义配置，作为协议参数传递给解析方法</div>
                </div>
                <div class="config-input">
                  <el-input placeholder="如IP、端口、设备特殊配置等" v-model="customConfig"></el-input>
                </div>
                <!-- 单行保存按钮 -->
                <div class="item-actions">
                  <el-button
                    size="small"
                    type="primary"
                    icon="el-icon-check"
                    @click="saveCustomConfig">
                    保存
                  </el-button>
                  <el-button
                    size="small"
                    type="success"
                    icon="el-icon-refresh-right"
                    @click="syncCustomConfigToDevice">
                    保存并同步到设备
                  </el-button>
                </div>
              </div>
            </div>
          </div>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import {getProduct, syncProperties, syncRetentionTimeToDevice, updateProduct,syncCustomConfigToDevice} from "@/api/business/product"
import {
  listProperties,
  getProperties,
  delProperties,
  addProperties,
  updateProperties,
  saveBatch,
  getPropertyBySn
} from "@/api/business/properties"
import {
  addWarnConfig,
  delWarnConfig,
  listWarnConfig,
  toggleRuleStatus,
  updateWarnConfig
} from "@/api/business/warnConfig";
import {listWarnRecord} from "@/api/business/warnRecord";
import {syncWarnConfigToDevice} from "@/api/business/warnConfig";
import {listFunction,getFunction,delFunction,addFunction,updateFunction,downFunction,syncProductToDevice} from "@/api/business/function";
export default {
  name: 'ProductDetail',
  created() {
    this.productId = this.$route.query.id
    this.getProductById(this.productId);
  },
  data() {
    return {
      productId: '',
      activeTab: 'thingModel',
      product: {
        id: '',
        productName: '',
        status: '0',
        deviceCount: 156,
        createTime: '',
        productSn: ''
      },
      thingModelData: [],
      dateRange: [],
      alarmLevel: '',
      alarmStatus: '',
      pagination: {
        current: 1,
        size: 10,
        total: 3
      },
      // 属性查询参数
      propertyParams: {
        pageNum: 1,
        pageSize: 1000,
        belongSn: null,
        belongType: null,
        identifier: null,
        name: null,
        parentId: null,
        dataType: null,
        sortNum: null,
        fromType: null
      },
      alarmRules: [],
      dialogVisible: false,
      isEditing: false,
      currentRule: {
        id: null,
        name: '',
        conditions: [{attribute: '', operator: '', value: ''}],
        relation: 'and',
        level: '1',
        message: '',
        actions: [{functionCode: '', functionParams: '', functionName: ''}],
        enable: true,
        belongSn: ''
      },
      attributeOptions: [],
      operatorOptions: [
        {label: '大于', value: 'gt'},
        {label: '大于等于', value: 'ge'},
        {label: '等于', value: 'eq'},
        {label: '不等于', value: 'ne'},
        {label: '小于', value: 'lt'},
        {label: '小于等于', value: 'le'},
        {label: '包含', value: 'contains'},
        {label: '不包含', value: 'notContains'},
        {label: '被包含', value: 'like'},
        {label: '不被包含', value: 'notLike'},
        {label: '在列表中', value: 'in'},
        {label: '不在列表中', value: 'notIn'}
      ],
      actionOptions: [
      ],
      // 属性查询参数
      warnRecordParams: {
        warnLevel: null,
        status: null,
        configName: null,
        belongSn: null,
        rangeDate: null
      },
      // 数据定期删除配置
      regularCleaning: "1",
      retentionTime: 24,
      retentionUnit: 'day',
      // 其他配置示例
      logLevel: 'info',
      autoBackupEnabled: true,
      functionList:[],
      functionDialogVisible: false,
      functionIsEditing: false,
      currentFunction:{
        id:null,
        functionName:null,
        functionCode:null,
        functionParams:null,
        belongSn:null,
        belongType:0
      },
      customConfig:null
    }
  },
  computed: {
    // 前端显示的布尔值
    regularCleaningBoolean: {
      get() {
        return this.regularCleaning === "1";
      },
      set(value) {
        this.regularCleaning = value ? "1" : "0";
      }
    }
  },
  methods: {
    handleStatusChange(value) {
      console.log(value)
      this.$message.success(value ? '产品已启用' : '产品已停用')
    },
    getProductById(productId) {
      getProduct(productId).then(res => {
        this.product = res.data
        this.getPropertyList();
        this.getPropertyByProductSn();
      })
    },
    getPropertyList() {
      this.propertyParams.belongSn = this.product.productSn;
      listProperties(this.propertyParams).then(res => {
        this.thingModelData = res.rows
      })
    },
    formatDate(dateString) {
      if (!dateString) return ''
      const date = new Date(dateString)
      const year = date.getFullYear()
      const month = String(date.getMonth() + 1).padStart(2, '0')
      const day = String(date.getDate()).padStart(2, '0')
      const hours = String(date.getHours()).padStart(2, '0')
      const minutes = String(date.getMinutes()).padStart(2, '0')
      const seconds = String(date.getSeconds()).padStart(2, '0')

      return `${year}-${month}-${day}`
    },
    syncCustomConfigToDevice(){
      syncCustomConfigToDevice({customConfig:this.customConfig,productSn:this.product.productSn}).then(res=>{
        if(res?.code==200){
          this.$message.success("同步成功")
        }else {
          this.$message.error(res?.msg)
        }
      })
    },
    handleTabClick(tab) {
      //告警配置页面
      if (tab.name === 'alarmConfig') {
        //初始化数据
        this.getWarnConfigList();
      }
      //告警记录页面
      if (tab.name === 'alarmRecord') {
        //初始化数据
        this.getWarnRecordList();
      }
      //其他配置页面
      if (tab.name === 'otherConfig') {
        //初始化数据
        this.retentionUnit = this.product.retentionUnit ? this.product.retentionUnit : "day";
        this.retentionTime = this.product.retentionTime;
        this.regularCleaning = this.product.regularCleaning;
        this.customConfig = this.product.customConfig
      }
      //指令下发配置
      if (tab.name === 'functionConfig') {
        //初始化数据
        this.getFunctionList();
      }
    },
    //指令下发列表查询
    getFunctionList(){
      listFunction({pageNum:1,pageSize: 10000,belongSn:this.product.productSn}).then(res=>{
        this.functionList = res?.rows;
      })
    },
    //同步产品指令配置到设备
    syncProductFunctionToDevice(){
      syncProductToDevice({belongSn:this.product.productSn}).then(res=>{
        if(res?.code==200){
          this.$message.success("同步成功");
        }
      })
    },
    // 编辑物模型
    editThingModel(row) {
      // 先取消其他行的编辑状态
      this.thingModelData.forEach(item => {
        if (item.editing && item !== row) {
          item.editing = false;
        }
      });
      // 设置当前行为编辑状态
      row.editing = true;
      // 保存原始数据用于取消编辑时恢复
      this.$set(row, 'originalData', {...row});
    },
    getPropertyByProductSn() {
      getPropertyBySn(this.product.productSn).then(res => {
        this.attributeOptions = res.data;
      })
    },
    // 保存物模型
    saveThingModel() {
      //校验数据完整性
      for (let i = 0; i < this.thingModelData.length; i++) {
        let current = this.thingModelData[i]
        if (!current.identifier || !current.name || !current.dataType) {
          this.$message.error("请将信息填写完整再提交");
          return
        }
      }
      const data = {belongSn: this.product.productSn, belongType: "0", propertyList: this.thingModelData, fromType: "0"}
      saveBatch(data).then(response => {
        this.$modal.msgSuccess("新增成功")
        this.getPropertyList()
      });
    },
    syncThingModel() {
      syncProperties({productSn: this.product.productSn}).then(res => {
        this.$message.success("同步成功");
      })
    },
    formatCondition(rule) {
      const conditionStrings = rule.conditions.map(cond => {
        const attr = this.attributeOptions.find(a => a.identifier === cond.attribute)?.name || cond.attribute;
        const op = this.operatorOptions.find(o => o.value === cond.operator)?.label || cond.operator;
        return `${attr} ${op} ${cond.value}`;
      });

      const relation = rule.relation === 'and' ? '并且' : '或者';
      return conditionStrings.join(` ${relation} `);
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
    // 取消编辑
    cancelEdit(row) {
      if (row.originalData) {
        Object.assign(row, row.originalData);
        delete row.originalData;
      }
      row.editing = false;
      this.$message.info('已取消编辑');
    },

    // 添加新的物模型属性
    addThingModel() {
      const newItem = {
        name: '',
        identifier: '',
        type: 'string',
        accessMode: '',
        description: '',
        editing: true
      };
      this.thingModelData.unshift(newItem);
      // this.$message.info('添加新属性，请编辑详细信息');
    },

    addService() {
      this.$message.info('添加服务功能')
    },

    addEvent() {
      this.$message.info('添加事件功能')
    },
    deleteThingModel(index) {
      this.$confirm('确定删除此物模型?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.thingModelData.splice(index, 1);
        this.$message.success('删除成功');
      });
    },

    //直接查询所有规则
    getWarnConfigList() {
      //初始化数据
      listWarnConfig({belongSn: this.product.productSn, pageNum: 1, pageSize: 10000}).then(res => {
        this.alarmRules = [];
        for (let i = 0; i < res?.rows.length; i++) {
          this.alarmRules.push(JSON.parse(res?.rows[i].ruleJson));
        }
      })
    },
    //查询告警记录
    getWarnRecordList() {
      this.warnRecordParams.belongSn = this.product.productSn
      listWarnRecord({
        pageNum: this.pagination.current,
        pageSize: this.pagination.size, ...this.warnRecordParams
      }).then(res => {
        if (res?.code === 200) {
          this.alarmRecords = res?.rows;
          this.pagination.total = res?.total;
        } else {
          this.$message.error(res?.msg);
        }
      })
    },
    addAlarmRule() {
      this.isEditing = false;
      this.currentRule = {
        id: null,
        name: '',
        conditions: [{attribute: '', operator: '', value: ''}],
        relation: 'and',
        level: '1',
        message: '',
        actions: [],
        enable: true,
        belongSn: this.product.productSn,
        belongType: '0',
        delayTime: 0
      };
      this.dialogVisible = true;
      this.getFunctionList();
    },

    addFunction() {
      this.functionIsEditing = false;
      this.currentFunction = {};
      this.functionDialogVisible = true;
    },
    //同步告警配置到所有设备
    syncAlarmRuleToDevice() {
      this.$confirm('确定同步到设备吗，该操作将覆盖设备现有规则?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        syncWarnConfigToDevice(this.product.productSn).then(res => {
          if (res?.code === 200) {
            this.getWarnConfigList();
            this.$message.success('同步成功');
          }
        })
      });
    },
    editAlarmRule(rule) {
      this.isEditing = true;
      this.currentRule = JSON.parse(JSON.stringify(rule));
      this.dialogVisible = true;
      this.getFunctionList();
    },
    editFunction(data) {
      this.functionIsEditing = true;
      this.currentFunction = data;
      this.functionDialogVisible = true;
    },
    saveAlarmRule() {
      // 验证表单
      if (!this.currentRule.name) {
        this.$message.error('请输入告警规则名称');
        return;
      }

      if (!this.currentRule.conditions.every(c => c.attribute && c.operator && c.value)) {
        this.$message.error('请完善所有告警条件');
        return;
      }

      if (!this.currentRule.message) {
        this.$message.error('请输入告警消息');
        return;
      }

      // if (!this.currentRule.actions.every(a => a.type && a.params)) {
      //   this.$message.error('请完善所有执行动作');
      //   return;
      // }

      if (this.isEditing) {
        // 更新现有规则
        updateWarnConfig(this.currentRule).then(res => {
          if (res?.code === 200) {
            this.getWarnConfigList();
          }
        });
      } else {
        // 添加新规则
        addWarnConfig(this.currentRule).then(res => {
          if (res?.code === 200) {
            this.getWarnConfigList();
          }
        });
      }
      this.dialogVisible = false;
      this.$message.success(this.isEditing ? '规则更新成功' : '规则添加成功');
    },

    saveFunction() {
      this.currentFunction.belongSn = this.product.productSn
      this.currentFunction.belongType = 0
      if (this.functionIsEditing) {
        // 更新现有指令
        updateFunction(this.currentFunction).then(res => {
          if (res?.code === 200) {
            this.getFunctionList();
          }
        });
      } else {
        // 添加新指令
        addFunction(this.currentFunction).then(res => {
          if (res?.code === 200) {
            this.getFunctionList();
          }
        });
      }
      this.functionDialogVisible = false;
      this.$message.success(this.functionIsEditing ? '更新成功' : '添加成功');
    },
    deleteAlarmRule(rule) {
      this.$confirm('确定要删除这条告警规则吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        delWarnConfig(rule.id).then(res => {
          if (res?.code === 200) {
            this.getWarnConfigList();
            this.$message.success('删除成功');
          }
        })
      });
    },
    deleteFunction(data) {
      this.$confirm('确定要删除这条指令配置吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        delFunction(data.id).then(res => {
          if (res?.code === 200) {
            this.getFunctionList();
            this.$message.success('删除成功');
          }
        })
      });
    },
    toggleAlarmRule(rule) {
      toggleRuleStatus(rule).then(res => {
        if (res?.code === 200) {
          this.$message.success(`规则 ${rule.enable ? '启用' : '禁用'} 成功`);
        }
      })
    },
    addCondition() {
      this.currentRule.conditions.push({attribute: '', operator: '', value: ''});
    },
    removeCondition(index) {
      if (this.currentRule.conditions.length > 1) {
        this.currentRule.conditions.splice(index, 1);
      }
    },
    searchAlarms() {
      this.$message.info('查询告警记录')
    },

    viewAlarmDetail(row) {
      this.$message.info(`查看告警详情: ${row.alarmName}`)
    },

    resolveAlarm(row) {
      this.$confirm('标记此告警为已处理?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        row.status = 'resolved'
        this.$message.success('操作成功')
      })
    },

    handlePageChange(page) {
      this.pagination.current = page
      this.$message.info(`切换到第${page}页`)
    },
    saveRegularCleaningConfig() {
      updateProduct({
        id: this.product.id,
        retentionTime: this.retentionTime,
        regularCleaning: this.regularCleaning,
        retentionUnit: this.retentionUnit
      }).then(res => {
        if (res?.code == 200) {
          this.$message.success('保存成功')
        }
      })
    },
    saveCustomConfig() {
      updateProduct({
        id: this.product.id,
        customConfig: this.customConfig,
      }).then(res => {
        if (res?.code == 200) {
          this.$message.success('保存成功')
        }
      })
    },
    saveAndSyncRegularCleaningConfig() {
      syncRetentionTimeToDevice({
        productSn: this.product.productSn,
        retentionTime: this.retentionTime,
        regularCleaning: this.regularCleaning,
        retentionUnit: this.retentionUnit
      }).then(res => {
        if (res?.code == 200) {
          this.$message.success('保存并同步成功')
        }
      })
    }
  }
}
</script>

<style scoped>
.product-management {
  padding: 24px;
  background: linear-gradient(135deg, #f5f7fa 0%, #e4e7ed 100%);
  min-height: 100vh;
}

.product-info-card {
  margin-bottom: 24px;
  border-radius: 12px;
  border: none;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  background: #fff;
}

.product-info-card:hover {
  box-shadow: 0 6px 24px rgba(0, 0, 0, 0.12);
  transform: translateY(-2px);
}

.product-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  padding-bottom: 20px;
  border-bottom: 1px solid #ebeef5;
}

.title-section {
  display: flex;
  flex-direction: column;
}

.product-title {
  margin: 0;
  font-size: 28px;
  font-weight: 700;
  color: #303133;
  background: linear-gradient(135deg, #000000 0%, #66B1FF 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.product-model {
  font-size: 20px;
  color: #2323c7;
  margin-top: 4px;
}

.product-stats {
  margin-top: 16px;
}

.stat-item {
  display: flex;
  align-items: center;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 8px;
  transition: all 0.3s ease;
  border-left: 4px solid #409EFF;
}

.stat-item:hover {
  background: #edf2ff;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.15);
}

.stat-icon {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: #ecf5ff;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 16px;
  font-size: 20px;
  color: #409EFF;
}

.stat-icon.online {
  background: #f0f9ff;
  color: #67C23A;
}

.stat-content {
  flex: 1;
}

.stat-label {
  font-size: 14px;
  color: #909399;
  margin-bottom: 4px;
  font-weight: 500;
}

.stat-value {
  font-size: 28px;
  font-weight: 700;
  color: #303133;
  letter-spacing: -0.5px;
}

.tab-card {
  border-radius: 12px;
  border: none;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  background: #fff;
}

.tab-card:hover {
  box-shadow: 0 6px 24px rgba(0, 0, 0, 0.12);
}

.custom-tabs {
  border-radius: 12px;
}

.custom-tabs >>> .el-tabs__header {
  margin-bottom: 0;
  background: #fafbfc;
  border-radius: 12px 12px 0 0;
  padding: 0 24px;
}

.custom-tabs >>> .el-tabs__nav-wrap::after {
  height: 1px;
  background-color: #ebeef5;
}

.custom-tabs >>> .el-tabs__item {
  height: 56px;
  line-height: 56px;
  font-size: 15px;
  font-weight: 500;
  color: #606266;
  transition: all 0.3s ease;
}

.custom-tabs >>> .el-tabs__item.is-active {
  color: #409EFF;
  font-weight: 600;
}

.custom-tabs >>> .el-tabs__active-bar {
  height: 3px;
  border-radius: 2px;
  background: linear-gradient(135deg, #409EFF 0%, #66B1FF 100%);
}

.tab-content {
  padding: 24px;
}

.tab-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.tab-title {
  font-size: 20px;
  font-weight: 600;
  color: #303133;
  position: relative;
  padding-left: 12px;
}

.tab-title::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 4px;
  height: 20px;
  background: linear-gradient(135deg, #409EFF 0%, #66B1FF 100%);
  border-radius: 2px;
}

.action-btn {
  border-radius: 8px;
  padding: 10px 16px;
  font-weight: 500;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(64, 158, 255, 0.2);
}

.action-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
}

.data-table {
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.data-table >>> .el-table__header {
  background: #f5f7fa;
}

.data-table >>> .el-table__row:hover {
  background-color: #f5f7fa !important;
}

.table-action {
  border-radius: 6px;
  padding: 6px 12px;
  font-size: 12px;
  transition: all 0.3s ease;
}

.table-action:hover {
  transform: translateY(-1px);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.config-alert {
  border-radius: 8px;
  margin-bottom: 24px;
  border: 1px solid #ebeef5;
}

.config-form {
  max-width: 800px;
}

.config-select, .config-input {
  width: 300px;
}

.config-input >>> .el-input-group__prepend,
.config-input >>> .el-input-group__append {
  background: #f5f7fa;
  color: #606266;
}

.form-actions {
  margin-top: 32px;
  padding-top: 24px;
  border-top: 1px solid #ebeef5;
}

.save-btn, .reset-btn {
  border-radius: 8px;
  padding: 10px 20px;
  font-weight: 500;
  transition: all 0.3s ease;
}

.save-btn {
  box-shadow: 0 2px 8px rgba(64, 158, 255, 0.2);
}

.save-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
}

.filter-bar {
  background: #f8f9fa;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 20px;
}

.filter-form {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
}

.filter-date, .filter-select {
  width: 200px;
}

.search-btn {
  border-radius: 8px;
  padding: 10px 20px;
  font-weight: 500;
}

.condition-code {
  background: #f5f7fa;
  padding: 4px 8px;
  border-radius: 4px;
  font-family: 'Courier New', monospace;
  color: #e74c3c;
}

.level-tag {
  border-radius: 4px;
  font-weight: 500;
}

.pagination {
  margin-top: 24px;
  display: flex;
  justify-content: flex-end;
}

@media (max-width: 768px) {
  .product-management {
    padding: 16px;
  }

  .product-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 16px;
  }

  .tab-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 16px;
  }

  .filter-form {
    flex-direction: column;
  }

  .filter-date, .filter-select {
    width: 100%;
  }
}

.button-group {
  display: flex;
  gap: 10px;
}

.config-list {
  background: #fff;
  border-radius: 6px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
  overflow: hidden;
  margin-bottom: 24px;
}

.config-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 24px;
  border-bottom: 1px solid #f0f0f0;
  transition: background-color 0.3s;
  gap: 16px;
}

.config-item:hover {
  background-color: #fafafa;
}

.config-item:last-child {
  border-bottom: none;
}

.config-info {
  flex: 1;
  min-width: 0;
}

.config-title {
  display: flex;
  align-items: center;
  margin-bottom: 6px;
}

.title-text {
  font-size: 15px;
  font-weight: 500;
  color: #303133;
}

.config-tip {
  margin-left: 6px;
  color: #c0c4cc;
  cursor: pointer;
  transition: color 0.3s;
}

.config-tip:hover {
  color: #409eff;
}

.config-desc {
  font-size: 13px;
  color: #909399;
  line-height: 1.4;
}

.config-controls {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
}
.config-input{
  display: flex;
  flex-wrap: wrap;
  max-width: 100%;
}
.retention-config {
  display: flex;
  align-items: center;
  margin-left: 16px;
  padding-left: 16px;
  border-left: 1px solid #e8e8e8;
}

.retention-label {
  font-size: 13px;
  color: #606266;
  white-space: nowrap;
}

.retention-input {
  width: 100px;
}

.retention-unit {
  font-size: 13px;
  color: #909399;
  margin-left: 6px;
}

/* 单行操作按钮样式 */
.item-actions {
  display: flex;
  gap: 8px;
  flex-shrink: 0;
}

.item-actions .el-button {
  border-radius: 4px;
  font-weight: 500;
  min-width: 80px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .tab-content {
    padding: 16px;
  }

  .config-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 16px;
  }

  .config-controls {
    width: 100%;
    justify-content: space-between;
  }

  .item-actions {
    width: 100%;
    justify-content: flex-end;
  }

  .item-actions .el-button {
    flex: 1;
  }
}

/* 灰色下拉框样式 */
.unit-select {
  width: 60px;
}

.gray-select ::v-deep .el-input__inner {
  background-color: #f5f7fa;
  border-color: #e4e7ed;
  color: #606266;
}

.gray-select ::v-deep .el-input__inner:hover {
  border-color: #c0c4cc;
  background-color: #f0f2f5;
}

.gray-select ::v-deep .el-input__inner:focus {
  border-color: #c0c4cc;
  background-color: #f5f7fa;
}

.gray-select ::v-deep .el-input__suffix {
  color: #909399;
}

/* 下拉选项样式 */
.gray-select ::v-deep .el-select-dropdown {
  border: 1px solid #e4e7ed;
}

.gray-select ::v-deep .el-select-dropdown__item {
  color: #606266;
}

.gray-select ::v-deep .el-select-dropdown__item:hover {
  background-color: #f5f7fa;
  color: #606266;
}

.gray-select ::v-deep .el-select-dropdown__item.selected {
  background-color: #f0f2f5;
  color: #606266;
  font-weight: normal;
}
</style>
