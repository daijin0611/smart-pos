<template>
  <PaginationTable
    :data="dataList"
    v-loading="settingStore.loading"
    :element-loading-text="settingStore.loadingMsg"
    :border="true"
    :stripe="true"
    :showPagination="false"
    size="small"
  >
    <el-table-column label="名称" width="100">
      <template #default="{ row }">
        {{ row.productName }}
      </template>
    </el-table-column>
    <el-table-column label="技师/销售" width="120">
      <template #default="{ row }">
        {{ row.serviceStaffName }}
      </template>
    </el-table-column>

    <el-table-column label="状态" width="80">
      <template #default="{ row }">
        {{ row.statusName }}
      </template>
    </el-table-column>
  </PaginationTable>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';

import { useSettingStore } from '@/store/modules/acl/setting';
const settingStore = useSettingStore();

const dataList: any = ref([]);

onMounted(async () => {
  settingStore.loading = true;

  dataList.value = [
    {
      acturalPrice: 0.0,
      bedID: 24737,
      bedName: '卡3',
      deductType: 0,
      deductValue: 0,
      finPayType: 0,
      id: 47307879,
      packageAmount: 0.0,
      packageID: 0,
      packageUUID: '',
      payKey: '',
      productID: 126719,
      productName: '套餐五选二',
      productType: 69,
      productTypeName: '服务',
      quantity: 1,
      salesID: 23171157,
      serviceStaffID: 44927,
      serviceStaffName: '李园园',
      serviceType: 89,
      standPrice: 138.0,
      thirdCouponDealId: 0,
      treatType: 0,
      updateUser: 46713,
    },
    {
      acturalPrice: 0.0,
      bedID: 24737,
      bedName: '卡3',
      deductType: 1,
      deductValue: 30,
      finPayType: 0,
      id: 47307881,
      packageAmount: 0.0,
      packageID: 0,
      packageUUID: '',
      payKey: '',
      productID: 107126,
      productName: '一次性工具',
      productType: 71,
      productTypeName: '卖品',
      quantity: 1,
      salesID: 23171157,
      serviceStaffID: 44927,
      serviceStaffName: '李园园',
      serviceType: 89,
      standPrice: 15.0,
      thirdCouponDealId: 0,
      treatType: 0,
      updateUser: 46713,
    },
  ];

  settingStore.loading = false;
});
</script>

<style lang="scss" scoped></style>
