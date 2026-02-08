<template>
  <div class="container">
    <el-table :data="properties" :border="true" stripe class="table-container">
      <el-table-column prop="orgName" label="门店" />
      <el-table-column prop="currOrgBalance" label="余额" />
      <el-table-column prop="currOrgCouponNum" label="优惠券" />
      <el-table-column label="操作">
        <template #default>
          <el-button type="primary" link>资产明细</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div class="property-detail">
      <el-table :data="memberOrgFinInfos" :border="true" stripe class="table-container">
        <el-table-column prop="finNo" label="资产编号" />
        <el-table-column prop="totalBalance" label="余额" />
        <el-table-column prop="awardedFin" label="资产类型" />
        <el-table-column prop="discountBaseType" label="折扣基础" />
        <el-table-column prop="discountRate" label="折扣率" />
        <el-table-column prop="allowCrossStore" label="跨店消费" />
        <el-table-column label="操作">
          <template #default>
            <el-button type="primary" link>修改</el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-table :data="memberOrgFinInfos" :border="true" stripe class="table-container">
        <el-table-column prop="finNo" label="资产编号" />
        <el-table-column prop="totalBalance" label="余额" />
        <el-table-column prop="awardedFin" label="资产类型" />
        <el-table-column prop="discountBaseType" label="折扣基础" />
        <el-table-column prop="discountRate" label="折扣率" />
        <el-table-column prop="allowCrossStore" label="跨店消费" />
        <el-table-column label="操作">
          <template #default>
            <el-button type="primary" link>修改</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

// 导入数据仓库
import { useMemberStore } from '@/store/modules/member/member';
const store = useMemberStore();

const properties = ref([
  {
    memberId: 866407,
    orgName: '郑州棉纺路店',
    currOrgBalance: 499.43,
    currOrgCouponNum: 0,
    availBalance: 499.43,
  },
]);

const memberOrgFinInfos = ref([
  {
    finId: 3539123,
    finNo: '003600B3',
    linkMemId: 926639,
    memberId: 866407,
    totalBalance: 34.0,
    cardType: '',
    entityCardNo: '',
    rechargeAmount: 0.0,
    awardedAmount: 2200.0,
    discountBaseType: 0,
    discountRate: 100,
    allowCrossStore: 0,
    awardedFin: 1,
    finStatus: 1,
    createTime: '2023-02-17',
    orgId: 1459,
    orgName: '郑州棉纺路店',
    brandId: 0,
    memCouponNum: 0,
  },
  {
    finId: 4716441,
    finNo: '0047F799',
    linkMemId: 926639,
    memberId: 866407,
    totalBalance: 13.0,
    cardType: '',
    entityCardNo: '',
    rechargeAmount: 1380.0,
    awardedAmount: 0.0,
    discountBaseType: 0,
    discountRate: 50,
    allowCrossStore: 0,
    awardedFin: 0,
    finStatus: 1,
    createTime: '2024-07-31',
    orgId: 1459,
    orgName: '郑州棉纺路店',
    brandId: 0,
    memCouponNum: 0,
  },
  {
    finId: 5089845,
    finNo: '004DAA35',
    linkMemId: 926639,
    memberId: 866407,
    totalBalance: 452.43,
    cardType: '',
    entityCardNo: '',
    rechargeAmount: 1380.0,
    awardedAmount: 0.0,
    discountBaseType: 0,
    discountRate: 59,
    allowCrossStore: 1,
    awardedFin: 0,
    finStatus: 1,
    createTime: '2025-03-01',
    orgId: 1459,
    orgName: '郑州棉纺路店',
    brandId: 0,
    memCouponNum: 0,
  },
]);
</script>
<style lang="scss" scoped>
.container {
  height: 100%;
  border: 1px $base-header-color solid;
  padding-bottom: 20px;

  .property-detail {
    display: flex;
    flex-direction: column;
    gap: $main-padding;
    width: 90%;
    margin: 0 auto;
    margin-top: $main-padding;
  }
}

/* 使用深度选择器修改表格表头样式 */
:deep(.table-container .el-table__header-wrapper th) {
  background-color: $base-child-nav-bg; // 使用自定义颜色变量
}
</style>
