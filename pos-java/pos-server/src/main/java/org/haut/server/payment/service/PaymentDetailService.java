package org.haut.server.payment.service;

import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.server.payment.entity.PaymentDetail;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 86156
* @description 针对表【payment_detail(支付明细表，记录各种业务的支付详情。)】的数据库操作Service
* @createDate 2025-08-25 23:22:33
*/
public interface PaymentDetailService extends IService<PaymentDetail> {

    void handelOrder(OrderSettleDTO orderSettleDTO);
}
