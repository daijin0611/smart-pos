import { defineStore } from 'pinia';
import { reactive, ref } from 'vue';
import {
  reqList,
  reqAdd,
  reqUpdate,
  reqUpdateStatus,
  reqAllocatedList,
  reqUnallocatedList,
  reqAddAllocatedUser,
  reqAddAllocatedPerm,
  reqQueryTree,
} from '@/api/acl/role';
import { parseResList, parseResMsg } from '@/utils/parseResponse';

import { useSettingStore } from '@/store/modules/acl/setting';
const settingStore = useSettingStore();

export const useRoleStore = defineStore('Role', () => {
  // 搜索参数
  const search = reactive({
    roleName: '',
    roleCode: '',
    status: 0,
  });

  const tableData: any = ref([]);
  const setTableData = async () => {
    settingStore.loading = true;
    const res = await reqList(search);
    let data = parseResList(res);
    tableData.value = data;
    settingStore.loading = false;
  };

  const getRoleList = async () => {
    const params = { status: 0 };
    const res = await reqList(params);
    let data = parseResList(res);
    return data;
  };

  const update = async (data: any) => {
    data = { ...data };
    const res = await (data?.id ? reqUpdate(data) : reqAdd(data));
    const result = parseResMsg(res);
    // 刷新数据
    result && setTableData();
    return result;
  };

  const updateStatus = async (data: any) => {
    const params = {
      roleId: data.id,
      status: data.roleStatus ? 0 : 1,
    };
    const res = await reqUpdateStatus(params);
    const result = parseResMsg(res);
    // 刷新数据
    result && setTableData();
    return result;
  };

  // 表单数据
  const formData: any = ref({});

  // 重置表单数据模型
  const resetFormData = () => {
    formData.value = {
      id: null,
      roleCode: '',
      roleName: '',
      remark: '',
      roleSort: 0,
      roleStatus: 0,
    };
  };

  const addPerm = async (data: any) => {
    const res = await reqAddAllocatedPerm(data);
    const result = parseResMsg(res, '分配权限成功');
    return result;
  };

  return {
    search,
    tableData,
    setTableData,
    update,
    formData,
    resetFormData,
    updateStatus,
    addPerm,
    getRoleList,
  };
});
