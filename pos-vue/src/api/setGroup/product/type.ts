/**
 * 产品对象的ts类型
 */
export interface Product {
  /**
   * 提成基准(0-标准价提成，1-实收价提成)
   */
  commissionBase?: number;
  /**
   * 提成类型
   */
  commissionType: number;
  /**
   * 提成值(固定提成时为固定金额，比例提成时为比例)
   */
  commissionValue?: number | null;
  /**
   * 主键ID
   */
  id?: number | null;
  /**
   * 是否参与打折(0-是，1-否)
   */
  isDiscount: number;
  /**
   * 产品编码
   */
  productEncode: string;
  /**
   * 产品名称
   */
  productName: string;
  /**
   * 标准价格
   */
  productPrice: number | null;
  /**
   * 产品状态(0-启用，1-禁用)
   */
  productStatus: number;
  /**
   * 备注信息
   */
  remark?: string;
  /**
   * 单位
   */
  unit?: string;
  /**
   * 会员价格
   */
  vipProductPrice: number | null;
}
