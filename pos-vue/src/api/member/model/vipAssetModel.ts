/**
 * 数据对象
 *
 * VipAssetVO
 */
export interface VipAssetVO {
  /**
   * 余额
   */
  assetBalance?: number;
  /**
   * 实体卡号
   */
  assetCardNumber?: string;
  /**
   * 折扣基础（0 标准价，1 会员价）
   */
  assetDiscountBase?: number;
  /**
   * 折扣率
   */
  assetDiscountRate?: number;
  /**
   * 跨店消费（0 不允许，1 允许）
   */
  assetIsCrossStore?: number;
  /**
   * 资产编号
   */
  assetNum?: string;
  /**
   * 资产类型（0 充值，1 赠送）
   */
  assetType?: number;
  /**
   * 创建时间
   */
  createTime?: string;
  /**
   * 主键
   */
  id?: number;
  /**
   * 删除状态(0 存在，1 删除)
   */
  isDelete?: number;
  /**
   * 门店id
   */
  orgId?: number;
  /**
   * 备注
   */
  remark?: string;
  /**
   * 更新时间
   */
  updateTime?: string;
  /**
   * 乐观锁
   */
  version?: number;
  /**
   * 会员id
   */
  vipId?: number;
  [property: string]: any;
}
