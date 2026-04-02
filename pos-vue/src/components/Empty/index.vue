<template>
  <div class="empty-content">
    <el-text type="info">{{ description }}</el-text>
  </div>
</template>

<script setup lang="ts">
interface Props {
  description: string;
}

const props = withDefaults(defineProps<Props>(), {
  description: '暂无数据',
});
</script>

<style scoped lang="scss">
.empty-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
}
</style>
