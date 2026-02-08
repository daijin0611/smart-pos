<template>
  <div class="main-container">
    <!-- 搜索组件区域 -->
    <Card class="operation-card">
      <div class="search-container">
        <!-- 状态 -->
        <div class="search-item">
          <label>
            <span>优惠券状态：</span>
            <el-select v-model="store.recordParams.status" @change="search" clearable style="width: 120px">
              <el-option
                v-for="item in couponRecordStatusOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
          </label>
        </div>

        <!-- 优惠券 -->
        <div class="search-item">
          <label>
            <span>优惠券：</span>
            <el-select v-model="store.recordParams.vipTicketId" @change="search" clearable style="width: 120px">
              <el-option v-for="item in coupons" :key="item.id" :label="item.ticketName" :value="item.id" />
            </el-select>
          </label>
        </div>

        <!-- 活动 -->
        <div class="search-item">
          <label>
            <span>活动：</span>
            <el-select v-model="store.recordParams.activeId" @change="search" clearable style="width: 120px">
              <el-option v-for="item in activities" :key="item.id" :label="item.activeName" :value="item.id" />
            </el-select>
          </label>
        </div>

        <!-- 发放员 -->
        <!-- <div class="search-item">
          <label>
            <span>发放员：</span>
            <el-select v-model="store.recordParams.ticketStatus" @change="search" style="width: 120px">
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </label>
        </div> -->
        <div class="search-item">
          <el-input
            v-model="store.recordParams.vipInfoFiled"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            clearable
            placeholder="会员信息关键字"
          >
            <template #append>
              <el-button type="primary" @click="search">搜索</el-button>
            </template>
          </el-input>
        </div>
      </div>
    </Card>

    <!-- 数据列表 -->
    <Card padding="0">
      <PaginationTable
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :data="store.couponRecords"
        :total="store.recordParams.total"
        v-model:currentPage="store.recordParams.pageNum"
        v-model:pageSize="store.recordParams.pageSize"
        @size-change="handleSizeChange"
        @pagination-current-change="handleCurrentChange"
      >
        <el-table-column prop="ticketName" label="代金券名称" min-width="100" />
        <el-table-column label="领取人" min-width="80">
          <template #default="{ row }">
            <p>会员姓名：{{ row.vipName }}</p>
            <p>会员卡号：{{ row.vipCardNumber }}</p>
            <p>电话号码：{{ row.vipPhoneNumber }}</p>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="使用状态" min-width="60">
          <template #default="{ row }">
            <el-tag :type="row.status === '未使用' ? 'success' : 'danger'">{{ row.status }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="时间" min-width="60">
          <template #default="{ row }">
            <p>领取时间：{{ row.claimTime }}</p>
            <p>到期时间：{{ row.expiryDate || '长期有效' }}</p>
          </template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" min-width="60" />
        <!-- <el-table-column prop="fromType" label="领取来源类型" min-width="60" />
        <el-table-column prop="expandStaffName" label="销售员" min-width="50" /> -->
        <!-- <el-table-column label="操作" min-width="50">
          <template #default="{ row }">
            <el-button link type="info" @click="">延期</el-button>
          </template>
        </el-table-column> -->
      </PaginationTable>
    </Card>
  </div>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { ref, onMounted } from 'vue';

// 导入枚举数据
import { couponRecordStatusOptions } from '@/enums/index';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useRechargeActivityStore } from '@/store/modules/member/rechargeActivity';
import { useCouponStore } from '@/store/modules/member/memberCoupon';
const settingStore = useSettingStore();
const activityStore = useRechargeActivityStore();
const store = useCouponStore();

onMounted(() => {
  search();
  getActivities();
  getCoupons();
});

// 搜索
const search = () => {
  store.setCouponRecords();
};

// 处理分页变化
const handleSizeChange = (val: number) => {
  store.recordParams.pageSize = val;
  store.setCouponRecords();
};

const handleCurrentChange = (val: number) => {
  store.recordParams.pageNum = val;
  store.setCouponRecords();
};

const activities = ref<any[]>([]);
const getActivities = async () => {
  const data = await activityStore.getActivities();
  activities.value = data;
};

const coupons = ref<any[]>([]);
const getCoupons = async () => {
  const data = await store.getCoupons();
  coupons.value = data;
};
</script>

<style scoped lang="scss">
:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
