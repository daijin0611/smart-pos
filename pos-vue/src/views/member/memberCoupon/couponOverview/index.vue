<template>
  <div class="main-container">
    <!-- 搜索组件区域 -->
    <Card class="operation-card">
      <div class="search-container">
        <!-- 状态 -->
        <div class="search-item">
          <label>
            <span>查询时段：</span>
            <DatePicker v-model="store.summaryParams.dateRange" @change="search"></DatePicker>
          </label>
        </div>

        <!-- 搜索 -->
        <div class="search-item">
          <el-button type="primary" @click="search">搜索</el-button>
        </div>
      </div>
    </Card>

    <!-- 数据列表 -->
    <Card class="table-card">
      <Table
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :data="store.couponSummary"
      >
        <el-table-column prop="couponStatType" label="优惠券统计类型" :formatter="couponTypeMap" />
        <el-table-column label="赠送数量/金额">
          <template #default="{ row }">
            <p>赠送数量：{{ row.numOfSend }}张</p>
            <p>赠送金额：￥{{ row.amountOfSend }}</p>
          </template>
        </el-table-column>
        <el-table-column label="使用数量/金额">
          <template #default="{ row }">
            <p>使用数量：{{ row.numOfUse }}张</p>
            <p>使用金额：￥{{ row.amountOfUse }}</p>
          </template>
        </el-table-column>
        <el-table-column label="取消和失效数量/金额">
          <template #default="{ row }">
            <p>取消和失效数量：{{ row.numOfCancel }}张</p>
            <p>取消和失效金额：￥{{ row.amountOfCancel }}</p>
          </template>
        </el-table-column>
      </Table>
    </Card>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';

// 导入枚举数据
import { couponTypeMap } from '@/utils/formatter';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useCouponStore } from '@/store/modules/member/memberCoupon';
const settingStore = useSettingStore();
const store = useCouponStore();

onMounted(() => {
  store.setCouponSummary();
});

// 搜索
const search = () => {
  store.setCouponSummary();
};
</script>

<style scoped lang="scss"></style>
