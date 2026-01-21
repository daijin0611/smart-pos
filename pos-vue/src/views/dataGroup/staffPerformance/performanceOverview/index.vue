<template>
  <div class="main-container">
    <!-- 数据筛选 -->
    <Card class="operation-card">
      <!-- 第一行 -->
      <div class="search-container">
        <div class="search-item" v-if="false">
          <label>
            选择门店：
            <el-select v-model="store.searchParams.storeId" style="width: 120px" placeholder="选择门店">
              <el-option
                v-for="item in [{ value: 1, label: '' }]"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
          </label>
        </div>
        <div class="search-item">
          <label>
            销售时段：
            <DatePicker v-model="store.searchParams.date" style="width: 260px" />
          </label>
        </div>
      </div>

      <!-- 第二行 -->
      <div class="search-container">
        <!-- <div class="search-item">
          <label>
            选择部门：
            <el-select v-model="store.searchParams.saleStaff" clearable placeholder="选择部门" style="width: 120px">
              <el-option label="未指定" value="0" />
              <el-option
                v-for="item in [{ value: 1, label: '' }]"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
          </label>
        </div> -->
        <div class="search-item">
          <label>
            选择技师：
            <el-select
              v-model="store.searchParams.userId"
              clearable
              placeholder="选择技师"
              filterable
              style="width: 120px"
            >
              <el-option label="全部" :value="null" />
              <el-option v-for="item in staffList" :key="item.id" :label="item.userName" :value="item.id" />
            </el-select>
          </label>
        </div>
        <div class="search-item">
          <el-button type="primary" @click="search">搜索</el-button>
          <el-button type="success" @click="search">导出表格</el-button>
        </div>
      </div>
    </Card>

    <!-- 数据列表 -->
    <Card padding="0">
      <PaginationTable
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :data="store.performanceSummary"
        :showPagination="false"
        show-summary
      >
        <el-table-column type="index" label="序号" width="60" fixed />
        <el-table-column prop="userName" label="技师" width="100" fixed />
        <el-table-column prop="totalPerformance" label="总业绩" width="85" fixed />
        <el-table-column prop="totalCommission" label="总提成" width="85" fixed />
        <el-table-column prop="totalProjectCount" label="总项目次" width="85" />
        <el-table-column prop="appointmentCount" label="点钟次数" width="85" />
        <el-table-column prop="rotationCount" label="轮牌次数" width="85" />
        <el-table-column prop="extendCount" label="加钟次数" width="85" />
        <el-table-column prop="projectPerformance" label="项目业绩" width="85" />
        <el-table-column prop="projectCommission" label="项目提成" width="85" />
        <el-table-column prop="productPerformance" label="产品业绩" width="85" />
        <el-table-column prop="productCommission" label="产品提成" width="85" />
        <el-table-column prop="cureTicketPerformance" label="疗程销售业绩" width="110" />
        <el-table-column prop="cureTicketCommission" label="疗程销售提成" width="110" />
        <el-table-column prop="rechargePerformance" label="卡金业绩" width="85" />
        <el-table-column prop="rechargeCommission" label="卡金提成" width="85" />
      </PaginationTable>
    </Card>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useStaffPerformanceStore } from '@/store/modules/dataGroup/staffPerformance';
import { useDataEnumStore } from '@/store/modules/enums/index';

const settingStore = useSettingStore();
const store = useStaffPerformanceStore();
const dataEnumStore = useDataEnumStore();

// 技师列表
const staffList: any = ref([]);
const loadStaffList = async () => {
  try {
    staffList.value = await dataEnumStore.getStaffList();
  } catch (error) {
    console.error('加载技师列表失败:', error);
  }
};

// 初始化
onMounted(() => {
  loadStaffList();
  store.setPerformanceSummary();
});

// 搜索
const search = () => {
  store.setPerformanceSummary();
};
</script>

<style scoped lang="scss"></style>
