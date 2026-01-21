import { defineStore } from 'pinia';
import { reactive, ref } from 'vue';
import {
  reqPermList,
  reqAddPerm,
  reqUpdatePerm,
  reqUpdatePermStatus,
  reqQueryPermTreeByUser,
  reqQueryPermTree,
  reqQueryPermTreeByRole,
} from '@/api/acl/permission';
import { parseResList, parseResMsg } from '@/utils/parseResponse';

import { useSettingStore } from '@/store/modules/acl/setting';

export const usePermissionStore = defineStore('Permission', () => {
  const settingStore = useSettingStore();
  // 搜索参数
  const search = reactive({
    name: '',
    status: 0,
  });

  const tableData: any = ref([]);
  const setTableData = async () => {
    settingStore.loading = true;
    const res = await reqQueryPermTree(search);
    let data = parseResList(res);
    tableData.value = data;
    settingStore.loading = false;
  };

  /**
   * 根据搜索参数获取权限列表
   * @param params 搜索参数
   * @returns 权限列表
   */
  const getPermList = async (params: { name: string; status: number }) => {
    settingStore.loading = true;
    const res = await reqPermList(params);
    const data = parseResList(res);
    settingStore.loading = false;
    return data;
  };

  /**
   * 获取权限树
   * @returns 权限树
   */
  const getPermTree = async (params = { status: 0 }) => {
    const res = await reqQueryPermTree(params);
    const data = parseResList(res);
    return data;
  };

  /**
   * 根据用户ID获取权限树
   * @param userId 用户ID
   * @returns 用户权限树
   */
  const getPermTreeByUserId = async (userId: number) => {
    const res = await reqQueryPermTreeByUser(userId);
    let data = parseResList(res);
    return data;
  };

  /**
   * 根据角色ID获取权限树
   * @param roleId 角色ID
   * @returns 角色权限树
   */
  const getPermTreeByRoleId = async (roleId: number) => {
    const res = await reqQueryPermTreeByRole(roleId);
    let data = parseResList(res);
    return data;
  };

  const update = async (data: any) => {
    const res = await (data?.id ? reqUpdatePerm(data) : reqAddPerm(data));
    const msg = data?.id ? `更新权限【${data.name}】成功` : `添加权限【${data.name}】成功`;
    const result = parseResMsg(res, msg);
    // 刷新数据
    result && setTableData();
    return result;
  };
  const importPerm = async (data: any) => {
    const res = await reqAddPerm(data);
    const result = parseResMsg(res, `导入权限【${data.name}】成功`);
    return result;
  };

  const updateStatus = async (data: any) => {
    const params = {
      id: data.id,
      status: data.permStatus ? 0 : 1,
    };
    const res = await reqUpdatePermStatus(params);
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
      parentId: 0,
      name: '',
      permCode: '',
      path: '',
      component: '',
      remark: '',
      permStatus: 0,
    };
  };

  return {
    search,
    tableData,
    setTableData,
    update,
    formData,
    resetFormData,
    updateStatus,
    getPermList,
    getPermTree,
    getPermTreeByUserId,
    getPermTreeByRoleId,
    importPerm,
  };
});
