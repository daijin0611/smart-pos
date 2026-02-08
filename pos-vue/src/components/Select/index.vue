<template>
  <el-select
    v-model="modelValue"
    :placeholder="placeholder"
    :disabled="disabled"
    :clearable="clearable"
    :filterable="filterable"
    :remote="remote"
    :remote-method="remoteMethod"
    :loading="loading"
    :popper-class="popperClass"
    :multiple="multiple"
    :collapse-tags="collapseTags"
    :collapse-tags-tooltip="collapseTagsTooltip"
    :multiple-limit="multipleLimit"
    :reserve-keyword="reserveKeyword"
    :default-first-option="defaultFirstOption"
    :teleported="teleported"
    :validate-event="validateEvent"
    :size="size"
    :id="id"
    :class="customClass"
    @change="handleChange"
    @visible-change="handleVisibleChange"
    @remove-tag="handleRemoveTag"
    @clear="handleClear"
    @focus="handleFocus"
    @blur="handleBlur"
  >
    <!-- 自定义内容插槽 -->
    <template v-if="$slots.default">
      <!-- 使用传入的自定义插槽内容 -->
      <slot></slot>
    </template>
    <template v-else>
      <!-- 默认选项内容 -->
      <el-option
        v-for="item in options"
        :key="item[valueKey]"
        :label="item[labelKey]"
        :value="item[valueKey]"
        :disabled="item.disabled"
      />
    </template>
  </el-select>
</template>

<script setup lang="ts">
import { computed, defineProps, defineEmits } from 'vue';

// 定义组件的 props
const props = defineProps({
  // 绑定值
  modelValue: {
    type: [String, Number, Boolean, Array, Object],
    default: null,
  },
  // 选项列表
  options: {
    type: Array,
    default: () => [],
  },
  // 选项的 value 字段名
  valueKey: {
    type: String,
    default: 'value',
  },
  // 选项的 label 字段名
  labelKey: {
    type: String,
    default: 'label',
  },
  // 占位文本
  placeholder: {
    type: String,
    default: '请选择',
  },
  // 是否禁用
  disabled: {
    type: Boolean,
    default: false,
  },
  // 是否可清空
  clearable: {
    type: Boolean,
    default: false,
  },
  // 是否可搜索
  filterable: {
    type: Boolean,
    default: true, // 默认为 true，支持输入搜索
  },
  // 是否为远程搜索
  remote: {
    type: Boolean,
    default: false,
  },
  // 远程搜索方法
  remoteMethod: {
    type: Function,
    default: () => {},
  },
  // 远程搜索加载状态
  loading: {
    type: Boolean,
    default: false,
  },
  // 下拉框的自定义类名
  popperClass: {
    type: String,
    default: '',
  },
  // 是否多选
  multiple: {
    type: Boolean,
    default: false,
  },
  // 多选时是否将选中值按文字的形式展示
  collapseTags: {
    type: Boolean,
    default: false,
  },
  // 多选时，是否使用 tooltip 显示已选择的标签
  collapseTagsTooltip: {
    type: Boolean,
    default: false,
  },
  // 多选时用户最多可以选择的项目数，为 0 则不限制
  multipleLimit: {
    type: Number,
    default: 0,
  },
  // 在输入框按下回车，选择第一个匹配项
  defaultFirstOption: {
    type: Boolean,
    default: false,
  },
  // 搜索关键词高亮
  reserveKeyword: {
    type: Boolean,
    default: false,
  },
  // 是否使用 teleport 到 body
  teleported: {
    type: Boolean,
    default: true,
  },
  // 是否触发表单验证
  validateEvent: {
    type: Boolean,
    default: true,
  },
  // 尺寸
  size: {
    type: String,
    default: '',
    validator: (value: string) => ['', 'large', 'default', 'small'].includes(value),
  },
  // id
  id: {
    type: String,
    default: '',
  },
  // 自定义类名
  customClass: {
    type: String,
    default: '',
  },
});

// 定义组件的事件
const emit = defineEmits([
  // 绑定值变化时触发
  'update:modelValue',
  // 选中值发生变化时触发
  'change',
  // 下拉框显示/隐藏时触发
  'visible-change',
  // 多选模式下移除tag时触发
  'remove-tag',
  // 可清空模式下点击清空按钮时触发
  'clear',
  // 当输入框获得焦点时触发
  'focus',
  // 当输入框失去焦点时触发
  'blur',
]);

// 计算属性：获取当前选中的值（用于v-model）
const model = computed({
  get() {
    return props.modelValue;
  },
  set(value) {
    emit('update:modelValue', value);
  },
});

// 处理值变化事件
const handleChange = (value: any) => {
  emit('change', value);
};

// 处理下拉框显示/隐藏事件
const handleVisibleChange = (visible: boolean) => {
  emit('visible-change', visible);
};

// 处理移除tag事件
const handleRemoveTag = (tag: any) => {
  emit('remove-tag', tag);
};

// 处理清空事件
const handleClear = () => {
  emit('clear');
};

// 处理焦点事件
const handleFocus = (event: FocusEvent) => {
  emit('focus', event);
};

// 处理失焦事件
const handleBlur = (event: FocusEvent) => {
  emit('blur', event);
};
</script>

<style scoped lang="scss">
// 组件的样式可以在这里定义
.el-select {
  width: 100%;
}
</style>
