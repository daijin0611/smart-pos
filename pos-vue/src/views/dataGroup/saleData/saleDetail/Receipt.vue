<template>
  <div class="dialog-container">
    <article class="consumption-detail" v-if="orderData">
      <div>
        <span>单据编号: {{ orderData.orderCode }}</span>
        <span>单据日期: {{ orderData.orderTime?.split(' ')[0] }}</span>
      </div>
      <div>
        <span>会员卡号: {{ orderData.vipCardNumber || '无' }}</span>
        <span>会员姓名: {{ orderData.vipName || orderData.customerName }}</span>
      </div>
      <div>
        <span>床位: {{ orderData.bedName }}</span>
        <span>销售员: {{ orderData.userName }}</span>
      </div>
      <div>
        <span>总金额: ¥{{ orderData.totalAmount }}</span>
        <span>实收金额: ¥{{ orderData.actualAmount }}</span>
      </div>
    </article>

    <div class="tab-container">
      <el-tabs type="border-card" style="height: 100%">
        <el-tab-pane class="tab-pane-content" style="height: 100%">
          <template #label>
            <span>项目/产品消费</span>
          </template>
          <el-table :data="orderData?.orderDetails || []" :border="true" height="100%" stripe class="table-container">
            <el-table-column prop="businessName" label="项目/产品名称" />
            <el-table-column prop="stdPrice" label="标准价" :formatter="priceFormatter" />
            <el-table-column prop="quantity" label="数量" />
            <el-table-column prop="truePrice" label="实收金额" :formatter="priceFormatter" />
            <el-table-column label="类型">
              <template #default="scope">
                <el-tag :type="getDetailTypeTagType(scope.row.detailType)">
                  {{ OrderDetailTypeMap[scope.row.detailType] || '未知' }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column label="技师/销售">
              <template #default="scope">
                {{ scope.row.userName }}
                <el-text
                  v-if="scope.row.detailType === 1 && scope.row.serverType !== null"
                  type="primary"
                  style="font-weight: bold; margin-left: 8px"
                >
                  [{{ ServiceTypeMap[scope.row.serverType] || scope.row.serverType }}]
                </el-text>
              </template>
            </el-table-column>
            <el-table-column prop="remark" label="备注" />
          </el-table>
        </el-tab-pane>
        <el-tab-pane>
          <template #label>
            <span>支付明细</span>
          </template>
          <article class="pay-detail">
            <div v-for="payment in orderData?.payments || []" :key="payment.id" class="payment-item">
              <span>{{ payment.paymentName }}</span>
              <span>¥{{ payment.totalAmount }}</span>
            </div>
            <div v-if="orderData?.vipId" class="balance-info">
              <span>消费前余额: ¥{{ orderData.beforeBalance }}</span>
              <span>消费后余额: ¥{{ orderData.afterBalance }}</span>
            </div>
          </article>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { OrderDetailTypeMap, ServiceTypeMap } from '@/enums';

// 定义props接收订单数据
const props = defineProps<{
  orderData: any;
}>();

// 价格格式化
const priceFormatter = (row: any, column: any, cellValue: any) => {
  return cellValue ? `¥${cellValue}` : '¥0';
};

// 获取明细类型标签颜色
const getDetailTypeTagType = (detailType: number) => {
  switch (detailType) {
    case 0:
      return 'success'; // 产品
    case 1:
      return 'primary'; // 项目
    case 2:
      return 'warning'; // 疗程
    case 3:
      return 'info'; // 套餐
    default:
      return '';
  }
};
</script>

<style lang="scss" scoped>
.dialog-container {
  height: 60vh;
  display: flex;
  flex-direction: column;
  padding: 0 $main-padding;

  .consumption-detail {
    width: 100%;
    line-height: 30px;
    margin-bottom: 20px;

    > div {
      display: flex;
      margin-bottom: 8px;
      > span {
        flex: 1;
        font-weight: 500;
      }
    }
  }

  .tab-container {
    flex: 1;
    height: calc(60vh - 120px);
  }

  .pay-detail {
    padding: 20px;
    line-height: 30px;

    .payment-item {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
      padding: 8px;
      background-color: #f5f7fa;
      border-radius: 4px;

      > span:first-child {
        width: 120px;
        font-weight: 500;
      }

      > span:last-child {
        color: #e6a23c;
        font-weight: bold;
      }
    }

    .balance-info {
      margin-top: 20px;
      padding-top: 20px;
      border-top: 1px solid #ebeef5;
      display: flex;
      justify-content: space-between;

      > span {
        color: #606266;
        font-size: 14px;
      }
    }
  }
}
</style>
