<template>
  <component
    :is="h(ElCard, { ...$attrs, ...props, ref: changeRef }, $slots)"
    :style="{
      border: props.border,
      borderRadius: props.borderRadius,
      backgroundColor: props.bgColor,
    }"
    :body-style="{
      gap: `${props.gap}px`,
      flexDirection: props.flex,
      padding: props.padding,
      flexWrap: props.wrap,
    }"
    class="card-container"
    body-class="card-body"
  />
</template>

<script setup lang="ts">
import { ElCard, type CardProps } from 'element-plus';
import { h, getCurrentInstance, withDefaults } from 'vue';

interface MyCardProps extends Partial<CardProps> {
  shadow?: 'always' | 'hover' | 'never';
  bgColor?: string;
  flex?: 'row' | 'column';
  gap?: number;
  padding?: string;
  border?: string;
  borderRadius?: string;
  wrap?: string;
}

// 获取当前组件实例，用于暴露实例方法
const vm: any = getCurrentInstance();
function changeRef(dialogInstance: any) {
  // 将实例挂载到组件实例上，便于父组件调用
  vm.exposeProxy = vm.exposed = dialogInstance || {};
}

const props = withDefaults(defineProps<MyCardProps>(), {
  shadow: 'never',
  bgColor: '#f5f7fa',
  flex: 'column',
  gap: 15,
  padding: '15px',
  border: 'none',
  wrap: 'wrap',
});
</script>
<script lang="ts">
export default {
  name: 'Card',
};
</script>

<style lang="scss">
.card-container {
  .card-body {
    display: flex;
    align-content: flex-start;
    height: 100%;
    overflow: auto;
  }
}
</style>
