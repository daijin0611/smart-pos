import { get, post, put, del, ContentType } from '@/utils/request';

enum API {
  INFO_URL = '/order/query-by-id/{orderId}',
  ADD_URL = '/order/add-order',
  ADD_DETAIL_URL = '/order/add-detail/{orderId}',
  SETTLE_URL = '/order/settle-order',
  DELETE_DETAIL_URL = '/order/delete-detail/{detailId}',
  CANCEL_ORDER_URL = '/order/cancel-order/{orderId}',
  QUERY_ORDER_URL = '/order/query-by-order-code/{orderCode}',
  QUERY_ORDER_BY_BED_ID_URL = '/order/query-by-bed-id/{bedId}',
  ORDER_RECONCILE = '/order/reconcile-order',
  ORDER_ROLL_BACK = '/order/roll-back',
}

/**
 * 查询订单详情
 * @param orderId 订单ID
 * @returns 订单详情
 */
export const reqOrderInfo = (orderId: number) => get(API.INFO_URL, { orderId });

/**
 * 添加订单
 * @param data 订单数据
 * @returns 订单ID
 */
export const reqAddOrder = (data = {}) => post(API.ADD_URL, data);

/**
 * 添加订单明细
 * @param orderId 订单ID
 * @param data 订单明细数据
 * @returns 订单明细ID
 */
export const reqAddOrderDetail = (orderId: number, data = {}) =>
  post(API.ADD_DETAIL_URL.replace('{orderId}', orderId.toString()), data);

/**
 * 订单结算
 * @param data 订单结算数据
 * @returns 订单ID
 */
export const reqSettleOrder = (data: any) => post(API.SETTLE_URL, data);

/**
 * 删除订单明细
 * @param detailId 订单明细ID
 * @returns 订单明细ID
 */
export const reqDeleteOrderDetail = (detailId: number) =>
  del(API.DELETE_DETAIL_URL.replace('{detailId}', detailId.toString()));

/**
 * 取消订单
 * @param orderId 订单ID
 * @returns 订单ID
 */
export const reqCancelOrder = (orderId: number) => put(API.CANCEL_ORDER_URL.replace('{orderId}', orderId.toString()));

/**
 * 查询订单
 * @param orderCode 订单号
 * @returns 订单详情
 */
export const reqQueryOrder = (orderCode: string) => get(API.QUERY_ORDER_URL.replace('{orderCode}', orderCode));

/**
 * 查询订单详情
 * @param bedId 床位ID
 * @returns 订单详情
 */
export const reqQueryOrderByBedId = (bedId: number) =>
  get(API.QUERY_ORDER_BY_BED_ID_URL.replace('{bedId}', bedId.toString()));

/**
 * 订单冲正
 * @param orderId 订单ID
 * @param reason 冲正原因
 * @returns
 */
export const reqRollBackOrder = (orderId: string, reason: string) => {
  return post(API.ORDER_ROLL_BACK, { orderId, reason });
};

/**
 * 订单对单
 * @param orderId 订单ID
 * @param remark 备注
 * @returns
 */
export const reqReconcileOrder = (orderId: string, remark: string) => {
  return post(API.ORDER_RECONCILE, { orderId, remark });
};
