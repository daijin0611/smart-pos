import { get, post, put, del } from '@/utils/request';

// 人员管理模块接口地址
enum API {
  // 获取人员列表
  LIST_URL = '/position/query-list',
  ADD_URL = '/position/add',
  UPDATE_URL = '/position/update',
  DEL_URL = '/position/del',
}

export const reqPositionList = (params = {}) => get(API.LIST_URL, params);

export const reqAddPosition = (data = {}) => post(API.ADD_URL, data);

export const reqUpdatePosition = (data = {}) => put(API.UPDATE_URL, data);

export const reqDelPosition = (params = {}) => del(API.DEL_URL, params);
