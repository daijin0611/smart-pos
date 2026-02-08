import { get, post, put, del } from '@/utils/request';
import { getToken } from '@/utils/localStorageTools';

// 接口地址
enum API {
  RECHARGE_URL = '/vip/recharge',
  LIST_URL = '/vip/recharge-history/query-list',
  UPDATE_URL = '/vip/recharge-history/update-status',
  ACTIVE_LIST_URL = '/vip/recharge-active/active-list',
  ADD_ACTIVE_URL = '/vip/recharge-active/add-active',
  ACTIVE_INFO_URL = '/vip/recharge-active/active-info',
  REVERSE_RECHARGE = '/vip/reverse-recharge',
  _ = ``,
}

/**
 * 查询充值记录列表
 * @param params 充值记录查询参数
 * @returns 充值记录列表
 */
export const reqRechargeHistoryList = (params = {}) => get(API.LIST_URL, params);

// export const reqAddRechargeHistory = (data = {}) => post(API.ADD_URL, data);

export const reqUpdateRechargeHistory = (data = {}) => put(API.UPDATE_URL, data);

export const reqActiveList = (params = {}) => get(API.ACTIVE_LIST_URL, params);

export const reqAddActive = (data = {}) => post(API.ADD_ACTIVE_URL, data);

export const reqActiveInfo = (params = {}) => get(API.ACTIVE_INFO_URL, params);

// export const reqUpdateActive = (data = {}) => put(API.UPDATE_ACTIVE_URL, data);

/**
 * 会员充值
 * @param data 充值参数
 * @returns 充值记录
 */
export const reqRecharge = (data = {}) =>
  post(API.RECHARGE_URL, data, {
    params: { token: getToken()?.split(' ')[1] || '' },
  });

/**
 * 充值记录冲正
 * @param historyCode 交易流水号（充值单号）
 * @param reverseReason 冲正原因
 * @returns
 */
export const reqRollBackRecharge = (historyCode: string, reverseReason: string) => {
  return post(API.REVERSE_RECHARGE, { historyCode, reverseReason });
};
