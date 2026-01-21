<template>
  <component ref="datePickerRef" :is="h(ElDatePicker, { ...$attrs, ...props, ref: changeRef }, $slots)" />
</template>

<script lang="ts" setup>
import { ElDatePicker, type DatePickerProps } from 'element-plus';
import { ref, h, getCurrentInstance, watch } from 'vue';

const datePickerRef = ref(null);
// 获取当前组件实例，用于暴露给父组件
const vm: any = getCurrentInstance();
function changeRef(instance: any) {
  // 将对话框实例挂载到组件实例上，便于父组件调用
  if (vm) {
    vm.exposeProxy = vm.exposed = instance || {};
  }
}

/**
 * 组件属性接口定义
 */
interface Props extends Partial<DatePickerProps> {}

// 定义组件属性
const props = withDefaults(defineProps<Props>(), {
  shortcuts: () => shortcuts,
  type: 'daterange',
  unlinkPanels: true,
  rangeSeparator: '至',
  startPlaceholder: '开始日期',
  endPlaceholder: '结束日期',
  clearable: true,
  format: 'YYYY-MM-DD',
  valueFormat: 'YYYY-MM-DD',
});

const emit = defineEmits();
</script>
<script lang="ts">
export default {
  name: 'CustomDatePicker',
};

// 设置快捷选项
const shortcuts = [
  {
    text: '今天',
    value: () => {
      // 起始时间：00:00:00.000
      const start = new Date();
      start.setHours(0, 0, 0, 0);
      // 结束时间：23:59:59.999
      const tomorrow = new Date(start.getTime() + 24 * 60 * 60 * 1000);
      const end = new Date(tomorrow);
      end.setHours(23, 59, 59, 999);
      return [start, end];
    },
  },
  {
    text: '昨天',
    value: () => {
      // 获取当前时间
      const now = new Date();
      // 计算昨天的时间（当前时间减去一天的毫秒数）
      const yesterday = new Date(now.getTime() - 24 * 60 * 60 * 1000);
      // 起始时间：00:00:00.000
      const start = new Date(yesterday);
      start.setHours(0, 0, 0, 0);
      // 结束时间：23:59:59.999
      const end = new Date();
      return [start, end];
    },
  },
  {
    text: '本周',
    value: () => {
      const end = new Date();
      const start = new Date();
      const offset = start.getDay() - 1;
      start.setTime(start.getTime() - 3600 * 1000 * 24 * offset);
      return [start, end];
    },
  },
  {
    text: '本月',
    value: () => {
      const end = new Date();
      const start = new Date();
      const offset = start.getDate() - 1;
      start.setTime(start.getTime() - 3600 * 1000 * 24 * offset);
      return [start, end];
    },
  },
  {
    text: '最近一个月',
    value: () => {
      const end = new Date();
      const start = new Date();
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
      return [start, end];
    },
  },
  {
    text: '最近三个月',
    value: () => {
      const end = new Date();
      const start = new Date();
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
      return [start, end];
    },
  },
  {
    text: '最近六个月',
    value: () => {
      const end = new Date();
      const start = new Date();
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 180);
      return [start, end];
    },
  },
  {
    text: '最近一年',
    value: () => {
      const end = new Date();
      const start = new Date();
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 365);
      return [start, end];
    },
  },
];
</script>
