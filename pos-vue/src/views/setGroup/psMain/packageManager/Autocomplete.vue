<template>
  <div>
    <div class="selected-container">
      <el-popover
        v-for="item in selectedList"
        :key="item"
        :visible="item.isEdit"
        :title="item.value"
        placement="left"
        width="200"
        trigger="click"
      >
        <template #default>
          <el-form @submit.prevent="modifyNumberSubmit(item)">
            <el-form-item>
              <label>
                数量：
                <el-input v-model.number="item.number" clearable style="width: 100px" />
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
            @click="modifyNumber(item)"
            @close="removeItem(item)"
            :style="{ cursor: isAdd ? 'pointer' : 'not-allowed' }"
            closable
          >
            <slot name="selected" :item="item"></slot>
          </el-tag>
        </template>
      </el-popover>
    </div>

    <component
      :is="h(ElAutocomplete, { ...$attrs, ...props, ref: changeRef }, $slots)"
      v-if="isAdd"
      v-model="state"
      :fetch-suggestions="querySearch"
      @select="handleSelect"
      placeholder="选择产品或者项目"
      ref="autocompleteRef"
      clearable
    >
      <template #default="{ item }">
        <slot :item="item"></slot>
      </template>
      <template #append>
        <el-button @click="handleSubmit" type="primary">确定</el-button>
      </template>
    </component>
    <el-button v-if="!isAdd" @click="isAdd = true" type="default">增加明细</el-button>
  </div>
</template>

<script setup lang="ts">
import cloneDeep from 'lodash/cloneDeep';
import { ElAutocomplete, type AutocompleteProps } from 'element-plus';
import { ref, reactive, onMounted, h, getCurrentInstance, nextTick } from 'vue';

// 获取当前组件实例，用于暴露对话框方法
const vm: any = getCurrentInstance();
function changeRef(instance: any) {
  // 将对话框实例挂载到组件实例上，便于父组件调用
  vm.exposeProxy = vm.exposed = instance || {};
}

/**
 * 组件属性
 */
interface _Props extends Partial<AutocompleteProps> {
  dataList: any[];
  selectedList: any[];
}

// 定义组件属性
const props = defineProps<_Props>();

// 定义组件触发的事件 - 关闭提交选择的列表
const emit = defineEmits(['submit', 'update-number']);

// 添加
const isAdd = ref(false);

// 提交
const handleSubmit = () => {
  isAdd.value = false;
  for (const item of selectedList) {
    delete item.value;
    delete item.number;
    delete item.isEdit;
  }
  emit('submit', selectedList);
};

// 数据列表
const dataList = reactive(props.dataList || []);
const selectedList: any = reactive(cloneDeep(props.selectedList) || []);

/**
 * 移除重复项
 */
const removeRepeatItem = () => {
  for (const selected of selectedList) {
    for (const item of dataList) {
      if (item.value === selected.value) {
        dataList.splice(dataList.indexOf(item), 1);
      }
    }
  }
};
removeRepeatItem();

// 输入框的值
const state = ref('');
// autocomplete 实例
const autocompleteRef: any = ref(null);

/**
 * 选择框搜索方法 - 过滤数据列表
 * @param queryString 搜索字符串
 * @param cb 回调函数
 */
const querySearch = (queryString: string, cb: Function) => {
  const results = queryString ? dataList.filter(createFilter(queryString)) : dataList;
  // 返回过滤过的数据
  cb(results);
};

/**
 * 搜索方法 - 过滤数据列表
 * @param queryString 搜索字符串
 */
const createFilter = (queryString: string) => {
  return (item: any) => {
    return item.value.toLowerCase().includes(queryString.toLowerCase());
  };
};

/**
 * 选择框选择方法 - 将选择的内容添加到已选择数组
 * @param item 选择的内容
 */
const handleSelect = (item: any) => {
  dataList.splice(dataList.indexOf(item), 1);
  item = { ...item, number: 1 };
  selectedList.push(item);
  state.value = '';
  // 选择完成后，失去焦点
  nextTick(() => {
    autocompleteRef.value.inputRef.blur();
  });
};

/**
 * 移除已选择的内容
 * @param item 已选择的内容
 */
const removeItem = (item: any) => {
  if (!isAdd.value) {
    return;
  }
  dataList.push(item);
  selectedList.splice(selectedList.indexOf(item), 1);
};

/**
 * 开始数量修改
 * @param item 已选择的内容
 */
const modifyNumber = (item: any) => {
  for (const e of selectedList) {
    e.isEdit = false;
  }
  isAdd.value && (item.isEdit = true);
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
<script lang="ts">
export default {
  name: 'Autocomplete',
};
</script>

<style lang="scss" scoped>
.selected-container {
  display: flex;
  flex-wrap: wrap;
  gap: 5px;
  margin-bottom: 10px;
}
</style>
