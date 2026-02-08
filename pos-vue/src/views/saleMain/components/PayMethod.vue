<template>
  <div class="payment-methods">
    <div v-for="(payment, index) in store.order.paymentInfoList" :key="index" class="payment-row">
      <el-button :icon="Plus" circle size="small" @click="addPaymentMethod" v-if="index === 0" />
      <el-button :icon="Minus" circle size="small" @click="removePaymentMethod(index)" v-if="index > 0" />
      <el-select v-model="payment.paymentType" placeholder="请选择支付方式" style="width: 120px; margin-left: 10px">
        <el-option v-for="item in paymentTypeOptions" :key="item.value" :label="item.label" :value="item.value" />
      </el-select>
      <el-input-number
        v-model="payment.paymentAmount"
        :min="0"
        :controls="false"
        style="width: 120px; margin-left: 10px"
      >
        <template #suffix>元</template>
      </el-input-number>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Plus, Minus } from '@element-plus/icons-vue';
import { paymentTypeOptions, paymentTypeMap, PaymentType } from '@/enums';
import { useOrderStore } from '@/store/modules/order/index';
const store = useOrderStore();

// 添加支付方式
const addPaymentMethod = () => {
  store.order.paymentInfoList.push({
    paymentType: PaymentType.WeChat,
    paymentName: paymentTypeMap[PaymentType.WeChat],
    paymentAmount: 0,
    assetCode: '',
  });
};

// 移除支付方式
const removePaymentMethod = (index: number) => {
  if (store.order.paymentInfoList.length > 1) {
    store.order.paymentInfoList.splice(index, 1);
  }
};
</script>

<style lang="scss" scoped>
.payment-methods {
  width: 100%;
}

.payment-row {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.payment-row:last-child {
  margin-bottom: 0;
}
</style>
