<template>
  <div class="container">
    <el-table :data="arr" :border="true" height="100%" stripe class="table-container">
      <el-table-column prop="rechargeTime" label="充值时间" width="170" />
      <el-table-column label="充值金额及资产编号" min-width="100">
        <template #default="scope">
          <p>
            <span>赠送：￥{{ scope.row.rechargeAwardedAmount || scope.row.rechargeAmount }}</span>
            <span>&nbsp;({{ JSON.parse(scope.row.finInfos)[0].finNo }})</span>
          </p>
        </template>
      </el-table-column>
      <el-table-column label="门店余额变化">
        <template #default="scope">
          <p>充值前：￥{{ scope.row.beforeRechargeOrgBanlance }}</p>
          <p>充值前：￥{{ scope.row.afterRechargeOrgBanlance }}</p>
        </template>
      </el-table-column>
      <el-table-column prop="orgName" label="充值机构" />
    </el-table>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

// 导入数据仓库
import { useMemberStore } from '@/store/modules/member/member';
const store = useMemberStore();

const consumptions = ref([
  {
    id: 2007451,
    rechargeNo: '225052514590004',
    memberId: 1182953,
    orgId: 1459,
    rechStatusType: 1,
    rechargeType: 169,
    rechargeTime: '2025-05-25 18:25:51',
    promotionId: 0,
    rechargeAmount: 0,
    rechargeAwardedAmount: 353,
    beforeRechargeBanlance: 216.3,
    afterRechargeBanlance: 569.3,
    beforeRechargeOrgBanlance: 182.3,
    afterRechargeOrgBanlance: 535.3,
    finInfos: '[{"awardedFin":true,"finId":5238215,"finNo":"004FEDC7"}]',
    moreSaleMan: 0,
    firstRecharge: 0,
    wxPay: 0,
    aliPay: 0,
    cashPay: 0,
    bankPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    otherPay: 0,
    discountBaseType: 0,
    discountRate: 79,
    allowCrossStore: 0,
    awardedDiscountBaseType: 0,
    awardedDiscountRate: 79,
    awardedAllowCrossStore: 0,
    diffPromDiscount: 0,
    cardNo: '',
    manualGift: 1,
    operator: 46713,
    updateTime: '2025-05-25 18:25:51',
    updateUser: 46713,
    shortDate: 250525,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    orgName: '郑州棉纺路店',
    memName: '毛先生',
    memCode: '019501380',
    levelCode: 'N',
    cellPhoneNo: '19913140198',
    rechargeTypeName: '门店充值',
    operatorName: '刘',
  },
  {
    id: 1994553,
    rechargeNo: '225051314590001',
    memberId: 1182953,
    orgId: 1459,
    rechStatusType: 1,
    rechargeType: 169,
    rechargeTime: '2025-05-13 18:14:59',
    promotionId: 105923,
    rechargeAmount: 680,
    rechargeAwardedAmount: 0,
    beforeRechargeBanlance: 34,
    afterRechargeBanlance: 714,
    beforeRechargeOrgBanlance: 0,
    afterRechargeOrgBanlance: 680,
    finInfos: '[{"awardedFin":false,"finId":5217365,"finNo":"004F9C55"}]',
    moreSaleMan: 0,
    firstRecharge: 1,
    wxPay: 680,
    aliPay: 0,
    cashPay: 0,
    bankPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    otherPay: 0,
    discountBaseType: 0,
    discountRate: 79,
    allowCrossStore: 0,
    awardedDiscountBaseType: 0,
    awardedDiscountRate: 79,
    awardedAllowCrossStore: 0,
    diffPromDiscount: 0,
    cardNo: '',
    manualGift: 0,
    operator: 46713,
    updateTime: '2025-05-13 18:14:59',
    updateUser: 46713,
    shortDate: 250513,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    orgName: '郑州棉纺路店',
    memName: '毛先生',
    memCode: '019501380',
    levelCode: 'N',
    cellPhoneNo: '19913140198',
    rechargeTypeName: '门店充值',
    salesManNames: '胡娅妮',
    operatorName: '刘',
    promTitle: '680送88项目一次',
  },
]);

const arr = ref(new Array(20).fill(consumptions.value[0]));
</script>

<style lang="scss" scoped>
.container {
  height: 100%;
}

/* 使用深度选择器修改表格表头样式 */
:deep(.table-container .el-table__header-wrapper th) {
  background-color: $base-child-nav-bg; // 使用自定义颜色变量
}
</style>
