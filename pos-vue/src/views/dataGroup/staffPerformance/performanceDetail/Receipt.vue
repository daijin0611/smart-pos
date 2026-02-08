<template>
  <div class="dialog-container">
    <article class="consumption-detail">
      <div>
        <span>单据编号: {{ receiptInfo?.orderCode || '-' }}</span>
        <span>单据日期: {{ receiptInfo?.orderTime || '-' }}</span>
      </div>
      <div>
        <span>会员卡号: {{ receiptInfo?.vipCardNumber || '-' }}</span>
        <span>会员姓名: {{ receiptInfo?.vipName || '-' }}</span>
      </div>
    </article>

    <div class="tab-container">
      <el-tabs type="border-card" style="height: 100%">
        <el-tab-pane class="tab-pane-content" style="height: 100%">
          <template #label>
            <span>项目/产品消费</span>
          </template>
          <el-table :data="receiptInfo?.orderDetails || []" :border="true" height="100%" stripe class="table-container">
            <el-table-column prop="businessName" label="项目/产品消费" />
            <el-table-column prop="stdPrice" label="标准价" />
            <el-table-column prop="quantity" label="数量" />
            <el-table-column prop="truePrice" label="金额" />
            <el-table-column label="上钟类型">
              <template #default="scope">
                {{ formatServiceType(scope.row.detailType) }}
              </template>
            </el-table-column>
            <el-table-column prop="userName" label="技师/销售" />
          </el-table>
        </el-tab-pane>
        <el-tab-pane>
          <template #label>
            <span>支付明细</span>
          </template>
          <article class="pay-detail">
            <div v-for="payment in receiptInfo?.payments || []" :key="payment.id">
              <span>{{ payment.paymentName }}</span>
              <span>{{ payment.totalAmount }}</span>
            </div>
            <div>
              <span>消费资产明细</span>
              <el-tag v-for="payment in receiptInfo?.payments || []" :key="payment.id">
                {{ payment.paymentName }}:{{ payment.totalAmount }}元
              </el-tag>
            </div>
          </article>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import { dateFormatter } from '@/utils/time';

const props = defineProps(['receiptInfo']);

// 格式化日期
const formatDate = (date: string | Date) => {
  if (!date) return '-';
  return dateFormatter(date);
};

// 格式化服务类型
const formatServiceType = (detailType: number) => {
  const typeMap: Record<number, string> = {
    0: '产品',
    1: '服务项目',
    2: '疗程券',
  };
  return typeMap[detailType] || '未知';
};
</script>

<style scoped lang="scss">
.dialog-container {
  height: 60vh;
  display: flex;
  flex-direction: column;
  padding: 0 $main-padding;

  .consumption-detail {
    width: 60%;
    line-height: 30px;
    height: 70px;

    > div {
      display: flex;
      > span {
        flex: 1;
      }
    }
  }

  .tab-container {
    flex: 1;
    height: calc(60vh - 70px);
  }

  .pay-detail {
    padding: 20px;
    line-height: 30px;

    > div {
      display: flex;
      align-items: flex-end;
      > span:first-child {
        width: 120px;
      }
    }
  }
}
</style>
