/**
 * 会员查询参数
 */
export interface SearchParams {
  /**
   * 查询关键字
   */
  queryField?: string;
  pageNum?: number;
  pageSize?: number;
  [property: string]: any;
}

/**
 * 数据对象
 *
 * VipInfoDTO，会员详细信息对象
 */
export interface VipInfoDTO {
  /**
   * 会员地址
   */
  address?: string;
  /**
   * 店内总余额
   */
  balance?: number;
  /**
   * 会员生日
   */
  birthday?: string;
  /**
   * 会员卡号
   */
  cardNumber?: string;
  /**
   * 性别（0 男，1 女）
   */
  gender?: number;
  /**
   * 主键
   */
  id?: number;
  /**
   * 会员身份
   */
  identity?: number;
  /**
   * 末次消费日期
   */
  lastConsumptionTime?: string;
  /**
   * 末次充值时间
   */
  lastRechargeTime?: string;
  /**
   * 姓名
   */
  name?: string;
  /**
   * 组织ID
   */
  orgId?: number;
  /**
   * 电话号码
   */
  phoneNumber?: string;
  /**
   * 会员密码
   */
  pwd?: string;
  /**
   * 备注
   */
  remark?: string;
  [property: string]: any;
}

/**
 * org.haut.common.domain.dto.vip.PresentTicketDTO
 */
export interface ReqPresentTicket {
  /**
   * 赠送数量
   */
  number: number;
  /**
   * 赠送备注
   */
  remark?: string;
  /**
   * 优惠券ID
   */
  vipTicketId: number;
  [property: string]: any;
}

/**
 * org.haut.common.domain.dto.vip.PresentAssetDTO
 */
export interface ReqPresentAsset {
  /**
   * 折扣基础（0 标准价，1 会员价）
   */
  discountBase: number;
  /**
   * 折扣率（0-1之间的小数，如0.8表示8折）
   * 折扣率
   */
  discountRate: number;
  /**
   * 是否跨店结算（0 不允许，1 允许）
   */
  isCrossStore: number;
  /**
   * 赠送金额
   */
  presentAmount: number;
  /**
   * 备注
   */
  remark?: string;
  [property: string]: any;
}
