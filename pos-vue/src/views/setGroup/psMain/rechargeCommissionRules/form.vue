<template>
  <div>
    <Form :model="store.formData" :rules="formRules" @submit="handleFormSubmit" @reset="handleFormReset">
      <!-- 提成规则名称 -->
      <el-form-item label="提成规则名称" prop="rechargeRoleName">
        <el-input v-model="store.formData.rechargeRoleName" placeholder="请输入提成规则名称" />
      </el-form-item>

      <!-- 充值金额 -->
      <el-form-item label="充值金额" prop="rechargePrice">
        <el-input-number
          v-model="store.formData.rechargePrice"
          placeholder="请输入充值金额"
          :controls="false"
          style="width: 120px"
          size="small"
        >
          <template #suffix>元</template>
        </el-input-number>
      </el-form-item>

      <!-- 提成类型 -->
      <el-form-item label="提成类型" prop="commissionType">
        <el-radio-group v-model="store.formData.commissionType">
          <el-radio
            v-for="item in commissionTypeOptions"
            :key="item.value"
            :value="item.value"
            :label="item.label"
            :border="true"
          />
        </el-radio-group>
      </el-form-item>

      <!-- 固定金额 -->
      <template v-if="store.formData.commissionType === CommissionType.FixedAmount">
        <!-- 允许打折 -->
        <el-form-item label="倍数叠加" prop="double">
          <el-switch v-model="store.formData.double" :active-value="0" :inactive-value="1" />
        </el-form-item>
        <el-form-item label="提成值" prop="rechargeCommissionValue">
          <el-input-number size="small" v-model="store.formData.rechargeCommissionValue" :controls="false" />
          &nbsp;元
        </el-form-item>
      </template>

      <!-- 比例提成 -->
      <template v-if="store.formData.commissionType === CommissionType.Proportion">
        <el-form-item label="提成比例" prop="rechargeCommissionValue" style="margin-bottom: 15px">
          <el-input-number
            v-model="store.formData.rechargeCommissionValue"
            :min="0"
            :max="100"
            :controls="false"
            size="small"
          />
          &nbsp;%
        </el-form-item>
      </template>

      <!-- 其他描述 -->
      <el-form-item label="其他描述">
        <el-input
          v-model="store.formData.remark"
          style="width: 240px"
          :autosize="{ minRows: 2, maxRows: 4 }"
          type="textarea"
          placeholder="请输入其他描述"
        />
      </el-form-item>
    </Form>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import { CommissionType, commissionTypeOptions } from '@/enums';
// 引入数据仓库
import { useRechargeCommissionRulesStore } from '@/store/modules/setGroup/rechargeCommissionRules';
const store = useRechargeCommissionRulesStore();

// 定义组件触发的事件 - 关闭抽屉
const $emit = defineEmits(['close-drawer']);

onMounted(() => {});

/**
 * 表单提交处理函数
 * @param model 表单数据对象
 */
const handleFormSubmit = async (model: any) => {
  const result = await store.updateData(model);
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
  rechargeRoleName: [{ required: true, message: '请输入提成规则名称', trigger: 'blur' }],
  rechargePrice: [
    { required: true, message: '请输入充值金额', trigger: 'blur' },
    { type: 'number', message: '请输入数字', trigger: 'blur' },
  ],
  commissionType: [{ required: true, message: '请选择提成类型', trigger: 'blur' }],
  double: [{ required: true, message: '是否倍数叠加', trigger: 'blur' }],
  rechargeCommissionValue: [
    { required: true, message: '请输入提成值', trigger: 'blur' },
    { type: 'number', message: '请输入数字', trigger: 'blur' },
  ],
  remark: [{ required: false, message: '请输入其他描述', trigger: 'blur' }],
};
</script>
