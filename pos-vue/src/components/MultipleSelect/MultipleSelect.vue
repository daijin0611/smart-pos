<!--

  ！！！注意：该组件在当前项目的依赖版本下失效，只是留作备份

  该组件是基于element-plus的el-select组件封装的多选组件，
  该组件的props参数与el-select组件的props参数一致，
  该组件的事件参数与el-select组件的事件参数一致，
  该组件的方法参数与el-select组件的方法参数一致，
  该组件的插槽参数与el-select组件的插槽参数一致，
  该组件的样式参数与el-select组件的样式参数一致，
  该组件的事件参数与el-select组件的事件参数一致，
  该组件的方法参数与el-select组件的方法参数一致，
  该组件的插槽参数与el-select组件的插槽参数一致，
  该组件的样式参数与el-select组件的样式参数一致，

-->

<template>
  <div class="multiple-select-container">
    <component
      ref="selectRef"
      class="multiple-select"
      :is="h(ElSelect, { ...$attrs, ...props, ref: changeRef }, $slots)"
    ></component>
    <h1>已选优惠券</h1>
    <div v-if="props.showDisplayArea" class="selected-container">
      <el-scrollbar :style="getScrollbarStyle">
        <div v-for="item in props.modelValue" class="selected-item">
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
        <!-- @vue-ignore -->
        <template v-if="props.modelValue && props.modelValue.length === 0">
          <el-empty description="暂未选择" :image-size="50" style="padding: 0" />
        </template>
      </el-scrollbar>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ElSelect } from 'element-plus';
import { ref, h, getCurrentInstance, computed } from 'vue';
import type { SelectProps } from 'element-plus';

// 获取当前组件实例，用于暴露实例方法
const vm: any = getCurrentInstance();
const selectRef = ref();
function changeRef(instance: any) {
  // 将实例挂载到组件实例上，便于父组件调用
  vm.exposeProxy = vm.exposed = instance || {};
}

// 定义props
interface Props extends Partial<SelectProps> {
  /**
   * 是否显示选中结果展示区
   */
  showDisplayArea?: boolean;
  /**
   * 自定义展示区props属性
   */
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

  // 自定义属性
  showDisplayArea: true,
  displayProps: () => ({ label: 'label', value: 'value' }),
});

const getScrollbarStyle = computed(() => {
  const margin = '10px 0px';
  // @ts-ignore
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
  height: auto;
  // .multiple-select {
  // 	// 样式
  // }
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
