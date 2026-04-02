<template>
  <div class="container">
    <PaginationTable
      v-loading="settingStore.loading"
      :data="arr"
      :total="tableData.total"
      v-model:currentPage="searchParams.pageNum"
      v-model:pageSize="searchParams.pageSize"
      @size-change="handleSizeChange"
      @pagination-current-change="handleCurrentChange"
    >
      <el-table-column prop="tradeTime" label="消费时间" />
      <el-table-column prop="actualAmount" label="支付类型" />
      <el-table-column prop="salesNo" label="关联单号" />
      <el-table-column prop="orgName" label="消费门店" />
      <el-table-column label="操作">
        <template #default>
          <el-button type="primary" link @click="visible = true">查看消费明细</el-button>
        </template>
      </el-table-column>
    </PaginationTable>
  </div>

  <Dialog v-model="visible" title="消费明细" width="60%">
    <div class="dialog-container">
      <article class="consumption-detail">
        <div>
          <span>单据编号: 125070314590016</span>
          <span>单据日期: 2025-07-03</span>
        </div>
        <div>
          <span>会员卡号: N145900813</span>
          <span>会员姓名: 刘涵</span>
        </div>
      </article>

      <div class="tab-container">
        <el-tabs type="border-card" style="height: 100%">
          <el-tab-pane class="tab-pane-content" style="height: 100%">
            <template #label>
              <span>项目/产品消费</span>
            </template>
            <el-table :data="consumptions" :border="true" height="100%" stripe class="table-container">
              <el-table-column prop="tradeTime" label="项目/产品消费" />
              <el-table-column prop="actualAmount" label="标准价" />
              <el-table-column prop="salesNo" label="数量" />
              <el-table-column prop="orgName" label="金额" />
              <el-table-column prop="orgName" label="上钟类型" />
              <el-table-column prop="orgName" label="技师/销售" />
            </el-table>
          </el-tab-pane>
          <el-tab-pane>
            <template #label>
              <span>支付明细</span>
            </template>
            <article class="pay-detail">
              <div>
                <span>会员卡支付</span>
                <span>118</span>
              </div>
              <div>
                <span>消费资产明细</span>
                <el-tag>0005:118元</el-tag>
              </div>
            </article>
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </Dialog>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue';

// 导入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useMemberStore } from '@/store/modules/member/member';
const settingStore = useSettingStore();
const store = useMemberStore();

const visible = ref(false);

const searchParams = reactive({
  pageNum: 1,
  pageSize: 10,
});

const tableData = reactive({ total: 0, list: [] });

const getConsumptionRecord = async () => {
  settingStore.loading = true;
  // const res = await reqGetConsumptionRecord(searchParams);
  // const result = parseResMsg(res, '获取消费记录成功');
  // if (result) {
  //   tableData.total = result.total;
  //   tableData.list = result.list;
  // }
  settingStore.loading = false;
};

// 处理分页变化
const handleSizeChange = (val: number) => {
  searchParams.pageSize = val;
  getConsumptionRecord();
};

const handleCurrentChange = (val: number) => {
  searchParams.pageNum = val;
  getConsumptionRecord();
};

const consumptions = ref([
  {
    id: 23003453,
    orgId: 1459,
    salesNo: '125070414590006',
    tradeTime: '2025-07-04 18:47:09',
    memberId: 866407,
    beforeBalance: 583.8,
    afterBalance: 499.43,
    beforeUnionBalance: 583.8,
    afterUnionBalance: 499.43,
    shouldAmount: 143,
    actualAmount: 84.37,
    discountAmount: 58.63,
    optDiscount: 0,
    optDisId: 0,
    totalCost: 0,
    commissionAmount: 41,
    cashPay: 0,
    memberCardPay: 84.37,
    bankCardPay: 0,
    wechatPay: 0,
    aliPay: 0,
    couponsPay: 0,
    entityCouponPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    lianLianPay: 0,
    otherPay: 0,
    createrUserId: 46713,
    settleUserId: 46713,
    orderStatus: 39,
    transSettleAmount: 0,
    transBrandId: 0,
    signBillStaffId: 0,
    timesCardInfo: '',
    createTime: '2025-07-04 18:10:14',
    updateTime: '2025-07-04 18:47:09',
    updateUserId: 46713,
    batchFlag: '',
    batchNum: 1,
    shortDate: 250704,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    receiptCoupon: 0,
    orgName: '郑州棉纺路店',
    memName: '杨丹',
    memCode: '145900499',
    levelCode: 'N',
    cellPhoneNo: '15039056751',
    createUserName: '刘',
    settleUserName: '刘',
  },
  {
    id: 22846567,
    orgId: 1459,
    salesNo: '125062214590011',
    tradeTime: '2025-06-22 18:13:22',
    memberId: 866407,
    beforeBalance: 616.25,
    afterBalance: 583.8,
    beforeUnionBalance: 616.25,
    afterUnionBalance: 583.8,
    shouldAmount: 55,
    actualAmount: 32.45,
    discountAmount: 22.55,
    optDiscount: 0,
    optDisId: 0,
    totalCost: 0,
    commissionAmount: 17,
    cashPay: 0,
    memberCardPay: 32.45,
    bankCardPay: 0,
    wechatPay: 0,
    aliPay: 0,
    couponsPay: 0,
    entityCouponPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    lianLianPay: 0,
    otherPay: 0,
    createrUserId: 46713,
    settleUserId: 46713,
    orderStatus: 39,
    transSettleAmount: 0,
    transBrandId: 0,
    signBillStaffId: 0,
    timesCardInfo: '',
    createTime: '2025-06-22 18:12:33',
    updateTime: '2025-06-22 18:13:22',
    updateUserId: 46713,
    batchFlag: '',
    batchNum: 1,
    shortDate: 250622,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    receiptCoupon: 0,
    orgName: '郑州棉纺路店',
    memName: '杨丹',
    memCode: '145900499',
    levelCode: 'N',
    cellPhoneNo: '15039056751',
    createUserName: '刘',
    settleUserName: '刘',
  },
  {
    id: 22837011,
    orgId: 1459,
    salesNo: '125062114590023',
    tradeTime: '2025-06-21 22:13:58',
    memberId: 866407,
    beforeBalance: 668.17,
    afterBalance: 616.25,
    beforeUnionBalance: 668.17,
    afterUnionBalance: 616.25,
    shouldAmount: 88,
    actualAmount: 51.92,
    discountAmount: 36.08,
    optDiscount: 0,
    optDisId: 0,
    totalCost: 0,
    commissionAmount: 24,
    cashPay: 0,
    memberCardPay: 51.92,
    bankCardPay: 0,
    wechatPay: 0,
    aliPay: 0,
    couponsPay: 0,
    entityCouponPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    lianLianPay: 0,
    otherPay: 0,
    createrUserId: 46713,
    settleUserId: 46713,
    orderStatus: 39,
    transSettleAmount: 0,
    transBrandId: 0,
    signBillStaffId: 0,
    timesCardInfo: '',
    createTime: '2025-06-21 22:13:16',
    updateTime: '2025-06-21 22:13:58',
    updateUserId: 46713,
    batchFlag: '',
    batchNum: 1,
    shortDate: 250621,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    receiptCoupon: 0,
    orgName: '郑州棉纺路店',
    memName: '杨丹',
    memCode: '145900499',
    levelCode: 'N',
    cellPhoneNo: '15039056751',
    createUserName: '刘',
    settleUserName: '刘',
  },
  {
    id: 22749475,
    orgId: 1459,
    salesNo: '125061514590008',
    tradeTime: '2025-06-15 16:15:19',
    memberId: 866407,
    beforeBalance: 756.17,
    afterBalance: 668.17,
    beforeUnionBalance: 756.17,
    afterUnionBalance: 668.17,
    shouldAmount: 176,
    actualAmount: 88,
    discountAmount: 88,
    optDiscount: 0,
    optDisId: 0,
    totalCost: 0,
    commissionAmount: 40,
    cashPay: 0,
    memberCardPay: 88,
    bankCardPay: 0,
    wechatPay: 0,
    aliPay: 0,
    couponsPay: 0,
    entityCouponPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    lianLianPay: 0,
    otherPay: 0,
    createrUserId: 46713,
    settleUserId: 46713,
    orderStatus: 39,
    transSettleAmount: 0,
    transBrandId: 0,
    signBillStaffId: 0,
    timesCardInfo: '',
    createTime: '2025-06-15 16:14:39',
    updateTime: '2025-06-15 16:15:20',
    updateUserId: 46713,
    batchFlag: '',
    batchNum: 1,
    shortDate: 250615,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    receiptCoupon: 0,
    orgName: '郑州棉纺路店',
    memName: '杨丹',
    memCode: '145900499',
    levelCode: 'N',
    cellPhoneNo: '15039056751',
    createUserName: '刘',
    settleUserName: '刘',
  },
  {
    id: 22701547,
    orgId: 1459,
    salesNo: '125061114590019',
    tradeTime: '2025-06-11 21:39:11',
    memberId: 866407,
    beforeBalance: 901.31,
    afterBalance: 756.17,
    beforeUnionBalance: 901.31,
    afterUnionBalance: 756.17,
    shouldAmount: 246,
    actualAmount: 145.14,
    discountAmount: 100.86,
    optDiscount: 0,
    optDisId: 0,
    totalCost: 0,
    commissionAmount: 74,
    cashPay: 0,
    memberCardPay: 145.14,
    bankCardPay: 0,
    wechatPay: 0,
    aliPay: 0,
    couponsPay: 0,
    entityCouponPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    lianLianPay: 0,
    otherPay: 0,
    createrUserId: 46713,
    settleUserId: 46713,
    orderStatus: 39,
    transSettleAmount: 0,
    transBrandId: 0,
    signBillStaffId: 0,
    timesCardInfo: '',
    createTime: '2025-06-11 21:38:54',
    updateTime: '2025-06-11 21:39:11',
    updateUserId: 46713,
    batchFlag: '',
    batchNum: 1,
    shortDate: 250611,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    receiptCoupon: 0,
    orgName: '郑州棉纺路店',
    memName: '杨丹',
    memCode: '145900499',
    levelCode: 'N',
    cellPhoneNo: '15039056751',
    createUserName: '刘',
    settleUserName: '刘',
  },
  {
    id: 22696573,
    orgId: 1459,
    salesNo: '125061114590011',
    tradeTime: '2025-06-11 17:11:21',
    memberId: 866407,
    beforeBalance: 933.76,
    afterBalance: 901.31,
    beforeUnionBalance: 933.76,
    afterUnionBalance: 901.31,
    shouldAmount: 55,
    actualAmount: 32.45,
    discountAmount: 22.55,
    optDiscount: 0,
    optDisId: 0,
    totalCost: 0,
    commissionAmount: 17,
    cashPay: 0,
    memberCardPay: 32.45,
    bankCardPay: 0,
    wechatPay: 0,
    aliPay: 0,
    couponsPay: 0,
    entityCouponPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    lianLianPay: 0,
    otherPay: 0,
    createrUserId: 46713,
    settleUserId: 46713,
    orderStatus: 39,
    transSettleAmount: 0,
    transBrandId: 0,
    signBillStaffId: 0,
    timesCardInfo: '',
    createTime: '2025-06-11 17:11:01',
    updateTime: '2025-06-11 17:11:21',
    updateUserId: 46713,
    batchFlag: '',
    batchNum: 1,
    shortDate: 250611,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    receiptCoupon: 0,
    orgName: '郑州棉纺路店',
    memName: '杨丹',
    memCode: '145900499',
    levelCode: 'N',
    cellPhoneNo: '15039056751',
    createUserName: '刘',
    settleUserName: '刘',
  },
  {
    id: 22396927,
    orgId: 1459,
    salesNo: '125052014590006',
    tradeTime: '2025-05-20 18:56:07',
    memberId: 866407,
    beforeBalance: 966.21,
    afterBalance: 933.76,
    beforeUnionBalance: 966.21,
    afterUnionBalance: 933.76,
    shouldAmount: 55,
    actualAmount: 32.45,
    discountAmount: 22.55,
    optDiscount: 0,
    optDisId: 0,
    totalCost: 0,
    commissionAmount: 17,
    cashPay: 0,
    memberCardPay: 32.45,
    bankCardPay: 0,
    wechatPay: 0,
    aliPay: 0,
    couponsPay: 0,
    entityCouponPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    lianLianPay: 0,
    otherPay: 0,
    createrUserId: 46713,
    settleUserId: 46713,
    orderStatus: 39,
    transSettleAmount: 0,
    transBrandId: 0,
    signBillStaffId: 0,
    timesCardInfo: '',
    createTime: '2025-05-20 18:55:50',
    updateTime: '2025-05-20 18:56:07',
    updateUserId: 46713,
    batchFlag: '',
    batchNum: 1,
    shortDate: 250520,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    receiptCoupon: 0,
    orgName: '郑州棉纺路店',
    memName: '杨丹',
    memCode: '145900499',
    levelCode: 'N',
    cellPhoneNo: '15039056751',
    createUserName: '刘',
    settleUserName: '刘',
  },
  {
    id: 22380323,
    orgId: 1459,
    salesNo: '125051914590003',
    tradeTime: '2025-05-19 15:20:33',
    memberId: 866407,
    beforeBalance: 1018.13,
    afterBalance: 966.21,
    beforeUnionBalance: 1018.13,
    afterUnionBalance: 966.21,
    shouldAmount: 88,
    actualAmount: 51.92,
    discountAmount: 36.08,
    optDiscount: 0,
    optDisId: 0,
    totalCost: 0,
    commissionAmount: 24,
    cashPay: 0,
    memberCardPay: 51.92,
    bankCardPay: 0,
    wechatPay: 0,
    aliPay: 0,
    couponsPay: 0,
    entityCouponPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    lianLianPay: 0,
    otherPay: 0,
    createrUserId: 46713,
    settleUserId: 46713,
    orderStatus: 39,
    transSettleAmount: 0,
    transBrandId: 0,
    signBillStaffId: 0,
    timesCardInfo: '',
    createTime: '2025-05-19 15:19:51',
    updateTime: '2025-05-19 15:20:33',
    updateUserId: 46713,
    batchFlag: '',
    batchNum: 1,
    shortDate: 250519,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    receiptCoupon: 0,
    orgName: '郑州棉纺路店',
    memName: '杨丹',
    memCode: '145900499',
    levelCode: 'N',
    cellPhoneNo: '15039056751',
    createUserName: '刘',
    settleUserName: '刘',
  },
  {
    id: 22218199,
    orgId: 1459,
    salesNo: '125050714590009',
    tradeTime: '2025-05-07 19:50:21',
    memberId: 866407,
    beforeBalance: 1154.42,
    afterBalance: 1018.13,
    beforeUnionBalance: 1154.42,
    afterUnionBalance: 1018.13,
    shouldAmount: 231,
    actualAmount: 136.29,
    discountAmount: 94.71,
    optDiscount: 0,
    optDisId: 0,
    totalCost: 0,
    commissionAmount: 65,
    cashPay: 0,
    memberCardPay: 136.29,
    bankCardPay: 0,
    wechatPay: 0,
    aliPay: 0,
    couponsPay: 0,
    entityCouponPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    lianLianPay: 0,
    otherPay: 0,
    createrUserId: 46713,
    settleUserId: 46713,
    orderStatus: 39,
    transSettleAmount: 0,
    transBrandId: 0,
    signBillStaffId: 0,
    timesCardInfo: '',
    createTime: '2025-05-07 19:49:47',
    updateTime: '2025-05-07 19:50:21',
    updateUserId: 46713,
    batchFlag: '',
    batchNum: 1,
    shortDate: 250507,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    receiptCoupon: 0,
    orgName: '郑州棉纺路店',
    memName: '杨丹',
    memCode: '145900499',
    levelCode: 'N',
    cellPhoneNo: '15039056751',
    createUserName: '刘',
    settleUserName: '刘',
  },
  {
    id: 22061425,
    orgId: 1459,
    salesNo: '125042614590005',
    tradeTime: '2025-04-26 17:12:52',
    memberId: 866407,
    beforeBalance: 1186.87,
    afterBalance: 1154.42,
    beforeUnionBalance: 1186.87,
    afterUnionBalance: 1154.42,
    shouldAmount: 55,
    actualAmount: 32.45,
    discountAmount: 22.55,
    optDiscount: 0,
    optDisId: 0,
    totalCost: 0,
    commissionAmount: 17,
    cashPay: 0,
    memberCardPay: 32.45,
    bankCardPay: 0,
    wechatPay: 0,
    aliPay: 0,
    couponsPay: 0,
    entityCouponPay: 0,
    meiTuanPay: 0,
    kouBeiPay: 0,
    douYinPay: 0,
    lianLianPay: 0,
    otherPay: 0,
    createrUserId: 46713,
    settleUserId: 46713,
    orderStatus: 39,
    transSettleAmount: 0,
    transBrandId: 0,
    signBillStaffId: 0,
    timesCardInfo: '',
    createTime: '2025-04-26 17:12:21',
    updateTime: '2025-04-26 17:12:52',
    updateUserId: 46713,
    batchFlag: '',
    batchNum: 1,
    shortDate: 250426,
    onlinePay: 0,
    onlinePayAmount: 0,
    payState: 0,
    receiptCoupon: 0,
    orgName: '郑州棉纺路店',
    memName: '杨丹',
    memCode: '145900499',
    levelCode: 'N',
    cellPhoneNo: '15039056751',
    createUserName: '刘',
    settleUserName: '刘',
  },
]);

const arr = ref(new Array(20).fill(consumptions.value[0]));
</script>

<style lang="scss" scoped>
.container {
  height: 100%;
}

.dialog-container {
  height: 60vh;
  display: flex;
  flex-direction: column;

  > div:last-child {
    flex: 1;
  }
  .tab-container {
    height: calc(60vh - 90px);
  }

  .consumption-detail {
    width: 60%;
    padding: 15px;
    line-height: 30px;
    height: 90px;

    > div {
      display: flex;
      > span {
        flex: 1;
      }
    }
  }

  .pay-detail {
    padding: 30px;
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
