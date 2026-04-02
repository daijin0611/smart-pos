/**
 * 订单响应数据转换为订单表单数据
 * @param params 订单数据
 * @returns 转换后的订单表单
 */
export const orderResToOrder = (params: any) => {
  const orderInfo = params || {};
  const details = orderInfo.orderDetails || [];
  const payments = orderInfo.payments || [];

  const result = {
    ...orderInfo,
    // 订单ID
    orderId: orderInfo.id,
    // 会员ID（可选，会员时有效）
    vipId: orderInfo.vipId,
    // 床位ID（可选）
    bedId: orderInfo.bedId,
    // 床位名称（可选）
    bedName: orderInfo.bedName,
    // 顾客类型（可选）
    customerType: orderInfo.customerType,
    // 散客名称（可选，顾客类型为散客时使用）
    customerName: orderInfo.customerName,
    // 应收金额（必填）
    totalAmount: orderInfo.totalAmount || 0,
    // 实收金额（必填）
    actualAmount: orderInfo.actualAmount || 0,
    // 优惠金额（必填）
    discountAmount: orderInfo.discountAmount || 0,
    // 下单时间（可选）
    orderTime: orderInfo.orderTime,
    // 备注（可选）
    remark: orderInfo.remark,

    // 资产ID列表（可选，源数据中无直接对应，可能需要从支付信息中提取）
    assetIds: [],
    // 优惠券使用列表（可选，源数据中无直接对应，可能需要额外处理）
    ticketUseList: [], // 源数据中无优惠券信息，暂为空数组
    // 订单明细（必填）
    details: details.map((detail: any) => ({
      // id: detail.id,
      detailCode: detail.detailCode,
      detailType: detail.detailType, // 业务类型（必填）
      bid: detail.bid, // 业务ID（必填）
      businessName: detail.businessName,
      businessCode: detail.businessCode,
      stdPrice: detail.stdPrice,
      truePrice: detail.truePrice,
      quantity: detail.quantity, // 销售数量（必填）
      serverType: detail.serverType,
      userId: detail.userId, // 员工ID（必填）
      userName: detail.userName,
      remark: detail.remark,
    })),
    // 支付信息（必填）
    // paymentInfoList: payments.map((payment: any) => ({
    //   assetCode: payment.assetCode,
    //   paymentAmount: payment.totalAmount, // 支付金额映射自总金额
    //   paymentName: payment.paymentName,
    //   paymentType: payment.paymentType,
    // })),
  };

  if (result.orderDetails) {
    delete result.orderDetails;
  }
  return result;
};
