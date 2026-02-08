<template>
  <div class="main-container">
    <!-- 数据筛选 -->
    <Card class="operation-card">
      <div class="search-container">
        <el-button type="primary" @click="showDrawer(0)">添加人员</el-button>
      </div>
      <div class="search-container">
        <!-- 人员在职状态 -->
        <div class="search-item">
          <label>
            <span>在职状态：</span>
            <el-select v-model="store.search.userStatus" @change="search" style="width: 120px">
              <el-option
                v-for="item in searchEmployedOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
          </label>
        </div>
        <!-- 角色 -->
        <div class="search-item">
          <label>
            <span>角色：</span>
            <el-select v-model="store.search.roleId" @change="search" style="width: 120px">
              <el-option v-for="item in roleList" :label="item.roleName" :value="item.id" :key="item.id" />
            </el-select>
          </label>
        </div>
        <!-- 搜索 -->
        <div class="search-item">
          <el-input
            v-model="store.search.userName"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            placeholder="姓名 | 登录名"
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
        v-loading="settingStore.loading && !drawer.visible"
        :data="store.tableData.list"
        :total="store.tableData.total"
        v-model:currentPage="store.search.pageNum"
        v-model:pageSize="store.search.pageSize"
        @size-change="handleSizeChange"
        @pagination-current-change="handleCurrentChange"
        :row-class-name="getRowClassName"
      >
        <el-table-column type="index" label="序号" width="60" />
        <el-table-column prop="userName" label="姓名" width="80" />
        <el-table-column prop="userSex" label="性别" width="60" :formatter="sexMap" />
        <el-table-column prop="userNumber" label="手机号" width="120" />
        <el-table-column prop="userCode" label="编号" min-width="60" />
        <el-table-column prop="userDept" label="部门" min-width="70" />
        <el-table-column prop="userPosition" label="职位" min-width="70" />
        <el-table-column prop="userEntryDate" label="入职时间" width="110" />
        <el-table-column prop="userStatus" label="在职状态" width="90" />
        <el-table-column label="操作" min-width="120">
          <template #default="{ row }">
            <el-button link type="info" @click="showDrawer(2, row)">更多</el-button>
            <el-button link type="primary" @click="showDrawer(1, row)">编辑</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <!-- 抽屉 -->
  <Drawer v-model="drawer.visible" :title="drawer.title" @closed="handleDrawerClose">
    <!-- 表单 -->
    <StaffForm :disabled="drawer.disabled" @close-drawer="drawer.visible = false" />
    <!-- 抽屉操作按钮 -->
    <div v-show="drawer.disabled" class="drawer-buttons">
      <el-button @click="drawer.visible = false">取消</el-button>
    </div>
  </Drawer>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { ref, onMounted, reactive } from 'vue';
import StaffForm from './form.vue';

// 导入枚举数据
import { searchEmployedOptions } from '@/enums/index';
import { sexMap } from '@/utils/formatter';

// 引入数据仓库
import { useStaffStore } from '@/store/modules/staffMain/staff';
import { useSettingStore } from '@/store/modules/acl/setting';
import { useRoleStore } from '@/store/modules/acl/role';
const store = useStaffStore();
const settingStore = useSettingStore();
const roleStore = useRoleStore();

const roleList = ref<any>([]);

// 初始化
onMounted(async () => {
  search();
  roleList.value = await roleStore.getRoleList();
});

// 搜索
const search = () => {
  store.setTableData();
};

// 处理分页变化
const handleSizeChange = (val: number) => {
  store.search.pageSize = val;
  search();
};

const handleCurrentChange = (val: number) => {
  store.search.pageNum = val;
  search();
};

const drawer: any = reactive({
  title: '新增人员信息',
  visible: false,
  disabled: false,
});

// 抽屉标题
const drawerTitles = ['新增人员信息', '人员信息', '修改人员信息'];

// 打开抽屉
const showDrawer = async (handleIndex: number, row: any = {}) => {
  // 表单数据回显
  row?.id ? (store.formData = { ...row }) : store.resetFormData();
  drawer.title = drawerTitles[handleIndex];
  drawer.visible = true;

  // 如果点击更多 禁用表单
  handleIndex === 2 && (drawer.disabled = true);
};

// 关闭抽屉触发
const handleDrawerClose = () => {
  store.resetFormData(); // 当抽屉关闭时重置表单
  drawer.disabled = false; // 去除预览禁用
};

// 设置行样式
const getRowClassName = ({ row }: { row: { userStatus: string } }) => {
  return row.userStatus === '离职' ? 'disabled-row' : '';
};
</script>

<style scoped lang="scss">
.main-container {
  padding: $main-padding;
}

:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
