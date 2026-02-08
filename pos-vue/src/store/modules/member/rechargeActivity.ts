import { defineStore } from 'pinia';
import { reactive, ref } from 'vue';
import { reqActiveList, reqAddActive, reqUpdateActiveStatus } from '@/api/member/rechargeActivity';

import { parseResMsg, parseResList } from '@/utils/parseResponse';
import { formatDate } from '@/utils/time';

import { useSettingStore } from '@/store/modules/acl/setting';

export const useRechargeActivityStore = defineStore('RechargeActivity', () => {
  const settingStore = useSettingStore();

  /**
   * 获取充值活动列表（作为枚举选项时调用）
   * @param params - 搜索参数
   * @returns 充值活动列表
   */
  const getActivities = async (params = { activeName: '', activeStatus: 0 }) => {
    const res = await reqActiveList(params);
    let data = parseResList(res);
    return data;
  };

  /**
   * 获取充值活动列表（管理页调用）
   * @param params - 搜索参数
   * @returns 充值活动列表
   */
  const getActiveList = async (params = { activeName: '', activeStatus: 0 }) => {
    const res = await reqActiveList(params);
    let data = parseResList(res);
    data = data.map((item) => {
      item.activeTime = [item.activeBeginTime, item.activeFinalTime];
      item.ticketIds = item.ticketList.map((ticket: any) => {
        return {
          vipTicketId: ticket.ticketId,
          vipTicketName: ticket.ticketName,
          vipTicketNum: ticket.number,
          ticketEffectiveTime: ticket.ticketEffectiveTime,
        };
      });
      return item;
    });
    return data;
  };

  // 搜索参数
  const search = reactive({
    activeName: '',
    activeStatus: 0,
  });

  /**
   * 数据列表
   */
  const tableData = ref<any>([]);

  /**
   * 刷新数据列表
   */
  const setTableData = async () => {
    settingStore.loading = true;
    tableData.value = await getActiveList(search);
    settingStore.loading = false;
  };

  /**
   * 更新数据
   * @param data - 数据对象
   * @returns 更新结果
   */
  const update = async (data: any) => {
    data.activeBeginTime = formatDate(data.activeTime[0]);
    data.activeFinalTime = formatDate(data.activeTime[1]);
    // 发送请求
    // const res = await (data?.id ? reqUpdateActive(data) : reqAddActive(data));
    const res = await (data?.id ? data : reqAddActive(data));
    const result = parseResMsg(res);
    // 刷新数据
    result && setTableData();
    return result;
  };

  /**
   * 更新数据状态
   * @param data - 数据对象
   * @returns 更新结果
   */
  const updateStatus = async (data: any) => {
    const status = data.activeStatus === 0 ? 1 : 0;
    const params = { id: data.id, activeStatus: status };
    const res = await reqUpdateActiveStatus(params);
    let msg = status === 0 ? '启用' : '禁用';
    msg = `充值活动${msg}成功`;
    const result = parseResMsg(res, msg);
    // 刷新数据
    result && setTableData();
    return result;
  };

  // 表单数据
  const formData = ref<any>({});

  // 重置表单数据模型
  const resetFormData = () => {
    formData.value = {
      activeTime: [], //活动时间(表单收集使用)
      activeName: '',
      activeBeginTime: '',
      activeFinalTime: '',
      activeType: 0,
      activeCapital: 0,
      activeDiscount: 100,
      activeBase: 1,
      isCrossStore: 1,

      presentValue: 0,
      presentDiscountIsSame: 1,
      presentDiscount: 100,
      presentBase: 0,
      presentIsCrossStore: 0,
      ticketIds: [],
      remark: '',
    };
  };

  return {
    search,
    tableData,
    getActiveList,
    getActivities,
    setTableData,
    update,
    updateStatus,
    formData,
    resetFormData,
  };
});
