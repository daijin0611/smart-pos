<template>
  <div class="form-container">
    <!-- 表单 -->
    <Form :model="formData" :rules="formRules" :loading="loading" @submit="handleFormSubmit" @reset="handleFormReset">
      <el-form-item label="赠送金额：" prop="presentAmount">
        <el-input-number v-model="formData.presentAmount" :controls="false" />
      </el-form-item>
      <el-form-item label="折扣率：" prop="discountRate">
        <el-input-number v-model="formData.discountRate" :min="0" :max="100" controls-position="right" />
        <span>&nbsp;&nbsp;%</span>
      </el-form-item>
      <el-form-item label="折扣基础：" prop="discountBase">
        <el-select v-model="formData.discountBase" style="width: 150px">
          <el-option v-for="item in discountTypeOptions" :value="item.value" :label="item.label" :key="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="跨店结算：" prop="isCrossStore">
        <el-select v-model="formData.isCrossStore" style="width: 150px">
          <el-option v-for="item in isCrossStoreOptions" :value="item.value" :label="item.label" :key="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="备注：" prop="remark">
        <el-input
          type="textarea"
          v-model="formData.remark"
          :autosize="{ minRows: 3, maxRows: 3 }"
          :maxlength="500"
          show-word-limit
        />
      </el-form-item>
    </Form>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { reqPresentAsset } from '@/api/member/member';
import { cloneDeep } from 'lodash';
import { parseResMsg } from '@/utils/parseResponse';
import { discountTypeOptions, isCrossStoreOptions } from '@/enums/index';

// 导入数据仓库
import { useMemberStore } from '@/store/modules/member/member';
const store = useMemberStore();

const $emit = defineEmits(['close-drawer']);

watch(
  () => store.formData.id,
  (val) => {
    if (val) {
      handleFormReset();
    }
  },
);

const loading = ref(false);

const DEFAULT_FORMDATA = {
  presentAmount: 0,
  discountRate: 100,
  discountBase: 0,
  isCrossStore: 0,
  remark: '手动赠送',
};
const formData = ref(cloneDeep(DEFAULT_FORMDATA));
// 表单验证规则
const formRules = {
  presentAmount: [{ required: true, message: '请输入金额', trigger: 'blur' }],
  discountRate: [{ required: true, message: '请输入折扣率', trigger: 'blur' }],
  discountBase: [{ required: true, message: '请选择折扣基础', trigger: 'blur' }],
  isCrossStore: [{ required: true, message: '是否允许跨店结算', trigger: 'blur' }],
};

// 表单提交
const handleFormSubmit = async () => {
  try {
    loading.value = true;
    const id = store.formData.id;
    const res = await reqPresentAsset(id, formData.value);
    parseResMsg(res, '赠送卡金成功');
    $emit('close-drawer');
  } catch (error) {
    console.error(error);
  } finally {
    loading.value = false;
  }
};

// 表单重置
const handleFormReset = () => {
  formData.value = cloneDeep(DEFAULT_FORMDATA);
};
</script>

<style lang="scss" scoped>
.form-container {
  width: 300px;
  margin: 0 auto;
}
</style>
