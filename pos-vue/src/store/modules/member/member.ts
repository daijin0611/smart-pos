import { defineStore } from 'pinia';
import { reactive, ref } from 'vue';
import { reqVipList, reqVipInfo, reqAddVip, reqUpdateVip, reqVipAsset, reqVipAssetList } from '@/api/member/member';
import { parseResObj, parseResMsg } from '@/utils/parseResponse';
import { SearchParams } from '@/api/member/member/type';

import { useSettingStore } from '@/store/modules/acl/setting';

export const useMemberStore = defineStore('Member', () => {
  const settingStore = useSettingStore();

  /**
   * 获取会员详情
   * @param id 会员id
   * @returns 会员详情
   */
  const getMemberInfo = async (id: number) => {
    const res = await reqVipInfo(id);
    const data = parseResObj(res);
    return data;
  };

  /**
   * 获取会员列表
   * @param params 搜索参数
   * @returns 会员列表
   */
  const getMemberList = async (params: SearchParams) => {
    const res = await reqVipList(params);
    const data = parseResObj(res);
    return data;
  };

  /**
   * 获取搜索联想会员列表
   * @param queryField 搜索字段
   * @param size 列表容量
   * @returns 会员列表
   */
  const getAssociateList = async (queryField: string, size?: number) => {
    const params = <SearchParams>{
      queryField,
      pageNum: 1,
      pageSize: size || 30,
    };
    const { rows } = await getMemberList(params);
    return rows;
  };

  // 搜索参数
  const search = reactive<SearchParams>({
    queryField: '',
    pageNum: 1,
    pageSize: 20,
  });

  // 会员列表
  const tableData = reactive<any>({ total: 0, list: [] });
  const setTableData = async () => {
    settingStore.loading = true;
    const data = await getMemberList(search);
    tableData.total = data.total;
    tableData.list = data.rows;
    settingStore.loading = false;
  };

  const update = async (data: any) => {
    // 浅拷贝防止操作原对象
    data = { ...data };

    // 发送请求
    const res = await (data?.id ? reqUpdateVip(data) : reqAddVip(data));
    formData.value.id = res.data.id;
    const result = parseResObj(res, '更新会员信息成功');
    // 刷新数据
    result && setTableData();
    return result;
  };

  /**
   * 更新会员密码
   * @param pwd 密码
   * @returns 结果
   */
  const updatePwd = async (pwd = '123456') => {
    const data = { ...formData.value, pwd };
    const res = await reqUpdateVip(data);
    const result = parseResMsg(res, '更新密码成功');
    // 刷新数据
    result && setTableData();
    return result;
  };

  // 表单数据
  const formData: any = ref({});

  // 重置表单数据模型
  const resetFormData = () => {
    formData.value = {
      id: null,
      name: '',
      pwd: '123456',
      gender: 0,
      cardNumber: '',
      phoneNumber: '',
      identity: 0,
      birthday: '',
      address: '',
      remark: '',
    };
  };

  /**
   * 获取会员资产
   * @param vipId 会员id
   * @returns 会员资产
   */
  const getMemberAsset = async (vipId: number) => {
    const res = await reqVipAsset(vipId);
    const data = parseResObj(res);
    return data;
  };

  /**
   * 获取会员资产列表
   * @param vipId 会员id
   * @returns 会员资产列表
   */
  const getMemberAssetList = async (vipId: number) => {
    const res = await reqVipAssetList(vipId);
    const data = parseResObj(res);
    return data;
  };

  return {
    getMemberInfo,
    getMemberList,
    getAssociateList,

    search,
    tableData,
    setTableData,
    update,
    formData,
    resetFormData,
    updatePwd,
    getMemberAsset,
    getMemberAssetList,
  };
});
