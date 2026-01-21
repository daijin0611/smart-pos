<template>
  <div>
    <Form :model="store.formData" :rules="formRules" @submit="handleFormSubmit" @reset="handleFormReset">
      <!-- 角色编码 -->
      <el-form-item label="角色编码" prop="roleCode">
        <el-input v-model="store.formData.roleCode" placeholder="请输入角色编码" clearable />
      </el-form-item>

      <!-- 角色名称 -->
      <el-form-item label="角色名称" prop="roleName">
        <el-input v-model="store.formData.roleName" placeholder="请输入角色名称" clearable />
      </el-form-item>

      <!-- 显示顺序 -->
      <el-form-item label="显示顺序" prop="roleSort">
        <el-input-number v-model="store.formData.roleSort" :min="0" placeholder="请输入显示顺序" />
      </el-form-item>

      <!-- 角色状态 -->
      <el-form-item label="角色状态" prop="roleStatus">
        <el-radio-group v-model="store.formData.roleStatus">
          <el-radio :value="0">正常</el-radio>
          <el-radio :value="1">停用</el-radio>
        </el-radio-group>
      </el-form-item>

      <!-- 备注 -->
      <el-form-item label="备注" prop="remark">
        <el-input v-model="store.formData.remark" type="textarea" placeholder="请输入备注信息" clearable />
      </el-form-item>
    </Form>
  </div>
</template>

<script setup lang="ts">
// 引入数据仓库
import { useRoleStore } from '@/store/modules/acl/role';
const store = useRoleStore();

// 定义组件触发的事件 - 关闭抽屉
const $emit = defineEmits(['close-drawer']);

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
  roleCode: [{ required: true, message: '角色编码为必填项', trigger: 'blur' }],
  roleName: [{ required: true, message: '角色名称为必填项', trigger: 'blur' }],
  roleSort: [{ type: 'number', message: '请输入有效的显示顺序', trigger: 'blur' }],
  roleStatus: [{ required: false, message: '请选择角色状态', trigger: 'change' }],
};
</script>
