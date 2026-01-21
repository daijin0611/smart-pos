<template>
  <div class="coupon-info" :class="{ active: active }">
    <template v-if="coupon.ticketInfo.ticketType === CouponType.voucher">
      <span class="title text-overflow" :title="`抵扣金额：${coupon.ticketInfo.ticketValue} 元`">
        抵扣金额：{{ coupon.ticketInfo.ticketValue }} 元
      </span>
    </template>
    <template v-else>
      <span class="title text-overflow" :title="getServerItems(coupon.ticketInfo.serverItems)">
        {{ getServerItems(coupon.ticketInfo.serverItems) }}
      </span>
    </template>
    <div class="coupon-tip text-overflow" :title="coupon.ticketInfo.ticketName">
      {{ coupon.ticketInfo.ticketName }}
    </div>
    <div class="coupon-tip text-overflow" :title="`${getExpiryDate(coupon.expiryDate)}`">
      {{ getExpiryDate(coupon.expiryDate) }}
    </div>
  </div>
</template>

<script setup lang="ts">
import { CouponType } from '@/enums/index';

interface Props {
  active: boolean;
  coupon: {
    expiryDate: string;
    ticketInfo: {
      ticketName: string;
      ticketDescription: string;
      ticketValue: number;
      ticketType: number;
      ticketFullPayment: number;
      ticketStatus: number;
      ticketEffectiveTime: number;
      serverItems: {
        id: number;
        itemName: string;
      }[];
    };
  };
}

const props = withDefaults(defineProps<Props>(), {
  active: true,
});

const getExpiryDate = (expiryDate: string) => {
  let result = '到期时间：';
  if (expiryDate) {
    result = expiryDate;
  } else {
    result = '长期有效';
  }
  return result;
};

const getServerItems = (serverItems: any) => {
  if (serverItems) {
    return serverItems.map((item: any) => item.itemName).join('、');
  } else {
    return '';
  }
};
</script>

<style lang="scss" scoped>
.coupon-info.active {
  background-color: var(--el-color-primary);
  .title {
    color: #fff;
  }
  .coupon-tip {
    color: var(--el-fill-color-light);
    opacity: 0.9;
  }
}
.coupon-info {
  display: inline-block;
  width: 150px;
  height: 60px;
  font-size: 13px;
  font-weight: 700;
  box-shadow: var(--el-color-primary-light-7) 0px 0px 5px;
  text-align: center;
  background-color: rgb(255, 255, 255);
  flex-shrink: 0;
  margin: 8px 0px 8px 20px;
  border-radius: 3px;
  padding: 5px;
  transition: 0.3s ease-in-out;
  .title {
    color: var(--el-color-primary);
    width: 100%;
    display: inline-block;
    cursor: default;
  }

  .coupon-tip {
    cursor: default;
    width: 100%;
    display: inline-block;
    font-size: 11px;
    margin-top: 5px;
    color: rgb(136, 136, 136);
  }
}
</style>
