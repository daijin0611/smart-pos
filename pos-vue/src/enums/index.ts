import { ResponseCode, ResponseCodeMeaning } from '@/enums/response';

export { ResponseCode, ResponseCodeMeaning };

// #region 状态选项
export enum Status {
  enabled = 0,
  disabled = 1,
}

export const StatusMap = {
  [Status.enabled]: '启用',
  [Status.disabled]: '禁用',
};

/**
 * 搜索状态
 */
export const statusOptions = [
  { value: '', label: '全部状态' },
  { value: Status.enabled, label: StatusMap[Status.enabled] },
  { value: Status.disabled, label: StatusMap[Status.disabled] },
];
// #endregion 状态选项

// #region 提成类型
/**
 * 提成类型
 */
export const commissionOptions = [
  { value: 0, label: '标准价提成' },
  { value: 1, label: '实收价提成' },
];
// #endregion 提成类型

// #region 提成类型
/**
 * 提成类型
 */
export enum CommissionType {
  FixedAmount = 0,
  Proportion = 1,
}

export const commissionTypeMap = {
  [CommissionType.FixedAmount]: '固定金额',
  [CommissionType.Proportion]: '比例提成',
};

export const commissionTypeOptions = [
  { value: CommissionType.FixedAmount, label: '固定金额' },
  { value: CommissionType.Proportion, label: '比例提成' },
];
// #endregion 提成类型

// #region 是否打折
/**
 * 是否打折
 */
export enum IsDiscount {
  discount = 0,
  noDiscount = 1,
}

export const IsDiscountMap = {
  [IsDiscount.discount]: '打折',
  [IsDiscount.noDiscount]: '不打折',
};

export const IsDiscountOptions = [
  { value: IsDiscount.discount, label: '打折' },
  { value: IsDiscount.noDiscount, label: '不打折' },
];
// #endregion 是否打折

// #region 会员等级
/**
 * 会员等级
 */
export enum VipLevel {
  Normal = 0,
  Silver = 1,
  Gold = 2,
  Platinum = 3,
  Diamond = 4,
}
/**
 * 会员等级
 */
export const vipLevelOptions = [
  { value: VipLevel.Normal, label: '普通会员' },
  { value: VipLevel.Silver, label: '白银会员' },
  { value: VipLevel.Gold, label: '黄金会员' },
  { value: VipLevel.Platinum, label: '铂金会员' },
  { value: VipLevel.Diamond, label: '钻石会员' },
];
/**
 * 会员等级映射
 */
export const vipLevelMap = new Map(vipLevelOptions.map((item) => [item.value, item.label]));
// #endregion 会员等级

// #region 性别
/**
 * 性别
 */
export const sexOptions = [
  { value: 2, label: '未知' },
  { value: 0, label: '男' },
  { value: 1, label: '女' },
];
// #endregion 性别

// #region 婚姻状态
/**
 * 婚姻状态
 */
export const maritalStatusOptions = [
  { label: '未知', value: '未知' },
  { label: '未婚', value: '未婚' },
  { label: '已婚', value: '已婚' },
  { label: '离异', value: '离异' },
  { label: '丧偶', value: '丧偶' },
];
// #endregion 婚姻状态

// #region 学历
/**
 * 学历
 */
export const educationOptions = [
  { label: '未知', value: '未知' },
  { label: '小学', value: '小学' },
  { label: '初中', value: '初中' },
  { label: '高中', value: '高中' },
  { label: '中专', value: '中专' },
  { label: '大专', value: '大专' },
  { label: '本科', value: '本科' },
  { label: '硕士', value: '硕士' },
  { label: '博士', value: '博士' },
  { label: '技校', value: '技校' },
];
// #endregion 学历

// #region 在职状态
/**
 * 在职状态
 */
export const employedOptions = [
  { value: '在职', label: '在职' },
  { value: '离职', label: '离职' },
  { value: '试用期', label: '试用期' },
  { value: '停薪留职', label: '停薪留职' },
];

/**
 * 过滤框的在职状态
 */
export const searchEmployedOptions = [{ value: '', label: '全部状态' }, ...employedOptions];
// #endregion 在职状态

// #region 活动类型
/**
 * 活动类型枚举
 */
export enum ActivityType {
  PresentValue = 0,
  PresentCoupon = 1,
  PresentValueAndCoupon = 2,
}

/**
 * 活动类型
 */
export const activityTypeOptions = [
  { value: ActivityType.PresentValue, label: '赠送储值金' },
  { value: ActivityType.PresentCoupon, label: '赠送优惠券' },
  { value: ActivityType.PresentValueAndCoupon, label: '赠送优惠券和储值金' },
];
// #endregion 活动类型

// #region 折扣类型
/**
 * 折扣类型枚举
 */
export enum DiscountType {
  Standard = 0, // 标准价
  Member = 1, // 会员价
}
/**
 * 折扣类型
 */
export const discountTypeOptions = [
  { value: DiscountType.Standard, label: '标准价' },
  { value: DiscountType.Member, label: '会员价' },
];
/**
 * 折扣类型映射
 */
export const discountTypeMap = {
  [DiscountType.Standard]: '标准价',
  [DiscountType.Member]: '会员价',
};
// #endregion 折扣类型

// #region 优惠券类型
/**
 * 优惠券类型枚举
 */
export enum CouponType {
  voucher = 0, // 代金券
  experience = 1, // 体验券
}
/**
 * 优惠券类型映射
 */
export const couponTypeMap = {
  [CouponType.voucher]: '代金券',
  [CouponType.experience]: '体验券',
};
/**
 * 优惠券类型
 */
export const couponTypeOptions = [
  { value: CouponType.voucher, label: '代金券' },
  { value: CouponType.experience, label: '体验券' },
];
// #endregion 优惠券类型

// #region 支付类型
/**
 * 支付类型枚举
 */
export enum PaymentType {
  WeChat = 0,
  Alipay = 1,
  Cash = 2,
  MemberCard = 3,
  BankCard = 4,
}
/**
 * 支付类型
 */
export const paymentTypeOptions = [
  { value: PaymentType.WeChat, label: '微信' },
  { value: PaymentType.Alipay, label: '支付宝' },
  { value: PaymentType.Cash, label: '现金' },
  { value: PaymentType.MemberCard, label: '会员卡' },
  { value: PaymentType.BankCard, label: '银行卡' },
];
/**
 * 支付类型映射
 */
export const paymentTypeMap = {
  [PaymentType.WeChat]: '微信',
  [PaymentType.Alipay]: '支付宝',
  [PaymentType.Cash]: '现金',
  [PaymentType.MemberCard]: '会员卡',
  [PaymentType.BankCard]: '银行卡',
};
// #endregion 支付类型

// #region 充值状态

export enum RechargeStatus {
  SUCCESS = 0,
  REVERSAL = 1,
}

export const RechargeStatusMap = {
  [RechargeStatus.SUCCESS]: '充值成功',
  [RechargeStatus.REVERSAL]: '已冲正',
};

/**
 * 充值状态
 */
export const rechargeStatusOptions = [
  { value: '', label: '全部状态' },
  { value: RechargeStatus.SUCCESS, label: RechargeStatusMap[RechargeStatus.SUCCESS] },
  { value: RechargeStatus.REVERSAL, label: RechargeStatusMap[RechargeStatus.REVERSAL] },
];
// #endregion 充值状态

// #region 优惠券记录查询状态
/**
 * 优惠券记录查询状态
 */
export const couponRecordStatusOptions = [
  { value: '', label: '全部状态' },
  { value: '未使用', label: '未使用' },
  { value: '已使用', label: '已使用' },
];
// #endregion 优惠券记录查询状态

// #region 跨店设置
/**
 * 是否允许跨店
 */
export enum IsCrossStore {
  NO = 0,
  YES = 1,
}
/**
 * 是否允许跨店
 */
export const isCrossStoreOptions = [
  { value: IsCrossStore.NO, label: '不允许' },
  { value: IsCrossStore.YES, label: '允许' },
];
// #endregion 跨店设置

// #region 订单明细类型
/**
 * 订单明细类型（0 产品，1 服务，2 疗程券）
 */
export enum OrderDetailType {
  Product = 0,
  Service = 1,
  TreatmentCoupon = 2,
  Package = 3,
}
export const OrderDetailTypeMap = {
  [OrderDetailType.Product]: '产品',
  [OrderDetailType.Service]: '项目',
  [OrderDetailType.TreatmentCoupon]: '疗程',
  [OrderDetailType.Package]: '套餐',
};
/**
 * 订单明细类型
 */
export const OrderDetailTypeOptions = [
  { value: OrderDetailType.Service, label: '项目' },
  { value: OrderDetailType.Product, label: '产品' },
  { value: OrderDetailType.TreatmentCoupon, label: '疗程' },
  // { value: OrderDetailType.Package, label: '套餐' },
];
// #endregion 订单明细类型

// #region 客户类型
/**
 * 客户类型（0 会员，1 散客）
 */
export enum CustomerType {
  Member = 0,
  Guest = 1,
}
export const CustomerTypeMap = {
  [CustomerType.Member]: '会员',
  [CustomerType.Guest]: '散客',
};
/**
 * 客户类型
 */
export const CustomerTypeOptions = [
  { value: CustomerType.Member, label: '会员' },
  { value: CustomerType.Guest, label: '散客' },
];
// #endregion 客户类型

// #region 服务类型
/**
 * 服务类型 （0 点钟，1 加钟，2 轮牌）
 */
export enum ServiceType {
  Point = 0,
  Add = 1,
  Round = 2,
}
/**
 * 服务类型映射
 */
export const ServiceTypeMap = {
  [ServiceType.Point]: '点钟',
  [ServiceType.Add]: '加钟',
  [ServiceType.Round]: '轮牌',
};
/**
 * 服务类型
 */
export const ServiceTypeOptions = [
  { value: ServiceType.Point, label: '点钟' },
  { value: ServiceType.Add, label: '加钟' },
  { value: ServiceType.Round, label: '轮牌' },
];
// #endregion 服务类型

// #region 订单状态
/**
 * 订单状态枚举
 */
export enum OrderStatus {
  UNSETTLED = 1, // 未结算
  SETTLED = 2, // 已结算
  CANCELLED = 3, // 已取消
  ROLLBACK = 4, // 已冲正
}

/**
 * 订单状态映射
 */
export const OrderStatusMap = {
  [OrderStatus.UNSETTLED]: '未结算',
  [OrderStatus.SETTLED]: '已结算',
  [OrderStatus.CANCELLED]: '已取消',
  [OrderStatus.ROLLBACK]: '已冲正',
};

/**
 * 订单状态选项
 */
export const orderStatusOptions = [
  { value: '', label: '全部状态' },
  { value: OrderStatus.UNSETTLED, label: '未结算' },
  { value: OrderStatus.SETTLED, label: '已结算' },
  { value: OrderStatus.CANCELLED, label: '已取消' },
  { value: OrderStatus.ROLLBACK, label: '已冲正' },
];
// #endregion 订单状态

// #region 床位状态
/**
 * 床位状态枚举
 */
export enum BedStatus {
  Available = 0, // 空闲
  Occupied = 1, // 占用
  Suspended = 2, // 暂停使用
}
/**
 * 床位状态映射
 */
export const BedStatusMap = {
  [BedStatus.Available]: '空闲',
  [BedStatus.Occupied]: '占用',
  [BedStatus.Suspended]: '暂停使用',
};
/**
 * 床位状态选项
 */
export const bedStatusOptions = [
  { value: '', label: '全部状态' },
  { value: BedStatus.Available, label: '空闲' },
  { value: BedStatus.Occupied, label: '占用' },
  { value: BedStatus.Suspended, label: '暂停使用' },
];
// #endregion 床位状态

// #region 是否是默认提成规则
/**
 * 是否是默认提成规则枚举
 */
export enum IsDefaultRCRule {
  default = 1,
  noDefault = 0,
}
/**
 * 是否是默认提成规则映射
 */
export const IsDefaultRCRuleMap = {
  [IsDefaultRCRule.default]: '默认',
  [IsDefaultRCRule.noDefault]: '不是默认',
};
// #endregion 床位状态
