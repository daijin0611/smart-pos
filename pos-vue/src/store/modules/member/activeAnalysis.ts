import { defineStore } from 'pinia';
import { reactive } from 'vue';
import { reqVipList } from '@/api/member/member';
import { parseResObj } from '@/utils/parseResponse';

import { formatDate } from '@/utils/time';

import { useSettingStore } from '@/store/modules/acl/setting';

export const useMemberActiveAnalysisStore = defineStore('MemberActiveAnalysis', () => {
  const settingStore = useSettingStore();

  // 搜索参数
  const search = reactive<any>({
    moreAmount: null,
    fullAmount: null,
    date: [],
    pageSize: 50,
    currentPage: 1,
  });

  const resetSearch = () => {
    search.moreAmount = null;
    search.fullAmount = null;
    search.date = [];
    setTableData();
  };

  // 处理请求参数
  const handleParams = () => {
    const params: any = { ...search };
    // 处理参数
    if (params.date.length !== 0) {
      params.startTime = formatDate(params.date[0]);
      params.endTime = formatDate(params.date[1]);
    }
    !params.moreAmount && delete params.moreAmount;
    !params.fullAmount && delete params.fullAmount;

    // 移除多余参数
    delete params.date;

    return params || {};
  };

  const tableData = reactive({ total: 0, list: [] });
  const setTableData = async () => {
    settingStore.loading = true;
    const params = handleParams();
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
