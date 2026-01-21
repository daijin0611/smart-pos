<template>
  <div class="custom-form">
    <el-form
      ref="formRef"
      :model="props.model"
      :rules="props.rules"
      :inline="props.inline"
      :label-position="props.labelPosition"
      :label-width="props.labelWidth"
      :label-suffix="props.labelSuffix"
      :hide-required-asterisk="props.hideRequiredAsterisk"
      :show-message="props.showMessage"
      :inline-message="props.inlineMessage"
      :status-icon="props.statusIcon"
      :validate-on-rule-change="props.validateOnRuleChange"
      :size="props.size"
      :disabled="props.disabled"
      :scroll-to-error="props.scrollToError"
    >
      <slot></slot>

      <!-- 自定义表单底部 -->
      <el-form-item label="&nbsp;" v-if="$slots.footer">
        <slot name="footer"></slot>
      </el-form-item>

      <!-- 表单操作按钮 -->
      <el-form-item v-if="props.showButtons" label="&nbsp;">
        <el-button type="primary" :loading="loading" @click="submitForm">{{ props.submitText }}</el-button>
        <el-button @click="resetForm">{{ props.resetText }}</el-button>
        <slot name="buttons"></slot>
      </el-form-item>
    </el-form>
  </div>
</template>

<script lang="ts" setup>
import { ref, withDefaults } from 'vue';
import type { FormInstance, FormRules } from 'element-plus';

// 定义事件
const $emit = defineEmits(['submit', 'reset', 'validate']);

// 使用 withDefaults 添加默认值
const props = withDefaults(
  defineProps<{
    model: Record<string, any>;
    rules?: FormRules;
    inline?: boolean;
    labelPosition?: 'left' | 'right' | 'top';
    labelWidth?: string | number;
    labelSuffix?: string;
    hideRequiredAsterisk?: boolean;
    showMessage?: boolean;
    inlineMessage?: boolean;
    statusIcon?: boolean;
    validateOnRuleChange?: boolean;
    size?: 'large' | 'default' | 'small';
    disabled?: boolean;
    scrollToError?: boolean;
    showButtons?: boolean;
    loading?: boolean;
    submitText?: string;
    resetText?: string;
  }>(),
  {
    rules: () => ({}),
    inline: false,
    labelPosition: 'right',
    labelWidth: 'auto',
    labelSuffix: '',
    hideRequiredAsterisk: false,
    showMessage: true,
    inlineMessage: false,
    statusIcon: false,
    validateOnRuleChange: true,
    size: 'default',
    disabled: false,
    scrollToError: false,
    showButtons: true,
    loading: false,
    submitText: '提交',
    resetText: '重置',
  },
);

// 表单引用
const formRef = ref<FormInstance>();

// 提交表单
const submitForm = async () => {
  if (!formRef.value) return;

  try {
    await formRef.value.validate();
    $emit('submit', props.model);
  } catch (error) {
    console.error('表单验证失败:', error);
    $emit('validate', false, error);
  }
};

// 重置表单
const resetForm = () => {
  if (!formRef.value) return;

  formRef.value.resetFields();
  $emit('reset');
};

// 对外暴露方法
defineExpose({
  formRef,
  submitForm,
  resetForm,
  // 提供验证方法
  validate: async () => {
    if (!formRef.value) return false;
    return formRef.value.validate();
  },
  // 提供验证特定字段方法
  validateField: (props: string | string[]) => {
    if (!formRef.value) return;
    return formRef.value.validateField(props);
  },
  // 提供清除验证方法
  clearValidate: (props?: string | string[]) => {
    if (!formRef.value) return;
    formRef.value.clearValidate(props);
  },
});
</script>

<style scoped>
.custom-form {
  width: 100%;
}
</style>
