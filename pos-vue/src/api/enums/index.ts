import { get, post, put, ContentType } from '@/utils/request';

enum API {
  LIST_URL = '/system/dict/query-list',
  ADD_URL = '/system/dict/add-type',
  UPDATE_URL = '/system/dict/update-type',
  DEL_URL = '/system/dict/delete-type',
  ITEM_LIST_URL = '/system/dict/query-items-by-code',
  ITEM_ADD_URL = '/system/dict/add-item',
  ITEM_UPDATE_URL = '/system/dict/update-item',
  ITEM_DEL_URL = '/system/dict/delete-item',
}

/**
 * 获取枚举列表
 * @param params 查询参数
 * @returns 枚举列表
 */
export const reqEnumList = (params = {}) => get(API.LIST_URL, params);

/**
 * 新增枚举
 * @param data 枚举数据
 * @returns 新增结果
 */
export const reqAddEnum = (data = {}) => post(API.ADD_URL, data);

/**
 * 更新枚举
 * @param data 枚举数据
 * @returns 更新结果
 */
export const reqUpdateEnum = (data = {}) => put(API.UPDATE_URL, data);

/**
 * 删除枚举
 * @param dictTypeId 枚举类型ID
 * @returns 删除结果
 */
export const reqDelEnum = (dictTypeId: number) => put(API.DEL_URL, { dictTypeId }, ContentType.URLencoded);

/**
 * 获取枚举项列表
 * @param params 查询参数
 * @returns 枚举项列表
 */
export const reqEnumItemList = (params = {}) => get(API.ITEM_LIST_URL, params);

/**
 * 新增枚举项
 * @param data 枚举项数据
 * @returns 新增结果
 */
export const reqAddEnumItem = (data = {}) => post(API.ITEM_ADD_URL, data);

/**
 * 更新枚举项
 * @param data 枚举项数据
 * @returns 更新结果
 */
export const reqUpdateEnumItem = (data = {}) => put(API.ITEM_UPDATE_URL, data);

/**
 * 删除枚举项
 * @param itemId 枚举项ID
 * @returns 删除结果
 */
export const reqDelEnumItem = (itemId: number) => put(API.ITEM_DEL_URL, { itemId }, ContentType.URLencoded);
