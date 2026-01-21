<template>
  <component
    v-model="value"
    :shortcuts="shortcuts"
    :is="h(ElDatePicker, { ...$attrs, ...props, ref: changeRef }, $slots)"
    @clear="reset"
    type="daterange"
    unlink-panels
    range-separator="至"
    start-placeholder="开始日期"
    end-placeholder="结束日期"
    clearable
    ref="datePickerRef"
  />
</template>

<script lang="ts" setup>
import { formatDate } from '@/utils/time';
import { ElDatePicker, type DatePickerProps } from 'element-plus';
import { ref, h, getCurrentInstance, watch } from 'vue';

/**
 * 组件属性接口定义
 * - 继承 DialogProps 并覆盖/扩展部分属性
 * - config: 配置对象，包含API调用方法和父级ID
 */
interface MyDatePickerProps extends Partial<DatePickerProps> {
  default?: Array<Date>;
}

// 定义组件属性
const props = defineProps<MyDatePickerProps>();

// 获取当前组件实例，用于暴露对话框方法
const vm: any = getCurrentInstance();
function changeRef(dialogInstance: any) {
  // 将对话框实例挂载到组件实例上，便于父组件调用
  vm.exposeProxy = vm.exposed = dialogInstance || {};
}

const emit: any = defineEmits();

// 绑定值
const value = ref<Array<Date>>([]);

// 当值发生变化时，调用自定义事件
watch(
  () => value.value,
  (newValue: Array<Date>, oldValue) => {
    if (newValue.length === 0) {
      return;
    }

    const start: string = formatDate(newValue[0]);
    const end: string = formatDate(newValue[1]);
    emit('selectDate', start, end);
  },
);

props.default && (value.value = props.default);

// 重置
const reset = () => {
  value.value = [];
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
<script lang="ts">
export default {
  name: 'DatePicker',
};
</script>
