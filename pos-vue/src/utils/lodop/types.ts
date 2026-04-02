export interface Config {
  width: number;
  height: number;
}

// 定义数据类型（匹配后端返回结构）
export interface OrderDetail {
  businessName: string;
  userName: string;
  stdPrice: number;
  quantity: number;
  truePrice: number;
  serverType: number; // 0-主项目 1-加项
}

export interface Payment {
  paymentName: string;
  totalAmount: number;
}

export interface OrderData {
  orderCode: string;
  orderTime: string;
  settleTime: string;
  totalAmount: number;
  actualAmount: number;
  discountAmount: number;
  bedName: string;
  userName: string; // 收银员
  orderDetails: OrderDetail[];
  payments: Payment[];
  orgName: string; // 门店名称，需补充到data中
  servicePhone: string; // 服务电话，需补充到data中
  orgNumber: string; // 服务电话，需补充到data中
  orgAddress: string; // 门店地址，需补充到data中
}

export interface RechargeData {
  id: number;
  remark: string | null;
  historyCode: string;
  rechargeStatus: number;
  rechargeType: string;
  rechargeTime: string;
  vipId: number;
  vipName: string;
  vipPhoneNumber: string;
  vipCardNumber: string;
  activityId: number;
  activeName: string;
  rechargeValue: number;
  assetCode: string;
  presentValue: number | null;
  presentAssetCode: string | null;
  ticketInfo: string;
  userName: string;
  userId: number;
  orgId: number;
  paymentInfoList: Array<{
    paymentType: number;
    paymentName: string;
    paymentAmount: number;
    assetCode: string | null;
  }>;
  userKpiList: Array<{
    userId: number;
    userName: string;
    kpi: number;
  }>;
  // 补充门店相关字段（默认值适配）
  orgName?: string;
  servicePhone?: string;
  orgNumber?: string;
  orgAddress?: string;
}
