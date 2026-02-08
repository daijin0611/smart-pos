<template>
  <div>
    <div class="selected-container">
      <el-popover
        v-for="item in modelValue"
        :key="item"
        :title="item.vipTicketName"
        :visible="item.isEdit"
        placement="left"
        width="200"
        trigger="click"
      >
        <template #default>
          <el-form @submit.prevent="modifyNumberSubmit(item)">
            <el-form-item>
              <label>
                数量：
                <el-input v-model.number="item.vipTicketNum" clearable style="width: 100px" />
              </label>
            </el-form-item>
            <div style="display: flex; justify-content: flex-end">
              <el-button type="primary" size="small" link @click="item.isEdit = false">取消</el-button>
              <el-button type="primary" size="small" native-type="submit">完成</el-button>
            </div>
          </el-form>
        </template>
        <template #reference>
          <el-tag
            @close.stop="removeItem(item)"
            @click="modifyNumber(item)"
            :style="{ cursor: true ? 'pointer' : 'not-allowed' }"
            closable
          >
            {{ item.vipTicketName }} &nbsp; 数量：{{ item.vipTicketNum }}
          </el-tag>
        </template>
      </el-popover>
    </div>

    <el-select
      v-model="selected"
      :multiple="multiple"
      :filterable="filterable"
      :clearable="clearable"
      :collapse-tags="collapseTags"
      :collapse-tags-tooltip="collapseTagsTooltip"
      :value-key="valueKey"
      :placeholder="placeholder"
      :filter-method="filterMethod"
      @change="selectedChange"
    >
      <el-option v-for="(item, index) in options" :value="item" :label="item[labelKey]" :key="index"></el-option>
    </el-select>
    <!-- <Card padding="10px" :gap="5" bgColor="#fff" shadow="always" class="package-card">
      <div class="package-item">
        <span>名称：</span>
        <span>{{ item.vipTicketName }}</span>
      </div>
      <div class="package-item text-overflow" style="color: var(--el-text-color-secondary)">
        <span>描述：</span>
        <span :title="item.ticketDescription">{{ item.ticketDescription || '-' }}</span>
      </div>
    </Card> -->
    <!-- <div v-if="isAdd">
    </div>
    <el-button v-if="!isAdd" @click="isAdd = true" type="default">增加明细</el-button> -->
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, nextTick, watch } from 'vue';
import { isEmpty, cloneDeep } from 'lodash';

/**
 * 组件属性
 */
interface Props {
  options: any;
  modelValue: any;
  valueKey?: string;
  labelKey?: string;
  placeholder?: string;
  multiple?: boolean;
  filterable?: boolean;
  clearable?: boolean;
  collapseTags?: boolean;
  collapseTagsTooltip?: boolean;
  filterMethod?: Function;
}

// 定义组件属性
const props = withDefaults(defineProps<Props>(), {
  options: [],
  modelValue: [],
  valueKey: 'id',
  labelKey: 'label',
  placeholder: '请选择',
  multiple: true,
  filterable: true,
  clearable: true,
  collapseTags: true,
  collapseTagsTooltip: true,
  filterMethod: (queryString: string, item: any) => {},
});

// 定义组件触发的事件 - 关闭提交选择的列表
const emit = defineEmits(['submit', 'update-number', 'update:model-value']);

watch(
  () => props.modelValue,
  (newValue) => {
    selected.value = newValue;
  },
);

const selectedChange = (data: any) => {
  emit('update:model-value', data);
};

const selected = ref<any>([]);

// 添加
const isAdd = ref(false);

// 提交
const handleSubmit = () => {
  isAdd.value = false;
  // for (const item of selectedList) {
  // delete item.value;
  // delete item.vipTicketNum;
  // delete item.isEdit;
  // }
  // emit('submit', selectedList);
};

// 数据列表
const dataList = ref<any>([]);
// const selectedList: any = reactive(cloneDeep(props.selectedList) || []);

/**
 * 选择框搜索方法 - 过滤数据列表
 * @param queryString 搜索字符串
 * @param cb 回调函数
 */
const querySearch = (queryString: string, cb: Function) => {
  const results = queryString ? dataList.value.filter(createFilter(queryString)) : dataList.value;
  // 返回过滤过的数据
  cb(results);
};

/**
 * 搜索方法 - 过滤数据列表
 * @param queryString 搜索字符串
 */
const createFilter = (queryString: string) => {
  return (item: any) => {
    return item.vipTicketName.toLowerCase().includes(queryString.toLowerCase());
  };
};

/**
 * 移除已选择的内容
 * @param item 已选择的内容
 */
const removeItem = (item: any) => {
  // if (!isAdd.value) {
  //   return;
  // }
  props.modelValue.splice(item, 1);
};

/**
 * 开始数量修改
 * @param item 已选择的内容
 */
const modifyNumber = (item: any) => {
  for (const e of props.modelValue) {
    e.isEdit = false;
  }
  // isAdd.value && (item.isEdit = true);
  item.isEdit = true;
};

/**
 * 完成数量修改
 * @param item 已选择的内容
 */
const modifyNumberSubmit = (item: any) => {
  item.isEdit = false;
  emit('update-number', item);
};
</script>

<style lang="scss" scoped>
.selected-container {
  display: flex;
  flex-wrap: wrap;
  gap: 5px;
  margin-bottom: 10px;
}

.package-card {
  margin: 5px 0;
  height: 50px;

  .package-item {
    color: var(--el-text-color-primary);
    line-height: 20px;
  }
}
</style>
