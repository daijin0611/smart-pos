<template>
  <!-- 使用高阶组件渲染 Element-Plus 对话框 -->
  <component
    :is="h(ElDialog, { ...$attrs, ...props, ref: changeRef }, $slots)"
    title="字典项管理"
    style="max-width: 800px"
  >
    <div class="enum-handler-container">
      <!-- 添加类型的表单组件 -->
      <div>
        <el-button type="primary" @click="add" ref="refBtn">新增字典项</el-button>
        <el-button type="success" @click="getList">刷新数据</el-button>
      </div>

      <div class="enum-handler-content">
        <PaginationTable
          :data="tableData"
          v-loading="settingStore.loading"
          :element-loading-text="settingStore.loadingMsg"
          :showPagination="false"
        >
          <el-table-column type="index" label="序号" width="60" />
          <el-table-column prop="dictCode" label="字典编码" />
          <el-table-column prop="itemLabel" label="字典项标签" />
          <el-table-column prop="itemValue" label="字典项值" width="90" />
          <el-table-column prop="remark" label="备注" />
          <el-table-column label="操作">
            <template #default="{ row }">
              <el-button link type="primary" @click="update(row)">编辑</el-button>
              <el-button link type="danger" @click="del(row)">删除</el-button>
            </template>
          </el-table-column>
        </PaginationTable>
      </div>
      <Dialog v-model="dialog.visible" :title="dialog.title" width="400px">
        <Form :model="store.dictItem" :rules="formRules" @submit="handleSubmit" @reset="store.resetDictItem">
          <el-form-item label="字典项标签" prop="itemLabel">
            <el-input v-model="store.dictItem.itemLabel" placeholder="请你输入字典项标签" />
          </el-form-item>
          <el-form-item label="字典项值" prop="itemValue">
            <el-input v-model="store.dictItem.itemValue" placeholder="请你输入字典项值" />
          </el-form-item>
          <el-form-item label="排序" prop="sort">
            <el-input-number v-model="store.dictItem.sort" />
          </el-form-item>
          <el-form-item label="备注" prop="remark">
            <el-input v-model="store.dictItem.remark" type="textarea" placeholder="请你输入备注" />
          </el-form-item>
        </Form>
      </Dialog>
    </div>
  </component>
</template>

<script setup lang="ts">
import { ElDialog, type DialogProps } from 'element-plus';
import { ref, onMounted, onUpdated, inject, h, getCurrentInstance, reactive } from 'vue';

import { useEnumStore } from '@/store/modules/enums/index';
import { useSettingStore } from '@/store/modules/acl/setting';
const store = useEnumStore();
const settingStore = useSettingStore();

const $MessageBox: any = inject('$MessageBox');

/**
 * 组件属性接口定义
 * - 继承 DialogProps 并覆盖/扩展部分属性
 * - config: 配置对象，包含API调用方法和父级ID
 */
interface CustomProps extends Partial<DialogProps> {
  dictCode: string;
  defaultData?: Array<any>;
}

// 定义组件属性
const props = defineProps<CustomProps>();

// 表格数据
const tableData: any = ref([]);

onMounted(() => {
  // init();
});

onUpdated(() => {
  init();
});

const init = () => {
  if (props.defaultData && props.defaultData.length !== 0) {
    tableData.value = props.defaultData;
    return;
  }
  if (tableData.value.length === 0) {
    getList();
    return;
  }
  if (tableData.value.length !== 0 && tableData.value[0].dictCode !== props.dictCode) {
    getList();
    return;
  }
};

const getList = async () => {
  settingStore.loading = true;
  const data = await store.getEnumItemList(props.dictCode);
  tableData.value = data;
  settingStore.loading = false;
};

const handleSubmit = async () => {
  const result = await store.updateDictItem();
  if (result) {
    getList();
    dialog.visible = false;
  }
};

const dialog = reactive({
  title: '新增字典项',
  visible: false,
});

const add = () => {
  dialog.title = '新增字典项';
  dialog.visible = true;
  store.resetDictItem();
  store.dictItem.dictCode = props.dictCode;
};

const update = (row: any) => {
  dialog.title = '编辑字典项';
  dialog.visible = true;
  store.dictItem = { ...row };
};

const del = async (row: any) => {
  const result = await $MessageBox.confirm({
    title: '确认操作',
    message: `你确定要删除字典项【${row.itemLabel}】吗？`,
    type: 'warning',
  });
  const isSuccess = result ? await store.delDictItem(row.dictItemId) : false;
  isSuccess && getList();
};

const formRules = {
  itemLabel: [{ required: true, message: '请输入字典项标签', trigger: 'blur' }],
  itemValue: [{ required: true, message: '请输入字典项值', trigger: 'blur' }],
  sort: [{ required: true, message: '请输入排序值', trigger: 'blur' }],
};

// 获取当前组件实例，用于暴露对话框方法
const vm: any = getCurrentInstance();
function changeRef(dialogInstance: any) {
  // 将对话框实例挂载到组件实例上，便于父组件调用
  vm.exposeProxy = vm.exposed = dialogInstance || {};
}
</script>
<script lang="ts">
export default {
  name: 'EnumHandler',
};
</script>

<style lang="scss" scoped>
.enum-handler-container {
  display: flex;
  flex-direction: column;
  gap: $main-padding;
  padding: $main-padding;
  border-top: 1px solid var(--el-color-info-light-5);
  height: 50vh;

  .enum-handler-content {
    height: calc(50vh - 77px);
  }
}
</style>
