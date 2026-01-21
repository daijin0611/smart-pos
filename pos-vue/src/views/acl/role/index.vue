<template>
  <div class="main-container">
    <!-- 搜索操作 -->
    <Card class="operation-card">
      <div class="search-container">
        <div><el-button type="primary" @click="showDrawer(0)">添加角色</el-button></div>
      </div>
      <div class="search-container">
        <!-- 状态 -->
        <div class="search-item">
          <label>
            <span>状态：</span>
            <el-select v-model="store.search.status" @change="search" style="width: 100px">
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </label>
        </div>
        <!-- 搜索框 -->
        <div class="search-item">
          <el-input
            v-model="store.search.roleName"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            placeholder="请输入角色名称"
            clearable
          >
            <template #append>
              <el-button type="primary" @click="search">搜索</el-button>
            </template>
          </el-input>
        </div>
      </div>
    </Card>
    <!-- 数据列表 -->
    <Card class="table-card" padding="0">
      <PaginationTable
        v-loading="settingStore.loading && drawer.handleIndex !== 2"
        :element-loading-text="settingStore.loadingMsg"
        :data="store.tableData"
        :showPagination="false"
        :row-class-name="getRowClassName"
      >
        <el-table-column type="index" label="序号" width="60" />
        <el-table-column prop="roleName" label="角色名称" />
        <el-table-column prop="roleCode" label="角色编码" />
        <el-table-column prop="roleStatus" label="角色状态">
          <template #default="{ row }">
            <el-tag :type="row.roleStatus === 0 ? 'success' : 'danger'" size="small">
              {{ row.roleStatus === 0 ? '正常' : '停用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="roleSort" label="显示顺序" />
        <el-table-column prop="remark" label="备注" />
        <el-table-column label="操作">
          <template #default="{ row }">
            <el-button @click="showDrawer(1, row)" link type="primary">修改</el-button>
            <el-button @click="setPermisstion(row)" link type="success">分配权限</el-button>
            <el-button v-if="row.roleStatus" @click="store.updateStatus(row)" link type="success">启用</el-button>
            <el-button v-else @click="showConfirm(row)" link type="warning">禁用</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <!-- 抽屉表单 -->
  <Drawer v-model="drawer.visible" :title="drawer.title" @close="handleDrawerClose">
    <!-- 表单 -->
    <template v-if="drawer.handleIndex !== 2">
      <RoleForm @close-drawer="drawer.visible = false" />
    </template>
    <template v-else>
      <div class="tree-container">
        <el-input v-model="filterText" placeholder="请输入权限关键字" />
        <div class="tree-content" v-loading="settingStore.loading && drawer.handleIndex === 2">
          <el-tree
            :data="permTree"
            :filter-node-method="filterNode"
            ref="treeRef"
            node-key="id"
            show-checkbox
            default-expand-all
          >
            <template #default="{ node, data }">
              <span>{{ data.name }}</span>
            </template>
          </el-tree>
        </div>

        <div>
          <el-button @click="drawer.visible = false">取消</el-button>
          <el-button type="primary" @click="assignPermissions">提交</el-button>
        </div>
      </div>
    </template>
  </Drawer>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { ref, onMounted, inject, reactive, watch } from 'vue';
import { statusOptions } from '@/enums/index';
import RoleForm from './form.vue';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useRoleStore } from '@/store/modules/acl/role';
import { usePermissionStore } from '@/store/modules/acl/permission';

// 引入消息提示组件
const $MessageBox: any = inject('$MessageBox');

const settingStore = useSettingStore();
const store = useRoleStore();
const permStore = usePermissionStore();

onMounted(async () => {
  search();
});

// 搜索
const search = () => {
  store.setTableData();
};

// 禁用
const showConfirm = async (row: any) => {
  const result = await $MessageBox.confirm({
    title: '确认操作',
    message: `你确定要禁用角色【${row.roleName}】吗？`,
    type: 'warning',
  });
  result && store.updateStatus(row);
};

// 抽屉标题
const drawerTitles = ['新增角色信息', '修改角色信息', '分配权限'];
const drawer: any = reactive({
  title: '新增角色信息',
  visible: false,
  handleIndex: 0,
});

// 打开抽屉
const showDrawer = (handleIndex: number, row: any = {}) => {
  drawer.handleIndex = handleIndex;
  drawer.title = drawerTitles[handleIndex];
  drawer.visible = true;

  // 表单数据回显
  row?.id ? (store.formData = { ...row }) : store.resetFormData();
};

// 关闭抽屉触发
const handleDrawerClose = () => {
  store.resetFormData();
};

// 定义数组存储用户权限的数据
const permTree = ref<any>([]);
// 获取tree组件实例
const treeRef = ref<any>();

// 请求权限树数据并设置已选的节点
const setPermisstion = async (row: any) => {
  drawer.handleIndex = 2;
  drawer.title = drawerTitles[2];
  drawer.visible = true;
  store.formData = row;
  settingStore.loading = true;
  permTree.value = await permStore.getPermTree();
  await setCheckedKeys(row.id);
  settingStore.loading = false;
};

/**
 * 设置勾选的节点
 * @param roleId 角色ID
 */
const setCheckedKeys = async (roleId: number) => {
  const data = await permStore.getPermTreeByRoleId(roleId);
  const checkKeys = data.treeMap((item) => item.id);
  for (const id of checkKeys) {
    treeRef.value.setChecked(id, true, false);
  }
};

/**
 * 分配权限
 */
const assignPermissions = async () => {
  settingStore.loading = true;
  // 角色ID
  const roleId = store.formData.id;
  // 选中节点的ID
  const treeCheckedKeys = treeRef.value.getCheckedKeys();
  // 半选的ID
  const treeHalfCheckedKeys = treeRef.value.getHalfCheckedKeys();
  // 合并选中和半选的ID
  const permissionIds = treeCheckedKeys.concat(treeHalfCheckedKeys);
  // 请求参数
  const params = { roleId, permissionIds };
  // 提交请求
  const result = await store.addPerm(params);
  settingStore.loading = false;
  result && window.location.reload();
};

// 过滤树结构
const filterText = ref('');

// 监听过滤文本的变化
watch(filterText, (val) => {
  treeRef.value!.filter(val);
});

/**
 * 过滤树节点
 * @param value 搜索关键词
 * @param data 树节点数据
 * @returns 是否显示该节点
 */
const filterNode = (value: string, data: any) => {
  if (!value) return true;
  return data.name.includes(value);
};

// 设置行样式
const getRowClassName = ({ row }: { row: { roleStatus: number } }) => {
  return row.roleStatus === 1 ? 'disabled-row' : '';
};
</script>

<style scoped lang="scss">
.main-container {
  padding: $main-padding;
}

.tree-container {
  width: 90%;
  margin: 0 auto;
  min-height: 100px;
  padding: 20px 15px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  gap: 15px;

  .tree-content {
    max-height: 70vh;
    overflow: auto;
  }

  > div:last-child {
    text-align: center;
  }
}

:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
