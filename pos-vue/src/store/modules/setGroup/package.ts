import { defineStore } from 'pinia';
import { ref } from 'vue';
import { reqPackageList, reqPackageInfo, reqAddPackage, reqUpdatePackage } from '@/api/setGroup/package';
import { parseResMsg, parseResList } from '@/utils/parseResponse';

import { useSettingStore } from '@/store/modules/acl/setting';

export const usePackageStore = defineStore('Package', () => {
  const settingStore = useSettingStore();
  // 搜索参数
  const searchParams = ref({
    storeId: 0,
    packageName: '',
    packageStatus: 0,
  });

  // 数据列表
  const dataList: any = ref([]);
  const setDataList = async () => {
    settingStore.loading = true;
    // 获取数据列表
    const res = await reqPackageList(searchParams.value);
    const data = parseResList(res, '获取套餐列表失败');

    // 处理数据
    dataList.value = data.map((item, i) => {
      item.id = i + 1;
      item.packageDetailDTOList = item.packageDetailDTOList.map((item: any) => ({
        ...item,
        value: item.packageDetailName,
        number: item.packageToolNumber,
      }));
      return item;
    });
    settingStore.loading = false;
  };

  // 更新数据
  const updateData = async (data: any) => {
    // 如果没有状态属性赋默认值
    data.packageStatus = data?.packageStatus || 0;

    // 发送请求
    const res = await (data?.id ? reqUpdatePackage(data) : reqAddPackage(data));
    const result = parseResMsg(res);
    // 刷新数据
    result && setDataList();
    return result;
  };

  // 更新数据状态
  const updateDataStatus = async (data: any) => {
    data = { ...data };
    data.packageStatus = data.packageStatus === 0 ? 1 : 0;
    updateData(data);
  };

  // 表单数据
  const formData: any = ref({});

  // 重置表单数据模型
  const resetFormData = () => {
    formData.value = {
      id: null, // 套餐id
      packageName: '', // 套餐名称
      packageEncode: '', // 套餐编码
      packagePrice: 0, // 散客价
      packagePriceVip: 0, // 会员价
      packageDetailDTOList: [], // 套餐项目信息
      remark: '', // 套餐备注
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
