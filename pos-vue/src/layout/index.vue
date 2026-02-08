<template>
  <div class="layout_container">
    <!-- 左侧菜单 -->
    <div class="layout_slider" :class="{ fold: settingStore.fold ? true : false }">
      <Logo></Logo>
      <!-- 展示菜单 -->
      <!-- 滚动组件 -->
      <el-scrollbar class="scrollbar">
        <!-- 菜单组件-->
        <el-menu
          :collapse="settingStore.fold ? true : false"
          :default-active="$route.path"
          background-color="#001529"
          text-color="white"
        >
          <!--根据路由动态生成菜单-->
          <Menu :menuList="userStore.menuRoutes"></Menu>
        </el-menu>
      </el-scrollbar>
      <div class="driver-down" v-show="!settingStore.fold">
        <el-link href="./Pdriver.exe" class="down-link" underline="never">小票打印机驱动</el-link>
        <el-link href="./printer.exe" class="down-link" underline="never">打印加速控件下载</el-link>
      </div>
    </div>
    <div class="layout_right">
      <!-- 顶部导航 -->
      <div class="layout_tabbar" :class="{ fold: settingStore.fold ? true : false }">
        <!-- layout组件的顶部导航tabbar -->
        <Tabbar></Tabbar>
      </div>
      <!-- 内容展示区域 -->
      <div class="layout_main" :class="{ fold: settingStore.fold ? true : false }">
        <Main></Main>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { debounce } from 'lodash';
import { ref, onMounted } from 'vue';
//获取路由对象
import { useRoute } from 'vue-router';
//引入左侧菜单logo子组件
import Logo from './logo/index.vue';
//引入菜单组件
import Menu from './menu/index.vue';
//右侧内容展示区域
import Main from './main/index.vue';
//引入顶部tabbar组件
import Tabbar from './tabbar/index.vue';

// 获取pinia仓库
import useUserStore from '@/store/modules/acl/user';
import { useSettingStore } from '@/store/modules/acl/setting';
import { useDataEnumStore } from '@/store/modules/enums/index';
const userStore = useUserStore();
const settingStore = useSettingStore();
const enumStore = useDataEnumStore();

//获取路由对象
let $route = useRoute();

onMounted(() => {
  // 监听窗口大小变化
  window.addEventListener('resize', handleResize);
  handleResize();
  init();
});

// 监听窗口大小变化
const windowWidth = ref(window.innerWidth);
const handleResize = debounce(() => {
  windowWidth.value = window.innerWidth;

  // 当窗口小于1024px时，自动折叠菜单
  if (windowWidth.value <= 1024) {
    settingStore.fold = true;
  } else {
    settingStore.fold = false;
  }
}, 300);

const init = async () => {
  // 初始化常用枚举信息
  await enumStore.getProductList();
  await enumStore.getServiceItemList();
  await enumStore.getTreatmentCouponList();
};
</script>

<script lang="ts">
export default {
  name: 'Layout',
};
</script>
<style scoped lang="scss">
.layout_container {
  width: 100%;
  height: 100vh;
  display: flex;

  // 左侧菜单
  .layout_slider {
    color: white;
    display: inline-block;
    height: 100vh;
    width: $base-menu-width;
    background: $base-menu-bg;
    transition: all 0.3s;
    z-index: 1;
    &.fold {
      width: $base-menu-min-width;
    }
    .scrollbar {
      width: 100%;
      height: calc(100vh - $base-menu-logo-height - 70px);

      .el-menu {
        height: 100%;
        border-right: none;
      }
    }
    .driver-down {
      height: 70px;
      padding: 5px 0;
      line-height: 25px;
      text-align: center;
      display: flex;
      flex-direction: column;
      .down-link {
        font-size: 12px !important;
      }
    }
  }

  // 右侧主题内容
  .layout_right {
    display: flex;
    flex-direction: column;
    justify-content: space-between;

    // 顶部header
    .layout_tabbar {
      width: calc(100vw - $base-menu-width);
      height: $base-tabbar-height;
      transition: all 0.3s;
      &.fold {
        width: calc(100vw - $base-menu-min-width);
      }
    }

    // 主体内容
    .layout_main {
      width: calc(100vw - $base-menu-width);
      height: calc(100vh - $base-tabbar-height);
      padding: $main-padding;
      transition: all 0.3s;
      &.fold {
        width: calc(100vw - $base-menu-min-width);
      }
    }
  }
}
</style>
