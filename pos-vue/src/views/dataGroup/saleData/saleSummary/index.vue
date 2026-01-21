<template>
  <div class="main-container">
    <!-- 数据筛选 -->
    <Card class="operation-card">
      <!-- 第一行 -->
      <div class="search-container">
        <div class="search-item" v-if="false">
          <label for="staffStatus">选择店铺：</label>
          <el-select v-model="store.searchParams.storeId" id="staffStatus" style="width: 120px" placeholder="选择店铺">
            <el-option
              v-for="item in [{ value: 1, label: '' }]"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </div>
        <div class="search-item">
          <label>
            销售时段：
            <DatePicker v-model="store.searchParams.date" style="width: 260px" />
          </label>
        </div>
        <div class="search-item">
          <el-button type="primary" @click="search">搜索</el-button>
        </div>
        <div class="search-item">
          <el-button type="primary" @click="">导出表格</el-button>
        </div>
      </div>
    </Card>

    <!-- 数据列表 -->
    <Card padding="0">
      <PaginationTable
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :data="store.saleSummary.data"
        :showPagination="false"
        show-summary
      >
        <el-table-column type="index" label="序号" width="60" fixed />
        <el-table-column prop="statsDate" label="日期" width="105" :formatter="dateFormatter" fixed />
        <el-table-column prop="totalTurnover" label="总营业额" width="85" fixed />
        <el-table-column prop="totalActualReceipt" label="总实收" width="85" fixed />
        <el-table-column prop="totalSingleTime" label="总单次" width="80" />
        <el-table-column prop="totalPeopleTime" label="总人次" width="80" />
        <el-table-column prop="totalProjectCount" label="总项目数" width="85" />
        <el-table-column prop="refundAmount" label="退卡金额" width="85" />
        <el-table-column prop="managerSignAmount" label="经理签单金额" width="110" />
        <el-table-column prop="alipayRecharge" label="支付宝充值" width="95" />
        <el-table-column prop="bankCardRecharge" label="银行卡充值" width="95" />
        <el-table-column prop="cashRecharge" label="现金充值" width="85" />
        <el-table-column prop="wechatRecharge" label="微信充值" width="85" />
        <el-table-column prop="otherRecharge" label="其他方式充值" width="110" />
        <el-table-column prop="alipayPayment" label="支付宝支付" width="95" />
        <el-table-column prop="bankCardPayment" label="银行卡支付" width="95" />
        <el-table-column prop="cashPayment" label="现金支付" width="85" />
        <el-table-column prop="wechatPayment" label="微信支付" width="85" />
        <el-table-column prop="electronicCouponPayment" label="电子优惠券支付" width="125" />
        <el-table-column prop="physicalCouponPayment" label="实体优惠券支付" width="125" />
        <el-table-column prop="membershipCardPayment" label="会员卡支付" width="95" />
        <el-table-column prop="otherPayment" label="其他方式支付" width="110" />
      </PaginationTable>
    </Card>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import { dateFormatter } from '@/utils/formatter';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useSaleStore } from '@/store/modules/dataGroup/saleData';
const settingStore = useSettingStore();
const store = useSaleStore();

// 初始化
onMounted(() => {
  store.setSaleSummary();
});

// 搜索
const search = () => {
  store.setSaleSummary();
};
</script>

<style scoped lang="scss"></style>
