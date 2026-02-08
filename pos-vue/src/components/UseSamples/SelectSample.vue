<template>
  <div class="select-sample-container">
    <h3>Select 组件示例</h3>

    <div class="example-group">
      <h4>基础用法</h4>
      <Select v-model="basicValue" :options="options" placeholder="请选择一个选项" />
    </div>

    <div class="example-group">
      <h4>支持清空</h4>
      <Select v-model="clearableValue" :options="options" placeholder="请选择一个选项（可清空）" clearable />
    </div>

    <div class="example-group">
      <h4>多选模式</h4>
      <Select v-model="multipleValue" :options="options" placeholder="请选择多个选项" multiple collapse-tags />
    </div>

    <div class="example-group">
      <h4>禁用状态</h4>
      <Select v-model="disabledValue" :options="options" placeholder="禁用状态" disabled />
    </div>

    <div class="example-group">
      <h4>自定义远程搜索</h4>
      <Select
        v-model="remoteValue"
        :options="remoteOptions"
        placeholder="请输入关键词搜索"
        :remote="true"
        :remote-method="remoteMethod"
        :loading="loading"
      />
    </div>

    <div class="example-group">
      <h4>自定义内容插槽</h4>
      <Select v-model="slotValue" placeholder="选择一个用户">
        <el-option v-for="user in users" :key="user.id" :label="user.name" :value="user.id">
          <div style="display: flex; align-items: center">
            <img
              :src="user.avatar"
              alt="avatar"
              style="width: 24px; height: 24px; border-radius: 50%; margin-right: 8px"
            />
            <div>
              <div>{{ user.name }}</div>
              <div style="font-size: 12px; color: #999">{{ user.email }}</div>
            </div>
          </div>
        </el-option>
      </Select>
    </div>

    <div class="example-group">
      <h4>自定义选项字段名</h4>
      <Select
        v-model="customFieldValue"
        :options="customFieldOptions"
        value-key="id"
        label-key="title"
        placeholder="请选择一个项目"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import Select from '../Select/index.vue';

// 基础选项数据
const options = [
  { value: '1', label: '选项一' },
  { value: '2', label: '选项二' },
  { value: '3', label: '选项三' },
  { value: '4', label: '选项四' },
  { value: '5', label: '选项五' },
];

// 自定义字段名的选项数据
const customFieldOptions = [
  { id: 'p1', title: '项目一' },
  { id: 'p2', title: '项目二' },
  { id: 'p3', title: '项目三' },
];

// 用户数据（用于自定义插槽示例）
const users = [
  {
    id: 'u1',
    name: '张三',
    email: 'zhangsan@example.com',
    avatar: 'https://picsum.photos/id/1/24/24',
  },
  {
    id: 'u2',
    name: '李四',
    email: 'lisi@example.com',
    avatar: 'https://picsum.photos/id/2/24/24',
  },
  {
    id: 'u3',
    name: '王五',
    email: 'wangwu@example.com',
    avatar: 'https://picsum.photos/id/3/24/24',
  },
];

// 绑定值
const basicValue = ref('');
const clearableValue = ref('');
const multipleValue = ref([]);
const disabledValue = ref('');
const remoteValue = ref('');
const slotValue = ref('');
const customFieldValue = ref('');

// 远程搜索相关
const remoteOptions = ref([]);
const loading = ref(false);

// 远程搜索方法
const remoteMethod = (query: string) => {
  if (query) {
    loading.value = true;
    // 模拟异步搜索
    setTimeout(() => {
      loading.value = false;
      remoteOptions.value = options.filter((item) => item.label.toLowerCase().includes(query.toLowerCase()));
    }, 500);
  } else {
    remoteOptions.value = [];
  }
};

// 监听值变化
watch([basicValue, clearableValue, multipleValue, remoteValue, slotValue, customFieldValue], (newValues) => {
  console.log('Select value changed:', newValues);
});
</script>

<style scoped lang="scss">
.select-sample-container {
  padding: 20px;
  background: #f5f7fa;
  border-radius: 8px;
}

h3 {
  margin: 0 0 20px 0;
  color: #303133;
  font-size: 18px;
}

h4 {
  margin: 0 0 12px 0;
  color: #606266;
  font-size: 14px;
  font-weight: 500;
}

.example-group {
  margin-bottom: 24px;
}

.example-group :deep(.el-select) {
  width: 300px;
}
</style>
