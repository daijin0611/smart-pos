<template>
  <el-dialog v-model="dialogVisible" :title="dialogTitle" @closed="close" width="800px">
    <el-tabs v-model="activeTab" type="border-card" class="modify-tabs">
      <!-- 支付方式修改 -->
      <el-tab-pane label="支付方式修改" name="payment">
        <div class="payment-section">
          <h1>修改支付方式：</h1>
          <div v-for="item in rechRecord.paymentInfoList" class="payment-item">
            <span>{{ item.paymentName }} ￥{{ item.paymentAmount }}</span>
            <el-select v-model="item.paymentType" placeholder="选择新支付方式">
              <el-option v-for="item in paymentTypeOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </div>
        </div>
      </el-tab-pane>

      <!-- 支付方式修改 -->
      <el-tab-pane label="销售技师修改" name="kpi">
        <div class="payment-section">
          <h1>修改销售技师：</h1>
          <div class="performance-technician-section">
            <div v-for="(technician, index) in rechRecord.userKpiList" :key="index" class="technician-row">
              <el-button :icon="Plus" circle size="small" @click="addTechnician" v-if="index === 0" />
              <el-button :icon="Minus" circle size="small" @click="removeTechnician(index)" v-if="index > 0" />
              <el-select
                v-model="technician.userId"
                placeholder="请选择"
                value-key="id"
                style="width: 120px; margin-left: 10px"
              >
                <el-option v-for="item in staffList" :key="item.id" :label="item.userName" :value="item.id" />
              </el-select>
              <el-input-number
                v-model="technician.kpi"
                :min="0"
                :controls="false"
                style="width: 120px; margin-left: 10px"
              >
                <template #suffix>元</template>
              </el-input-number>
            </div>
          </div>
        </div>
      </el-tab-pane>
    </el-tabs>
    <div class="submit-area">
      <el-button type="primary" @click="confirmModify">确定修改</el-button>
    </div>
  </el-dialog>
</template>

<script setup lang="ts">
import { Plus, Minus } from '@element-plus/icons-vue';
import { ref, onMounted, watch } from 'vue';
import { paymentTypeMap, paymentTypeOptions } from '@/enums/index';
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
      rechRecord.value = val;
      if (val.userKpiList && val.userKpiList.length == 0) {
        rechRecord.value.userKpiList.push(cloneDeep(DEFAULT_USER_KPI));
      }
    }
  },
);

onMounted(() => {
  getStaffList();
});

const DEFAULT_USER_KPI = {
  userId: '',
  userName: '',
  kpi: 0,
};

// 控制弹窗显隐
const dialogVisible = ref<boolean>(false);
const dialogTitle = ref('修改单据');
// 重置表单
const close = () => {
  emit('update:visible', false);
};
// 提交按钮loading
const btnLoading = ref<boolean>(false);
// 当前充值记录
const rechRecord = ref<any>({});
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

/** 处理支付信息 */
const handlePaymentType = (payList: any) => {
  if (!Array.isArray(payList)) {
    return [];
  }

  try {
    for (const item of payList) {
      item.paymentName = paymentTypeMap[item.paymentType || 0];
    }
    return payList;
  } catch (error) {
    console.error(error);
  }
  return [];
};

/** 处理销售技师信息 */
const handleKpiList = (kpiList: any) => {
  if (!Array.isArray(kpiList)) {
    return [];
  }

  try {
    for (const item of kpiList) {
      item.userName = staffMap[item.userId || 0];
    }
    return kpiList;
  } catch (error) {
    console.error(error);
  }
  return [];
};

// 确定修改按钮事件
const confirmModify = () => {
  const paymentList = handlePaymentType(rechRecord.value.paymentInfoList);
  const kpiList = handleKpiList(rechRecord.value.userKpiList);
  console.log('paymentList', paymentList);
  console.log('kpiList', kpiList);

  // 可在此处编写调用接口修改数据的逻辑
  // console.log('确定修改，当前激活标签页：', activeTab.value);
  if (activeTab.value === 'payment') {
    // console.log('优惠券支付新方式：', couponPayment.value);
    // console.log('会员卡支付新方式：', cardPayment.value);
  } else {
    // console.log('项目修改数据：', projectList.value);
  }
};

// 添加业绩技师
const addTechnician = () => {
  try {
    rechRecord.value.userKpiList.push({ userId: '', userName: '', kpi: 0 });
  } catch (error) {
    console.error(error);
  }
};

// 移除业绩技师
const removeTechnician = (index: number) => {
  try {
    if (rechRecord.value.userKpiList.length > 1) {
      rechRecord.value.userKpiList.splice(index, 1);
    }
  } catch (error) {
    console.error(error);
  }
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
  margin-top: 20px;
}
</style>
