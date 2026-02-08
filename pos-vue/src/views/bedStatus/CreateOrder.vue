<template>
  <div>
    <el-descriptions size="large" :column="1">
      <el-descriptions-item label="床位名称：">{{ orderStore.orderForm.bedName }}</el-descriptions-item>
      <el-descriptions-item label="顾客类型：">
        <el-radio-group v-model="orderStore.orderForm.customerType">
          <el-radio
            v-for="item in CustomerTypeOptions"
            :value="item.value"
            :label="item.label"
            :key="item.value"
            :border="true"
          />
          <!-- :disabled="item.value == CustomerType.Guest" -->
        </el-radio-group>
      </el-descriptions-item>
      <el-descriptions-item v-show="orderStore.orderForm.customerType == CustomerType.Member" label="开单会员：">
        <SearchMember
          v-model="orderStore.orderForm.vipName"
          size="default"
          :showSearchButton="false"
          @selected="handleMemberSelected"
        />
      </el-descriptions-item>
      <el-descriptions-item v-show="orderStore.orderForm.customerType == CustomerType.Guest" label="散客姓名：">
        <el-input
          v-model="orderStore.orderForm.customerName"
          placeholder="请输入散客姓名"
          clearable
          style="width: 200px"
        />
      </el-descriptions-item>
    </el-descriptions>
    <Card padding="0px">
      <div style="margin: 10px 0 0 10px">
        <el-button type="primary" :disabled="type == 'view'" @click="showDialog(false)">新增明细</el-button>
      </div>
      <PaginationTable :data="orderStore.orderForm.orderDetails" :showPagination="false">
        <el-table-column prop="businessName" label="名称" />
        <el-table-column prop="truePrice" label="价格">
          <template #default="{ row }">
            <p>标准价￥{{ row.stdPrice }}</p>
            <p>实收价￥{{ row.truePrice }}</p>
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="技师/销售">
          <template #default="{ row }">
            <span>{{ row.userName }}</span>
            <span style="color: var(--el-color-primary); font-weight: 600">
              [{{ ServiceTypeMap[row.serverType as ServiceType] }}]
            </span>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template #default="{ row }">
            <el-button @click="showDialog(true, row)" link type="primary">编辑</el-button>
            <el-button @click="deleteOrderDetail(row)" link type="warning">删除</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
    <footer style="text-align: center; margin: 20px 0">
      <el-button type="default" @click="emit('close')">关闭</el-button>
      <el-button v-if="type === 'add'" type="primary" @click="createOrder">开单</el-button>
      <el-button v-if="type === 'view'" type="primary" @click="goCheckout">去结账</el-button>
    </footer>
  </div>
  <DetailForm v-model="dialogVisible" :handleType="handleType"></DetailForm>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { CustomerType, CustomerTypeOptions, ServiceType, ServiceTypeMap } from '@/enums/index';
import SearchMember from '@/components/Input/SearchMember.vue';
import Message from '@/components/Message';
import DetailForm from './DetailForm.vue';
import { cloneDeep } from 'lodash';
import { useOrderStore } from '@/store/modules/order/index';
const orderStore = useOrderStore();

const emit = defineEmits(['close', 'refresh', 'checkout']);
const props = defineProps({
  type: {
    type: String,
    default: 'add',
  },
});

onMounted(async () => {});

const createOrder = () => {
  orderStore.createOrder(() => {
    emit('refresh');
    emit('close');
  });
};

const goCheckout = () => {
  emit('checkout', { id: orderStore.orderForm.bedId });
};

const handleMemberSelected = (item: any) => {
  console.log('会员', item);
  orderStore.orderForm.vipId = item.id;
  orderStore.orderForm.vipName = item.name;
  orderStore.orderForm.vipPhoneNumber = item.phoneNumber;
  orderStore.orderForm.vipCardNumber = item.cardNumber;
};

// 删除开单明细
const deleteOrderDetail = (row: any) => {
  orderStore.orderForm.orderDetails.splice(orderStore.orderForm.orderDetails.indexOf(row), 1);
};

// #region 新增开单明细
const dialogVisible = ref(false);
const handleType = ref('add');
const showDialog = (type: boolean, row: any = {}) => {
  if (orderStore.orderForm.customerType === CustomerType.Member && !orderStore.orderForm.vipId) {
    Message.warning('请选择会员');
    return;
  }
  if (orderStore.orderForm.customerType === CustomerType.Guest && !orderStore.orderForm.customerName) {
    Message.warning('请输入散客姓名');
    return;
  }
  dialogVisible.value = true;
  if (type) {
    // 编辑
    handleType.value = 'edit';
    orderStore.detailForm = cloneDeep(row);
  } else {
    // 新增
    handleType.value = 'add';
    orderStore.resetDetailForm();
  }
};
</script>
