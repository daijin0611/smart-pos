<template>
  <div class="search-container">
    <div class="search-item">
      <label>
        <span>时间段：</span>
        <DatePicker v-model="searchParams.date" @change="search" @clear="clearDate" style="width: 240px" />
      </label>
    </div>
    <div class="search-item">
      <label>
        <span>操作人：</span>
        <el-input v-model="searchParams.operator" placeholder="请输入操作人" clearable style="width: 110px" />
      </label>
    </div>
    <div class="search-item">
      <label>
        <span>订单号：</span>
        <el-input v-model="searchParams.orderCode" placeholder="请输入库存单号" clearable style="width: 180px" />
      </label>
    </div>
    <div class="search-item">
      <el-button type="primary" @click="search">搜索</el-button>
    </div>
    <div class="search-item">
      <el-button type="info" @click="reset">重置</el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue';
import { formatDateTime } from '@/utils/time';

const emit = defineEmits(['search']);

const searchParams = reactive<any>({
  endDate: '',
  startDate: '',
  date: [],
  operator: '',
  orderCode: '',
});

const search = () => {
  if (searchParams?.date?.length === 2) {
    searchParams.startDate = formatDateTime(searchParams.date[0]);
    searchParams.endDate = formatDateTime(searchParams.date[1]);
  }
  emit('search', searchParams);
};

const reset = () => {
  searchParams.endDate = '';
  searchParams.startDate = '';
  searchParams.operator = '';
  searchParams.orderCode = '';
  searchParams.date = [];
  emit('search', searchParams);
};

const clearDate = () => {
  searchParams.date = [];
  // delete searchParams.startDate;
  // delete searchParams.endDate;
  searchParams.endDate = '';
  searchParams.startDate = '';
  emit('search', searchParams);
};
</script>
