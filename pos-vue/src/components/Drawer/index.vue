<template>
  <component
    :is="h(ElDrawer, { ...$attrs, ...props, ref: changeRef }, $slots)"
    style="min-width: 400px; max-width: 500px"
    header-class="custom-header"
  />
</template>

<script lang="ts" setup>
import { ElDrawer, type DrawerProps } from 'element-plus';
import { h, getCurrentInstance } from 'vue';

// 获取当前组件实例，用于暴露实例方法
const vm: any = getCurrentInstance();
function changeRef(instance: any) {
  // 将实例挂载到组件实例上，便于父组件调用
  vm.exposeProxy = vm.exposed = instance || {};
}

interface CustomProps extends Partial<DrawerProps> {}

const props = defineProps<CustomProps>();
</script>
<script lang="ts">
export default {
  name: 'CustomDrawer',
};
</script>

<style lang="scss">
.custom-header {
  font-size: 18px;
  text-align: center;
  font-weight: bold;
  margin-bottom: 10px;
}
</style>
