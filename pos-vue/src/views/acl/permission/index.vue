<template>
  <div class="main-container">
    <!-- 搜索操作 -->
    <Card class="operation-card">
      <div class="search-container">
        <div><el-button type="primary" @click="addPermisstion(0)">添加一级权限</el-button></div>
        <!-- <div><el-button type="success" @click="importPermisstion">从路由导入</el-button></div> -->
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
            v-model="store.search.name"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            placeholder="请输入权限关键字"
            clearable
          >
            <template #append>
              <el-button type="primary" @click="search">搜索</el-button>
            </template>
          </el-input>
        </div>
      </div>
    </Card>
    <Card padding="0">
      <el-table
        :data="store.tableData"
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :border="true"
        row-key="id"
        height="100%"
      >
        <el-table-column label="权限名称" prop="name"></el-table-column>
        <el-table-column label="权限标识" prop="permCode"></el-table-column>
        <el-table-column label="资源路径" prop="path"></el-table-column>
        <el-table-column label="组件名称" prop="component"></el-table-column>
        <el-table-column label="备注" prop="remark"></el-table-column>
        <el-table-column label="操作" width="220">
          <template #="{ row, $index }">
            <el-button @click="addPermisstion(row.id)" type="primary" size="small">添加权限</el-button>
            <el-button @click="updatePermisstion(row)" type="warning" size="small">编辑</el-button>
            <el-button v-if="row.permStatus === 0" @click="forbid(row)" type="danger" size="small">禁用</el-button>
            <el-button v-else @click="store.updateStatus(row)" type="success" size="small">启用</el-button>
          </template>
        </el-table-column>
      </el-table>
    </Card>
  </div>

  <!-- 对话框组件:添加或者更新已有的菜单的数据结构 -->
  <el-dialog v-model="dialog.visible" :title="dialog.title" @close="handleClose" width="400px">
    <el-form :model="store.formData" :rules="formRules" ref="formRef" label-width="80">
      <el-form-item label="名称" prop="name">
        <el-input placeholder="请你输入权限名称" v-model="store.formData.name"></el-input>
      </el-form-item>
      <el-form-item label="权限" prop="permCode">
        <el-input placeholder="请你输入权限标识" v-model="store.formData.permCode"></el-input>
      </el-form-item>
      <el-form-item label="资源路径" prop="path">
        <el-input placeholder="请你输入资源路径" v-model="store.formData.path"></el-input>
      </el-form-item>
      <el-form-item label="组件名称" prop="component">
        <el-input placeholder="请你输入组件名称" v-model="store.formData.component"></el-input>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input placeholder="请你输入备注" v-model="store.formData.remark"></el-input>
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialog.visible = false">取消</el-button>
        <el-button type="primary" @click="save">确定</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { ref, onMounted, reactive, inject } from 'vue';
import { statusOptions } from '@/enums/index';

import { useSettingStore } from '@/store/modules/acl/setting';
import { usePermissionStore } from '@/store/modules/acl/permission';

// 引入消息提示组件
const $MessageBox: any = inject('$MessageBox');

const settingStore = useSettingStore();
const store = usePermissionStore();

onMounted(() => {
  search();
});

// 搜索
const search = () => {
  store.setTableData();
};

// 禁用
const forbid = async (row: any) => {
  const result = await $MessageBox.confirm({
    title: '确认操作',
    message: `你确定要禁用权限【${row.name}】吗？`,
    type: 'warning',
  });
  result && store.updateStatus(row);
};

// 添加菜单按钮的回调
const addPermisstion = (parentId: number) => {
  dialog.title = '新增权限';
  dialog.visible = true;
  store.formData.parentId = parentId;
};

// 编辑已有的菜单
const updatePermisstion = (row: any) => {
  dialog.title = '编辑权限';
  dialog.visible = true;
  store.formData = { ...row };
};

const formRef = ref<any>(null);

// 确定按钮的回调
const save = async () => {
  // 表单验证
  await formRef.value.validate();
  const result = await store.update(store.formData);
  result && (dialog.visible = false);
};

const dialog = reactive({
  title: '新增权限',
  visible: false,
});

// 关闭抽屉触发
const handleClose = () => {
  store.resetFormData();
  formRef.value.resetFields();
};

// 从路由导入权限
// import { asyncRoute } from '@/router/perms';
// const importPermisstion = async () => {
//   const deep = async (routes: any) => {
//     for (const route of routes) {
//       const permCode = route.path.split('/').slice(1).join(':') || '';
//       const data = {
//         // @ts-ignore
//         id: route.meta.id,
//         name: route.meta.title,
//         permCode,
//         path: route.path,
//         component: route.name,
//         // @ts-ignore-error
//         parentId: route.meta.parentId || 0,
//         permStatus: 0,
//         // @ts-ignore-error
//         remark: JSON.stringify(route.meta.tabs || '') === '""' ? '' : JSON.stringify(route.meta.tabs || ''),
//       };
//       const is = await store.importPerm(data);
//       is && console.log(`导入【${data.name}】成功`);
//       !is && console.log(`导入【${data.name}】失败`);
//       if (route.children) {
//         await deep(route.children);
//       }
//     }
//   };
//   deep(asyncRoute);
// };

// 表单验证规则
const formRules = {
  name: [{ required: true, message: '权限名称为必填项', trigger: 'blur' }],
  permCode: [{ required: true, message: '权限标识为必填项', trigger: 'blur' }],
  path: [{ required: true, message: '资源路径为必填项', trigger: 'blur' }],
  component: [{ required: true, message: '组件名称为必填项', trigger: 'blur' }],
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
