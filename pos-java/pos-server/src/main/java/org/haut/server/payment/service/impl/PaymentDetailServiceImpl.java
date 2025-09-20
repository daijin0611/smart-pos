package org.haut.server.payment.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.vip.PaymentInfoDTO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.payment.entity.PaymentDetail;
import org.haut.server.payment.service.PaymentDetailService;
import org.haut.server.payment.mapper.PaymentDetailMapper;
import org.haut.server.vip.service.VipAssetService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

/**
* @author 86156
* @description 针对表【payment_detail(支付明细表，记录各种业务的支付详情。)】的数据库操作Service实现
* @createDate 2025-08-25 23:22:33
*/
@Service
public class PaymentDetailServiceImpl extends ServiceImpl<PaymentDetailMapper, PaymentDetail>
    implements PaymentDetailService{

    private final VipAssetService vipAssetService;

    public PaymentDetailServiceImpl(VipAssetService vipAssetService) {
        this.vipAssetService = vipAssetService;
    }

    /**
     * 处理订单结算的支付信息
     * @param dto 订单结算信息
     */
    @Override
    @Transactional(rollbackFor = BusinessException.class)
    public void handelOrder(OrderSettleDTO dto) {
        // 1. 支付金额是否足够
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        List<PaymentInfoDTO> paymentInfoList = dto.getPaymentInfoList();
        BigDecimal sumPay = paymentInfoList.stream()
                .map(PaymentInfoDTO::getPaymentAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        if (sumPay.compareTo(dto.getActualAmount()) < 0)
            throw new BusinessException("支付金额不足");
        // 2. 处理会员资产（校验+更新）
        vipAssetService.handelOrder(dto);
    }
}




