import { defineStore } from 'pinia';
import { reactive, ref } from 'vue';
import {
  reqProductList,
  reqProductInfo,
  reqAddProduct,
  reqUpdateProduct,
  reqUpdateStatus,
} from '@/api/setGroup/product';

import { Product } from '@/api/setGroup/product/type';

import { parseResMsg, parseResList, parseResObj } from '@/utils/parseResponse';

import { useSettingStore } from '@/store/modules/acl/setting';

export const useProductStore = defineStore('Product', () => {
  const settingStore = useSettingStore();

  /**
   * 获取产品详情
   * @param id 产品ID
   * @returns 产品详情
   */
  const getProductInfo = async (id: number) => {
    const res = await reqProductInfo({ id });
    const result = parseResObj(res);
    return result;
  };

  /**
   * 获取产品列表
   * @param params - 搜索参数
   * @returns 产品列表
   */
  const getProductList = async (params: { keyWord?: string; productStatus?: number }) => {
    const res = await reqProductList(params);
    const data = parseResList(res);
    return data;
  };

  // 搜索参数
  const search = reactive({
    keyWord: '',
    productStatus: 0,
  });

  /**
   * 数据列表
   */
  const tableData = ref<Product[]>([]);

  /**
   * 刷新数据列表
   */
  const setTableData = async () => {
    settingStore.loading = true;
    tableData.value = await getProductList(search);
    settingStore.loading = false;
  };

  /**
   * 更新数据
   * @param data - 数据对象
   * @returns 更新结果
   */
  const update = async (data: any) => {
    // 发送请求
    const res = await (data?.id ? reqUpdateProduct(data) : reqAddProduct(data));
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
    const status = data.productStatus === 0 ? 1 : 0;
    const params = { id: data.id, status };
    const res = await reqUpdateStatus(params);
    let msg = status === 0 ? '启用' : '禁用';
    msg = `产品${msg}成功`;
    const result = parseResMsg(res, msg);
    // 刷新数据
    result && setTableData();
    return result;
  };

  // 表单数据
  const formData = ref<Product>({} as Product);

  // 重置表单数据模型
  const resetFormData = () => {
    formData.value = {
      id: null,
      remark: '',
      productName: '',
      productEncode: '',
      productPrice: null,
      vipProductPrice: null,
      isDiscount: 1,
      commissionType: 1,
      commissionValue: null,
      commissionBase: 0,
      productStatus: 0,
      unit: '',
    };
  };

  return {
    search,
    tableData,
    setTableData,
    update,
    updateStatus,
    formData,
    resetFormData,
    getProductInfo,
    getProductList,
  };
});
