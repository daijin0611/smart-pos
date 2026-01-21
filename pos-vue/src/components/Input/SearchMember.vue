<template>
  <el-autocomplete
    v-model="inputValue"
    @input="(val: string) => emit('update:modelValue', val)"
    @select="handleSelect"
    :fetch-suggestions="querySearchAsync"
    :prefix-icon="Search"
    :placeholder="placeholder"
    :size="size"
    value-key="name"
    clearable
    style="width: 200px"
  >
    <template #default="{ item }">
      <div class="mem-info-card">
        <p>
          <span>姓名：</span>
          <span>{{ item.name }}</span>
        </p>
        <p>
          <span>电话：</span>
          <span>{{ item.phoneNumber }}</span>
        </p>
        <p>
          <span>卡号：</span>
          <span>{{ item.cardNumber }}</span>
        </p>
      </div>
    </template>
    <template v-if="showSearchButton" #append>
      <el-button type="primary" size="large">搜索</el-button>
    </template>
  </el-autocomplete>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { ref, PropType, watch } from 'vue';
import { useMemberStore } from '@/store/modules/member/member';
const memberStore = useMemberStore();
const props = defineProps({
  modelValue: {
    type: String,
    default: () => '',
  },
  size: {
    type: String as PropType<'large' | 'default' | 'small'>,
    default: () => 'large',
  },
  placeholder: {
    type: String,
    default: () => '姓名 | 手机号 | 会员卡号',
  },
  showSearchButton: {
    type: Boolean,
    default: () => true,
  },
});
watch(
  () => props.modelValue,
  (newVal) => {
    inputValue.value = newVal;
  },
);
const emit = defineEmits(['update:modelValue', 'selected']);
// 搜索会员
const inputValue = ref(props.modelValue);
// 搜索联想会员列表
const querySearchAsync: (queryString: string, cb: (arg: any) => void) => void = async (
  queryString: string,
  cb: (arg: any) => void,
) => {
  if (!queryString) {
    cb([]);
    return;
  }
  const results = await memberStore.getAssociateList(queryString, 50);
  cb(results);
};

// 选中会员
const handleSelect = (item: Record<string, any>) => {
  inputValue.value = '';
  emit('update:modelValue', '');
  emit('selected', { ...item });
};
</script>

<style lang="scss" scoped>
// 搜索提示会员信息
.mem-info-card {
  line-height: 20px;
  margin: 10px;
  padding: 10px;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
