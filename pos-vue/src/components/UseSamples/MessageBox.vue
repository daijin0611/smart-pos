<template>
  <div class="demo-container">
    <h2>MessageBox 二次封装使用示例</h2>

    <div class="button-group">
      <el-button @click="showAlert">普通提示</el-button>
      <el-button @click="showConfirm">确认弹窗</el-button>
      <el-button @click="showPrompt">输入弹窗</el-button>
    </div>

    <div class="button-group">
      <el-button type="success" @click="showSuccess">成功提示</el-button>
      <el-button type="danger" @click="showError">错误提示</el-button>
      <el-button type="warning" @click="showWarning">警告提示</el-button>
      <el-button type="info" @click="showInfo">信息提示</el-button>
    </div>

    <div class="button-group">
      <el-button type="danger" @click="showDeleteConfirm">删除确认</el-button>
      <el-button type="primary" @click="showSaveConfirm">保存确认</el-button>
      <el-button type="warning" @click="showExitConfirm">退出确认</el-button>
    </div>

    <div class="button-group">
      <el-button @click="showCustomConfirm">自定义确认</el-button>
      <el-button @click="showValidationPrompt">验证输入</el-button>
    </div>

    <div class="result-display" v-if="lastResult">
      <h3>最后操作结果：</h3>
      <pre>{{ lastResult }}</pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { ElButton, ElMessage } from 'element-plus';
import messageBox from '@/components/MessageBox/index';

const lastResult = ref<string>('');

// 普通提示
const showAlert = async () => {
  try {
    await messageBox.alert({
      title: '提示',
      message: '这是一个普通的提示消息',
      type: 'info',
    });
    lastResult.value = '用户点击了确定';
  } catch (error) {
    lastResult.value = '用户取消了操作';
  }
};

// 确认弹窗
const showConfirm = async () => {
  const result = await messageBox.confirm({
    title: '确认操作',
    message: '您确定要执行此操作吗？',
    type: 'warning',
  });
  lastResult.value = result ? '用户确认了操作' : '用户取消了操作';
};

// 输入弹窗
const showPrompt = async () => {
  try {
    const result = await messageBox.prompt({
      title: '请输入',
      message: '请输入您的姓名',
      inputPlaceholder: '请输入姓名',
      inputValidator: (value: string) => {
        if (!value) return '姓名不能为空';
        if (value.length < 2) return '姓名至少2个字符';
        return true;
      },
    });
    lastResult.value = `用户输入了: ${result.value}`;
  } catch (error) {
    lastResult.value = '用户取消了输入';
  }
};

// 成功提示
const showSuccess = async () => {
  const result = await messageBox.success('操作成功完成！');
  lastResult.value = result ? '用户确认了成功消息' : '用户取消了操作';
};

// 错误提示
const showError = async () => {
  const result = await messageBox.error('操作失败，请重试！');
  lastResult.value = result ? '用户确认了错误消息' : '用户取消了操作';
};

// 警告提示
const showWarning = async () => {
  const result = await messageBox.warning('请注意，此操作有风险！');
  lastResult.value = result ? '用户确认了警告消息' : '用户取消了操作';
};

// 信息提示
const showInfo = async () => {
  await messageBox.info('这是一条信息提示');
  lastResult.value = '用户查看了信息提示';
};

// 删除确认
const showDeleteConfirm = async () => {
  const result = await messageBox.confirmDelete('确定要删除这条记录吗？');
  if (result) {
    ElMessage.success('删除成功');
    lastResult.value = '用户确认删除';
  } else {
    lastResult.value = '用户取消删除';
  }
};

// 保存确认
const showSaveConfirm = async () => {
  const result = await messageBox.confirmSave('检测到有未保存的更改，是否保存？');
  if (result) {
    ElMessage.success('保存成功');
    lastResult.value = '用户确认保存';
  } else {
    lastResult.value = '用户取消保存';
  }
};

// 退出确认
const showExitConfirm = async () => {
  const result = await messageBox.confirmExit();
  if (result) {
    ElMessage.info('已退出');
    lastResult.value = '用户确认退出';
  } else {
    lastResult.value = '用户取消退出';
  }
};

// 自定义确认
const showCustomConfirm = async () => {
  const result = await messageBox.show({
    title: '自定义弹窗',
    message: '这是一个完全自定义的确认弹窗',
    type: 'info',
    showCancelButton: true,
    confirmButton: { text: '同意', type: 'success' },
    cancelButton: { text: '拒绝', type: 'danger' },
    closeOnClickModal: false,
    center: true,
    roundButton: true,
  });
  lastResult.value = `用户选择了: ${result}`;
};

// 验证输入
const showValidationPrompt = async () => {
  try {
    const result = await messageBox.prompt({
      title: '输入邮箱',
      message: '请输入您的邮箱地址',
      inputPlaceholder: 'example@email.com',
      inputPattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
      inputErrorMessage: '请输入有效的邮箱地址',
      inputValidator: (value: string) => {
        if (!value) return '邮箱不能为空';
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
          return '请输入有效的邮箱格式';
        }
        return true;
      },
    });
    lastResult.value = `验证通过，邮箱: ${result.value}`;
  } catch (error) {
    lastResult.value = '邮箱输入被取消';
  }
};
</script>

<style scoped>
.demo-container {
  padding: 20px;
  max-width: 800px;
  margin: 0 auto;
}

.button-group {
  margin: 15px 0;
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.result-display {
  margin-top: 30px;
  padding: 15px;
  background-color: #f5f5f5;
  border-radius: 4px;
  border-left: 4px solid #409eff;
}

.result-display h3 {
  margin-top: 0;
  color: #333;
}

.result-display pre {
  margin: 10px 0 0 0;
  color: #666;
  font-family: monospace;
}
</style>
