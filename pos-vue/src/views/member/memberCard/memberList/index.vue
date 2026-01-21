<template>
  <div class="main-container">
    <!-- 数据筛选 -->
    <Card class="operation-card">
      <div class="search-container">
        <div class="search-item">
          <el-button type="primary" @click="showDrawer(0)" class="add-button">新增会员</el-button>
        </div>
        <div class="search-item">
          <el-input
            v-model="store.search.queryField"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            placeholder="会员卡号 | 姓名 | 手机号"
            clearable
            class="search-input"
          >
            <template #append>
              <el-button type="primary" @click="search">搜索</el-button>
            </template>
          </el-input>
        </div>
      </div>
    </Card>

    <!-- 数据列表 -->
    <Card padding="0">
      <PaginationTable
        v-loading="settingStore.loading && !dialog.visible"
        :element-loading-text="settingStore.loadingMsg"
        :data="store.tableData.list"
        :total="store.tableData.total"
        v-model:currentPage="store.search.pageNum"
        v-model:pageSize="store.search.pageSize"
        @size-change="handleSizeChange"
        @pagination-current-change="handleCurrentChange"
      >
        <el-table-column prop="name" label="姓名" min-width="40" />
        <el-table-column prop="gender" label="性别" min-width="30" :formatter="sexMap" />
        <el-table-column prop="cardNumber" label="卡号" min-width="80" />
        <el-table-column prop="phoneNumber" label="手机号" min-width="50" />
        <el-table-column prop="lastConsumptionTime" label="末次消费日期" min-width="50" />
        <el-table-column prop="lastRechargeTime" label="末次充值日期" min-width="50" />
        <el-table-column prop="remark" label="备注" min-width="80" />
        <el-table-column label="操作" min-width="100">
          <template #default="{ row }">
            <el-button link type="warning" @click="showDrawer(1, row)">修改资料</el-button>
            <el-button link type="primary" @click="showDrawer(2, row)">修改密码</el-button>
            <el-button link type="success" :disabled="false" @click="showDrawer(3, row)">赠送优惠券</el-button>
            <el-button link type="warning" :disabled="true" @click="showDialog(4, row)">取消优惠券</el-button>
            <el-button link type="success" :disabled="false" @click="showDrawer(5, row)">赠送卡金</el-button>
            <el-button link type="info" :disabled="true" @click="showDialog(6, row)">更多</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <Drawer v-model="drawer.visible" :title="drawer.title" @closed="handleDrawerClose">
    <component :is="drawer.component" @close-drawer="drawer.visible = false" />
  </Drawer>

  <el-dialog
    v-model="dialog.visible"
    :title="dialog.title"
    @closed="handleDrawerClose"
    center
    :style="{
      width: dialog.width,
      backgroundColor: dialog.width === '1200px' ? 'var(--el-color-primary-light-9)' : '#fff',
    }"
  >
    <component :is="dialog.component" @close-drawer="dialog.visible = false" />
  </el-dialog>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { onMounted, markRaw, reactive } from 'vue';
import { sexMap } from '@/utils/formatter';

// 导入子组件
import MemberForm from './components/MemberForm.vue';
import PwdForm from './components/PwdForm.vue';
import GiveCouponForm from './components/GiveCouponForm.vue';
import CancelCoupon from './components/CancelCoupon.vue';
import GiveCardAmount from './components/GiveCardAmount.vue';
import MemberInfo from './components/MemberInfo.vue';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useMemberStore } from '@/store/modules/member/member';
const settingStore = useSettingStore();
const store = useMemberStore();

// 初始化
onMounted(() => {});

// 搜索
const search = () => {
  store.setTableData();
};

// 处理分页变化
const handleSizeChange = (val: number) => {
  store.search.pageSize = val;
  store.setTableData();
};

const handleCurrentChange = (val: number) => {
  store.search.pageNum = val;
  store.setTableData();
};

// 抽屉标题
const titles = ['新增会员', '修改会员信息', '修改会员密码', '赠送优惠券', '优惠券列表', '赠送卡金', '会员信息'];
const drawer = reactive({
  title: '新增会员',
  visible: false,
  component: markRaw(MemberForm),
});

// 打开抽屉
const showDrawer = (index: number, row?: any) => {
  // 表单数据回显
  row?.id ? (store.formData = { ...row }) : store.resetFormData();
  drawer.title = titles[index];
  drawer.visible = true;

  // 切换子组件
  index === 0 && (drawer.component = markRaw(MemberForm));
  index === 1 && (drawer.component = markRaw(MemberForm));
  index === 2 && (drawer.component = markRaw(PwdForm));
  index === 3 && (drawer.component = markRaw(GiveCouponForm));
  index === 5 && (drawer.component = markRaw(GiveCardAmount));
};

// 关闭抽屉触发
const handleDrawerClose = () => {
  // 当抽屉关闭时重置表单
  store.resetFormData();
};

// 模态框
const dialog: any = reactive({
  title: '优惠券列表',
  visible: false,
  component: markRaw(CancelCoupon),
  width: '900px',
});

// 打开模态框
const showDialog = (index: number, row?: any) => {
  row?.id ? (store.formData = { ...row }) : store.resetFormData();

  dialog.title = titles[index];
  dialog.visible = true;

  // 切换子组件
  if (index === 4) {
    dialog.width = '900px';
    dialog.component = markRaw(CancelCoupon);
  }
  if (index === 6) {
    dialog.width = '1200px';
    dialog.component = markRaw(MemberInfo);
  }
};
</script>

<style scoped lang="scss">
:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
