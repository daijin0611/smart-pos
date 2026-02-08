import { defineStore } from 'pinia';
import { ref } from 'vue';
import { parseResMsg, parseResList } from '@/utils/parseResponse';
import { Status } from '@/enums';

import {
  reqTreatmentCouponList,
  reqAddTreatmentCoupon,
  reqUpdateTreatmentCoupon,
  reqUpdateTreatmentCouponStatus,
} from '@/api/setGroup/treatmentCoupon';

import { useSettingStore } from '@/store/modules/acl/setting';

export const useTreatmentCouponStore = defineStore('TreatmentCoupon', () => {
  const settingStore = useSettingStore();
  // 搜索参数
  const searchParams = ref({
    cureTicketName: '',
    status: Status.enabled,
  });

  // 数据列表
  const dataList: any = ref([]);
  const setDataList = async () => {
    settingStore.loading = true;
    // 获取数据列表
    const res = await reqTreatmentCouponList(searchParams.value);
    const data = parseResList(res);
    dataList.value = data;
    // 处理数据
    // dataList.value = data.map((item, i) => {
    //   item.id = i + 1;
    //   item.cureTicketDetailInfoDTOList = item.cureTicketDetailInfoDTOList.map((item: any) => ({
    //     ...item,
    //     value: item.vipTicketName,
    //     number: item.vipTicketNum,
    //   }));
    //   return item;
    // });

    settingStore.loading = false;
  };
  // {
  //     "remark": "string",
  //     "name": "string",
  //     "encode": "string",
  //     "price": 0,
  //     "type": 0,
  //     "commissionValue": 0,
  //     "commissionBase": 0,
  //     "status": 0,
  //     "vipTicketList": [
  //         {
  //             "vipTicketId": 0,
  //             "vipTicketName": "string",
  //             "vipTicketNum": 0
  //         }
  //     ]
  // }
  // 更新数据
  const updateData = async (data: any) => {
    // 如果没有状态属性赋默认值
    data.packageStatus = data?.packageStatus || 0;

    // 发送请求
    const res = await (data?.id ? reqUpdateTreatmentCoupon(data) : reqAddTreatmentCoupon(data));
    const result = parseResMsg(res);
    // 刷新数据
    result && setDataList();
    return result;
  };

  // 更新数据状态
  const updateDataStatus = async (data: any) => {
    data = { ...data };
    data.status = data.status === 0 ? 1 : 0;
    const res = await reqUpdateTreatmentCouponStatus(data);
    const result = parseResMsg(res);
    // 刷新数据
    result && setDataList();
    return result;
  };

  // 表单数据
  const formData: any = ref({});

  // 重置表单数据模型
  const resetFormData = () => {
    formData.value = {
      remark: '',
      name: '',
      encode: '',
      price: 0,
      type: 0,
      commissionValue: 0,
      commissionBase: 0,
      status: 0,
      vipTicketList: [],
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
  };
});
