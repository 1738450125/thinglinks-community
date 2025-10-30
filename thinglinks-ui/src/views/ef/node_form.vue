<template>
  <div>
    <div class="ef-node-form">
      <div class="ef-node-form-header">
        编辑
      </div>
      <div class="ef-node-form-body">
        <el-form :model="node" ref="dataForm" label-width="80px" v-show="type === 'node'">
          <el-form :model="configData" ref="configForm" label-width="80px" v-show="componentType === 'deviceLog'">
            <el-form-item label="产品范围" required>
              <el-select v-model="configData.productScope" multiple @change="getDeviceByProductSnList">
                <el-option v-for="item in configData.productList"
                           :label="item.productName"
                           :value="item.productSn"
                           :key="item.productSn"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="设备范围" required>
              <el-radio-group v-model="configData.deviceScope" @change="getDeviceByProductSnList">
                <el-radio label="所有设备" value="all"></el-radio>
                <el-radio label="部分设备" value="part"></el-radio>
              </el-radio-group>
            </el-form-item>
            <el-form-item label="设备筛选" required v-if="configData.deviceScope==='部分设备'">
              <el-select v-model="configData.deviceSnList" multiple>
                <el-option v-for="item in configData.deviceList"
                           :label="item.deviceName"
                           :value="item.deviceSn"
                           :key="item.deviceSn"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-form>
          <el-form :model="configData" ref="dataForm" label-width="80px" v-show="componentType === 'HTTP'">
            <el-form-item label="接口地址">
              <el-input v-model="configData.address"></el-input>
            </el-form-item>
            <el-form-item label="请求方式">
              <el-select v-model="configData.method">
                <el-option label="POST" value="POST"></el-option>
                <el-option label="PUT" value="PUT"></el-option>
              </el-select>
            </el-form-item>
          </el-form>
          <el-form :model="configData" ref="dataForm" label-width="80px" v-show="componentType === 'RabbitMQ'">
            <el-form-item label="IP地址" required>
              <el-input v-model="configData.host"></el-input>
            </el-form-item>
            <el-form-item label="端口" required>
              <el-input type="number" v-model="configData.port"></el-input>
            </el-form-item>
            <el-form-item label="用户名" required>
              <el-input v-model="configData.username"></el-input>
            </el-form-item>
            <el-form-item label="密码" required>
              <el-input v-model="configData.password"></el-input>
            </el-form-item>
            <el-form-item label="Exchange">
              <el-input v-model="configData.exchange" placeholder="选填，默认使用空字符串（直接发送到队列）"></el-input>
            </el-form-item>
            <el-form-item label="路由键">
              <el-input v-model="configData.routingKey" placeholder="选填，默认null"></el-input>
            </el-form-item>
            <el-form-item label="队列" required>
              <el-input v-model="configData.queue" placeholder="必填，自动创建"></el-input>
            </el-form-item>
          </el-form>

          <el-form :model="configData" ref="dataForm" label-width="80px" v-show="componentType === 'Kafka'">
            <el-form-item label="IP地址" required>
              <el-input v-model="configData.host"></el-input>
            </el-form-item>
            <el-form-item label="端口" required>
              <el-input type="number" v-model="configData.port"></el-input>
            </el-form-item>
            <el-form-item label="用户名" required>
              <el-input v-model="configData.username"></el-input>
            </el-form-item>
            <el-form-item label="密码" required>
              <el-input v-model="configData.password"></el-input>
            </el-form-item>
            <el-form-item label="主题" required>
              <el-input v-model="configData.topic"></el-input>
            </el-form-item>
          </el-form>

          <el-form :model="configData" ref="dataForm" label-width="80px" v-show="componentType === 'RocketMQ'">
            <el-form-item label="IP地址" required>
              <el-input v-model="configData.host"></el-input>
            </el-form-item>
            <el-form-item label="端口" required>
              <el-input type="number" v-model="configData.port"></el-input>
            </el-form-item>
            <el-form-item label="用户名" required>
              <el-input v-model="configData.username"></el-input>
            </el-form-item>
            <el-form-item label="密码" required>
              <el-input v-model="configData.password"></el-input>
            </el-form-item>
            <el-form-item label="主题" required>
              <el-input v-model="configData.topic"></el-input>
            </el-form-item>
          </el-form>

          <el-form-item>
            <el-button icon="el-icon-close" @click="reset">重置</el-button>
            <el-button type="primary" icon="el-icon-check" @click="save">保存</el-button>
          </el-form-item>
        </el-form>

        <el-form :model="line" ref="dataForm" label-width="80px" v-show="type === 'line'">
          <el-form-item label="条件">
            <el-input v-model="line.label"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button icon="el-icon-close">重置</el-button>
            <el-button type="primary" icon="el-icon-check" @click="saveLine">保存</el-button>
          </el-form-item>
        </el-form>
      </div>
      <!--            <div class="el-node-form-tag"></div>-->
    </div>
  </div>

</template>

<script>
import {cloneDeep} from 'lodash'
import {listProduct, getProduct, delProduct, addProduct, updateProduct} from "@/api/business/product"
import {listDevice, getDevice, delDevice, addDevice, updateDevice, getDeviceByProductSn} from "@/api/business/device"
import {addRuleEngine, updateRuleEngine} from "@/api/business/ruleEngine";

export default {
  data() {
    return {
      visible: true,
      // node 或 line
      type: 'node',
      componentType: 'HTTP',
      node: {},
      line: {},
      configData: {
        productScope: [],
        productList: [],
        deviceScope: '全部设备',
        deviceList: [],
        deviceSnList: []
      },
      data: {},
      stateList: [{
        state: 'success',
        label: '成功'
      }, {
        state: 'warning',
        label: '警告'
      }, {
        state: 'error',
        label: '错误'
      }, {
        state: 'running',
        label: '运行中'
      }],
    }
  },
  methods: {
    /**
     * 表单修改，这里可以根据传入的ID进行业务信息获取
     * @param data
     * @param id
     */
    nodeInit(data, id) {
      this.type = 'node'
      this.data = data
      data.nodeList.filter((node) => {
        if (node.id === id) {
          this.node = cloneDeep(node)
          this.componentType = node.type
          if (this.componentType === 'deviceLog' || this.componentType === 'deviceWarn' || this.componentType === 'deviceInfo') {
            listProduct({pageNum: 1, pageSize: 100000}).then(res => {
              this.configData.productList = res?.rows;
            })
          }
        }
      })
    },
    getDeviceByProductSnList() {
      if (this.configData.deviceScope === '部分设备') {
        getDeviceByProductSn(this.configData.productScope.join(',')).then(res => {
          this.configData.deviceList = res?.data
        })
      }
    },
    lineInit(line) {
      this.type = 'line'
      this.line = line
    },
    // 修改连线
    saveLine() {
      this.$emit('setLineLabel', this.line.from, this.line.to, this.line.label)
    },
    reset() {
      this.configData = {}
    },
    save() {
      this.data.nodeList.filter((node) => {
        if (node.id === this.node.id) {
          node.name = this.node.name
          node.left = this.node.left
          node.top = this.node.top
          node.ico = this.node.ico
          node.state = this.node.state
          node.configData = this.configData
          this.$emit('repaintEverything')
        }
      })
    }
  }
}
</script>

<style>
.el-node-form-tag {
  position: absolute;
  top: 50%;
  margin-left: -15px;
  height: 40px;
  width: 15px;
  background-color: #fbfbfb;
  border: 1px solid rgb(220, 227, 232);
  border-right: none;
  z-index: 0;
}
</style>
