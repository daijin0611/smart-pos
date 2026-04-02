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
      <!-- 产品编码 -->
      <el-form-item label="产品编码" prop="productEncode">
        <el-input v-model="store.formData.productEncode" placeholder="请输入产品编码" />
      </el-form-item>

      <!-- 产品名称 -->
      <el-form-item label="产品名称" prop="productName">
        <el-input v-model="store.formData.productName" placeholder="请输入产品名称" />
      </el-form-item>

      <!-- 产品单位 -->
      <el-form-item label="产品单位" prop="unit">
        <el-select v-model="store.formData.unit" placeholder="选择产品单位" style="width: 150px; margin-right: 15px">
          <el-option
            v-for="item in unitOptions"
            :key="item.itemValue"
            :label="item.itemLabel"
            :value="item.itemValue"
          />
        </el-select>
        <el-button link type="primary" @click="enumDialog.visible = true">单位管理</el-button>
      </el-form-item>

      <!-- 价格设置 -->
      <el-form-item label="价格设置">
        <Card>
          <el-form-item label="标准价：" prop="productPrice" style="margin-bottom: 15px">
            <el-input-number size="small" v-model="store.formData.productPrice" :controls="false" />
            &nbsp;元
          </el-form-item>
          <el-form-item label="会员价：" prop="vipProductPrice">
            <el-input-number size="small" v-model="store.formData.vipProductPrice" :controls="false" />
            &nbsp;元
          </el-form-item>
        </Card>
      </el-form-item>

      <!-- 允许打折 -->
      <el-form-item label="允许打折" prop="isDiscount">
        <el-switch v-model="store.formData.isDiscount" :active-value="0" :inactive-value="1" />
      </el-form-item>

      <!-- 提成类型 -->
      <el-form-item label="提成类型" prop="commissionType">
        <el-radio-group v-model="store.formData.commissionType">
          <el-radio :value="CommissionType.FixedAmount" :border="true">固定金额</el-radio>
          <el-radio :value="CommissionType.Proportion" :border="true">比例提成</el-radio>
        </el-radio-group>
      </el-form-item>

      <!-- 固定金额 -->
      <template v-if="store.formData.commissionType === CommissionType.FixedAmount">
        <el-form-item label="提成值" prop="commissionValue">
          <el-input-number size="small" v-model="store.formData.commissionValue" :controls="false" />
          &nbsp;元
        </el-form-item>
      </template>

      <!-- 比例提成 -->
      <template v-if="store.formData.commissionType === CommissionType.Proportion">
        <el-form-item label="提成比例" prop="commissionValue" style="margin-bottom: 15px">
          <el-input-number size="small" v-model="store.formData.commissionValue" :controls="false" />
          &nbsp;%
        </el-form-item>
        <el-form-item label="价格类型" prop="commissionBase">
          <el-select v-model="store.formData.commissionBase" style="width: 150px">
            <el-option v-for="item in commissionOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
      </template>

      <!-- 其他描述 -->
      <el-form-item label="其他描述">
        <el-input
          v-model="store.formData.remark"
          style="width: 240px"
          :autosize="{ minRows: 2, maxRows: 4 }"
          type="textarea"
          placeholder="请输入产品描述"
        />
      </el-form-item>
    </Form>

    <!-- 枚举管理dialog -->
    <EnumHandler v-model="enumDialog.visible" :title="enumDialog.title" :dictCode="enumDialog.dictCode"></EnumHandler>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue';
import EnumHandler from '@/components/EnumHandler/index.vue';

// 导入枚举数据
import { commissionOptions, CommissionType, IsDiscount } from '@/enums/index';

// 引入数据仓库
import { useProductStore } from '@/store/modules/setGroup/product';
import { useEnumStore, Enums } from '@/store/modules/enums/index';
const store = useProductStore();
const enumStore = useEnumStore();

// 定义组件触发的事件 - 关闭抽屉
const $emit = defineEmits(['close-drawer']);

// 定义组件接收的props - 是否禁用表单
defineProps(['disabled']);

/**
 * 表单提交处理函数
 * @param model 表单数据对象
 */
const handleFormSubmit = async (model: any) => {
  console.log(model);

  const result = await store.update(model);
  result && $emit('close-drawer');
};

/**
 * 表单重置处理函数
 * 调用数据仓库的重置表单数据方法
 */
const handleFormReset = () => {
  store.resetFormData();
};

const unitOptions = ref<any>([]);
onMounted(async () => {
  unitOptions.value = await enumStore.getUnits();
});

// dialog 参数
const enumDialog = reactive({
  title: '单位管理',
  visible: false,
  dictCode: Enums.UNIT,
});

// 表单验证规则
const formRules = {
  productEncode: [
    { required: false, message: '请输入产品编码', trigger: 'blur' },
    {
      validator: (rule: any, value: string, callback: any) => {
        const isExist = store.tableData.filter((item: any) => item.productEncode === value);
        if (isExist.length > 1) {
          callback(new Error('产品编码已存在'));
        }
        callback();
      },
      trigger: 'blur',
    },
  ],
  productName: [{ required: true, message: '请输入产品名称', trigger: 'blur' }],
  unit: [{ required: true, message: '请输入产品单位', trigger: 'blur' }],
  productPrice: [{ required: true, message: '请输入产品价格', trigger: 'blur' }],
  vipProductPrice: [{ required: true, message: '请输入会员价格', trigger: 'blur' }],
  isDiscount: [{ required: true, message: '请选择是否参与折扣卡打折', trigger: 'blur' }],
  commissionType: [{ required: true, message: '请选择提成类型', trigger: 'blur' }],
  commissionValue: [{ required: true, message: '请输入提成值', trigger: 'blur' }],
  commissionBase: [{ required: true, message: '请选择提成价格类型', trigger: 'blur' }],
};
</script>
