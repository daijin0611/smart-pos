<template>
  <component :is="h(ElDialog, { ...$attrs, ...props, ref: changeRef }, $slots)" />
</template>

<script lang="ts" setup>
import { ElDialog, type DialogProps } from 'element-plus';
import { h, getCurrentInstance, withDefaults } from 'vue';

// 获取当前组件实例，用于暴露实例方法
const vm: any = getCurrentInstance();
function changeRef(instance: any) {
  // 将实例挂载到组件实例上，便于父组件调用
  vm.exposeProxy = vm.exposed = instance || {};
}

interface CustomProps extends Partial<DialogProps> {}

const props = defineProps<CustomProps>();
</script>
<script lang="ts">
export default {
  name: 'CustomDialog',
};
</script>

<style scoped></style>
