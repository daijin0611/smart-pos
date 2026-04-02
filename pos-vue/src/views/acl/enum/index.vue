<template>
  <div class="main-container">
    <!-- 搜索操作 -->
    <Card class="operation-card">
      <div class="search-container">
        <div class="search-item"><el-button type="primary" @click="handleAddDict">添加字典</el-button></div>
        <div class="search-item">
          <el-input
            v-model="store.search.dictName"
            @keydown.enter="search"
            @clear="search"
            :prefix-icon="Search"
            placeholder="请输入字典名称"
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
      <PaginationTable
        :data="store.tableData"
        v-loading="settingStore.loading && !enumHandler.visible"
        :element-loading-text="settingStore.loadingMsg"
        :showPagination="false"
      >
        <el-table-column type="index" label="序号" width="60" />
        <el-table-column prop="dictName" label="字典名称" />
        <el-table-column prop="dictCode" label="字典编码" />
        <el-table-column prop="remark" label="备注" />
        <el-table-column label="字典项数量">
          <template #default="scope">
            {{ scope.row.dictItems?.length || 0 }}
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" />
        <el-table-column prop="updateTime" label="更新时间" />
        <el-table-column label="操作">
          <template #default="{ row }">
            <el-button link type="primary" @click="handleEditDict(row)">编辑</el-button>
            <el-button link type="success" @click="handleViewItems(row)">查看项</el-button>
            <el-button link type="danger" @click="handleDeleteDict(row)">删除</el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <!-- 对话框组件:添加或者更新已有的菜单的数据结构 -->
  <Dialog v-model="dialog.visible" :title="dialog.title" width="400px">
    <Form :model="store.dict" :rules="formRules" @submit="handleSubmit" @reset="store.resetDict">
      <el-form-item label="字典名称" prop="dictName">
        <el-input v-model="store.dict.dictName" placeholder="请你输入字典名称" />
      </el-form-item>
      <el-form-item label="字典编码" prop="dictCode">
        <el-input v-model="store.dict.dictCode" placeholder="请你输入字典编码" />
      </el-form-item>
      <el-form-item label="排序" prop="sort">
        <el-input-number v-model="store.dict.sort" />
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="store.dict.remark" type="textarea" placeholder="请你输入备注" />
      </el-form-item>
    </Form>
  </Dialog>

  <EnumHandler v-model="enumHandler.visible" :dictCode="enumHandler.dictCode" :defaultData="enumHandler.defaultData" />
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { onMounted, reactive, inject } from 'vue';
import EnumHandler from '@/components/EnumHandler/index.vue';
import { useSettingStore } from '@/store/modules/acl/setting';
import { useEnumStore } from '@/store/modules/enums';

// 引入消息提示组件
const $MessageBox: any = inject('$MessageBox');

const settingStore = useSettingStore();
const store = useEnumStore();

onMounted(() => {
  search();
});

// 搜索
const search = () => {
  store.setTableData();
};

const handleSubmit = async () => {
  const result = await store.updateDict();
  result && (dialog.visible = false);
};

const dialog = reactive({
  title: '新增字典',
  visible: false,
});

const handleAddDict = () => {
  dialog.title = '新增字典';
  dialog.visible = true;
  store.resetDict();
};

const handleEditDict = (row: any) => {
  dialog.title = '编辑字典';
  dialog.visible = true;
  store.dict = { ...row };
};

const handleDeleteDict = async (row: any) => {
  const result = await $MessageBox.confirm({
    title: '确认操作',
    message: `你确定要删除字典【${row.dictName}】吗？`,
    type: 'warning',
  });
  result && store.delDict(row.dictTypeId);
};

const enumHandler = reactive({
  visible: false,
  dictCode: '',
  defaultData: <any>[],
});

const handleViewItems = (row: any) => {
  enumHandler.visible = true;
  enumHandler.dictCode = row.dictCode;
  enumHandler.defaultData = row.dictItems;
};

const formRules = {
  dictName: [{ required: true, message: '请输入字典名称', trigger: 'blur' }],
  dictCode: [{ required: true, message: '请输入字典编码', trigger: 'blur' }],
  sort: [{ required: true, message: '请输入排序', trigger: 'blur' }],
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
