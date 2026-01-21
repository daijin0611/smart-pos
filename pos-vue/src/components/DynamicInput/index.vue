<template>
  <div class="dynamic-input-container">
    <!-- 查看状态 -->
    <template v-if="!isEditing">
      <div class="view-text">
        <span class="text-overflow" :title="inputValue">{{ inputValue || '- ' }}</span>
        <el-button type="primary" :color="btnColor ? btnColor : ''" :size="size" link @click="isEditing = true">
          编辑
        </el-button>
      </div>
    </template>
    <!-- 编辑状态 -->
    <template v-else>
      <el-input v-model="inputValue" @keyup.enter="handleConfirm" :size="size" class="input" clearable />
      <el-button type="primary" :color="btnColor ? btnColor : ''" :size="size" link @click="handleCancel">
        取消
      </el-button>
      <el-button type="primary" :color="btnColor ? btnColor : ''" :size="size" link @click="handleConfirm">
        确定
      </el-button>
    </template>
  </div>
</template>

<script setup lang="ts">
import { ref, withDefaults, inject } from 'vue';

const $Message: any = inject('$Message');

interface DynamicInputProps {
  value: string; // 输入框值
  params?: any; // 额外参数
  btnColor?: string;
  size?: '' | 'default' | 'small' | 'large';
}

const props = withDefaults(defineProps<DynamicInputProps>(), {
  value: '',
  size: 'default',
});

const $emit = defineEmits(['update']);

// 输入框初始值
let inputValue = ref(props.value);
// 是否处于编辑状态
let isEditing = ref(false);

// 确认修改
const handleConfirm = () => {
  if (!inputValue.value) {
    $Message.error('内容不能为空');
    return;
  }
  // 传递数据
  const value = inputValue.value;
  let params = {};
  props.params && (params = props.params);
  $emit('update', value, params);
  // 关闭编辑状态
  isEditing.value = false;
};

// 取消编辑
const handleCancel = () => {
  isEditing.value = false;
  inputValue.value = props.value;
};
</script>
<script lang="ts">
export default {
  name: 'DynamicInput',
};
</script>
<style lang="scss" scoped>
.dynamic-input-container {
  display: flex;
  align-items: center;
  width: 100%;
  max-width: 300px;

  .view-text {
    width: 100%;
    display: flex;
    align-items: center;
    > span {
      margin: 0 5px 0 0;
    }
  }

  .input {
    width: calc(100% - 85px);
    margin: 0 5px 0 0;
  }
}
</style>
