import { defineStore } from 'pinia';
import { reactive, ref, computed } from 'vue';
import { reqList, reqListOne, reqAdd, reqUpdate, reqUpdateStatus } from '@/api/acl/org';
import { Org } from '@/api/acl/org/type';
import { parseResList, parseResMsg, parseResObj } from '@/utils/parseResponse';
import { getUserInfo } from '@/utils/localStorageTools';

import { useSettingStore } from '@/store/modules/acl/setting';

export const useOrgStore = defineStore('Org', () => {
  const settingStore = useSettingStore();

  /**
   * 搜索参数
   */
  const search = reactive({
    orgName: '',
    orgCode: '',
    orgStatus: '',
  });

  /**
   * 获取门店详情
   * @param id 门店id
   * @returns 门店详情
   */
  const getOrgInfo = async (id: number) => {
    try {
      const res = await reqListOne(id);
      const orgInfo = parseResObj(res);
      orgInfo.orgArea && (orgInfo.orgArea = JSON.parse(orgInfo.orgArea as string));
      return orgInfo;
    } catch (error) {
      console.error(`获取门店信息报错：${error}`);
    }
    return {};
  };

  // 存储当前登录用户的门店信息
  const _org = ref<Org | null>(null);
  const getOrg = async () => {
    try {
      const user = getUserInfo();
      // 未登录
      if (!user) {
        return {};
      }
      // 已登录
      if (_org.value && _org.value.id === user.orgId) {
        return _org.value;
      } else {
        _org.value = await getOrgInfo(user.orgId);
        return _org.value;
      }
    } catch (error) {
      console.log('获取门店信息报错：', error);
      return {};
    }
  };

  /**
   * 表格数据
   */
  const tableData: any = ref([]);

  /**
   * 刷新列表
   */
  const setTableData = async () => {
    settingStore.loading = true;
    const res = await reqList(search);
    const data: Org[] = parseResList(res);
    for (const item of data) {
      item.orgArea && (item.orgArea = JSON.parse(item.orgArea as string));
    }
    tableData.value = data;
    settingStore.loading = false;
  };

  /**
   * 新增/更新
   * @param data 数据
   * @returns 是否成功
   */
  const update = async (data: Org) => {
    data = { ...data };
    data.orgArea && (data.orgArea = JSON.stringify(data.orgArea));
    const res = await (data?.id ? reqUpdate(data) : reqAdd(data));
    const result = parseResMsg(res);
    // 刷新数据
    result && setTableData();
    return result;
  };

  /**
   * 更新状态
   * @param data 数据
   * @returns 是否成功
   */
  const updateStatus = async (data: Org) => {
    const params = {
      id: data.id,
      status: data.orgState ? 0 : 1,
    };
    const res = await reqUpdateStatus(params);
    const result = parseResMsg(res);
    // 刷新数据
    result && setTableData();
    return result;
  };

  /**
   * 表单数据
   */
  const formData = ref<Org>({
    id: 0,
    orgState: 0,
    orgName: '',
    orgShortName: '',
    orgCode: '',
    orgParent: '',
    orgProperty: '',
    orgType: '',
    orgArea: [],
    orgNumber: '',
    orgLeader: '',
    orgLeaderNum: '',
    orgAddress: '',
    remark: '',
  });

  /**
   * 重置表单数据模型
   */
  const resetFormData = () => {
    formData.value = {
      id: 0,
      orgState: 0,
      orgName: '',
      orgShortName: '',
      orgCode: '',
      orgParent: '无',
      orgProperty: '实体门店',
      orgType: '自营',
      orgArea: ['河南省', '郑州市', '中原区'],
      orgNumber: '',
      orgLeader: '',
      orgLeaderNum: '',
      orgAddress: '',
      remark: '',
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
    getOrgInfo,

    getOrg,
  };
});
