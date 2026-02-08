import { defineStore } from 'pinia';
import { reactive, ref } from 'vue';
import {
  reqServiceItemList,
  reqServiceItemInfo,
  reqAddServiceItem,
  reqUpdateServiceItem,
  reqUpdateServiceItemStatus,
} from '@/api/setGroup/serviceItem';

import { parseResMsg, parseResList, parseResObj } from '@/utils/parseResponse';

import { useSettingStore } from '@/store/modules/acl/setting';

export const useServiceItemStore = defineStore('ServiceItem', () => {
  const settingStore = useSettingStore();

  /**
   * 获取服务项目详情
   * @param id 服务项目id
   * @returns 服务项目详情
   */
  const getServiceItemInfo = async (id: number) => {
    const res = await reqServiceItemInfo(id);
    const data = parseResObj(res);
    return data;
  };

  /**
   * 获取服务项目列表
   * @param params 搜索参数
   * @returns 服务项目列表
   */
  const getServiceItems = async (params = { keyWord: '', itemStatus: 0 }) => {
    const res = await reqServiceItemList(params);
    const data = parseResList(res);
    return data;
  };

  /**
   * 搜索参数
   */
  const searchParams = reactive({
    keyWord: '',
    itemStatus: 0,
  });

  // 数据列表
  const dataList: any = ref([]);
  const setDataList = async () => {
    settingStore.loading = true;
    const data = await getServiceItems(searchParams);
    dataList.value = data;
    settingStore.loading = false;
  };

  // 更新数据
  const updateData = async (data: any) => {
    // 发送请求
    const res = await (data?.id ? reqUpdateServiceItem(data) : reqAddServiceItem(data));
    const result = parseResMsg(res);
    // 刷新数据
    result && setDataList();
    return result;
  };

  // 更新数据状态
  const updateDataStatus = async (data: any) => {
    const params = {
      id: data.id,
      status: data.itemStatus === 0 ? 1 : 0,
    };
    const res = await reqUpdateServiceItemStatus(params);
    const result = parseResMsg(res);
    result && setDataList();
    return result;
  };

  // 表单数据
  const formData: any = ref({});

  // 重置表单数据模型
  const resetFormData = () => {
    formData.value = {
      id: null,
      itemName: '',
      itemEncode: '',
      serverTime: null,
      itemPrice: null,
      vipItemPrice: null,
      isDiscounts: 1,
      commissionType: 0,
      commissionValueRotation: null,
      commissionValueAppointment: null,
      commissionValueExtend: null,
      commissionBase: 0,
      itemStatus: 0,
      remark: '',
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
    getServiceItemInfo,
    getServiceItems,
  };
});
