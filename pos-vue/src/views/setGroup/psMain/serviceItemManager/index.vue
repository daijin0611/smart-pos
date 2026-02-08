<template>
  <div class="main-container">
    <!-- 搜索组件区域 -->
    <Card class="operation-card">
      <div class="header-container">
        <el-button type="primary" @click="showDrawer(0)" class="add-button">添加服务项目</el-button>
      </div>
      <div class="search-container">
        <!-- 服务项目状态 -->
        <div class="search-item">
          <label>
            <span>服务项目状态：</span>
            <el-select v-model="store.searchParams.itemStatus" @change="search" style="width: 120px">
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </label>
        </div>

        <!-- 搜索框 -->
        <div class="search-item">
          <el-input
            v-model="store.searchParams.keyWord"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            placeholder="编码 | 服务名称"
            clearable
          >
            <template #append>
              <el-button type="primary" @click="search">搜索</el-button>
            </template>
          </el-input>
        </div>
      </div>
    </Card>

    <!-- 表格组件 -->
    <Card padding="0px">
      <PaginationTable
        :data="store.dataList"
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :row-class-name="getRowClassName"
        :showPagination="false"
      >
        <el-table-column prop="itemName" label="名称" />
        <el-table-column prop="itemEncode" label="编码" />
        <el-table-column prop="serverTime" label="服务时长(分钟)" />
        <el-table-column prop="itemPrice" label="标准价(元)" :formatter="amountFormatter" />
        <el-table-column prop="vipItemPrice" label="会员价(元)" :formatter="amountFormatter" />
        <el-table-column prop="isDiscounts" label="参与折扣卡打折" :formatter="isDiscountMap" />
        <el-table-column label="操作">
          <template #default="{ row }">
            <el-button @click="showDrawer(2, row)" link type="info">详情</el-button>
            <el-button @click="showDrawer(1, row)" :disabled="!!row.itemStatus" link type="primary">编辑</el-button>
            <el-button @click="store.updateDataStatus(row)" v-if="row.itemStatus" link type="warning">启用</el-button>
            <el-button @click="showConfirm(row)" v-else link type="warning">禁用</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <!-- 抽屉表单 -->
  <Drawer v-model="drawer.visible" :title="drawer.title" @closed="handleDrawerClose">
    <!-- 表单 -->
    <ServiceItemForm :disabled="drawer.disabled" @close-drawer="drawer.visible = false" />
    <!-- 抽屉操作按钮 -->
    <div v-show="drawer.disabled" class="drawer-buttons">
      <el-button @click="drawer.visible = false">取消</el-button>
    </div>
  </Drawer>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { onMounted, inject, reactive } from 'vue';
import ServiceItemForm from './form.vue';

// 导入表格数据格式化器
import { amountFormatter, isDiscountMap } from '@/utils/formatter';
// 导入枚举数据
import { statusOptions } from '@/enums/index';

// 导入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useServiceItemStore } from '@/store/modules/setGroup/serviceItem';
const settingStore = useSettingStore();
const store = useServiceItemStore();

// 引入消息提示组件
const $MessageBox: any = inject('$MessageBox');

// 初始化
onMounted(() => {
  search();
});

// 搜索
const search = () => {
  store.setDataList();
};

// 禁用
const showConfirm = async (row: any) => {
  const result = await $MessageBox.confirm({
    title: '确认操作',
    message: `你确定要禁用服务项目【${row.itemName}】吗？`,
    type: 'warning',
  });
  result && store.updateDataStatus(row);
};

// 抽屉标题
const drawerTitles = ['新增服务项目信息', '修改服务项目信息', '服务项目信息'];
const drawer = reactive({
  title: '新增服务项目信息',
  visible: false,
  disabled: false,
});

// 打开抽屉
const showDrawer = (handleIndex: number, row?: any) => {
  row?.id ? (store.formData = { ...row }) : store.resetFormData();
  handleIndex === 2 && (drawer.disabled = true);
  drawer.title = drawerTitles[handleIndex];
  drawer.visible = true;
};

// 关闭抽屉触发
const handleDrawerClose = () => {
  // 当抽屉关闭时重置表单
  store.resetFormData();
  // 去除预览禁用
  drawer.disabled = false;
};

// 设置行样式
const getRowClassName = ({ row }: { row: { itemStatus: number } }) => {
  return row.itemStatus === 1 ? 'disabled-row' : '';
};
</script>

<style scoped lang="scss">
:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
