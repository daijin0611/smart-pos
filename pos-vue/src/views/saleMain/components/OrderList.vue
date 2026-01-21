<template>
  <div class="order-list-container">
    <!-- 头部操作 -->
    <header class="order-list-header">
      <div class="order-count">账单明细({{ orderStore.orderCount }})</div>
      <div class="operation-btns">
        <el-button type="primary" link size="large" @click="handleCleanOrder">清空</el-button>
        <EditDiscountPrice @confirm="handleDiscountConfirm">
          <template #reference>
            <el-button type="success" plain round size="small">打折优惠</el-button>
          </template>
        </EditDiscountPrice>
      </div>
    </header>

    <!-- 资产概览 -->
    <div v-if="orderStore.checkedAssetInfo.assetIds.length > 0" class="selected-property-count">
      <span>当前选择资产为：{{ orderStore.checkedAssetInfo.assetTitle || '' }}</span>
      <span>，总余额：{{ orderStore.checkedAssetInfo.assetAmount || 0 }}</span>
    </div>
    <div v-else class="el-center selected-property-count">
      <el-text type="danger">存在不同折扣类型的资产，选择的资产不同，结账金额可能会变化</el-text>
    </div>

    <!-- 订单明细 -->
    <div class="order-content">
      <el-scrollbar>
        <DetailCard
          v-for="(item, index) in orderStore.order.details"
          :key="item.id"
          :index="index + 1"
          :data="item"
          @delete="handleDeleteItem"
        />
        <div style="height: 110px"></div>
      </el-scrollbar>
    </div>
    <div v-show="coupons && coupons.length > 0" class="coupon-list-container">
      <el-divider>
        <el-radio-group v-model="tabSwitch">
          <el-radio-button :value="0" :border="false" size="small">本单可选优惠券</el-radio-button>
          <el-radio-button :value="1" :border="false" size="small">所有优惠券</el-radio-button>
        </el-radio-group>
      </el-divider>
      <el-scrollbar class="coupon-content">
        <template v-if="coupons && coupons.length > 0">
          <CouponCard v-for="(item, index) in coupons" :key="item.id" :coupon="item" :active="couponActive(item)" />
        </template>
        <Empty v-else description="暂无优惠券" />
      </el-scrollbar>
    </div>
    <footer class="order-list-footer">
      <div class="left-footer">
        <div class="pay-info">
          <span class="pay-amount">
            待付款:
            <b>￥{{ orderStore.truePayAmount }}</b>
          </span>
          <template v-if="orderStore.discountAmount > 0">
            <span class="original-amount">应付：￥{{ orderStore.payAmount }}</span>
          </template>
        </div>
        <div class="discount-info">
          <span class="coupon-amount" v-for="item in orderStore.order.ticketUseList" :key="item">
            已抵扣：{{ getCouponInfo(item.ticketId) }}元
          </span>
          <template v-if="orderStore.order.discountAmount > 0">
            <span class="discount-amount">打折优惠：{{ orderStore.order.discountAmount || 0 }}元</span>
          </template>
        </div>
      </div>
      <div class="right-footer">
        <template v-if="orderStore.order && orderStore.order.ticketUseList.length > 0">
          <el-button type="primary" link @click="handleCancelCoupon">取消所选优惠券</el-button>
        </template>
        <el-button type="primary" @click="handleSettle">结 算</el-button>
      </div>
    </footer>
  </div>
  <SettleForm v-model="settleDialogVisible" />
</template>

<script setup lang="ts">
import Message from '@/components/Message';
import DetailCard from './DetailCard.vue';
import CouponCard from './CouponCard.vue';
import EditDiscountPrice from './EditDiscountPrice.vue';
import SettleForm from './SettleForm.vue';
import MessageBox from '@/components/MessageBox';

import { ref, onMounted, computed } from 'vue';
import { CouponType, PaymentType, paymentTypeMap, CustomerType } from '@/enums/index';
import { useOrderStore } from '@/store/modules/order/index';
const orderStore = useOrderStore();

const handleCleanOrder = async () => {
  const result = await MessageBox.warning('确定清空订单吗？');
  if (result) {
    // orderStore.reset();
    orderStore.order.details = [];
  }
};

const handleDiscountConfirm = (discountAmount: number) => {
  orderStore.order.discountAmount = discountAmount;
};
/**
 * 处理删除订单明细项事件
 * @param index 订单明细项索引
 */
const handleDeleteItem = (item: any) => {
  const index = orderStore.order.details.findIndex((detail: any) => detail.index === item.index);
  orderStore.order.details.splice(index, 1);
};

const tabSwitch = ref(0);
const coupons = computed(() => {
  if (!orderStore.member.vipTicketVOList || orderStore.member.vipTicketVOList.length === 0) {
    return [];
  }
  if (tabSwitch.value === 0) {
    return orderStore.member.vipTicketVOList.filter((item: any) => {
      return item.ticketInfo.ticketType === CouponType.voucher;
    });
  } else {
    return orderStore.member.vipTicketVOList;
  }
});

const settleDialogVisible = ref(false);

// 处理结算事件
const handleSettle = () => {
  if (orderStore.order.customerType === CustomerType.Member && !orderStore.order.vipId) {
    Message.warning('请选择会员进行结算');
    return;
  }
  if (orderStore.order.customerType === CustomerType.Guest && orderStore.order.customerName === '') {
    Message.warning('请输入散客姓名后进行结算');
    return;
  }
  // 检查订单是否为空
  if (orderStore.order.details.length === 0) {
    Message.warning('订单不能为空');
    return;
  }

  orderStore.order.paymentInfoList = [];

  if (orderStore.order.customerType === CustomerType.Member) {
    if (orderStore.checkedAssetInfo.assetIds.length === 0) {
      Message.warning('会员存在不同类型的资产记录，请您选择至少一个条资产记录，进行结算');
      return;
    }
    let truePayAmount = orderStore.truePayAmount;
    for (const assetId of orderStore.checkedAssetInfo.assetIds) {
      const asset = orderStore.member.vipAssetVOList.find((assetItem: any) => assetItem.id === assetId);
      if (asset.assetBalance <= 0) {
        continue;
      }
      if (asset) {
        const paymentInfo = {
          paymentType: PaymentType.MemberCard,
          paymentName: paymentTypeMap[PaymentType.MemberCard],
          paymentAmount: truePayAmount,
          assetCode: asset.assetNum,
        };
        if (asset.assetBalance < truePayAmount) {
          paymentInfo.paymentAmount = asset.assetBalance;
          truePayAmount -= asset.assetBalance;
        }
        orderStore.order.paymentInfoList.push(paymentInfo);
      } else {
        Message.warning('未找到相关资产记录，请重新选择');
        return;
      }
    }
    const totalTruePayment = orderStore.order.paymentInfoList.reduce(
      (total: number, item: any) => (total += item.paymentAmount),
      0,
    );
    if (totalTruePayment < orderStore.truePayAmount) {
      orderStore.order.paymentInfoList.push({
        paymentType: PaymentType.WeChat,
        paymentName: paymentTypeMap[PaymentType.WeChat],
        paymentAmount: orderStore.truePayAmount - totalTruePayment,
        assetCode: '',
      });
    }
    settleDialogVisible.value = true;
  } else {
    orderStore.order.paymentInfoList.push({
      paymentType: PaymentType.WeChat,
      paymentName: paymentTypeMap[PaymentType.WeChat],
      paymentAmount: orderStore.truePayAmount,
      assetCode: '',
    });
    settleDialogVisible.value = true;
  }
};

const handleCancelCoupon = () => {
  orderStore.order.ticketUseList = [];
};

// 获取优惠券金额
const getCouponInfo = (id: number) => {
  const coupon = orderStore.member.vipTicketVOList.find((item: any) => item.id === id);
  if (coupon) {
    return coupon.ticketInfo.ticketValue;
  }
  return 0;
};

// 判断优惠券是否已选中
const couponActive = (item: any) => {
  return orderStore.order.ticketUseList.some((useItem: any) => useItem.ticketId === item.id);
};
</script>

<style lang="scss" scoped>
.order-list-container {
  $order-header-height: 40px;
  $order-footer-height: 80px;
  $selected-property-count-height: 30px;
  $coupon-list-container-height: 110px;

  height: 100%;
  position: relative;

  .order-list-header {
    height: $order-header-height;
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    > div {
      width: 50%;
      text-align: center;
    }
    .order-count {
      font-size: 16px;
      font-weight: 500;
      color: var(--el-text-color-regular);
    }
    .operation-btns {
    }
  }
  .selected-property-count {
    width: 100%;
    font-weight: 500;
    text-align: center;
    height: $selected-property-count-height;
    line-height: $selected-property-count-height;
    color: var(--el-color-success);
  }
  .coupon-list-container {
    position: absolute;
    bottom: $order-footer-height;
    left: 0;
    width: 100%;
    height: $coupon-list-container-height;
    // border-top: 1px solid var(--el-border-color);
    background-color: var(--el-bg-color);
    z-index: 1000;
    :deep(.el-divider) {
      margin-top: 0;
      > .el-divider__text {
        background: none;
      }
    }
    .coupon-content {
      width: 100%;
      height: calc(100% - 25px);
      display: flex;
      overflow-x: auto;
      :deep(.el-scrollbar__wrap) {
        width: 100%;
        .el-scrollbar__view {
          height: 100%;
        }
      }
    }
  }
  .order-list-footer {
    border-top: 1px solid var(--el-border-color);
    height: $order-footer-height;
    display: flex;
    > div {
      height: 100%;
      // border: 1px red solid;
    }
    .left-footer {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
      gap: 10px;
      padding-left: 20px;

      .pay-info {
        .pay-amount {
          font-size: 20px;
          color: var(--el-text-color-regular);
          > b {
            font-weight: 600;
            color: red;
          }
        }
        .original-amount {
          margin-left: 5px;
          font-size: 14px;
          font-weight: 500;
          color: red;
          text-decoration: line-through;
        }
      }
      .discount-info {
        width: 100%;
        > span {
          font-size: 14px;
          color: var(--el-color-success);
          margin-right: 5px;
          padding: 0 5px;
          border-radius: 4px;
          border: 1px solid var(--el-color-success);
        }
      }
    }
    .right-footer {
      width: 200px;
      display: flex;
      align-items: center;
      justify-content: flex-end;
      padding-right: 20px;
    }
  }
  .order-content {
    height: calc(100% - #{$order-header-height} - #{$order-footer-height} - #{$selected-property-count-height});
    > :deep(.el-scrollbar) {
      padding: 10px;
    }
  }
}
</style>
