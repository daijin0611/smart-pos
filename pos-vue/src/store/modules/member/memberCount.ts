import { defineStore } from 'pinia';
import { reactive } from 'vue';
import { reqVipList } from '@/api/member/member';
import { parseResObj } from '@/utils/parseResponse';

import { formatDate } from '@/utils/time';

import { useSettingStore } from '@/store/modules/acl/setting';

export const useMemberCountStore = defineStore('MemberCount', () => {
  const settingStore = useSettingStore();

  // 搜索参数
  const search = reactive<any>({
    queryField: '',
    pageNum: 1,
    pageSize: 20,
    amount: null,
    amountType: 0,
    date: [],
  });

  const resetSearch = () => {
    search.queryField = '';
    search.amount = null;
    search.amountType = 0;
    search.date = [];
    setTableData();
  };

  // 处理请求参数
  const handleTotalParams = () => {
    const params: any = { ...search };

    // 处理参数
    if (params.amount) {
      params.amountType === 0 ? (params.less = params.amount) : (params.greater = params.amount);
    }
    if (params.date.length !== 0) {
      params.startTime = formatDate(params.date[0]);
      params.endTime = formatDate(params.date[1]);
    }

    // 移除多余参数
    delete params.amount;
    delete params.amountType;
    delete params.date;

    return params;
  };

  const tableData = reactive({ total: 0, list: [] });
  const setTableData = async () => {
    settingStore.loading = true;
    const params = handleTotalParams();
    const res = await reqVipList(params);
    const { total, rows } = parseResObj(res);
    tableData.total = total;
    tableData.list = rows;
    settingStore.loading = false;
  };

  return {
    search,
    tableData,
    setTableData,
    resetSearch,
  };
});
