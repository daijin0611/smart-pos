import { defineStore } from 'pinia';
import { ref } from 'vue';
import {
  reqRechargeCommissionRulesList,
  reqAddRechargeCommissionRules,
  reqUpdateRechargeCommissionRules,
} from '@/api/setGroup/rechargeCommissionRules';

import { parseResMsg, parseResList } from '@/utils/parseResponse';

import { useSettingStore } from '@/store/modules/acl/setting';

export const useRechargeCommissionRulesStore = defineStore('RechargeCommissionRules', () => {
  const settingStore = useSettingStore();

  // 搜索参数
  const searchParams = ref({
    rechargeRoleName: '',
    status: 0,
  });

  const getRCRule = async (params = { rechargeRoleName: '', status: 0 }) => {
    const res = await reqRechargeCommissionRulesList(params);
    const data = parseResList(res);
    return data;
  };

  const getDefaultRCRule = async () => {
    const data = await getRCRule();
    return data[0];
  };

  // 数据列表
  const dataList: any = ref([]);
  const setDataList = async () => {
    settingStore.loading = true;
    // 获取数据列表
    const res = await reqRechargeCommissionRulesList(searchParams.value);
    const data = parseResList(res);

    // 处理数据
    dataList.value = data.map((item: any) => {
      return { ...item, commissionType: parseInt(item.commissionType) };
    });
    settingStore.loading = false;
  };

  // 更新数据
  const updateData = async (data: any) => {
    // 发送请求
    const res = await (data?.id ? reqUpdateRechargeCommissionRules(data) : reqAddRechargeCommissionRules(data));
    const result = parseResMsg(res);
    // 刷新数据
    result && setDataList();
    return result;
  };

  // 更新数据状态
  const updateDataStatus = async (data: any) => {
    data = { ...data };
    data.rechargeRoleStatus = data.rechargeRoleStatus === 0 ? 1 : 0;
    updateData(data);
  };

  // 表单数据
  const formData: any = ref({});

  // 重置表单数据模型
  const resetFormData = () => {
    formData.value = {
      id: null,
      remark: '',
      rechargeRoleName: '',
      rechargePrice: null,
      commissionType: 1,
      rechargeCommissionValue: null,
      double: 1,
    };
  };

  return {
    searchParams,
    dataList,
    setDataList,
    updateData,
    updateDataStatus,
    formData,
    resetFormData,
    getRCRule,
    getDefaultRCRule,
  };
});
