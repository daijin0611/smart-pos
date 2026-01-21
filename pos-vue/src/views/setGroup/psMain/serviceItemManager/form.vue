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
      <!-- 项目编码 -->
      <el-form-item label="项目编码" prop="itemEncode">
        <el-input v-model="store.formData.itemEncode" placeholder="请输入项目编码" clearable />
      </el-form-item>

      <!-- 项目名称（必填） -->
      <el-form-item label="项目名称" prop="itemName">
        <el-input v-model="store.formData.itemName" placeholder="请输入项目名称" clearable />
      </el-form-item>

      <!-- 服务时长 -->
      <el-form-item label="服务时长" prop="serverTime">
        <el-input
          v-model.number="store.formData.serverTime"
          placeholder="请输入服务时长"
          style="width: 120px"
          clearable
          :controls="false"
        />
        &nbsp;分钟
      </el-form-item>

      <!-- 价格设置 -->
      <el-form-item label="价格设置">
        <Card padding="15px 15px 20px 0">
          <el-form-item label="标准价：" prop="itemPrice">
            <el-input-number size="small" v-model="store.formData.itemPrice" :controls="false" />
            &nbsp;元
          </el-form-item>
          <el-form-item label="会员价：" prop="vipItemPrice">
            <el-input-number size="small" v-model="store.formData.vipItemPrice" :controls="false" />
            &nbsp;元
          </el-form-item>
        </Card>
      </el-form-item>

      <!-- 允许打折（开关） -->
      <el-form-item label="允许打折" prop="isDiscounts">
        <el-switch v-model="store.formData.isDiscounts" :active-value="0" :inactive-value="1" />
      </el-form-item>

      <!-- 提成类型（单选） -->
      <el-form-item label="提成类型" prop="commissionType">
        <el-radio-group v-model.number="store.formData.commissionType">
          <el-radio :value="0" :border="true">固定金额</el-radio>
          <el-radio :value="1" :border="true">比例提成</el-radio>
        </el-radio-group>
      </el-form-item>

      <!-- 提成值（根据提成类型动态显示单位：元/百分比） -->
      <template v-if="store.formData.commissionType === 0">
        <el-form-item label="提成值(轮牌)" prop="commissionValueRotation">
          <el-input
            v-model.number="store.formData.commissionValueRotation"
            style="width: 100px; margin-right: 8px"
            clearable
          />
          <span>元</span>
        </el-form-item>
        <el-form-item label="提成值(点钟)" prop="commissionValueAppointment">
          <el-input
            v-model.number="store.formData.commissionValueAppointment"
            style="width: 100px; margin-right: 8px"
            clearable
          />
          <span>元</span>
        </el-form-item>
        <el-form-item label="提成值(加钟)" prop="commissionValueExtend">
          <el-input
            v-model.number="store.formData.commissionValueExtend"
            style="width: 100px; margin-right: 8px"
            clearable
          />
          <span>元</span>
        </el-form-item>
      </template>
      <template v-else>
        <el-form-item label="提成值(轮牌)" prop="commissionValueRotation">
          <el-input-number
            v-model.number="store.formData.commissionValueRotation"
            :min="0"
            :max="100"
            :controls="false"
            style="width: 100px; margin-right: 8px"
          />
          <span>%</span>
        </el-form-item>
        <el-form-item label="提成值(点钟)" prop="commissionValueAppointment">
          <el-input-number
            v-model.number="store.formData.commissionValueAppointment"
            :min="0"
            :max="100"
            :controls="false"
            style="width: 100px; margin-right: 8px"
          />
          <span>%</span>
        </el-form-item>
        <el-form-item label="提成值(加钟)" prop="commissionValueExtend">
          <el-input-number
            v-model.number="store.formData.commissionValueExtend"
            :min="0"
            :max="100"
            :controls="false"
            style="width: 100px; margin-right: 8px"
          />
          <span>%</span>
        </el-form-item>
        <el-form-item label="提成价格" prop="commissionBase">
          <el-select
            v-model="store.formData.commissionBase"
            placeholder="请选择提成基数"
            style="width: 160px"
            clearable
          >
            <el-option label="标准价提成" :value="0" />
            <el-option label="会员价提成" :value="1" />
          </el-select>
        </el-form-item>
      </template>

      <!-- 其他描述 -->
      <el-form-item label="其他描述" prop="remark">
        <el-input v-model="store.formData.remark" type="textarea" placeholder="请输入其他描述" />
      </el-form-item>
    </Form>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue';

// 引入数据仓库
import { useServiceItemStore } from '@/store/modules/setGroup/serviceItem';
const store = useServiceItemStore();

// 定义组件触发的事件 - 关闭抽屉
const emit = defineEmits(['close-drawer']);

// 定义组件接收的props - 是否禁用表单
defineProps(['disabled']);

// 组件挂载后执行的生命周期钩子
onMounted(async () => {
  // 可在此处添加组件初始化逻辑
  await getServiceItems();
});

const serviceItems = ref<any>([]);
const getServiceItems = async () => {
  const params: any = { itemStatus: '' };
  serviceItems.value = await store.getServiceItems(params);
};

/**
 * 表单提交处理函数
 * @param model 表单数据对象
 */
const handleFormSubmit = async (model: any) => {
  // 调用数据仓库的更新方法
  const result = await store.updateData(model);
  // 更新成功则触发关闭抽屉事件
  result && emit('close-drawer');
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
  itemEncode: [
    { required: true, message: '请输入服务项目编码', trigger: 'blur' },
    {
      validator: (rule: any, value: any, callback: any) => {
        const item = serviceItems.value.filter((item: any) => item.itemEncode === value);
        if (item.length === 0) {
          callback();
          return;
        }
        if (item.length === 1 && store.formData.id === item[0].id) {
          callback();
          return;
        }
        callback(new Error('编码已存在'));
      },
      trigger: 'blur',
    },
  ],
  itemName: [{ required: true, message: '请输入服务项目名称', trigger: 'blur' }],
  serverTime: [
    { required: true, message: '请输入服务时间', trigger: 'blur' },
    { type: 'number', message: '请输入数字', trigger: 'blur' },
  ],
  itemPrice: [{ required: true, message: '请输入服务项目价格', trigger: 'blur' }],
  vipItemPrice: [{ required: true, message: '请输入会员价格', trigger: 'blur' }],
  isDiscounts: [{ required: true, message: '请输入是否提成', trigger: 'blur' }],
  commissionType: [{ required: true, message: '请选择提成类型', trigger: 'blur' }],
  commissionValueRotation: [
    { required: true, message: '请输入提成值(轮牌)', trigger: 'blur' },
    { type: 'number', message: '请输入数字', trigger: 'blur' },
  ],
  commissionValueAppointment: [
    { required: true, message: '请输入提成值(点钟)', trigger: 'blur' },
    { type: 'number', message: '请输入数字', trigger: 'blur' },
  ],
  commissionValueExtend: [
    { required: true, message: '请输入提成值(加钟)', trigger: 'blur' },
    { type: 'number', message: '请输入数字', trigger: 'blur' },
  ],
  commissionBase: [{ required: true, message: '请选择提成价格', trigger: 'blur' }],
};
</script>
