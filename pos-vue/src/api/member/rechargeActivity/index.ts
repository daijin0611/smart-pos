import { get, post, put } from '@/utils/request';

enum API {
  LIST_URL = '/vip/recharge-active/query-list',
  ADD_URL = '/vip/recharge-active/add',
  // UPDATE_URL = '/vip/recharge-active/update-active',
  UPDATE_STATUS_URL = '/vip/recharge-active/update-status',
}

/**
 * 获取充值活动列表
 */
export const reqActiveList = (params = {}) => get(API.LIST_URL, params);

/**
 * 添加充值活动
 */
export const reqAddActive = (data = {}) => post(API.ADD_URL, data);

/**
 * 更新充值活动
 */
// export const reqUpdateActive = (data = {}) => put(API.UPDATE_URL, data);

/**
 * 更新充值活动状态
 */
export const reqUpdateActiveStatus = (data = {}) => put(API.UPDATE_STATUS_URL, data);
