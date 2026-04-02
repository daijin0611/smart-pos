<template>
  <div class="main-container">
    <!-- 搜索组件区域 -->
    <Card class="operation-card">
      <div class="header-container">
        <el-button type="primary" @click="showDrawer(0)" class="add-button">添加产品</el-button>
      </div>
      <div class="search-container">
        <!-- 产品状态 -->
        <div class="search-item">
          <label>
            <span>产品状态：</span>
            <el-select v-model="store.search.productStatus" @change="search" style="width: 120px">
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </label>
        </div>
        <!-- 搜索框 -->
        <div class="search-item">
          <el-input
            v-model="store.search.keyWord"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            placeholder="编码 | 产品名称"
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
        :data="store.tableData"
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :row-class-name="getRowClassName"
        :showPagination="false"
      >
        <el-table-column prop="productName" label="产品" />
        <el-table-column prop="productEncode" label="编码" />
        <el-table-column prop="quantity" label="库存" />
        <el-table-column prop="unit" label="单位/规格" :formatter="unitFormatter" width="90" />
        <el-table-column prop="productPrice" label="标准价(元)" />
        <el-table-column prop="vipProductPrice" label="会员价(元)" />
        <el-table-column prop="isDiscount" label="参与折扣卡打折" :formatter="isDiscountMap" />
        <el-table-column label="操作">
          <template #default="{ row }">
            <el-button @click="showDrawer(2, row)" link type="info">详情</el-button>
            <el-button @click="showDrawer(1, row)" :disabled="!!row.productStatus" link type="primary">编辑</el-button>
            <el-button @click="store.updateStatus(row)" v-if="row.productStatus" link type="success">启用</el-button>
            <el-button @click="showConfirm(row)" v-else link type="warning">禁用</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <!-- 抽屉表单 -->
  <Drawer v-model="drawer.visible" :title="drawer.title" @closed="handleDrawerClose">
    <!-- 表单 -->
    <ProductForm :disabled="drawer.disabled" @close-drawer="drawer.visible = false" />
    <!-- 抽屉操作按钮 -->
    <div v-show="drawer.disabled" class="drawer-buttons">
      <el-button @click="drawer.visible = false">取消</el-button>
    </div>
  </Drawer>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { ref, onMounted, inject, reactive } from 'vue';
import ProductForm from './form.vue';

// 导入枚举数据
import { statusOptions } from '@/enums/index';
import { isDiscountMap } from '@/utils/formatter';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useEnumStore } from '@/store/modules/enums/index';
import { useProductStore } from '@/store/modules/setGroup/product';
const settingStore = useSettingStore();
const enumStore = useEnumStore();
const store = useProductStore();

// 引入消息提示组件
const $MessageBox: any = inject('$MessageBox');

onMounted(() => {
  search();
});

// 搜索产品
const search = () => {
  store.setTableData();
};

// 禁用产品
const showConfirm = async (row: any) => {
  const result = await $MessageBox.confirm({
    title: '确认操作',
    message: `你确定要禁用产品【${row.productName}】吗？`,
    type: 'warning',
  });
  result && store.updateStatus(row);
};

// 抽屉标题
const drawerTitles = ['新增产品信息', '修改产品信息', '产品信息'];
const drawer = reactive({
  title: '新增产品信息',
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

const unitList = ref<any>([]);
const getUnitList = async () => {
  unitList.value = await enumStore.getUnits();
};
getUnitList();

/**
 * 单位格式化
 * @param row 行数据
 * @param column 列数据
 * @param cellValue 单元格值
 * @param index 行索引
 * @returns 单位名称
 */
const unitFormatter = (row: any, column: any, cellValue: number, index: number) => {
  const unit = unitList.value.find((item: any) => item.itemValue === cellValue);
  return unit?.itemLabel || '-';
};

// 设置行样式
const getRowClassName = ({ row }: { row: { productStatus: number } }) => {
  return row.productStatus === 1 ? 'disabled-row' : '';
};
</script>

<style scoped lang="scss">
:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
