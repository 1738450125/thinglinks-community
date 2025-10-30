<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="归属id 产品/设备" prop="belongSn">
        <el-input
          v-model="queryParams.belongSn"
          placeholder="请输入归属id 产品/设备"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="属性标识符，如 temperature, status" prop="identifier">
        <el-input
          v-model="queryParams.identifier"
          placeholder="请输入属性标识符，如 temperature, status"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="属性名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入属性名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="父属性ID，用于构建嵌套结构。0表示根级属性" prop="parentId">
        <el-input
          v-model="queryParams.parentId"
          placeholder="请输入父属性ID，用于构建嵌套结构。0表示根级属性"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="排序" prop="sortNum">
        <el-input
          v-model="queryParams.sortNum"
          placeholder="请输入排序"
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
          v-hasPermi="['business:properties:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['business:properties:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['business:properties:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['business:properties:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="propertiesList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="id" align="center" prop="id" />
      <el-table-column label="归属id 产品/设备" align="center" prop="belongSn" />
      <el-table-column label="归属类型 0-产品 1-设备" align="center" prop="belongType" />
      <el-table-column label="属性标识符，如 temperature, status" align="center" prop="identifier" />
      <el-table-column label="属性名称" align="center" prop="name" />
      <el-table-column label="父属性ID，用于构建嵌套结构。0表示根级属性" align="center" prop="parentId" />
      <el-table-column label="数据类型: int, double, bool, string, struct, array..." align="center" prop="dataType" />
      <el-table-column label="排序" align="center" prop="sortNum" />
      <el-table-column label="来源 0-产品继承 1-设备自定义(继承不可修改)" align="center" prop="fromType" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['business:properties:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['business:properties:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改物模型属性定义对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="归属id 产品/设备" prop="belongSn">
          <el-input v-model="form.belongSn" placeholder="请输入归属id 产品/设备" />
        </el-form-item>
        <el-form-item label="属性标识符，如 temperature, status" prop="identifier">
          <el-input v-model="form.identifier" placeholder="请输入属性标识符，如 temperature, status" />
        </el-form-item>
        <el-form-item label="属性名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入属性名称" />
        </el-form-item>
        <el-form-item label="父属性ID，用于构建嵌套结构。0表示根级属性" prop="parentId">
          <el-input v-model="form.parentId" placeholder="请输入父属性ID，用于构建嵌套结构。0表示根级属性" />
        </el-form-item>
        <el-form-item label="排序" prop="sortNum">
          <el-input v-model="form.sortNum" placeholder="请输入排序" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listProperties, getProperties, delProperties, addProperties, updateProperties } from "@/api/business/properties"

export default {
  name: "Properties",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 物模型属性定义表格数据
      propertiesList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        belongSn: null,
        belongType: null,
        identifier: null,
        name: null,
        parentId: null,
        dataType: null,
        sortNum: null,
        fromType: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询物模型属性定义列表 */
    getList() {
      this.loading = true
      listProperties(this.queryParams).then(response => {
        this.propertiesList = response.rows
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
        belongSn: null,
        belongType: null,
        identifier: null,
        name: null,
        parentId: null,
        dataType: null,
        sortNum: null,
        fromType: null
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
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加物模型属性定义"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getProperties(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改物模型属性定义"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateProperties(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addProperties(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除物模型属性定义编号为"' + ids + '"的数据项？').then(function() {
        return delProperties(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('business/properties/export', {
        ...this.queryParams
      }, `properties_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
