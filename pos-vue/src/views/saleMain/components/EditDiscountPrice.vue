<template>
  <el-popover ref="popoverRef" trigger="click" effect="light" placement="bottom" title="打折优惠" width="240">
    <div class="popover-container">
      <main class="discount-content">
        <div class="discount-item">
          <span>待款总金额：</span>
          <span class="price-text">¥ {{ store.payAmount }}</span>
        </div>
        <div class="discount-item">
          <span>优惠后金额：</span>
          <span class="price-text">¥ {{ store.payAmount - discountAmount }}</span>
        </div>
        <div class="discount-item discount-input-wrapper">
          <span>优惠金额：</span>
          <el-input
            v-model.number="discountAmount"
            :min="0"
            :max="store.payAmount"
            type="number"
            placeholder="请输入优惠金额"
            class="discount-input"
          ></el-input>
          <span class="currency-unit">元</span>
        </div>
      </main>
      <footer class="footer-btns">
        <el-button link @click="handleCancel">取消</el-button>
        <el-button type="primary" @click="handleConfirm">确认</el-button>
      </footer>
    </div>
    <template #reference>
      <slot name="reference"></slot>
    </template>
  </el-popover>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PopoverInstance } from 'element-plus';
// import type { PopoverProps } from 'element-plus/es/components/popover/index';

import { useOrderStore } from '@/store/modules/order/index';
const store = useOrderStore();

// interface Props {}

// const props = withDefaults(defineProps<Props>(), {});

interface Emits {
  /**
   * 对话框关闭事件
   */
  (e: 'update:visible', value: boolean): void;
  /**
   * 确认优惠事件
   */
  (e: 'confirm', discountAmount: number): void;
  /**
   * 取消优惠事件
   */
  (e: 'cancel'): void;
}

const emit = defineEmits<Emits>();

// 弹出框实例
const popoverRef = ref<PopoverInstance>();
const discountAmount = ref<number>(0);

const handleConfirm = () => {
  emit('confirm', discountAmount.value);
  popoverRef.value?.hide();
};

const handleCancel = () => {
  emit('cancel');
  popoverRef.value?.hide();
};

defineExpose({});
</script>

<style lang="scss" scoped>
.popover-container {
  .discount-content {
    padding: 10px 0;
    color: var(--el-color-primary);
    .discount-item {
    }
    .discount-input-wrapper {
      margin-top: 10px;
      display: flex;
      align-items: center;
      gap: 5px;
      .discount-input {
        width: 120px;
      }
    }
  }

  .footer-btns {
    display: flex;
    justify-content: center;
    gap: 10px;
  }
}
</style>
