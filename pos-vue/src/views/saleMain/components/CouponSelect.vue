<template>
  <el-popover ref="popoverRef" trigger="click" effect="light" placement="left" title="请选择优惠券" width="180">
    <!-- <el-scrollbar height="100px">
      <CouponCard v-for="(item, index) in coupons" :key="item.id" :coupon="item" @click="handleClick(item)" />
    </el-scrollbar> -->
    <el-select v-model="selected" placeholder="请选择优惠券" filterable clearable value-key="id" @change="handleChange">
      <el-option v-for="(item, index) in coupons" :key="item.id" :label="item.ticketName" :value="item" />
    </el-select>
    <template #reference>
      <el-button type="primary" link size="large" icon="Ticket" style="transform: scale(1.3)" />
    </template>
  </el-popover>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { CouponType } from '@/enums/index';
import { PopoverInstance } from 'element-plus';

import { useOrderStore } from '@/store/modules/order/index';
const store = useOrderStore();

interface Emits {
  (e: 'change', coupon: any): void;
}

const emit = defineEmits<Emits>();

const coupons = computed(() => {
  if (store.order.ticketUseList && store.order.ticketUseList.length > 0) {
    return store.member.vipTicketVOList.filter((item: any) => {
      return (
        item.ticketInfo.ticketType === CouponType.voucher &&
        !store.order.ticketUseList.some((useItem: any) => useItem.ticketId === item.id)
      );
    });
  } else {
    if (!store.member.vipTicketVOList || store.member.vipTicketVOList.length === 0) {
      return [];
    }
    return store.member.vipTicketVOList.filter((item: any) => {
      return item.ticketInfo.ticketType === CouponType.voucher;
    });
  }
});

// 弹出框实例
const popoverRef = ref<PopoverInstance>();
const selected = ref<any>();

const handleChange = (coupon: any) => {
  emit('change', coupon);
  selected.value = '';
  popoverRef.value?.hide();
};
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
