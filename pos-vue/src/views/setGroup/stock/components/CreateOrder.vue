<template>
  <div class="create-container">
    <div class="container-left">
      <el-button type="primary" @click="getProductList" :disabled="formData.items.length > 0">获取产品数据</el-button>
      <div class="left-content">
        <div
          v-for="item in productList"
          @click="addItem(item)"
          :type="item.quantity == 0 ? 'danger' : 'primary'"
          :key="item.productId"
          class="product-card"
        >
          <span>{{ item.productName }}({{ item.productEncode }})</span>
          <span>剩余数量：{{ item.quantity }}</span>
        </div>
      </div>
    </div>
    <div class="container-right">
      <div class="right-header">
        <div class="header-item">
          <label>
            <span>操作人：</span>
            <el-input v-model="formData.operator" clearable style="width: 90px" placeholder="请输入操作人" />
          </label>
        </div>
        <div class="header-item">
          <label>
            <span>备注：</span>
            <el-input v-model="formData.remark" clearable style="width: 200px" placeholder="请输入备注" />
          </label>
        </div>
        <div class="header-item">
          <el-button
            type="primary"
            @click="createOrder"
            :loading="settingStore.loading"
            :disabled="formData.items.length === 0"
          >
            提交
          </el-button>
        </div>
        <div class="header-item">
          <el-button type="info" @click="resetFormData">重置</el-button>
        </div>
      </div>
      <div class="right-content">
        <PaginationTable
          :data="formData.items"
          :showPagination="false"
          :show-summary="true"
          :summary-method="summaryMethod"
        >
          <el-table-column prop="productName" label="产品" />
          <el-table-column prop="productEncode" label="编码">
            <template #default="{ row }">
              <span>{{ row.productEncode }}&nbsp;</span>
            </template>
          </el-table-column>
          <el-table-column prop="price" label="单价" />
          <el-table-column prop="quantity" label="库存" width="180">
            <template #default="{ row }">
              <el-input-number v-model="row.quantity" placeholder="请输入库存" :min="0" />
            </template>
          </el-table-column>
          <el-table-column prop="remark" label="备注" width="220">
            <template #default="{ row }">
              <el-input v-model="row.remark" placeholder="请输入备注" clearable />
            </template>
          </el-table-column>
          <el-table-column prop="handle" label="操作" width="80">
            <template #default="{ row }">
              <el-button type="danger" size="small" @click="removeItem(row)">删除</el-button>
            </template>
          </el-table-column>
        </PaginationTable>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, watch, inject } from 'vue';
import { getUserInfo } from '@/utils/localStorageTools';

import { useStockStore } from '@/store/modules/setGroup/stock';
import { useProductStore } from '@/store/modules/setGroup/product';
import { useSettingStore } from '@/store/modules/acl/setting';

const store = useStockStore();
const productStore = useProductStore();
const settingStore = useSettingStore();

const $Message: any = inject('$Message');

const props = defineProps({
  handle: {
    type: String,
    default: 'out',
  },
});

const emit = defineEmits(['submit']);

const productList = ref<any>();
const getProductList = async () => {
  if (formData.items.length > 0) {
    return;
  }
  const params = { productStatus: 0 };
  productList.value = await productStore.getProductList(params);
};

onMounted(async () => {
  await getProductList();
  const user = getUserInfo();
  formData.operator = user.userName;
});

const formData = reactive<any>({
  totalPrice: 0,
  operator: '',
  remark: '',
  items: [],
});

const createOrder = async () => {
  if (formData.items.length === 0) {
    $Message.warning('请选择产品');
    return;
  }
  if (formData.operator === '') {
    $Message.warning('请输入操作人');
    return;
  }
  settingStore.loading = true;
  let result = false;
  if (props.handle === 'in') {
    result = await store.addInStock(formData);
  } else {
    result = await store.addOutStock(formData);
  }
  if (result) {
    resetFormData();
    await getProductList();
    emit('submit');
  }
  settingStore.loading = false;
};

const addItem = (item: any) => {
  if (props.handle === 'out' && item.quantity == 0) {
    $Message.warning('库存不足');
    return;
  }

  formData.items.push({
    id: item.productId,
    productPrice: item.productPrice,
    productName: item.productName,
    productEncode: item.productEncode,
    quantityCopy: item.quantity,

    productId: item.id,
    quantity: 0,
    price: item.productPrice,
    remark: '',
  });

  productList.value.splice(productList.value.indexOf(item), 1);
};

const resetFormData = () => {
  formData.remark = '';
  formData.items = [];
  getProductList();
};

const removeItem = (row: any) => {
  row.quantity = row.quantityCopy;
  productList.value.push(row);
  formData.items.splice(formData.items.indexOf(row), 1);
};

watch(
  () => formData.items,
  (newVal) => {
    formData.totalPrice = newVal.reduce((total: any, item: any) => total + item.price * item.quantity, 0);
  },
  { deep: true },
);
watch(
  () => productList,
  (newVal) => {
    productList.value.sort((a: any, b: any) => a.quantity - b.quantity);
  },
  { deep: true },
);

const summaryMethod = (data: { columns: any[]; data: any[] }) => {
  const { columns, data: rows } = data;
  const sums: any = [];
  columns.forEach((item, index) => {
    if (index === 0) {
      sums[index] = '合计';
      return;
    }
    if (item.property === 'productEncode') {
      sums[index] = '';
      return;
    }
    if (item.property === 'remark') {
      sums[index] = '';
      return sums[index];
    }
    if (item.property === 'handle') {
      sums[index] = '';
      return;
    }
    if (item.property === 'price') {
      sums[index] = formData.totalPrice;
      return sums[index];
    }
    const values = rows.map((row) => row[item.property]);
    sums[index] = values.reduce((prev, cur) => {
      const value = Number(cur);
      if (!isNaN(value)) {
        return prev + value;
      } else {
        return prev;
      }
    }, 0);
  });
  return sums;
};
</script>

<style lang="scss" scoped>
.create-container {
  height: 70vh;
  padding: 0 10px 10px 10px;
  display: flex;
  gap: 15px;

  .container-left {
    width: 250px;
    height: 100%;
    padding: 10px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
    gap: 10px;

    .left-content {
      flex: 1;
      overflow: auto;
      display: flex;
      flex-direction: column;
      gap: 10px;
      flex-wrap: nowrap;
      padding: 10px 10px;

      .product-card {
        line-height: 25px;
        display: flex;
        flex-direction: column;
        flex-wrap: nowrap;
        cursor: pointer;
        border: 2px solid transparent;
        border-radius: 10px;
        padding: 10px;
        transition: 0.2s ease;

        &[type='primary'] {
          color: var(--el-color-primary-dark-2);
          background-color: var(--el-color-primary-light-9);
        }
        &[type='primary']:hover {
          box-shadow: 0 0 8px var(--el-color-primary-light-7);
          border: 2px solid var(--el-color-primary-light-7);
        }

        &[type='danger'] {
          color: var(--el-color-danger-dark-2);
          background-color: var(--el-color-danger-light-9);
        }
        &[type='danger']:hover {
          box-shadow: 0 0 8px var(--el-color-danger-light-7);
          border: 2px solid var(--el-color-error-light-7);
        }
      }
    }
  }

  .container-right {
    flex: 1;
    height: 100%;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;

    .right-header {
      display: flex;
      flex-direction: row;
      flex-wrap: nowrap;
      align-items: center;
      gap: 10px;
      padding: 10px 20px;
    }

    .right-content {
      flex: 1;
      padding: 10px;
      height: calc(100% - 72px);
    }
  }
}
</style>
