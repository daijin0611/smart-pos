<template>
  <!-- 顶部左侧静态 -->
  <el-icon @click="changeIcon" style="cursor: pointer">
    <component :is="settingStore.fold ? 'Fold' : 'Expand'"></component>
  </el-icon>
  <!-- 左侧面包屑 -->
  <el-breadcrumb separator-icon="ArrowRight">
    <!-- 面包动态展示路由名字与标题 -->
    <el-breadcrumb-item v-for="(item, index) in $route.matched" :key="index" v-show="item.meta.title" :to="item.path">
      <div class="breadcrumb_item">
        <!-- 图标 -->
        <el-icon>
          <component :is="item.meta.icon"></component>
        </el-icon>
        <!-- 面包屑展示匹配路由的标题 -->
        <span>{{ item.meta.title }}</span>
      </div>
    </el-breadcrumb-item>
  </el-breadcrumb>
</template>

<script setup lang="ts">
import { useRoute } from 'vue-router';
import { useSettingStore } from '@/store/modules/acl/setting';
// 获取layout配置相关的仓库
let settingStore = useSettingStore();
// 获取路由对象
let $route = useRoute();
// 点击图标的方法
const changeIcon = () => {
  // 图标进行切换
  settingStore.fold = !settingStore.fold;
};
</script>
<script lang="ts">
export default {
  name: 'Breadcrumb',
};
</script>

<style scoped lang="scss">
.breadcrumb_item {
  display: flex;
  align-items: center;
  gap: 5px;
  color: $base-header-color;
  cursor: pointer;
}
</style>
