<template>
  <div class="main-container">
    <!-- 搜索组件区域 -->
    <Card class="operation-card">
      <div class="header-container">
        <el-button type="primary" @click="showDrawer(0)" class="add-button">添加套餐</el-button>
      </div>
      <div class="search-container">
        <!-- 套餐状态 -->
        <div class="search-item">
          <label>
            套餐状态：
            <el-select v-model="store.searchParams.packageStatus" style="width: 120px">
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </label>
        </div>

        <!-- 搜索框 -->
        <div class="search-item">
          <el-input
            v-model="store.searchParams.packageName"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            placeholder="套餐名称"
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
        <el-table-column label="套餐" width="200">
          <template #default="scope">
            <p>名称：{{ scope.row.packageName }}</p>
            <p>编码：{{ scope.row.packageEncode }}</p>
          </template>
        </el-table-column>
        <el-table-column label="套餐明细">
          <template #default="scope">
            <div style="display: flex; gap: 5px; flex-wrap: wrap">
              <el-tag v-for="item in scope.row.packageDetailDTOList" :key="item" type="primary">
                {{ item.packageDetailName }} 数量：{{ item.packageToolNumber }}
              </el-tag>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="packagePrice" label="散客价(元)" :formatter="amountFormatter" width="110" />
        <el-table-column prop="packagePriceVip" label="会员价(元)" :formatter="amountFormatter" width="110" />
        <el-table-column label="操作" width="160">
          <template #default="scope">
            <el-button link type="info" @click="showDrawer(2, scope.row)">详情</el-button>
            <el-button link type="primary" :disabled="!!scope.row.packageStatus" @click="showDrawer(1, scope.row)">
              编辑
            </el-button>
            <el-button link type="warning" v-if="scope.row.packageStatus" @click="store.updateDataStatus(scope.row)">
              启用
            </el-button>
            <el-button link type="warning" v-else @click="showConfirm(scope.row)">禁用</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <!-- 抽屉表单 -->
  <Drawer v-model="drawer.visible" :title="drawer.title" @closed="handleDrawerClose">
    <!-- 表单 -->
    <PackageForm :disabled="drawer.disabled" @close-drawer="drawer.visible = false" />
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
import PackageForm from './form.vue';

// 导入表格数据格式化器
import { amountFormatter } from '@/utils/formatter';
// 导入枚举数据
import { statusOptions } from '@/enums/index';

// 导入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { usePackageStore } from '@/store/modules/setGroup/package';
const settingStore = useSettingStore();
const store = usePackageStore();

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
    message: `你确定要禁用套餐【${row.packageName}】吗？`,
    type: 'warning',
  });
  result && store.updateDataStatus(row);
};

// 抽屉标题
const drawerTitles = ['新增套餐信息', '修改套餐信息', '套餐信息'];
const drawer = reactive({
  title: '新增套餐信息',
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
  store.resetFormData();
  // 去除预览禁用
  drawer.disabled = false;
};

// 设置行样式
const getRowClassName = ({ row }: { row: { itemStatus: number } }) => {
  return row.itemStatus ? 'disabled-row' : '';
};
</script>

<style scoped lang="scss">
:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
