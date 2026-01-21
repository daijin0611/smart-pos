<template>
  <!-- 路由组件出口的位置 -->
  <router-view v-slot="{ Component }">
    <transition name="fade">
      <!-- 渲染layout一级路由组件的子路由 -->
      <div class="main_content" :key="$route.fullPath">
        <component :is="Component" v-if="flag" />
      </div>
    </transition>
  </router-view>
</template>

<script setup lang="ts">
import { watch, ref, nextTick } from 'vue';
import { useSettingStore } from '@/store/modules/acl/setting';
let settingStore = useSettingStore();

//控制当前组件是否销毁重建
let flag = ref(true);

//监听仓库内部数据是否发生变化,如果发生变化，说明用户点击过刷新按钮
watch(
  () => settingStore.refresh,
  () => {
    //点击刷新按钮:路由组件销毁
    flag.value = false;
    nextTick(() => {
      flag.value = true;
    });
  },
);
</script>
<script lang="ts">
export default {
  name: 'MainContent',
};
</script>

<style scoped lang="scss">
.fade-enter-from {
  opacity: 0;
  transform: translateX(-100vw);
}

.fade-enter-active {
  transition: all 0.3s;
}

.fade-enter-to {
  opacity: 1;
  transform: translateX(0vw);
}

.main_content {
  width: 100%;
  height: 100%;
  box-sizing: border-box;
  border-radius: 6px;
  overflow: auto;
  background-color: $base-main-bg;
}
</style>
