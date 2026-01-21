<template>
  <div class="main-container">
    <!-- 数据筛选 -->
    <Card class="operation-card">
      <!-- 第一行 -->
      <div class="search-container">
        <div class="search-item" v-if="false">
          <label>
            选择门店：
            <el-select v-model="store.searchParams.storeId" clearable style="width: 120px" placeholder="选择门店">
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
            开单时段：
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
            产品/项目：
            <el-select
              v-model="store.searchParams.orderCode"
              clearable
              placeholder="选择产品/项目"
              style="width: 140px"
            >
              <el-option label="未指定" value="0" />
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
            提成技师：
            <el-select
              v-model="store.searchParams.username"
              placeholder="请选择技师"
              clearable
              filterable
              style="width: 200px"
            >
              <el-option v-for="item in staffList" :key="item.userId" :label="item.userName" :value="item.userName" />
            </el-select>
          </label>
        </div>
        <div class="search-item">
          <el-button type="primary" @click="search">搜索</el-button>
        </div>
      </div>
    </Card>

    <!-- 数据列表 -->
    <Card padding="0">
      <PaginationTable
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :data="store.performanceRecord.data"
        :total="store.performanceRecord.total"
        v-model:currentPage="store.searchParams.pageNum"
        v-model:pageSize="store.searchParams.pageSize"
        @size-change="handleSizeChange"
        @pagination-current-change="handleCurrentChange"
        show-summary
      >
        <el-table-column type="index" label="序号" width="60" />
        <el-table-column prop="createTime" label="业绩日期" :formatter="dateFormatter" />
        <el-table-column label="订单编号" width="200">
          <template #default="scope">
            {{ scope.row.orderCode }}
          </template>
        </el-table-column>
        <el-table-column prop="serviceName" label="项目/产品/疗程名称" width="155" />
        <el-table-column label="类型">
          <template #default="scope">
            {{ formatServiceType(scope.row.serviceType) }}
          </template>
        </el-table-column>
        <el-table-column label="上钟类型">
          <template #default="scope">
            {{ formatPerfType(scope.row.itemType) }}
          </template>
        </el-table-column>
        <el-table-column prop="quantity" label="数量" />
        <el-table-column prop="userName" label="提成技师" />
        <el-table-column prop="performance" label="业绩金额" />
        <el-table-column prop="commission" label="提成金额" />
        <el-table-column label="操作" width="100">
          <template #default="scope">
            <el-button @click="showDialog(scope.row)" link type="primary">查看原单</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <el-dialog v-model="dialog.visible" title="收银单据" width="800px">
    <Receipt :receiptInfo="receiptInfo" />
  </el-dialog>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from 'vue';
import { ElMessage } from 'element-plus';
import { dateFormatter } from '@/utils/time';
import Receipt from './Receipt.vue';

import { useSettingStore } from '@/store/modules/acl/setting';
import { useStaffPerformanceStore } from '@/store/modules/dataGroup/staffPerformance';
import { useEnumStore, useDataEnumStore } from '@/store/modules/enums/index';

const settingStore = useSettingStore();
const store = useStaffPerformanceStore();
const enumStore = useEnumStore();
const dataEnumStore = useDataEnumStore();

// 上钟类型字典数据
const perfTypeList = ref<any[]>([]);
// 服务类型字典数据
const serviceTypeList = ref<any[]>([]);

// 获取上钟类型字典数据
const loadPerfTypeList = async () => {
  try {
    perfTypeList.value = await enumStore.getPerfTypeList();
  } catch (error) {
    console.error('获取上钟类型字典失败:', error);
    perfTypeList.value = [];
  }
};

// 获取服务类型字典数据
const loadServiceTypeList = async () => {
  try {
    serviceTypeList.value = await enumStore.getServiceTypeList();
  } catch (error) {
    console.error('获取服务类型字典失败:', error);
    serviceTypeList.value = [];
  }
};

// 技师列表
const staffList: any = ref([]);
const loadStaffList = async () => {
  try {
    staffList.value = await dataEnumStore.getStaffList();
  } catch (error) {
    console.error('加载技师列表失败:', error);
  }
};

// 上钟类型映射计算属性
const perfTypeMap = computed(() => {
  const map = new Map();
  perfTypeList.value.forEach((item: any) => {
    map.set(item.itemValue, item.itemLabel);
  });
  return map;
});

// 服务类型映射计算属性
const serviceTypeMap = computed(() => {
  const map = new Map();
  serviceTypeList.value.forEach((item: any) => {
    map.set(item.itemValue, item.itemLabel);
  });
  return map;
});

// 格式化上钟类型显示
const formatPerfType = (perfType: any) => {
  return perfTypeMap.value.get(String(perfType)) || perfType || '';
};

// 格式化服务类型显示
const formatServiceType = (serviceType: any) => {
  return serviceTypeMap.value.get(String(serviceType)) || serviceType || '';
};

// 初始化
onMounted(() => {
  loadPerfTypeList();
  loadServiceTypeList();
  loadStaffList();
  store.setPerformanceRecord();
});

// 搜索
const search = () => {
  store.setPerformanceRecord();
};

// 处理分页变化
const handleSizeChange = (val: number) => {
  store.searchParams.pageSize = val;
  store.setPerformanceRecord();
};

const handleCurrentChange = (val: number) => {
  store.searchParams.pageNum = val;
  store.setPerformanceRecord();
};

// 模态框
const dialog: any = reactive({
  title: '修改单据',
  visible: false,
});

const receiptInfo: any = ref({});

const showDialog = async (row: any) => {
  if (row.serviceType === 3) {
    ElMessage.info('充值订单暂不能查看原单');
    return;
  }

  try {
    // 使用store中的方法查询订单详情
    const orderDetail = await store.queryOrderDetail(row.orderCode);
    console.log(orderDetail);

    if (orderDetail) {
      receiptInfo.value = orderDetail;
      dialog.visible = true;
    }
  } catch (error) {
    console.error('查看原单失败:', error);
    // 错误处理已在store中统一处理，这里只需要记录日志
  }
};
</script>

<style scoped lang="scss"></style>
