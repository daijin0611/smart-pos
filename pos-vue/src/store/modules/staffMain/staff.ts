import { defineStore } from 'pinia';
import { reactive, ref } from 'vue';
import { reqUserList, reqAddUser, reqUpdateUser, reqUserInfo } from '@/api/staffMain/staff/index';

import { parseResList, parseResMsg, parseResObj } from '@/utils/parseResponse';

import { formatDate } from '@/utils/time';

import { useSettingStore } from '@/store/modules/acl/setting';
const settingStore = useSettingStore();

export const useStaffStore = defineStore('Staff', () => {
  // 搜索参数
  const search = reactive({
    storeId: null,
    roleId: '',
    userName: '',
    userStatus: '在职',
    userNumber: '',
    pageNum: 1,
    pageSize: 20,
  });

  const tableData: any = reactive({ total: 0, list: [] });
  const setTableData = async () => {
    settingStore.loading = true;
    const res: any = await reqUserList(search);
    const data: any = parseResObj(res);
    tableData.total = data.total;
    tableData.list = data.rows.map((item: any) => {
      item.roleId = item?.role?.id || '';
      return item;
    });
    settingStore.loading = false;
  };

  const update = async (data: any) => {
    const res: any = await (data?.id ? reqUpdateUser(data) : reqAddUser(data));
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
      userCode: '',
      userPassword: '123456',
      userName: '',
      userNumber: '',
      userPosition: '采耳师',
      userSex: 1,
      userBirthday: '',
      userDept: '管理部',
      userEntryDate: formatDate(new Date()),
      userStatus: '在职',
      userIdCard: '',
      userAddress: '',
      userMarry: '未知',
      userEdu: '未知',
      userHealth: '',
      roleId: 3,
    };
  };

  return {
    search,
    tableData,
    setTableData,
    update,
    formData,
    resetFormData,
  };
});
