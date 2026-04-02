import { defineStore } from 'pinia';
import { ref, reactive, computed } from 'vue';
import { isEmpty } from 'lodash';

import {
  reqEnumList,
  reqAddEnum,
  reqUpdateEnum,
  reqDelEnum,
  reqEnumItemList,
  reqAddEnumItem,
  reqUpdateEnumItem,
  reqDelEnumItem,
} from '@/api/enums/index';
import { reqTicketList } from '@/api/member/coupon/index';
import { reqActiveList } from '@/api/member/rechargeActivity/index';
import { reqUserList } from '@/api/staffMain/staff/index';
import { reqProductList } from '@/api/setGroup/product/index';
import { reqServiceItemList } from '@/api/setGroup/serviceItem/index';
import { reqPackageList } from '@/api/setGroup/package/index';
import { reqBedListAll } from '@/api/setGroup/room/index';
import { reqTreatmentCouponList } from '@/api/setGroup/treatmentCoupon/index';
import { reqList as reqOrgList } from '@/api/acl/org/index';

import { parseResList, parseResMsg, parseResObj } from '@/utils/parseResponse';
import { CouponType } from '@/enums/index';

export enum Enums {
  BED_STATUS = 'bed_status',
  UNIT = 'unit',
  POSITION = 'position',
  DEPARTMENT = 'department',
  PERF_TYPE = 'item_type',
  SERVICE_TYPE = 'service_type',
}

import { useSettingStore } from '@/store/modules/acl/setting';

export const useEnumStore = defineStore('Enum', () => {
  const settingStore = useSettingStore();

  // 搜索参数
  const search = reactive({
    dictName: '',
    dictCode: '',
  });

  const tableData: any = ref([]);
  const setTableData = async () => {
    settingStore.loading = true;
    const res = await reqEnumList(search);
    const data = parseResList(res);
    tableData.value = data;
    settingStore.loading = false;
  };

  const dict: any = ref({});
  const resetDict = () => {
    dict.value = {
      dictTypeId: null,
      dictName: '',
      dictCode: '',
      sort: 0,
      remark: '',
    };
  };

  const updateDict = async () => {
    const res = await (dict.value.dictTypeId ? reqUpdateEnum(dict.value) : reqAddEnum(dict.value));
    const result = parseResMsg(res);
    result && setTableData();
    return result;
  };

  const delDict = async (dictTypeId: number) => {
    const res = await reqDelEnum(dictTypeId);
    const result = parseResMsg(res);
    result && setTableData();
    return result;
  };

  const dictItem: any = ref({});
  const resetDictItem = () => {
    dictItem.value = {
      dictItemId: null,
      dictCode: '',
      itemValue: '',
      itemLabel: '',
      sort: 0,
      remark: '',
    };
  };

  const updateDictItem = async (data?: any) => {
    const params = data || dictItem.value;
    const res = await (params.dictItemId ? reqUpdateEnumItem(params) : reqAddEnumItem(params));
    const result = parseResMsg(res);
    return result;
  };

  const delDictItem = async (dictItemId: number) => {
    const res = await reqDelEnumItem(dictItemId);
    const result = parseResMsg(res);
    return result;
  };

  /**
   * 获取枚举项列表
   * @param dictCode 枚举编码
   * @returns 枚举项列表
   */
  const getEnumItemList = async (dictCode: string) => {
    const params = { dictCode };
    const res = await reqEnumItemList(params);
    const data = parseResList(res);
    return data;
  };

  /**
   * 获取单位列表
   * @returns 单位列表
   */
  const getUnits = async () => {
    return await getEnumItemList(Enums.UNIT);
  };

  /**
   * 获取岗位列表
   * @returns 岗位列表
   */
  const getPositionList = async () => {
    return await getEnumItemList(Enums.POSITION);
  };

  /**
   * 获取部门列表
   * @returns 部门列表
   */
  const getDeptList = async () => {
    return await getEnumItemList(Enums.DEPARTMENT);
  };

  /**
   * 获取上钟类型列表
   * @returns 上钟类型列表
   */
  const getPerfTypeList = async () => {
    return await getEnumItemList(Enums.PERF_TYPE);
  };

  /**
   * 获取服务类型列表
   * @returns 服务类型列表
   */
  const getServiceTypeList = async () => {
    return await getEnumItemList(Enums.SERVICE_TYPE);
  };

  return {
    getDeptList,
    getUnits,
    getPositionList,
    getPerfTypeList,
    getServiceTypeList,
    getEnumItemList,

    search,
    tableData,
    setTableData,
    dict,
    resetDict,
    updateDict,
    dictItem,
    resetDictItem,
    updateDictItem,
    delDict,
    delDictItem,
  };
});

export const useDataEnumStore = defineStore('DataEnum', () => {
  // 员工列表
  const staffList: any = ref([]);
  /**
   * 获取员工列表
   * @param refresh 是否刷新
   * @param params 请求参数
   * @returns 枚举项列表
   */
  const getStaffList = async (refresh = false, params = { userStatus: '在职', pageNum: 1, pageSize: 100 }) => {
    if (isEmpty(staffList.value) || refresh) {
      await setStaffList(params);
      return staffList.value;
    } else {
      return staffList.value;
    }
  };
  const setStaffList = async (params: any) => {
    const res = await reqUserList(params);
    const data = parseResObj(res);
    staffList.value = data.rows;
  };

  /** 优惠券列表 */
  const ticketList: any = ref([]);
  /**
   * 获取优惠券列表
   * @param refresh 是否刷新
   * @param params 请求参数
   * @returns 优惠券列表
   */
  const getTicketList = async (refresh = false, params = { ticketName: '', ticketStatus: 0 }) => {
    if (isEmpty(ticketList.value) || refresh) {
      await setTicketList(params);
      return ticketList.value;
    } else {
      return ticketList.value;
    }
  };
  const setTicketList = async (params: any) => {
    const res = await reqTicketList(params);
    const data = parseResList(res);
    // const data = parseResList(res).filter((item) => {
    //   return item.ticketType === CouponType.voucher;
    // });
    ticketList.value = data;
  };

  /** 充值活动列表 */
  const activeList: any = ref([]);
  /**
   * 获取充值活动列表
   * @param refresh 是否刷新
   * @param params 请求参数
   * @returns 充值活动列表
   */
  const getActiveList = async (refresh = false, params = { pageNum: 1, pageSize: 100 }) => {
    if (isEmpty(activeList.value) || refresh) {
      await setActiveList(params);
      return activeList.value;
    } else {
      return activeList.value;
    }
  };
  const setActiveList = async (params: any) => {
    const res = await reqActiveList(params);
    const data = parseResObj(res);
    activeList.value = data.rows;
  };

  /** 产品列表 */
  const productList: any = ref([]);
  /**
   * 获取产品列表
   * @param refresh 是否刷新
   * @param params 请求参数
   * @returns 产品列表
   */
  const getProductList = async (refresh = false, params = { productStatus: 0 }) => {
    if (isEmpty(productList.value) || refresh) {
      await setProductList(params);
      return productList.value;
    } else {
      return productList.value;
    }
  };
  const setProductList = async (params: any) => {
    const res = await reqProductList(params);
    const data = parseResList(res);
    productList.value = data;
  };

  // 服务项目列表
  const serviceItemList: any = ref([]);
  /**
   * 获取服务项目列表
   * @param refresh 是否刷新
   * @param params 请求参数
   * @returns 服务项目列表
   */
  const getServiceItemList = async (refresh = false, params = { itemStatus: 0 }) => {
    if (isEmpty(serviceItemList.value) || refresh) {
      await setServiceItemList(params);
      return serviceItemList.value;
    } else {
      return serviceItemList.value;
    }
  };
  const setServiceItemList = async (params: any) => {
    const res = await reqServiceItemList(params);
    const data = parseResList(res);
    serviceItemList.value = data;
  };

  // 套餐列表
  const packageList: any = ref([]);
  /**
   * 获取套餐列表
   * @param refresh 是否刷新
   * @param params 请求参数
   * @returns 套餐列表
   */
  const getPackageList = async (refresh = false, params = {}) => {
    if (isEmpty(packageList.value) || refresh) {
      await setPackageList(params);
      return packageList.value;
    } else {
      return packageList.value;
    }
  };
  const setPackageList = async (params: any) => {
    const res = await reqPackageList(params);
    const data = parseResList(res);
    packageList.value = data;
  };

  // 床位列表
  /**
   * 所有床位列表
   */
  const getAllBedList = async () => {
    const res = await reqBedListAll();
    const data = parseResList(res);
    return data.filter((item: any) => item.status !== 2).sort((a: any, b: any) => a.roomInfoId - b.roomInfoId);
  };

  // 治疗券列表
  const treatmentCouponList: any = ref([]);
  /**
   * 获取治疗券列表
   * @param refresh 是否刷新
   * @param params 请求参数
   * @returns 治疗券列表
   */
  const getTreatmentCouponList = async (refresh = false, params = { status: 0 }) => {
    if (isEmpty(treatmentCouponList.value) || refresh) {
      await setTreatmentCouponList(params);
      return treatmentCouponList.value;
    } else {
      return treatmentCouponList.value;
    }
  };
  const setTreatmentCouponList = async (params: any) => {
    const res = await reqTreatmentCouponList(params);
    const data = parseResList(res);
    treatmentCouponList.value = data;
  };

  // 门店列表
  const orgList: any = ref([]);
  /**
   * 获取门店列表
   * @param refresh 是否刷新
   * @param params 请求参数
   * @returns 门店列表
   */
  const getOrgList = async (refresh = false, params = {}) => {
    if (isEmpty(orgList.value) || refresh) {
      await setOrgList(params);
      return orgList.value;
    } else {
      return orgList.value;
    }
  };
  const setOrgList = async (params: any) => {
    const res = await reqOrgList(params);
    const data = parseResList(res);
    orgList.value = data;
  };

  const $reset = () => {
    staffList.value = [];
    ticketList.value = [];
    activeList.value = [];
    productList.value = [];
    serviceItemList.value = [];
    packageList.value = [];
    treatmentCouponList.value = [];
    orgList.value = [];
  };

  return {
    $reset,
    // 员工相关
    staffList,
    setStaffList,
    getStaffList,

    // 优惠券相关
    ticketList,
    setTicketList,
    getTicketList,

    // 充值活动相关
    activeList,
    setActiveList,
    getActiveList,

    // 产品相关
    productList,
    setProductList,
    getProductList,

    // 服务项目相关
    serviceItemList,
    setServiceItemList,
    getServiceItemList,

    // 套餐相关
    packageList,
    setPackageList,
    getPackageList,

    // 床位相关
    getAllBedList,

    // 治疗券相关
    treatmentCouponList,
    setTreatmentCouponList,
    getTreatmentCouponList,

    // 门店相关
    orgList,
    setOrgList,
    getOrgList,
  };
});

export const useEnumsStore = useEnumStore;
