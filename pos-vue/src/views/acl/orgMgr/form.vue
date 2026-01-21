<template>
  <div>
    <Form
      :model="store.formData"
      :rules="formRules"
      :disabled="disabled"
      @submit="handleFormSubmit"
      @reset="handleFormReset"
    >
      <el-form-item label="门店名称" prop="orgName">
        <el-input v-model="store.formData.orgName" placeholder="请输入门店名称" />
      </el-form-item>

      <el-form-item label="门店简称" prop="orgShortName">
        <el-input v-model="store.formData.orgShortName" placeholder="请输入门店简称" />
      </el-form-item>

      <el-form-item label="门店编号" prop="orgCode">
        <el-input v-model="store.formData.orgCode" placeholder="请输入门店编号" />
      </el-form-item>

      <el-form-item label="门店性质" prop="orgProperty">
        <el-select v-model="store.formData.orgProperty" placeholder="请选择门店性质">
          <el-option label="实体门店" value="实体门店" />
          <el-option label="线上门店" value="线上门店" />
        </el-select>
      </el-form-item>

      <el-form-item label="门店类型" prop="orgType">
        <el-select v-model="store.formData.orgType" placeholder="请选择门店类型">
          <el-option label="自营" value="自营" />
          <el-option label="代理商加盟" value="代理商加盟" />
        </el-select>
      </el-form-item>

      <el-form-item label="门店电话" prop="orgNumber">
        <el-input v-model="store.formData.orgNumber" placeholder="请输入门店电话" />
      </el-form-item>

      <el-form-item label="门店负责人" prop="orgLeader">
        <el-input v-model="store.formData.orgLeader" placeholder="请输入门店负责人" />
      </el-form-item>

      <el-form-item label="负责人电话" prop="orgLeaderNum">
        <el-input v-model="store.formData.orgLeaderNum" placeholder="请输入负责人电话" />
      </el-form-item>

      <el-form-item label="行政区域" prop="orgArea">
        <el-cascader :options="pcaTextArr" v-model="store.formData.orgArea" filterable placement="left" />
      </el-form-item>

      <el-form-item label="详细地址" prop="orgAddress">
        <el-input v-model="store.formData.orgAddress" type="textarea" :rows="2" placeholder="请输入详细地址" />
      </el-form-item>

      <!-- 其他信息 -->
      <!-- <el-form-item label="父级门店" prop="orgParent">
        <el-input v-model="store.formData.orgParent" placeholder="请输入父级门店" />
      </el-form-item> -->

      <!-- <el-form-item label="门店状态" prop="orgState">
        <el-radio-group v-model="store.formData.orgState">
          <el-radio :value="0" key="0">正常</el-radio>
          <el-radio :value="1" key="1">停用</el-radio>
        </el-radio-group>
      </el-form-item> -->

      <el-form-item label="备注" prop="remark">
        <el-input v-model="store.formData.remark" type="textarea" :rows="3" placeholder="请输入备注信息" />
      </el-form-item>
    </Form>
  </div>
</template>

<script setup lang="ts">
// import AreaCascader from '@/components/AreaCascader/index.vue';
import { pcaTextArr } from 'element-china-area-data';
// 引入数据仓库
import { useOrgStore } from '@/store/modules/acl/org';
const store = useOrgStore();

// 定义组件触发的事件 - 关闭抽屉
const $emit = defineEmits(['close-drawer']);
// 定义组件接收的props - 是否禁用表单
defineProps(['disabled']);

/**
 * 表单提交处理函数
 * @param model 表单数据对象
 */
const handleFormSubmit = async (model: any) => {
  const result = await store.update(model);
  result && $emit('close-drawer');
};

/**
 * 表单重置处理函数
 * 调用数据仓库的重置表单数据方法
 */
const handleFormReset = () => {
  store.resetFormData();
};

// 表单验证规则
const formRules = {
  orgName: [{ required: true, message: '请输入门店名称', trigger: 'blur' }],
  orgShortName: [{ required: true, message: '请输入门店简称', trigger: 'blur' }],
  orgCode: [{ required: true, message: '请输入门店编号', trigger: 'blur' }],
  // orgParent: [{ required: true, message: '请输入父级门店', trigger: 'blur' }],
  orgProperty: [{ required: true, message: '请选择门店性质', trigger: 'change' }],
  orgType: [{ required: true, message: '请选择门店类型', trigger: 'change' }],
  orgNumber: [
    { required: true, message: '请输入门店电话', trigger: 'blur' },
    { pattern: /^(1[3-9]\d{9})$|(^\(?0\d{2,3}\)?[-]?\d{7,8}$)/, message: '请输入正确的手机号', trigger: 'blur' },
  ],
  orgLeader: [{ required: true, message: '请输入门店负责人', trigger: 'blur' }],
  orgLeaderNum: [
    { required: true, message: '请输入负责人电话', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' },
  ],
  orgArea: [{ required: true, message: '请选择行政区域', trigger: 'change' }],
  orgAddress: [{ required: true, message: '请输入详细地址', trigger: 'blur' }],
};
</script>
