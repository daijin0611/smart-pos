<template>
  <div class="main-container">
    <!-- 搜索组件区域 -->
    <Card class="operation-card">
      <div class="header-container">
        <el-button type="primary" @click="showDrawer(0)" class="add-button">添加疗程券</el-button>
      </div>
      <div class="search-container">
        <!-- 疗程券状态 -->
        <div class="search-item">
          <label>
            疗程券状态：
            <el-select v-model="store.searchParams.status" @change="search" style="width: 120px">
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </label>
        </div>

        <!-- 搜索框 -->
        <div class="search-item">
          <el-input
            v-model="store.searchParams.cureTicketName"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            placeholder="疗程券名称"
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
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :data="store.dataList"
        :row-class-name="getRowClassName"
        :showPagination="false"
      >
        <el-table-column label="疗程券" min-width="60">
          <template #default="{ row }">
            <p>名称：{{ row.name }}</p>
            <p>编码：{{ row.encode }}</p>
          </template>
        </el-table-column>
        <el-table-column label="疗程券内容" min-width="100">
          <template #default="{ row }">
            <div style="display: flex; gap: 5px; flex-wrap: wrap">
              <el-tag v-for="item in row.ticketDetails" :key="item" type="primary">
                {{ item.vipTicketName }} &nbsp; 数量：{{ item.vipTicketNum }}
              </el-tag>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="price" label="疗程价(元)" :formatter="amountFormatter" min-width="50" />
        <el-table-column label="提成" width="200">
          <template #default="{ row }">
            <span v-if="row.type === CommissionType.FixedAmount">固定金额提成：{{ row.commissionValue || 0 }}元</span>
            <span v-else>固定比例提成：{{ row.commissionValue || 0 }}%</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" min-width="50">
          <template #default="{ row }">
            <el-button link type="info" @click="showDrawer(2, row)">详情</el-button>
            <el-button link type="primary" :disabled="!!row.status" @click="showDrawer(1, row)">编辑</el-button>
            <el-button link type="success" v-if="row.status" @click="store.updateDataStatus(row)">启用</el-button>
            <el-button link type="warning" v-else @click="showConfirm(row)">禁用</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <!-- 抽屉表单 -->
  <Drawer v-model="drawer.visible" :title="drawer.title" @closed="handleDrawerClose">
    <!-- 表单 -->
    <TreatmentCouponForm :disabled="drawer.disabled" @close-drawer="drawer.visible = false" />
    <!-- 抽屉操作按钮 -->
    <template v-if="drawer.disabled">
      <div class="drawer-buttons">
        <el-button @click="drawer.visible = false">取消</el-button>
      </div>
    </template>
  </Drawer>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { ref, onMounted, inject, reactive } from 'vue';
import TreatmentCouponForm from './form.vue';

// 导入表格数据格式化器
import { amountFormatter } from '@/utils/formatter';
// 导入枚举数据
import { statusOptions, CommissionType } from '@/enums/index';
import { cloneDeep } from 'lodash';

// 导入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useTreatmentCouponStore } from '@/store/modules/setGroup/treatmentCoupon';
const settingStore = useSettingStore();
const store = useTreatmentCouponStore();

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
    message: `你确定要禁用疗程券【${row.name}】吗？`,
    type: 'warning',
  });
  result && store.updateDataStatus(row);
};

// 抽屉标题
const drawerTitles = ['新增疗程券信息', '修改疗程券信息', '疗程券信息'];
const drawer = reactive({
  title: '新增疗程券信息',
  visible: false,
  disabled: false,
});

// 打开抽屉
const showDrawer = (handleIndex: number, row: any = {}) => {
  handleIndex === 2 && (drawer.disabled = true);
  handleIndex !== 0 ? (store.formData = cloneDeep(row)) : store.resetFormData();
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
const getRowClassName = ({ row }: { row: { status: number } }) => {
  return row.status ? 'disabled-row' : '';
};
</script>

<style scoped lang="scss">
:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
