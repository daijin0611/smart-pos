<template>
  <div class="data-view-container">
    <div class="left-content">
      <div class="content-top">
        <div class="filter-row">
          <div>日记单</div>
          <div>
            统计日期：
            <DatePicker v-model="dateRange" @change="handleDateChange" style="width: 260px; margin-right: 10px" />
            <el-button disabled @click="" plain>打印数据</el-button>
          </div>
        </div>
        <div class="chart-container">
          <div class="pie-chart-list">
            <div class="chart-item">
              <PieChart :data="store.incomeData" title="实收合计" radius="[40%, 70%]" height="100%" />
            </div>
            <div class="chart-item">
              <PieChart
                :data="store.performanceData"
                title="劳动业绩"
                radius="[40%, 70%]"
                height="100%"
                centerText="劳动业绩"
              />
            </div>
            <div class="chart-item">
              <PieChart
                :data="store.businessData"
                title="业务统计"
                radius="[40%, 70%]"
                height="100%"
                unit="次"
                :centerText="`总项目次\n${55}次`"
              />
            </div>
          </div>
          <div class="bar-chart-list">
            <BarChart
              :data="store.projectPerformanceData"
              title="项目和产品业绩"
              xAxisName=""
              yAxisName="单位(元)"
              height="100%"
            />
            <BarChart
              :data="store.rechargeData"
              :title="`充值/开卡，总额：￥${352525}`"
              xAxisName=""
              yAxisName="单位(元)"
              height="100%"
            />
          </div>
        </div>
      </div>
      <!-- <div class="content-bottom">
        <div class="bottom-item">
          <span></span>
          <span>会员公众号</span>
        </div>
        <div class="bottom-item">
          <span></span>
          <span>会员小程序</span>
        </div>
        <div class="bottom-item">
          <span></span>
          <span>员工小程序</span>
        </div>
        <div class="bottom-item">
          <span></span>
          <span>管理小程序</span>
        </div>
      </div> -->
    </div>

    <div class="right-content" v-loading="settingStore.loading" :element-loading-text="settingStore.loadingMsg">
      <PaginationTable
        :data="store.data.prodTreatSummary.productStatDetails"
        :showPagination="false"
        :stripe="false"
        containerHeight="auto"
        size="small"
        height="auto"
        show-summary
      >
        <el-table-column prop="prodName" label="科目" :align="'center'" />
        <el-table-column prop="countNum" label="数量" :align="'center'" />
        <el-table-column prop="countAmount" label="金额" :align="'center'" />
      </PaginationTable>

      <PaginationTable
        :data="store.data.prodStatSummary.productStatDetails"
        :showPagination="false"
        :stripe="false"
        containerHeight="auto"
        size="small"
        height="auto"
        show-summary
      >
        <el-table-column prop="prodName" label="科目" :align="'center'" />
        <el-table-column prop="countNum" label="数量" :align="'center'" />
        <el-table-column prop="countAmount" label="金额" :align="'center'" />
      </PaginationTable>
      <PaginationTable
        :data="store.data.itemStatSummary.productStatDetails"
        :showPagination="false"
        :summary-method="summaryMethod"
        :stripe="false"
        size="small"
        height="auto"
        containerHeight="auto"
        show-summary
      >
        <el-table-column prop="prodName" label="科目" :align="'center'" />
        <el-table-column prop="countNum" label="点 | 轮 | 加" :align="'center'">
          <template #default="{ row }">
            <div class="count-num">
              <span>{{ row.dianNum }}</span>
              <span>{{ row.lunNum }}</span>
              <span>{{ row.jiaNum }}</span>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="countAmount" label="金额" :align="'center'" />
      </PaginationTable>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue';
import { formatDateTime } from '@/utils/time';
import PieChart from '@/views/home/components/PieChart.vue';
import BarChart from '@/views/home/components/BarChart.vue';

import { useSettingStore } from '@/store/modules/acl/setting';
import { useHomeStore } from '@/store/modules/home/index';
const settingStore = useSettingStore();
const store = useHomeStore();

const dateRange = ref([new Date(), new Date()]);

const handleDateChange = async () => {
  if (dateRange.value.length === 0) {
    return;
  }
  const startDate = formatDateTime(dateRange.value[0]);
  const endDate = formatDateTime(dateRange.value[1]);
  console.log(startDate, endDate);
  // 这里可以添加实际的数据获取逻辑
};
handleDateChange();

const summaryMethod = (data: { columns: any[]; data: any[] }) => {
  const { columns, data: rows } = data;
  const sums: any = [];
  columns.forEach((item, index) => {
    if (index === 0) {
      sums[index] = '合计';
      return;
    }
    if (item.property === 'countNum') {
      const lun = calcTotal(rows, 'lunNum');
      const dian = calcTotal(rows, 'dianNum');
      const jia = calcTotal(rows, 'jiaNum');
      sums[index] = `点钟：${dian}；轮钟：${lun}；加钟：${jia}`;
      return;
    }

    sums[index] = calcTotal(rows, item.property);
  });
  return sums;
};
const calcTotal = (rows: any, key: string) => {
  const values = rows.map((row: any) => row[key]);
  const result = values.reduce((prev: any, cur: any) => {
    const value = Number(cur);
    if (!isNaN(value)) {
      return prev + value;
    } else {
      return prev;
    }
  }, 0);
  return result;
};
</script>

<style scoped lang="scss">
.data-view-container {
  width: 100%;
  height: 100%;
  background-color: $base-bg;
  display: flex;
  gap: 15px;

  .left-content {
    flex: 1;
    height: 100%;
    display: flex;
    flex-direction: column;
    gap: 15px;
    > div {
      border-radius: 5px;
      background-color: $base-main-bg;
    }
    .content-top {
      flex: 1;
      display: flex;
      flex-direction: column;
      gap: 15px;
      padding: 10px;
      color: var(--el-text-color-regular);
      overflow: auto;
      .filter-row {
        height: 32px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 10px;
      }
      .chart-container {
        height: calc(100% - 52px);
        > div {
          height: 50%;
        }

        .pie-chart-list {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          grid-template-rows: 1fr;
          gap: 15px;
          .chart-item {
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 0 2px rgba(0, 0, 0, 0.2);
          }
        }
        .bar-chart-list {
          display: grid;
          grid-template-columns: repeat(2, 1fr);
          grid-template-rows: 1fr;
        }
      }
    }
    .content-bottom {
      height: 160px;
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      grid-template-rows: 1fr;
      padding: 10px;
      gap: 10px;

      .bottom-item {
        height: 100%;
        font-size: 14px;
        text-align: center;
        > span:first-child {
          display: inline-block;
          width: 100%;
          height: calc(100% - 30px);
          margin-bottom: 10px;
          border-radius: 5px;
          background-color: $base-bg;
        }
      }
    }
  }

  .right-content {
    width: 400px;
    padding: 10px;
    height: 100%;
    border-radius: 5px;
    overflow: auto;
    background-color: $base-main-bg;
    display: flex;
    flex-direction: column;
    gap: 15px;

    .count-num {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      grid-template-rows: 1fr;
      span:first-child {
        border-right: 1px dashed gray;
      }
      span:last-child {
        border-left: 1px dashed gray;
      }
    }
  }
}
</style>
