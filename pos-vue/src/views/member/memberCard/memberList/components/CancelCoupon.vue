<template>
  <div class="coupon-list-container">
    <el-table :data="coupons" @select="selectRow" @select-all="selectAll" :border="true" stripe class="table-container">
      <el-table-column type="selection" width="55" />
      <el-table-column prop="couponDefInfo.couponName" label="优惠券名称" />
      <el-table-column prop="couponDefInfo.content" label="优惠券描述" />
      <el-table-column prop="fromType" label="领取来源" />
      <el-table-column prop="getTime" label="领取时间" :formatter="dateFormatter" />
      <el-table-column prop="limitTime" label="到期时间" :formatter="dateFormatter" />
    </el-table>
    <div>
      <el-button :disabled="selectedCoupons.length === 0" type="primary">取消优惠券</el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

import { dateFormatter } from '@/utils/formatter';

// 导入数据仓库
import { useMemberStore } from '@/store/modules/member/member';
const store = useMemberStore();

const coupons = ref(
  new Array(20)
    .fill({
      id: 2445739,
      orgId: 1459,
      couponId: 7179,
      couponNo: '145900000559',
      getTime: '2025-07-04 00:28:16',
      limitTime: '2028-03-29',
      memberId: 1223597,
      status: 0,
      promotionId: 0,
      expandStaffId: 46713,
      fromType: 3,
      fromBusId: 204801,
      transOutBusId: 0,
      updateUser: 46713,
      updateTime: '2025-07-04 00:28:15',
      shortDate: 250704,
      couponDefInfo: {
        id: 7179,
        orgId: 1459,
        isEntityTicket: 1,
        couponType: 151,
        couponName: '88元代金券',
        content: '88元代金券',
        quantityLimit: 1,
        useLimitRule: '{"value":88,"limitBuy":0}',
        shouldPay: 0.0,
        timeLimit: 999,
        isValid: 1,
        creator: 19149,
        createTime: '2024-07-05 23:55:58',
        updateUser: 19149,
        updateTime: '2024-07-05 23:55:58',
        remark: '',
        ruleDis: '优惠88.0元',
      },
    })
    .map((item, index) => ({
      ...item,
      id: index,
    })),
);

const selectedCoupons: any = ref([]);

const selectRow = <T = any>(selection: T[], row: T) => {
  if (selectedCoupons.value.includes(row)) {
    selectedCoupons.value.splice(row);
  } else {
    selectedCoupons.value.push(row);
  }
  console.log('selectedCoupons = ', selectedCoupons.value);
};

const selectAll = <T = any>(selection: T[]) => {
  if (selectedCoupons.value.length === coupons.value.length) {
    selectedCoupons.value = [];
  } else {
    selectedCoupons.value = selection;
  }
  console.log('selectedCoupons = ', selectedCoupons.value);
};
</script>
<style lang="scss" scoped>
.coupon-list-container {
  height: 500px;
  display: flex;
  flex-direction: column;
  gap: $main-padding;
  padding: $main-padding $main-padding * 2;

  > div:first-child {
    flex: 1;
  }

  > div:last-child {
    display: flex;
    justify-content: flex-end;
  }
}

/* 使用深度选择器修改表格表头样式 */
:deep(.table-container .el-table__header-wrapper th) {
  background-color: $base-child-nav-bg; // 使用自定义颜色变量
}
</style>
