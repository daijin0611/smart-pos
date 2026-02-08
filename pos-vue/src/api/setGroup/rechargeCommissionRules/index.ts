import { get, post, put, del } from '@/utils/request';

enum API {
  /** 获取充值提成规则列表 */
  LIST_URL = '/server/recharge-role/query-list',
  /** 添加充值提成规则 */
  ADD_URL = '/server/recharge-role/add-role',
  /** 更新充值提成规则 */
  UPDATE_URL = '/server/recharge-role/update-role',
  /** 更新充值提成规则状态 */
  UPDATE_STATUS = `/server/recharge-role/update-status`,
  /** 获取默认充值提成规则 */
  GET_DEFAULT = `/server/recharge-role/get-default`,
  /** 设置默认充值提成规则 */
  SET_DEFAULT = `/server/recharge-role/set-default/{roleId}`,
}

const roleIdStr = '{roleId}';

export const reqRechargeCommissionRulesList = (params = {}) => get(API.LIST_URL, params);

export const reqAddRechargeCommissionRules = (data = {}) => post(API.ADD_URL, data);

export const reqUpdateRechargeCommissionRules = (data = {}) => put(API.UPDATE_URL, data);

/**
 * 获取默认充值提成规则
 * @returns
 */
export const reqDefaultCommissionRule = () => {
  return get(API.GET_DEFAULT);
};

/**
 * 设置默认充值提成规则
 * @param ruleId 提成规则ID
 * @returns
 */
export const reqSetDefaultCommissionRule = (ruleId: number) => {
  const url = API.SET_DEFAULT.replace(roleIdStr, ruleId.toString());
  return put(url);
};
