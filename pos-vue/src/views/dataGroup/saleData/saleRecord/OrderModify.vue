<template>
  <el-dialog v-model="dialogVisible" :title="dialogTitle" @closed="close" width="800px">
    <el-tabs v-model="activeTab" type="border-card" class="modify-tabs">
      <!-- 支付方式修改 -->
      <el-tab-pane label="支付方式修改" name="payment">
        <div class="payment-section">
          <h1>修改支付方式：</h1>
          <div v-for="item in orderData.payments" class="payment-item">
            <span>{{ item.paymentName }} ￥{{ item.totalAmount }}</span>
            <el-select
              v-model="item.paymentType"
              :disabled="item.paymentType === PaymentType.MemberCard"
              placeholder="选择新支付方式"
            >
              <el-option v-for="item in paymentTypeOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </div>
        </div>
      </el-tab-pane>

      <!-- 技师/项目修改 -->
      <el-tab-pane label="技师/项目修改" name="technician">
        <el-alert title="修改产品/项目时，技师业绩会发生变化" type="warning" />

        <el-table
          :data="orderData.orderDetails"
          :border="true"
          size="small"
          height="400px"
          style="width: 100%; margin-top: 10px"
        >
          <el-table-column label="价格/数量" min-width="100">
            <template #default="{ row }">
              <div>单价: {{ row.truePrice || 0 }} 元</div>
              <div>数量: {{ row.quantity || 0 }}</div>
            </template>
          </el-table-column>
          <el-table-column label="名称/标准价" min-width="120">
            <template #default="{ row }">
              <div>{{ row.businessName }}</div>
              <div>标准价: {{ row.stdPrice }}</div>
            </template>
          </el-table-column>
          <el-table-column label="修改项目/产品" min-width="120">
            <template #default="{ row }">
              <el-select v-model="row.bid" placeholder="选择项目">
                <template v-if="row.detailType === OrderDetailType.Product">
                  <el-option v-for="item in productList" :key="item.id" :label="item.productName" :value="item.id" />
                </template>
                <template v-if="row.detailType === OrderDetailType.Service">
                  <el-option v-for="item in serviceItemList" :key="item.id" :label="item.itemName" :value="item.id" />
                </template>
                <template v-if="row.detailType === OrderDetailType.TreatmentCoupon">
                  <el-option v-for="item in treatmentCouponList" :key="item.id" :label="item.name" :value="item.id" />
                </template>
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="技师/销售" min-width="100">
            <template #default="{ row }">
              <div>{{ row.userName }}</div>
            </template>
          </el-table-column>
          <el-table-column label="修改技师/销售" min-width="120">
            <template #default="{ row }">
              <el-select v-model="row.userId" placeholder="选择人员">
                <el-option v-for="item in staffList" :key="item.id" :label="item.userName" :value="item.id" />
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="修改上钟类型" min-width="120">
            <template #default="{ row }">
              <el-select v-model="row.serverType" placeholder="选择类型">
                <el-option
                  v-for="item in ServiceTypeOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                />
              </el-select>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>
    </el-tabs>
    <template #footer>
      <div class="submit-area">
        <el-button type="primary" :loading="loading" @click="confirmModify">确定修改</el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';
import { PaymentType, paymentTypeMap, paymentTypeOptions, ServiceTypeOptions, OrderDetailType } from '@/enums/index';
import { useDynamicDataStore } from '@/store/modules/enums/dynamicData';
import { cloneDeep } from 'lodash';

const dynamicDataStore = useDynamicDataStore();

interface Props {
  data: any;
  // 弹窗显隐
  visible: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  data: () => {},
  visible: false,
});

const emit = defineEmits<{
  (e: 'update:visible', value: boolean): void;
  (e: 'refresh'): void;
}>();

watch(
  () => props.visible,
  (val) => {
    dialogVisible.value = val || false;
  },
);

watch(
  () => props.data,
  (val) => {
    if (val) {
      orderData.value = val;
      // rechRecord.value = val;
      // if (val.userKpiList && val.userKpiList.length == 0) {
      //   rechRecord.value.userKpiList.push(cloneDeep(DEFAULT_USER_KPI));
      // }
    }
  },
);

onMounted(async () => {
  // const products = computed(async () => await enumsStore.getProductList());
  // const serviceItems = computed(async () => await enumsStore.getServiceItemList());
  // const treatmentCoupons = computed(async () => await enumsStore.getTreatmentCouponList());
  getStaffList();
  productList.value = (await dynamicDataStore.getProductList()).data;
  serviceItemList.value = (await dynamicDataStore.getServiceItemList()).data;
  treatmentCouponList.value = (await dynamicDataStore.getTreatmentCouponList()).data;
});

const productList = ref<any>([]);
const serviceItemList = ref<any>([]);
const treatmentCouponList = ref<any>([]);

// 控制弹窗显隐
const dialogVisible = ref<boolean>(false);
const dialogTitle = ref('修改单据');
// 重置表单
const close = () => {
  emit('update:visible', false);
};

const orderData = ref<any>({});
// 标签页激活状态
const activeTab = ref('payment');

// 销售员列表
const staffList = ref<any>([]);
const staffMap = ref<Record<number, string>>({});
const getStaffList = async () => {
  const res = await dynamicDataStore.getUserList();
  if (res && res.data && res.data.rows) {
    staffList.value = res.data.rows || [];
    staffMap.value = staffList.value.map((item: any) => ({ [item.id]: item.userName }));
  }
};

const loading = ref(false);

// 确定修改按钮事件
const confirmModify = () => {
  // 可在此处编写调用接口修改数据的逻辑
  try {
    loading.value = true;
  } catch (error) {}
  loading.value = false;
};
</script>

<style scoped lang="scss">
.modify-tabs {
  margin: 10px 20px;
}

.payment-section {
  padding: 10px;

  h1 {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 20px;
  }

  .payment-item {
    display: flex;
    align-items: center;
    margin-bottom: $main-padding;

    span {
      width: 160px;
    }

    .el-select {
      width: 200px;
    }
  }
}

.submit-area {
  display: flex;
  justify-content: flex-end;
  padding-right: 20px;
}
</style>
