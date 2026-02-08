<template>
  <div class="main-container">
    <!-- 搜索组件区域 -->
    <Card class="operation-card">
      <div class="header-container">
        <el-button type="primary" @click="showDrawer(0)" class="add-button">添加充值提成规则</el-button>
      </div>
      <div class="search-container">
        <!-- 提成规则状态 -->
        <div class="search-item">
          <label>
            提成规则状态：
            <el-select
              v-model="store.searchParams.status"
              @change="search"
              @clear="search"
              clearable
              style="width: 120px"
            >
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </label>
        </div>

        <!-- 搜索框 -->
        <div class="search-item">
          <el-input
            v-model="store.searchParams.rechargeRoleName"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            placeholder="提成规则名称"
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
        <el-table-column type="index" label="序号" width="60" />
        <el-table-column prop="rechargeRoleName" label="提成规则名称" min-width="100" />
        <el-table-column prop="rechargePrice" label="充值金额" :formatter="amountFormatter" min-width="50" />
        <el-table-column label="提成类型" min-width="60">
          <template #default="{ row }">
            {{ commissionTypeMap[row.commissionType as CommissionType] }}
          </template>
        </el-table-column>
        <el-table-column label="提成值" min-width="50">
          <template #default="{ row }">
            {{ row.rechargeCommissionValue }}{{ row.commissionType === CommissionType.FixedAmount ? ' 元' : '%' }}
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" :formatter="dateFormatter" min-width="60" />
        <el-table-column prop="updateTime" label="修改时间" :formatter="dateFormatter" min-width="60" />
        <el-table-column label="操作" min-width="60">
          <template #default="{ row }">
            <el-button @click="showDrawer(1, row)" :disabled="!!row.status" link type="primary">编辑</el-button>
            <el-button @click="store.updateDataStatus(row)" v-if="row.status" link type="success">启用</el-button>
            <el-button @click="showConfirm(row)" v-else link type="warning">禁用</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <!-- 抽屉表单 -->
  <Drawer v-model="drawer.visible" :title="drawer.title" @closed="handleDrawerClose">
    <!-- 表单 -->
    <RechargeCommissionRulesForm @close-drawer="drawer.visible = false" />
  </Drawer>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { reactive, onMounted, inject } from 'vue';
import RechargeCommissionRulesForm from './form.vue';

// 导入表格内容格式化器
import { amountFormatter, dateFormatter } from '@/utils/formatter';

// 导入枚举数据
import { statusOptions, commissionTypeMap, CommissionType } from '@/enums/index';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useRechargeCommissionRulesStore } from '@/store/modules/setGroup/rechargeCommissionRules';
const settingStore = useSettingStore();
const store = useRechargeCommissionRulesStore();

// 引入消息提示组件
const $MessageBox: any = inject('$MessageBox');

onMounted(() => {
  search();
});

// 搜索产品
const search = () => {
  store.setDataList();
};

// 禁用产品
const showConfirm = async (row: any) => {
  const result = await $MessageBox.confirm({
    title: '确认操作',
    message: `你确定要禁用充值提成规则【${row.rechargeRoleName}】吗？`,
    type: 'warning',
  });
  result && store.updateDataStatus(row);
};

// 抽屉标题
const drawerTitles = ['新增充值提成规则信息', '修改充值提成规则信息'];
const drawer = reactive({
  title: '新增充值提成规则信息',
  visible: false,
});

// 打开抽屉
const showDrawer = (handleIndex: number, row?: any) => {
  // 表单数据回显
  handleIndex ? (store.formData = { ...row }) : store.resetFormData();
  drawer.title = drawerTitles[handleIndex];
  drawer.visible = true;
};

// 关闭抽屉触发
const handleDrawerClose = () => {
  store.resetFormData();
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
