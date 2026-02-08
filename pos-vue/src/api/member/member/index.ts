import { get, post, put, ContentType } from '@/utils/request';
import * as Types from './type';

enum API {
  /** 获取会员列表 */
  LIST_URL = '/vip/query-list',
  /** 根据会员id查询详细信息 */
  INFO_URL = '/vip/query-info',
  /** 添加会员 */
  ADD_URL = '/vip/add-vip',
  /** 更新会员 */
  UPDATE_URL = '/vip/update-vip',
  /** 赠送优惠券 */
  PRESENT_TICKET = '/vip/present-ticket/{vipId}',
  /** 取消会员优惠券 */
  CANCEL_TICKET = '/vip/cancel-ticket/{vipId}',
  /** 赠送资产 */
  PRESENT_ASSET = '/vip/present-asset/{vipId}',
  /** 根据会员id查询资产详情 */
  ASSET_URL = '/vip/count/query-asset/{vipId}',
  /** 查询会员资产列表 */
  ASSET_LIST_URL = '/vip/query-asset-list/{vipId}',
  /** 修改会员备注 */
  UPDATE_MEMBER_REMARK = `/vip/update-remark/{vipId}`,
  /** 修改会员资产备注 */
  UPDATE_ASSET_REMARK = `/vip/update-asset-remark/{assetId}`,
  /**  */
  _ = '',
}

const IdStr = '{vipId}';
const AssetIdStr = '{assetId}';

/**
 * 获取会员列表
 * @param params 搜索参数
 * @returns 会员列表
 */
export const reqVipList = (params: Types.SearchParams) => get(API.LIST_URL, params);

/**
 * 获取会员详情
 * @param id 会员id
 * @returns 会员详情
 */
export const reqVipInfo = (id: number) => get(API.INFO_URL, { id });

/**
 * 添加会员
 * @param data 会员数据
 * @returns 添加结果
 */
export const reqAddVip = (data = {}) => post(API.ADD_URL, data);

/**
 * 更新会员
 * @param data 会员数据
 * @returns 更新结果
 */
export const reqUpdateVip = (data = {}) => put(API.UPDATE_URL, data);

/**
 * 获取会员资产
 * @param vipId 会员id
 * @returns 会员资产
 */
export const reqVipAsset = (vipId: number) => get(API.ASSET_URL.replace(IdStr, vipId.toString()));

/**
 * 获取会员资产列表
 * @param vipId 会员id
 * @returns 会员资产列表
 */
export const reqVipAssetList = (vipId: number) => get(API.ASSET_LIST_URL.replace(IdStr, vipId.toString()));

/**
 * 更新会员备注
 * @param remark 备注
 * @returns
 */
export const reqUpdateMemberRemark = (id: number, remark: string) => {
  const url = API.UPDATE_MEMBER_REMARK.replace(IdStr, id.toString());
  return post(url, { remark });
};

/**
 * 更新会员资产备注
 * @param remark 备注
 * @returns
 */
export const reqUpdateAssetRemark = (id: number, remark: string) => {
  const url = API.UPDATE_ASSET_REMARK.replace(AssetIdStr, id.toString());
  return post(url, { remark });
};

/**
 * 赠送会员优惠券
 * @param data
 * @returns
 */
export const reqPresentTicket = (id: number, data: Types.ReqPresentTicket) => {
  const url = API.PRESENT_TICKET.replace(IdStr, id.toString());
  return post(url, data);
};

/**
 * 取消会员优惠券
 * @param data
 * @returns
 */
export const reqCancelTicket = (id: number, ticketIds: number[]) => {
  const url = API.CANCEL_TICKET.replace(IdStr, id.toString());
  return post(url, ticketIds);
};

/**
 * 赠送会员资产
 * @param data
 * @returns
 */
export const reqPresentAsset = (id: number, data: Types.ReqPresentAsset) => {
  const url = API.PRESENT_ASSET.replace(IdStr, id.toString());
  return post(url, data);
};
