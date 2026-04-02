<template>
  <div class="main-container">
    <!-- 搜索组件区域 -->
    <Card class="operation-card">
      <div class="header-container">
        <el-button type="primary" @click="showDrawer(0)" class="add-button">添加优惠券</el-button>
      </div>
      <div class="search-container">
        <!-- 状态 -->
        <div class="search-item">
          <label>
            <span>优惠券状态：</span>
            <el-select v-model="store.searchParams.ticketStatus" @change="search" style="width: 120px">
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </label>
        </div>

        <!-- 搜索框 -->
        <div class="search-item">
          <el-input
            v-model="store.searchParams.ticketName"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            clearable
            placeholder="优惠券名称"
            class="search-input"
          >
            <template #append>
              <el-button type="primary" @click="search">搜索</el-button>
            </template>
          </el-input>
        </div>
      </div>
    </Card>

    <!-- 表格组件 -->
    <Card v-loading="settingStore.loading" :element-loading-text="settingStore.loadingMsg" flex="row" :gap="7">
      <CouponCard
        v-for="item in store.tableData"
        :coupon="item"
        @disable="handleDisable"
        @edit="handleEdit"
        @more="handleMore"
      ></CouponCard>
      <template v-if="store.tableData.length === 0">
        <div class="el-full el-center">
          <el-empty></el-empty>
        </div>
      </template>
    </Card>
  </div>
  <!-- 抽屉表单 -->
  <Drawer v-model="drawer.visible" :title="drawer.title" @closed="handleDrawerClose">
    <!-- 表单 -->
    <CouponForm :disabled="drawer.disabled" @close-drawer="drawer.visible = false" />
    <!-- 抽屉操作按钮 -->
    <div v-show="drawer.disabled" class="drawer-buttons">
      <el-button @click="drawer.visible = false">取消</el-button>
    </div>
  </Drawer>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { onMounted, inject, reactive } from 'vue';
import CouponForm from './form.vue';
import CouponCard from '@/components/CouponCard/index.vue';

// 导入枚举数据
import { statusOptions } from '@/enums/index';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useCouponStore } from '@/store/modules/member/memberCoupon';
const settingStore = useSettingStore();
const store = useCouponStore();

// 引入消息提示组件
const $MessageBox: any = inject('$MessageBox');

onMounted(() => {
  store.setTableData();
});

// 搜索
const search = () => {
  store.setTableData();
};

// 禁用
const handleDisable = async (coupon: any) => {
  const handleStr = coupon.ticketStatus ? '启用' : '禁用';
  const result = await $MessageBox.confirm({
    title: '确认操作',
    message: `你确定要${handleStr}优惠券【${coupon.ticketName}】吗？`,
    type: 'warning',
  });
  result && store.updateStatus(coupon);
};

// 更多
const handleEdit = (coupon: any) => {
  showDrawer(2, coupon);
};

// 更多
const handleMore = (coupon: any) => {
  showDrawer(1, coupon);
};

// 抽屉标题
const drawerTitles = ['新增优惠券', '优惠券详情'];
const drawer = reactive({
  title: '新增优惠券',
  visible: false,
  disabled: false,
});

// 打开抽屉
const showDrawer = (index: number, row?: any) => {
  row?.id ? (store.formData = { ...row }) : store.resetFormData();
  index === 1 && (drawer.disabled = true);
  drawer.title = drawerTitles[index];
  drawer.visible = true;
};

// 关闭抽屉触发
const handleDrawerClose = () => {
  // 当抽屉关闭时重置表单
  store.resetFormData();
  // 去除预览禁用
  drawer.disabled = false;
};
</script>

<style scoped lang="scss">
:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
