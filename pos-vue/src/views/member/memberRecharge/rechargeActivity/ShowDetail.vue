<template>
  <div class="detail-container">
    <header class="detail-header">
      <span>时间段：</span>
      <DatePicker @selectDate="selectDate" :default="defaultDate" style="width: 260px; margin-right: 10px" />
      <el-button type="primary">查询</el-button>
    </header>

    <div class="detail-content">
      <PaginationTable
        v-loading="loading"
        :element-loading-text="settingStore.loadingMsg"
        :data="[]"
        :show-pagination="false"
      >
        <el-table-column prop="productName" label="充值时间" min-width="100" />
        <el-table-column prop="productCode" label="姓名" min-width="60" />
        <el-table-column prop="unit" label="卡号" min-width="80" />
        <el-table-column prop="quantity" label="充值金额" min-width="70" />
        <el-table-column prop="price" label="赠送金额" min-width="70" />
        <el-table-column prop="price" label="赠送券数" min-width="70" />
        <el-table-column prop="remark" label="支付方式" min-width="70" />
      </PaginationTable>
    </div>

    <footer class="detail-footer">
      <el-text type="primary">合计: 参加人次3、总充值金额1500、总赠送金额0、总赠送优惠券数0</el-text>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed, watch, onUpdated } from 'vue';
import { formatDate } from '@/utils/time';
import { useSettingStore } from '@/store/modules/acl/setting';
const settingStore = useSettingStore();

const props = defineProps<{
  id: any;
}>();

// 默认最近一月日期
const defaultDate = computed(() => {
  const end = new Date();
  const start = new Date();
  start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
  return [start, end];
});
const start = formatDate(defaultDate.value[0]);
const end = formatDate(defaultDate.value[1]);

const loading = ref(false);

onMounted(() => {
  // search(start, end);
});

watch(
  () => props.id,
  (newVal) => {
    if (newVal) {
      search(start, end);
    }
  },
);

const search = async (start: string, end: string) => {
  loading.value = true;
  console.log('活动ID = ', props.id);
  await new Promise((resolve) => setTimeout(resolve, 1000));
  loading.value = false;
};

const selectDate = (start: string, end: string) => {
  search(start, end);
};
</script>

<style lang="scss" scoped>
.detail-container {
  $height: 60vh;
  $header-height: 30px;
  $footer-height: 30px;
  $content-height: calc(100% - $header-height - $footer-height);

  height: $height;
  max-height: 600px;

  .detail-header {
    height: $header-height;
    line-height: $header-height;
  }

  .detail-content {
    height: $content-height;
    padding: 10px 0;
  }

  .detail-footer {
    height: $footer-height;
    line-height: $footer-height;
  }
}
</style>
