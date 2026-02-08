<template>
  <div class="main-container">
    <!-- 数据筛选 -->
    <Card class="operation-card">
      <div class="search-container">
        <div class="search-item">
          <label>
            时间：
            <DatePicker v-model="store.search.date" style="width: 260px" />
          </label>
        </div>
        <div class="search-item">
          范围：
          <el-input
            v-model="store.search.fullAmount"
            :disabled="!!store.search.moreAmount"
            style="max-width: 180px"
            placeholder="输入金额"
            clearable
          >
            <template #prepend>消费满</template>
          </el-input>
          &nbsp;
          <el-input
            v-model="store.search.moreAmount"
            :disabled="!!store.search.fullAmount"
            style="max-width: 210px"
            placeholder="输入金额"
            clearable
          >
            <template #prepend>单词消费超过</template>
          </el-input>
        </div>
        <div class="search-item">
          <el-button type="primary" @click="search">搜索</el-button>
        </div>
        <div class="search-item">
          <el-button type="info" @click="store.resetSearch">重置</el-button>
        </div>
        <div class="search-item">
          <el-button type="success" @click="">导出所有会员</el-button>
        </div>
      </div>
    </Card>

    <!-- 数据列表 -->
    <Card padding="0">
      <PaginationTable
        v-loading="settingStore.loading && !dialog.visible"
        :element-loading-text="settingStore.loadingMsg"
        :data="store.tableData.list"
        :total="store.tableData.total"
        v-model:currentPage="store.search.currentPage"
        v-model:pageSize="store.search.pageSize"
        @size-change="handleSizeChange"
        @pagination-current-change="handleCurrentChange"
      >
        <el-table-column prop="name" label="姓名" min-width="60" />
        <el-table-column prop="gender" label="性别" min-width="30" :formatter="sexMap" />
        <el-table-column prop="cardNumber" label="卡号" min-width="80" />
        <el-table-column prop="phoneNumber" label="手机号" min-width="80" />
        <el-table-column prop="balance" label="店内总余额" min-width="80" :formatter="amountFormatter" />
        <el-table-column prop="lastConsumptionTime" label="末次消费日期" min-width="80" />
        <el-table-column prop="lastRechargeTime" label="末次充值日期" min-width="80" />
        <el-table-column label="操作" min-width="80">
          <template #default="{ row }">
            <el-button link type="primary" :disabled="true" @click="showDialog(row)">资产详情</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <el-dialog v-model="dialog.visible" :title="dialog.title" center width="800px">
    <PropertyDetail @close-dialog="dialog.visible = false" :memberId="dialog.memberId" />
  </el-dialog>
</template>

<script setup lang="ts">
import { reactive, onMounted } from 'vue';
import { sexMap, amountFormatter } from '@/utils/formatter';
import PropertyDetail from '../components/PropertyDetail.vue';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useMemberActiveAnalysisStore } from '@/store/modules/member/activeAnalysis';
const settingStore = useSettingStore();
const store = useMemberActiveAnalysisStore();

// 初始化
onMounted(() => {});

// 搜索
const search = () => {
  store.setTableData();
};

// 处理分页变化
const handleSizeChange = (val: number) => {
  store.search.pageSize = val;
  store.setTableData();
};

const handleCurrentChange = (val: number) => {
  store.search.currentPage = val;
  store.setTableData();
};

// 模态框
const dialog: any = reactive({
  title: '优惠券列表',
  visible: false,
  memberId: null,
});

// 打开模态框
const showDialog = (row: any) => {
  // 显示模态框
  dialog.title = `会员${row.name}在本店的资产详情`;
  dialog.visible = true;
  dialog.memberId = row.id;
};
</script>

<style scoped lang="scss">
:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
