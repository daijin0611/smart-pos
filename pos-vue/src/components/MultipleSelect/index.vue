<template>
  <div class="multiple-select-container">
    <!-- @vue-ignore -->
    <component
      ref="selectRef"
      class="multiple-select"
      :is="h(ElSelect, { ...$attrs, ...props, ref: changeRef }, $slots)"
      @change="handleChange"
      @visible-change="visibleChange"
    ></component>
    <template v-if="props.showDisplayArea">
      <el-text class="title" size="default">{{ props.displayAreaTitle }} :</el-text>
      <div class="selected-container">
        <el-scrollbar :style="getScrollbarStyle">
          <div v-for="item in props.modelValue" :key="item[props.displayProps.label]" class="selected-item">
            <div>
              <span>名称：</span>
              <span class="selected-item-label">
                <el-tooltip effect="light" :content="item[props.displayProps.label]" placement="top">
                  {{ item[props.displayProps.label] }}
                </el-tooltip>
              </span>
            </div>
            <div>
              <span>数量：</span>
              <span>
                <el-input-number v-model="item[props.displayProps.value]" :min="1" size="small" style="width: 100px" />
              </span>
            </div>
          </div>
          <template v-if="props.modelValue && props.modelValue.length === 0">
            <el-empty description="暂未选择" :image-size="50" style="padding: 0" />
          </template>
        </el-scrollbar>
      </div>
    </template>
  </div>
</template>

<script setup lang="ts">
import { ElSelect } from 'element-plus';
import { ref, h, getCurrentInstance, computed, withDefaults } from 'vue';

// 获取当前组件实例，用于暴露实例方法
const vm: any = getCurrentInstance();
const selectRef = ref();
function changeRef(instance: any) {
  // 将实例挂载到组件实例上，便于父组件调用
  if (instance) {
    instance.selectRef = selectRef;
  }
  vm.exposeProxy = vm.exposed = instance || {};
}

// 定义props
interface Props {
  // #region el-select 参数
  ariaLabel?: string;
  emptyValues?: Array<any>;
  valueOnClear?: any;
  name?: string;
  id?: string;
  modelValue: any;
  autocomplete?: any;
  automaticDropdown?: boolean;
  size?: '' | 'small' | 'default' | 'large';
  effect?: any;
  disabled?: boolean;
  clearable?: boolean;
  filterable?: boolean;
  allowCreate?: boolean;
  loading?: boolean;
  popperClass?: any;
  popperOptions?: any;
  remote?: boolean;
  loadingText?: string;
  noMatchText?: string;
  noDataText?: string;
  remoteMethod?: any;
  filterMethod?: any;
  multiple?: boolean;
  multipleLimit?: any;
  placeholder?: string;
  defaultFirstOption?: boolean;
  reserveKeyword?: any;
  valueKey?: any;
  collapseTags?: boolean;
  collapseTagsTooltip?: boolean;
  maxCollapseTags?: any;
  teleported?: any;
  persistent?: any;
  clearIcon?: any;
  fitInputWidth?: boolean;
  suffixIcon?: any;
  tagType?: any;
  tagEffect?: any;
  validateEvent?: any;
  remoteShowSuffix?: boolean;
  showArrow?: any;
  offset?: any;
  placement?:
    | ''
    | 'top'
    | 'bottom'
    | 'left'
    | 'right'
    | 'auto'
    | 'auto-start'
    | 'auto-end'
    | 'top-start'
    | 'top-end'
    | 'bottom-start'
    | 'bottom-end'
    | 'right-start'
    | 'right-end'
    | 'left-start'
    | 'left-end';
  fallbackPlacements?: any;
  tabindex?: any;
  appendTo?: any;
  // #endregion el-select 参数

  // 是否显示选中结果展示区
  showDisplayArea?: boolean;
  // 结果展示区标题文本
  displayAreaTitle?: string;
  // 自定义展示区props属性
  displayProps?: {
    label: string;
    value: string;
    [property: string]: string;
  };
}

// props默认值
const props = withDefaults(defineProps<Props>(), {
  // el-select 本身具有的属性赋默认值
  multiple: true,
  clearable: true,
  placeholder: '请选择',
  placement: 'bottom',

  // 自定义属性
  showDisplayArea: true,
  displayAreaTitle: '已选',
  displayProps: () => ({ label: 'label', value: 'value' }),
});

const emit = defineEmits(['visible-change', 'update:model-value']);
// const emit = defineEmits(['update:model-value']);

const visibleChange = (val: any) => {
  emit('visible-change', val);
};

const handleChange = (val: any) => {
  emit('update:model-value', val);
};

const getScrollbarStyle = computed(() => {
  const margin = '10px 0px';
  const height = props.modelValue && props.modelValue.length >= 2 ? '160px' : '100%';
  return { margin, height };
});
</script>
<script lang="ts">
export default {
  name: 'MultipleSelect',
};
</script>

<style lang="scss">
.multiple-select-container {
  min-width: 200px;
  height: auto;

  // 展示区标题
  .title {
    display: block;
    margin-left: 2px;
  }

  // 展示区
  .selected-container {
    margin-bottom: 15px;
    max-height: 180px;
    min-height: 0px;
    border-radius: 5px;
    border: 1px solid var(--el-border-color);
    box-shadow: var(--el-box-shadow-lighter);

    .selected-item {
      height: 70px;
      line-height: 30px;
      margin: 10px;
      padding: 5px 0;
      border: 1px solid var(--el-border-color);
      border-radius: 5px;
      &:first-child {
        margin-top: 0;
      }

      > div {
        display: flex;
        > span:first-child {
          width: 60px;
          text-align: right;
        }
        .selected-item-label {
          width: calc(100% - 70px);
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
        }
      }
    }
  }
}
</style>
