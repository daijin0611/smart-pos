<template>
  <div class="form-container">
    <!-- 表单 -->
    <Form :model="formData" :rules="formRules" @submit="handleFormSubmit" @reset="handleFormReset">
      <!-- 原密码 -->
      <el-form-item label="原密码" prop="oldPwd">
        <el-input v-model="formData.oldPwd" type="password" show-password placeholder="请输入旧密码" />
      </el-form-item>

      <!-- 新密码 -->
      <el-form-item label="新密码" prop="newPwd">
        <el-input v-model="formData.newPwd" type="password" show-password placeholder="请输入新密码" />
      </el-form-item>

      <!-- 确认密码 -->
      <el-form-item label="确认密码" prop="confirmPwd">
        <el-input v-model="formData.confirmPwd" type="password" show-password placeholder="请输入确认密码" />
      </el-form-item>
    </Form>
  </div>
</template>

<script setup lang="ts">
import { reactive, onMounted } from 'vue';

import useUserStore from '@/store/modules/acl/user';
const store = useUserStore();

const $emit = defineEmits(['close']);

onMounted(async () => {
  await store.getUserInfo();
});

const formData = reactive({
  oldPwd: '',
  newPwd: '',
  confirmPwd: '',
});

// 表单提交
const handleFormSubmit = async () => {
  const isSuccess = await store.updatePwd(formData);
  isSuccess && $emit('close');
};

// 表单重置
const handleFormReset = () => {
  formData.oldPwd = '';
  formData.newPwd = '';
  formData.confirmPwd = '';
};

// 表单验证规则
const formRules = {
  oldPwd: [
    { required: true, message: '请输入原密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度6-20位', trigger: 'change' },
    {
      validator: async (rule: any, value: any, callback: any) => {
        if (!store.user.userPassword) {
          await store.getUserInfo();
        }
        if (value !== store.user.userPassword) {
          callback(new Error('原密码错误'));
        } else {
          callback();
        }
      },
      trigger: 'blur',
    },
  ],
  newPwd: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度6-20位', trigger: 'change' },
  ],
  confirmPwd: [
    { required: true, message: '请输入确认密码', trigger: 'blur' },
    {
      validator: (rule: any, value: any, callback: any) => {
        if (value !== formData.newPwd) {
          callback(new Error('两次输入的密码不一致'));
        } else {
          callback();
        }
      },
      trigger: 'change',
    },
  ],
};
</script>
<script lang="ts">
export default {
  name: 'PwdForm',
};
</script>

<style lang="scss" scoped>
.form-container {
  width: 90%;
  min-width: 260px;
  max-width: 350px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: $main-padding * 2;
}
</style>
