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
      <!-- 套餐编码 -->
      <el-form-item label="套餐编码" prop="packageEncode">
        <el-input v-model="store.formData.packageEncode" placeholder="请输入套餐编码" clearable />
      </el-form-item>

      <!-- 套餐名称（必填） -->
      <el-form-item label="套餐名称" prop="packageName">
        <el-input v-model="store.formData.packageName" placeholder="请输入套餐名称" clearable />
      </el-form-item>

      <!-- 价格设置 -->
      <el-form-item label="价格设置">
        <Card style="width: 75%">
          <el-form-item label="散客价：" prop="packagePrice">
            <el-input-number size="small" v-model="store.formData.packagePrice" :controls="false" />
            &nbsp;元
          </el-form-item>
          <el-form-item label="会员价：" prop="packagePriceVip">
            <el-input-number size="small" v-model="store.formData.packagePriceVip" :controls="false" />
            &nbsp;元
          </el-form-item>
        </Card>
      </el-form-item>

      <!-- 套餐明细 -->
      <el-form-item label="套餐明细" prop="packageDetailDTOList">
        <el-alert title="点击胶囊按钮, 可修改产品数量哦" type="warning" style="width: 75%; margin-bottom: 10px" />
        <Card style="width: 75%">
          <Autocomplete
            :dataList="packages"
            :selectedList="store.formData.packageDetailDTOList"
            @submit="submitSelect"
            @update-number="updateNumber"
          >
            <template #selected="{ item }">
              {{ item.packageDetailName }} &nbsp; 数量：{{ item.packageToolNumber }}
            </template>
            <!-- 套餐明细 -->
            <template #default="{ item }">
              <Card padding="10px" :gap="5" bgColor="#fff" shadow="always" class="package-card">
                <div class="package-item">
                  <span>名称：</span>
                  <span>{{ item.packageDetailName }}</span>
                </div>
                <div class="package-item" style="color: var(--el-text-color-secondary)">
                  <span>编码：</span>
                  <span>{{ item.packageToolNumber }}</span>
                </div>
              </Card>
            </template>
          </Autocomplete>
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
import { ref, reactive, onMounted, watch } from 'vue';
import Autocomplete from './Autocomplete.vue';

// 引入数据仓库
import { usePackageStore } from '@/store/modules/setGroup/package';
const store = usePackageStore();

// 定义组件触发的事件 - 关闭抽屉
const $emit = defineEmits(['close-drawer']);

// 定义组件接收的props - 是否禁用表单
defineProps(['disabled']);

// 组件挂载后执行的生命周期钩子
onMounted(() => {
  // 可在此处添加组件初始化逻辑
});

const packages = new Array(10)
  .fill({
    packageDetailName: '',
    packageToolNumber: 1,
    packageId: 1,
  })
  .map((item, i) => ({
    ...item,
    packageDetailName: `一次性工具${i + 1}`,
    value: `一次性工具${i + 1}`,
  }));

/**
 * 选择框选择方法 - 将选择的内容添加到已选择数组
 * @param data 选择的内容
 */
const submitSelect = (data: any) => {
  console.log('已选择：', data);
  store.formData.packageDetailDTOList = data;
};

/**
 * 更新数量
 * @param item 已选择的内容
 */
const updateNumber = (item: any) => {
  item.packageToolNumber = item.number;
};

/**
 * 表单提交处理函数
 * @param model 表单数据对象
 */
const handleFormSubmit = async (model: any) => {
  console.log('套餐数据：', model);
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
  packageEncode: [{ required: true, message: '请输入套餐编码', trigger: 'blur' }],
  packageName: [{ required: true, message: '请输入套餐名称', trigger: 'blur' }],
  packagePrice: [
    { required: true, message: '请输入散客价', trigger: 'blur' },
    { type: 'number', message: '请输入数字', trigger: 'blur' },
  ],
  packagePriceVip: [
    { required: true, message: '请输入会员价', trigger: 'blur' },
    { type: 'number', message: '请输入数字', trigger: 'blur' },
  ],
  packageDetailDTOList: [{ required: true, message: '请选择套餐项目信息', trigger: 'blur' }],
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
