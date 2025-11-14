package org.haut.server.payment.service;

import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.dto.vip.PaymentInfoDTO;
import org.haut.server.payment.entity.PaymentDetail;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 支付明细服务接口
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-08-25
 */
public interface PaymentDetailService extends IService<PaymentDetail> {

    /**
     * 处理订单结算的支付信息
     * @param orderSettleDTO 结算参数
     * @param orderCode 订单编号
     */
    void handelOrder(OrderSettleDTO orderSettleDTO, String orderCode);

    /**
     * 对单更新支付信息（会删除原来的支付明细并重新写入）
     * @param paymentInfos 支付信息
     * @param orderCode 订单编号
     */
    void reconcileOrderPayments(java.util.List<PaymentInfoDTO> paymentInfos, String orderCode);
}
