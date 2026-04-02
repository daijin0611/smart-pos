<template>
  <el-popover :visible="visible" :placement="props.placement" width="200" trigger="click">
    <template #default>
      <el-form @submit.prevent="submitForm" ref="form">
        <el-form-item>
          <el-input v-model="value" :placeholder="props.tipText" clearable />
        </el-form-item>
        <div class="submit-area">
          <el-button type="primary" link @click="visible = false">取消</el-button>
          <el-button type="primary" native-type="submit">添加</el-button>
        </div>
      </el-form>
    </template>
    <template #reference>
      <el-button type="primary" @click="visible = true">{{ props.btnText }}</el-button>
    </template>
  </el-popover>
</template>

<script setup lang="ts">
import { ref, withDefaults } from 'vue';

const props = withDefaults(
  defineProps<{
    btnText?: string;
    tipText?: string;
    visible?: boolean;
    placement?: string;
  }>(),
  { btnText: '添加', tipText: '请输入', visible: false, placement: 'right' },
);

const $emit = defineEmits(['submit']);

const value = ref('');
const visible = ref(false);
const form = ref(null);

const submitForm = (e: any) => {
  $emit('submit', value.value);
  visible.value = false;
  value.value = '';
};
</script>
<style scoped lang="scss">
.submit-area {
  display: flex;
  justify-content: right;
}
</style>
