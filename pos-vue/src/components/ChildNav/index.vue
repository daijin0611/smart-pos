<template>
  <component
    :is="h(ElTabs, { ...$attrs, ...props, ref: changeRef }, $slots)"
    v-model="activeName"
    @tab-click="handleTabClick"
    type="border-card"
    class="demo-tabs"
  >
    <el-tab-pane v-for="item in props.navList" :key="item.label" :name="item.label" style="height: 100%">
      <template #label>
        <span class="custom-tabs-label">
          <el-icon v-if="item.icon">
            <component :is="item.icon" />
          </el-icon>
          <span>{{ item.label }}</span>
        </span>
      </template>

      <!-- 仅当标签页激活时渲染组件 -->
      <component :is="item.component" v-if="activeName === item.label" />
    </el-tab-pane>
  </component>
</template>

<script setup lang="ts">
import { ElTabs, type TabsProps } from 'element-plus';
import { ref, onMounted, h, getCurrentInstance, withDefaults } from 'vue';

interface NavItem {
  label: string;
  icon?: string;
  component: object;
}

interface MyTabsProps extends Partial<TabsProps> {
  navList: Array<NavItem>;
}

const props = withDefaults(defineProps<MyTabsProps>(), {});

// 追踪当前激活的标签页
const activeName = ref('');

// 页面加载时，从 localStorage 恢复激活的 tab
onMounted(() => {
  const savedTab = localStorage.getItem('activeTab');
  if (savedTab && props.navList.some((item) => item.label === savedTab)) {
    activeName.value = savedTab;
  } else {
    // 默认激活第一个 tab
    activeName.value = props.navList[0]?.label || '';
  }
});

// tab 切换时保存到 localStorage
const handleTabClick = (tab: any) => {
  localStorage.setItem('activeTab', tab.props.name);
  activeName.value = tab.props.name;
};

// // 获取当前组件实例，用于暴露对话框方法
const vm: any = getCurrentInstance();
function changeRef(instance: any) {
  // 将组件实例挂载到组件实例上，便于父组件调用
  vm.exposeProxy = vm.exposed = instance || {};
}
</script>
<script lang="ts">
export default {
  name: 'ChildNav',
};
</script>

<style scoped lang="scss">
.demo-tabs {
  border: none;
  height: 100%;

  > .el-tabs__content {
    padding: 32px;
    color: #6b778c;
    font-size: 32px;
    font-weight: 600;
  }
  .custom-tabs-label .el-icon {
    vertical-align: middle;
  }
  .custom-tabs-label span {
    vertical-align: middle;
    margin-left: 4px;
  }
}
</style>
