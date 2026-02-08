<template>
  <div class="detail-container">
    <header class="detail-header">
      <div class="detail-header-row">
        <div>
          <span>创建时间：</span>
          <span>{{ data.createTime }}</span>
        </div>
        <div>
          <span>入库单号：</span>
          <span>{{ data.orderCode }}</span>
        </div>
      </div>
      <div class="detail-header-row">
        <div>
          <span>操作人：</span>
          <span>{{ data.operator }}</span>
        </div>
        <div>
          <span>总金额：</span>
          <span>￥{{ data.totalPrice }}</span>
        </div>
      </div>
    </header>

    <div class="detail-content">
      <PaginationTable
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :data="data.items"
        :show-pagination="false"
      >
        <el-table-column prop="productName" label="产品名称" min-width="7" />
        <el-table-column prop="productCode" label="产品编码" min-width="5" />
        <el-table-column prop="unit" label="计量单位" min-width="5" :formatter="unitFormatter" />
        <el-table-column prop="quantity" label="入库数量" min-width="5" />
        <el-table-column prop="price" label="单价" min-width="5" />
        <el-table-column prop="remark" label="备注" min-width="10" />
      </PaginationTable>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';

import { useEnumStore } from '@/store/modules/enums/index';
import { useSettingStore } from '@/store/modules/acl/setting';
const enumStore = useEnumStore();
const settingStore = useSettingStore();

const data = ref<any>({});

const props = defineProps<{
  data: any;
}>();

onMounted(() => {
  data.value = props.data;
});

watch(
  () => props.data,
  () => {
    data.value = props.data;
  },
);

const unitList = ref<any>([]);
const getUnitList = async () => {
  unitList.value = await enumStore.getUnits();
};
getUnitList();

/**
 * 单位格式化
 * @param row 行数据
 * @param column 列数据
 * @param cellValue 单元格值
 * @param index 行索引
 * @returns 单位名称
 */
const unitFormatter = (row: any, column: any, cellValue: number, index: number) => {
  const unit = unitList.value.find((item: any) => item.itemValue === cellValue);
  return unit?.itemLabel || '-';
};
</script>

<style lang="scss" scoped>
.detail-container {
  height: 60vh;
  padding: 0 10px 10px 10px;

  .detail-header {
    display: flex;
    flex-direction: column;
    line-height: 30px;
    margin-bottom: 10px;

    .detail-header-row {
      display: flex;
      > div {
        flex: 1;
        > span:first-child {
          width: 80px;
          text-align: right;
          display: inline-block;
        }
        > span:last-child {
          font-weight: 600;
        }
      }
    }
  }

  .detail-content {
    height: calc(60vh - 80px);
  }
}
</style>
