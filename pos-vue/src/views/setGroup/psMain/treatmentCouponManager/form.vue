<template>
  <div>
    <Form
      :model="store.formData"
      :rules="formRules"
      :showButtons="!disabled"
      :disabled="disabled"
      @submit="handleFormSubmit"
      @reset="handleFormReset"
    >
      <!-- 疗程券编码 -->
      <el-form-item label="疗程券编码" prop="encode">
        <el-input v-model="store.formData.encode" placeholder="请输入疗程券编码" clearable />
      </el-form-item>

      <!-- 疗程券名称（必填） -->
      <el-form-item label="疗程券名称" prop="name">
        <el-input v-model="store.formData.name" placeholder="请输入疗程券名称" clearable />
      </el-form-item>

      <!-- 价格设置 -->
      <el-form-item label="价格设置">
        <Card style="width: 75%" padding="10px 0">
          <el-form-item label="疗程价：" prop="price">
            <el-input-number size="" v-model="store.formData.price" :controls="false" />
            &nbsp;元
          </el-form-item>
        </Card>
      </el-form-item>

      <!-- 提成类型 -->
      <el-form-item label="提成类型" prop="type">
        <el-radio-group v-model="store.formData.type">
          <el-radio
            v-for="item in commissionTypeOptions"
            :value="item.value"
            :label="item.label"
            :key="item.value"
            :border="true"
          />
        </el-radio-group>
      </el-form-item>

      <!-- 固定金额 -->
      <template v-if="store.formData.type === CommissionType.FixedAmount">
        <el-form-item label="提成值" prop="commissionValue">
          <el-input-number size="" v-model="store.formData.commissionValue" :controls="false" />
          &nbsp;元
        </el-form-item>
      </template>

      <!-- 比例提成 -->
      <template v-if="store.formData.type === CommissionType.Proportion">
        <el-form-item label="提成比例" prop="commissionValue" style="margin-bottom: 15px">
          <el-input-number size="" v-model="store.formData.commissionValue" :controls="false" />
          &nbsp;%
        </el-form-item>
        <el-form-item label="价格类型" prop="commissionBase">
          <el-select v-model="store.formData.commissionBase" style="width: 200px">
            <el-option v-for="item in commissionOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
      </template>

      <!-- 套餐明细 -->
      <!-- <el-form-item label="套餐明细" prop="cureTicketDetailInfoDTOList">
        <el-alert title="点击胶囊按钮, 可修改产品数量哦" type="warning" style="width: 75%; margin-bottom: 10px" />
        <Card style="width: 75%">
          <Autocomplete
            :dataList="tickets"
            :selectedList="store.formData.vipTicketList"
            @submit="submitSelect"
            @update-number="updateNumber"
          >
            <template #selected="{ item }">{{ item.vipTicketName }} &nbsp; 数量：{{ item.vipTicketNum }}</template>
            <template #default="{ item }">
              <Card padding="10px" :gap="5" bgColor="#fff" shadow="always" class="package-card">
                <div class="package-item">
                  <span>名称：</span>
                  <span>{{ item.vipTicketName }}</span>
                </div>
                <div class="package-item text-overflow" style="color: var(--el-text-color-secondary)">
                  <span>描述：</span>
                  <span :title="item.ticketDescription">{{ item.ticketDescription || '-' }}</span>
                </div>
              </Card>
            </template>
          </Autocomplete>
        </Card>
      </el-form-item> -->
      <!-- 套餐明细 -->
      <el-form-item label="套餐明细" prop="cureTicketDetailInfoDTOList">
        <el-alert title="点击胶囊按钮, 可修改产品数量哦" type="warning" style="width: 75%; margin-bottom: 10px" />
        <Card style="width: 75%">
          <TicketSelect
            v-model="store.formData.vipTicketList"
            :options="tickets"
            value-key="vipTicketId"
            labelKey="vipTicketName"
          ></TicketSelect>
        </Card>
      </el-form-item>

      <!-- 其他描述 -->
      <el-form-item label="其他描述" prop="remark">
        <el-input v-model="store.formData.remark" type="textarea" placeholder="请输入其他描述" clearable />
      </el-form-item>
    </Form>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed, watch } from 'vue';
import Autocomplete from './Autocomplete.vue';
import TicketSelect from './TicketSelect.vue';

import { commissionOptions, commissionTypeOptions, CommissionType } from '@/enums/index';

// 引入数据仓库
import { useTreatmentCouponStore } from '@/store/modules/setGroup/treatmentCoupon';
import { useDataEnumStore } from '@/store/modules/enums/index';
const store = useTreatmentCouponStore();
const dataEnumStore = useDataEnumStore();

// 定义组件触发的事件 - 关闭抽屉
const $emit = defineEmits(['close-drawer']);

// 定义组件接收的props - 是否禁用表单
defineProps(['disabled']);

// 组件挂载后执行的生命周期钩子
onMounted(() => {
  // 可在此处添加组件初始化逻辑
  store.resetFormData();
  dataEnumStore.getTicketList();
});

const tickets = computed(() =>
  dataEnumStore.ticketList.map((item: any) => {
    return {
      vipTicketId: item.id,
      vipTicketName: item.ticketName,
      vipTicketNum: 1,
      ticketDescription: item.ticketDescription,
      isEdit: false,
    };
  }),
);

/**
 * 选择框选择方法 - 将选择的内容添加到已选择数组
 * @param data 选择的内容
 */
const submitSelect = (data: any) => {
  console.log('已选择：', data);
  store.formData.vipTicketList = data;
};

/**
 * 更新数量
 * @param item 已选择的内容
 */
const updateNumber = (item: any) => {
  item.vipTicketNum = item.vipTicketNum;
};

/**
 * 表单提交处理函数
 * @param model 表单数据对象
 */
const handleFormSubmit = async (model: any) => {
  console.log('疗程券数据：', model);
  // 调用数据仓库的更新方法
  const result = await store.updateData(model);
  // 更新成功则触发关闭抽屉事件
  result && $emit('close-drawer');
};

/**
 * 表单重置处理函数
 * 调用数据仓库的重置表单数据方法
 */
const handleFormReset = () => {
  store.resetFormData();
};

// 表单验证规则
const formRules = {
  encode: [{ required: true, message: '请输入疗程券编码', trigger: 'blur' }],
  name: [{ required: true, message: '请输入疗程券名称', trigger: 'blur' }],
  price: [
    { required: true, message: '请输入疗程价', trigger: 'blur' },
    { type: 'number', message: '请输入数字', trigger: 'blur' },
  ],
  type: [{ required: true, message: '请输入疗程券名称', trigger: 'blur' }],
  commissionValue: [
    { required: true, message: '请输入提成比例', trigger: 'blur' },
    { type: 'number', message: '请输入数字', trigger: 'blur' },
  ],
  commissionBase: [
    { required: true, message: '请输入提成金额', trigger: 'blur' },
    { type: 'number', message: '请输入数字', trigger: 'blur' },
  ],
  vipTicketList: [{ required: true, message: '请选择套餐项目信息', trigger: 'blur' }],
};
</script>

<style lang="scss" scoped>
.package-card {
  margin: 5px 0;

  .package-item {
    color: var(--el-text-color-primary);
    line-height: 20px;
  }
}
</style>
