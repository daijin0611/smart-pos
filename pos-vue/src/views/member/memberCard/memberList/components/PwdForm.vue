<template>
  <div class="form-container">
    <!-- 提示卡片信息 -->
    <Card bgColor="var(--el-color-success-light-8)" style="color: var(--el-color-success-dark-2)">
      <h3 style="font-weight: bold">会员信息确认</h3>
      <p style="font-size: 14px; line-height: 24px">
        您正在为：
        <b style="font-weight: bold">{{ store.formData.name }}（{{ store.formData.cardNumber }}）</b>
        修改密码
      </p>
    </Card>
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

      <template #footer>
        <el-button type="danger" size="large" link @click="resetPwd">重置密码</el-button>
      </template>
    </Form>
  </div>
</template>

<script setup lang="ts">
import { reactive, inject, watchEffect } from 'vue';
import { useMemberStore } from '@/store/modules/member/member';
const store = useMemberStore();

const $MessageBox: any = inject('$MessageBox');

const emit = defineEmits(['close-drawer']);

const formData = reactive({
  oldPwd: '',
  newPwd: '',
  confirmPwd: '',
});

watchEffect(() => {
  formData.oldPwd = store.formData.pwd;
});

// 重置密码
const resetPwd = async () => {
  const result = await $MessageBox.confirm({
    title: '确认操作',
    message: `重置后会员密码为：123456，你确定要重置会员【${store.formData.name}】的密码吗？`,
    type: 'warning',
  });
  const isSuccess = result ? store.updatePwd() : false;
  if (isSuccess) {
    emit('close-drawer');
    handleFormReset();
  }
};

// 表单提交
const handleFormSubmit = async () => {
  const result = await store.updatePwd(formData.newPwd);
  if (result) {
    emit('close-drawer');
    handleFormReset();
  }
};

// 表单重置
const handleFormReset = () => {
  formData.oldPwd = '';
  formData.newPwd = '';
  formData.confirmPwd = '';
};

// 表单验证规则
const formRules = {
  oldPwd: [{ required: true, message: '请输入原密码', trigger: 'blur' }],
  newPwd: [{ required: true, message: '请输入新密码', trigger: 'blur' }],
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
      trigger: 'blur',
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
