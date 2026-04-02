<template>
  <Dialog :title="title" v-model="dialogVisible" @closed="closeDialog" width="700px" center>
    <el-form ref="formRef" :model="orderStore.detailForm" :rules="rules" @submit.native.prevent label-width="120px">
      <el-form-item label="明细类型：" prop="detailType">
        <el-radio-group v-model="orderStore.detailForm.detailType" @change="changeDetailType">
          <el-radio-button
            v-for="item in OrderDetailTypeOptions"
            :value="item.value"
            :label="item.label"
            :key="item.value"
          />
        </el-radio-group>
      </el-form-item>
      <!-- 服务项目 -->
      <div v-show="orderStore.detailForm.detailType === OrderDetailType.Service">
        <el-form-item label="选择项目：" prop="bid">
          <el-select
            v-model="orderStore.detailForm.bid"
            placeholder="请选择项目"
            filterable
            clearable
            @visible-change="selectVisibleChange($event, enumStore.getServiceItemList)"
            style="width: 240px"
          >
            <el-option
              v-for="item in enumStore.serviceItemList"
              :key="item.id"
              :label="item.itemName"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="服务类型：" prop="serverType">
          <el-radio-group v-model="orderStore.detailForm.serverType">
            <el-radio
              v-for="item in ServiceTypeOptions"
              :value="item.value"
              :label="item.label"
              :key="item.value"
              :border="true"
            />
          </el-radio-group>
        </el-form-item>
      </div>

      <!-- 产品 -->
      <div v-show="orderStore.detailForm.detailType === OrderDetailType.Product">
        <el-form-item label="选择产品：" prop="bid">
          <el-select
            v-model="orderStore.detailForm.bid"
            placeholder="请选择产品"
            filterable
            clearable
            @visible-change="selectVisibleChange($event, enumStore.getProductList)"
            style="width: 240px"
          >
            <el-option
              v-for="item in enumStore.productList"
              :key="item.id"
              :label="item.productName"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="数量：" prop="quantity">
          <el-input
            v-model.number="orderStore.detailForm.quantity"
            placeholder="请输入数量"
            clearable
            style="width: 240px"
          />
        </el-form-item>
      </div>
      <!-- 疗程 -->
      <div v-show="orderStore.detailForm.detailType === OrderDetailType.TreatmentCoupon">
        <el-form-item label="选择疗程：" prop="bid">
          <el-select
            v-model="orderStore.detailForm.bid"
            placeholder="请选择疗程"
            filterable
            clearable
            @visible-change="selectVisibleChange($event, enumStore.getTreatmentCouponList)"
            style="width: 240px"
          >
            <el-option
              v-for="item in enumStore.treatmentCouponList"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="数量：" prop="quantity">
          <el-input
            v-model.number="orderStore.detailForm.quantity"
            placeholder="请输入数量"
            clearable
            style="width: 240px"
          />
        </el-form-item>
      </div>

      <el-form-item label="技师/销售：" prop="userId">
        <el-select
          v-model="orderStore.detailForm.userId"
          placeholder="请选择技师/销售"
          filterable
          clearable
          @visible-change="selectVisibleChange($event, enumStore.getStaffList)"
          style="width: 240px"
        >
          <el-option v-for="item in enumStore.staffList" :key="item.id" :label="item.userName" :value="item.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input
          type="textarea"
          v-model="orderStore.detailForm.remark"
          placeholder="请输入备注"
          :row="2"
          style="width: 240px"
        />
      </el-form-item>
    </el-form>

    <template #footer>
      <el-button type="default" @click="dialogVisible = false">取消</el-button>
      <el-button type="primary" @click="handleSubmit">保存</el-button>
    </template>
  </Dialog>
</template>

<script setup lang="ts">
import { ref, watch, onMounted } from 'vue';
import { OrderDetailType, ServiceTypeOptions, OrderDetailTypeOptions, CustomerType } from '@/enums/index';
import Message from '@/components/Message';
import { type FormInstance } from 'element-plus';
import { useOrderStore } from '@/store/modules/order/index';
import { useDataEnumStore } from '@/store/modules/enums/index';
const orderStore = useOrderStore();
const enumStore = useDataEnumStore();

interface Props {
  modelValue: boolean;
  handleType: string;
}
const props = withDefaults(defineProps<Props>(), {
  modelValue: false,
  handleType: 'add',
});

watch(
  () => props.modelValue,
  (newVal) => {
    dialogVisible.value = newVal;
  },
);
watch(
  () => props.handleType,
  (newVal) => {
    title.value = newVal === 'add' ? '新增开单明细' : '编辑开单明细';
  },
);

const emit = defineEmits(['update:modelValue', 'close-dialog']);

onMounted(async () => {
  await enumStore.getStaffList();
  await enumStore.getProductList();
  await enumStore.getServiceItemList();
  await enumStore.getTreatmentCouponList();
});

const dialogVisible = ref(false);
const title = ref('新增开单明细');

const handleSubmit = () => {
  formRef.value &&
    formRef.value.validate((valid) => {
      if (valid) {
        console.log('提交开单明细:', orderStore.detailForm);
        // 调用添加开单明细方法
        const result =
          props.handleType === 'add'
            ? orderStore.addOrderDetail(orderStore.detailForm)
            : orderStore.updateOrderDetail(orderStore.detailForm);

        result && closeDialog();
      }
    });
};

const closeDialog = () => {
  emit('update:modelValue', false);
};

const changeDetailType = () => {
  orderStore.detailForm.bid = '';
};

const formRef = ref<FormInstance | null>(null);

const rules = ref({
  detailType: [{ required: true, message: '请选择明细类型', trigger: 'blur' }],
  bid: [{ required: true, message: '请选择产品/疗程', trigger: 'blur' }],
  quantity: [{ required: false, message: '请输入数量', trigger: 'blur' }],
  userId: [{ required: true, message: '请选择技师/销售', trigger: 'blur' }],
  serverType: [{ required: true, message: '请选择服务类型', trigger: 'blur' }],
});

const selectVisibleChange = (visible: boolean, callback: Function) => {
  if (visible) {
    callback();
  }
};
</script>
