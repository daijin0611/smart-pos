import { get, post, put, ContentType } from '@/utils/request';

enum API {
  IN_ADD_URL = '/stock/in-order/add-order',
  IN_LIST_URL = '/stock/in-order/query-page',
  IN_INFO_URL = '/stock/in-order/query-one/{orderCode}',
  OUT_LIST_URL = '/stock/out-order/query-page',
  OUT_INFO_URL = '/stock/out-order/query-one',
  OUT_ADD_URL = '/stock/out-order/add-order',
  LOG_URL = '/stock/log/query-page',
}

/**
 * 新增入库单
 * @param data
 * @returns
 */
export const reqInStockAdd = (data = {}) => post(API.IN_ADD_URL, data);

/**
 * 入库单列表
 * @param params
 * @returns
 */
export const reqInStockList = (params = {}) => get(API.IN_LIST_URL, params);

/**
 * 入库单详情
 * @param orderCode
 * @returns
 */
export const reqInStockInfo = (orderCode: string) => get(API.IN_INFO_URL.replace('{orderCode}', orderCode));

/**
 * 新增出库单
 * @param data
 * @returns
 */
export const reqOutStockAdd = (data = {}) => post(API.OUT_ADD_URL, data);

/**
 * 出库单列表
 * @param params
 * @returns
 */
export const reqOutStockList = (params = {}) => get(API.OUT_LIST_URL, params);

/**
 * 出库单详情
 * @param orderCode
 * @returns
 */
export const reqOutStockInfo = (orderCode = {}) => get(API.OUT_INFO_URL, orderCode);

/**
 * 库存流水列表
 * @param params
 * @returns
 */
export const reqStockLogList = (params = {}) => get(API.LOG_URL, params);
