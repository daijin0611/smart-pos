<template>
  <el-tooltip
    :disabled="!isOverflow"
    :content="content"
    :placement="placement"
    :effect="effect"
    popper-class="text-overflow-tooltip"
  >
    <div ref="textRef" :class="['text-overflow-wrapper', customClass]" :style="textStyle">
      {{ content }}
    </div>
  </el-tooltip>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUpdated, nextTick, watch } from 'vue';

interface Props {
  content: string; // 文本内容
  placement?: 'top' | 'bottom' | 'left' | 'right'; // tooltip位置
  effect?: 'dark' | 'light'; // tooltip主题
  maxLines?: number; // 最大显示行数,默认1行
  customClass?: string; // 自定义类名
  width?: string; // 容器宽度
}

const props = withDefaults(defineProps<Props>(), {
  placement: 'top',
  effect: 'dark',
  maxLines: 1,
  customClass: '',
  width: '100%',
});

const textRef = ref<HTMLElement>();
const isOverflow = ref(false);

// 计算文本样式
const textStyle = computed(() => ({
  width: props.width,
  overflow: 'hidden',
  textOverflow: 'ellipsis',
  display: '-webkit-box',
  WebkitLineClamp: props.maxLines,
  WebkitBoxOrient: 'vertical',
  wordBreak: 'break-all',
}));

// 检查文本是否溢出
const checkOverflow = () => {
  nextTick(() => {
    if (!textRef.value) return;

    const element = textRef.value;

    // 多行文本溢出检测
    if (props.maxLines > 1) {
      isOverflow.value = element.scrollHeight > element.clientHeight;
    } else {
      // 单行文本溢出检测
      isOverflow.value = element.scrollWidth > element.clientWidth;
    }
  });
};

// 监听内容变化
watch(
  () => props.content,
  () => {
    checkOverflow();
  },
  { immediate: true },
);

// 监听最大行数变化
watch(
  () => props.maxLines,
  () => {
    checkOverflow();
  },
);

onMounted(() => {
  checkOverflow();

  // 监听窗口大小变化
  window.addEventListener('resize', checkOverflow);
});

onUpdated(() => {
  checkOverflow();
});

// 清理事件监听
const cleanup = () => {
  window.removeEventListener('resize', checkOverflow);
};

// 组件卸载时清理
defineExpose({
  checkOverflow,
  cleanup,
});
</script>

<style lang="scss" scoped>
.text-overflow-wrapper {
  cursor: pointer;

  &:hover {
    color: var(--el-color-primary);
  }
}
</style>

<style lang="scss">
// 全局样式,用于tooltip
.text-overflow-tooltip {
  max-width: 400px;
  word-break: break-all;
}
</style>
