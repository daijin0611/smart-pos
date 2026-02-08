<template>
  <div class="pagination-container">
    <el-pagination
      v-model:current-page="currentPage"
      v-model:page-size="pageSize"
      :page-sizes="props.pageSizes"
      :small="props.small"
      :background="props.background"
      :layout="props.layout"
      :total="props.total"
      :disabled="props.disabled"
      :hide-on-single-page="props.hideOnSinglePage"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      @prev-click="handlePrevClick"
      @next-click="handleNextClick"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, watch, withDefaults } from 'vue';

// 定义事件
const $emit = defineEmits([
  'update:currentPage',
  'update:pageSize',
  'size-change',
  'current-change',
  'prev-click',
  'next-click',
]);

// 使用 withDefaults 添加默认值
const props = withDefaults(
  defineProps<{
    currentPage?: number;
    pageSize?: number;
    pageSizes?: number[];
    layout?: string;
    total?: number;
    small?: boolean;
    background?: boolean;
    disabled?: boolean;
    hideOnSinglePage?: boolean;
  }>(),
  {
    currentPage: 1,
    pageSize: 10,
    pageSizes: () => [10, 20, 30, 50],
    layout: 'total, sizes, prev, pager, next, jumper',
    total: 0,
    small: false,
    background: true,
    disabled: false,
    hideOnSinglePage: false,
  },
);

// 内部状态
const currentPage = ref(props.currentPage);
const pageSize = ref(props.pageSize);

// 监听 props 变化
watch(
  () => props.currentPage,
  (newValue) => {
    currentPage.value = newValue;
  },
);

watch(
  () => props.pageSize,
  (newValue) => {
    pageSize.value = newValue;
  },
);

// 监听内部状态变化，通知父组件更新
watch(
  () => currentPage.value,
  (newValue) => {
    $emit('update:currentPage', newValue);
  },
);

watch(
  () => pageSize.value,
  (newValue) => {
    $emit('update:pageSize', newValue);
  },
);

// 事件处理函数
const handleSizeChange = (val: number) => {
  pageSize.value = val;
  $emit('size-change', val);
};

const handleCurrentChange = (val: number) => {
  currentPage.value = val;
  $emit('current-change', val);
};

const handlePrevClick = (val: number) => {
  $emit('prev-click', val);
};

const handleNextClick = (val: number) => {
  $emit('next-click', val);
};

// 对外暴露方法
defineExpose({
  currentPage,
  pageSize,
});
</script>

<style scoped>
.pagination-container {
  margin: 15px 0;
  display: flex;
  justify-content: flex-end;
}
</style>
