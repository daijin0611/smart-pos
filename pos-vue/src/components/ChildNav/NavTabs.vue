<template>
  <div class="nav-tabs-container">
    <component
      ref="treeRef"
      :is="h(ElTabs, { ...$attrs, ...props, ref: changeRef }, $slots)"
      class="nav-tabs"
      style="height: 100%"
    >
      <template v-if="$slots.default">
        <slot></slot>
      </template>
      <template v-else>
        <el-tab-pane
          v-for="item in props.tabs"
          :label="item[props.props.label]"
          :name="item[props.props.name]"
          :key="item[props.props.name]"
          style="height: 100%"
        >
          <template #label>
            <span class="label">
              <template v-if="item[props.props.icon || 'icon']">
                <SvgIcon :name="item[props.props.icon || 'icon']" class="icon" />
              </template>
              <span>{{ item[props.props.label] }}</span>
            </span>
          </template>
          <template v-if="item[props.props.content || 'content']">
            <component :is="item[props.props.content || 'content']" />
          </template>
        </el-tab-pane>
      </template>
    </component>
    <!-- 操作按钮(绝对定位布局) -->
    <div v-if="props.showBtns" class="btns">
      <template v-if="$slots.btns">
        <slot name="btns"></slot>
      </template>
      <template v-else>
        <el-button v-if="showResetBtn" type="default" @click="handleReset">重置表单</el-button>
        <el-button v-if="showEditBtn" type="primary" @click="handleEdit">更新</el-button>
        <el-button v-if="showAddBtn" type="primary" @click="handleAdd">添加</el-button>
      </template>
    </div>
  </div>
</template>
<script setup lang="ts">
// 引入组件默认样式
import 'element-plus/es/components/tabs/style/css';
import 'element-plus/es/components/tab-pane/style/css';
import { h, getCurrentInstance } from 'vue';
import { ElTabs, type TabsProps } from 'element-plus';
// 导入子组件
import SvgIcon from '@/components/icon-font/SvgIcon.vue';

// 获取当前组件实例，用于暴露实例方法
const vm: any = getCurrentInstance();
function changeRef(instance: any) {
  // 将实例挂载到组件实例上，便于父组件调用
  vm.exposeProxy = vm.exposed = instance || {};
}

// 定义 Props 并继承 TabsProps
interface Props extends Partial<TabsProps> {
  // 是否显示操作按钮
  showBtns?: boolean;
  // 是否显示重置按钮
  showResetBtn?: boolean;
  // 是否显示提交更新按钮
  showEditBtn?: boolean;
  // 是否显示提交添加按钮
  showAddBtn?: boolean;
  // tab 列表
  tabs?: Array<TabPane>;
  // tab 列表Props属性
  props?: {
    label: string;
    name: string;
    icon?: string;
    content?: string;
    [property: string]: string | undefined;
  };
}

// props默认值
const props = withDefaults(defineProps<Props>(), {
  type: 'card',

  // 自定义属性
  showBtns: true,
  showResetBtn: true,
  showEditBtn: true,
  showAddBtn: true,
  tabs: () => [],
  props: () => ({ label: 'label', name: 'name', icon: 'icon' }),
});

// 定义emit
const emit = defineEmits(['reset', 'edit', 'add']);

const handleReset = () => {
  emit('reset');
};

const handleEdit = () => {
  emit('edit');
};

const handleAdd = () => {
  emit('add');
};
</script>
<script lang="ts">
export default {
  name: 'NavTabs',
};
interface TabPane {
  label: string;
  name: string;
  icon?: string;
  disabled?: boolean;
  closable?: boolean;
  content?: string;
}
</script>

<style lang="scss" scoped>
.nav-tabs-container {
  // 定义nav高度
  $height: 46px;
  $nav-bg: var(--container-bg-color);
  $tab-bg: #f8f9fa;

  height: 100%;
  position: relative;

  .label {
    display: flex;
    align-items: center;
    .icon {
      margin-right: 5px;
    }
  }

  > :deep(.el-tabs) {
    // 修改tabs默认样式
    > .el-tabs__header {
      // 改变tabs高度
      --el-tabs-header-height: #{$height};
      border: none;
      margin: 0;
      > .el-tabs__nav-wrap {
        border: none;
        margin: 0;
        height: 100%;

        > .el-tabs__nav-scroll {
          height: 100%;
        }
      }
      > div {
        // 设置整个导航的背景色
        background-color: $nav-bg;
        margin: 0;
      }
      // 改变tabs标签样式
      > div > div > .el-tabs__nav {
        height: 100%;
        border: none;
        // 设置tabs标签项的背景色
        background-color: $tab-bg;

        > .el-tabs__item {
          margin: 0;
          border: none;
          &.is-active {
            // 设置tabs标签选中时的背景色
            background-color: var(--el-bg-color);
          }
        }
      }
    }
  }
  .btns {
    $spacing: calc(($height - 32px) / 2);
    position: absolute;
    right: $spacing;
    top: $spacing;
  }
}
</style>
