<template>
  <div class="ellipsis-container" :style="textStyle">
    <el-tooltip v-if="isOverflow && tooltip" :content="content" :effect="effect" :placement="placement">
      <span ref="textRef" class="ellipsis-text" :style="textStyle">
        {{ content }}
      </span>
    </el-tooltip>
    <span v-else ref="textRef" class="ellipsis-text" :style="textStyle">
      {{ content }}
    </span>
  </div>
</template>

<script setup lang="ts">
import type { ElTooltipProps } from 'element-plus';
import { computed } from 'vue';
import { useTextEllipsis } from './useTextEllipsis';

interface Props extends Partial<ElTooltipProps> {
  tooltip?: boolean;
  width?: string | number;
  maxWidth?: string | number;
  lineClamp?: number;
  content: string;
  placement?:
    | 'top'
    | 'top-start'
    | 'top-end'
    | 'bottom'
    | 'bottom-start'
    | 'bottom-end'
    | 'left'
    | 'left-start'
    | 'left-end'
    | 'right'
    | 'right-start'
    | 'right-end';
  effect?: 'light' | 'dark';
}

const props = withDefaults(defineProps<Props>(), {
  tooltip: true,
  placement: 'top',
  effect: 'light',
  maxWidth: '100%',
  lineClamp: 1,
  content: '',
});

const { textRef, isOverflow, checkOverflow } = useTextEllipsis();

const textStyle = computed(() => ({
  width: typeof props.width === 'number' ? `${props.width}px` : props.width,
  maxWidth: typeof props.maxWidth === 'number' ? `${props.maxWidth}px` : props.maxWidth,
  WebkitLineClamp: props.lineClamp > 1 ? props.lineClamp : undefined,
}));

defineExpose({
  checkOverflow,
});
</script>

<style scoped lang="scss">
.ellipsis-container {
  display: inline-block;
}

.ellipsis-text {
  display: inline-block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  vertical-align: bottom;

  // 多行省略支持
  &:global(.multiline) {
    display: -webkit-box;
    -webkit-box-orient: vertical;
    white-space: normal;
  }
}
</style>
