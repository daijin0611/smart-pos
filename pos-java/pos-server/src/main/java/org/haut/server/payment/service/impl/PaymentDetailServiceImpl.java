package org.haut.server.payment.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.collection.ListUtil;
import cn.hutool.http.HttpBase;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.vip.PaymentInfoDTO;
import org.haut.common.enums.PaymentActiveTypeEnum;
import org.haut.common.enums.PaymentStatusEnum;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.payment.entity.PaymentDetail;
import org.haut.server.payment.service.PaymentDetailService;
import org.haut.server.payment.mapper.PaymentDetailMapper;
import org.haut.server.vip.service.VipAssetService;
import org.haut.server.vip.service.VipInfoService;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Mapper(componentModel = "spring")
interface PaymentDetailConvert {
    @Mapping(target = "totalAmount", source = "paymentAmount")
    PaymentDetail toEntity(PaymentInfoDTO dto);
    List<PaymentDetail> toEntities(List<PaymentInfoDTO> dto);
}

/**
* @author 86156
* @description 针对表【payment_detail(支付明细表，记录各种业务的支付详情。)】的数据库操作Service实现
* @createDate 2025-08-25 23:22:33
*/
@Service
@RequiredArgsConstructor
public class PaymentDetailServiceImpl extends ServiceImpl<PaymentDetailMapper, PaymentDetail>
    implements PaymentDetailService{

    private final VipAssetService vipAssetService;
    private final PaymentDetailConvert paymentDetailConvert;

    /**
     * 处理订单结算的支付信息
     * @param dto 订单结算信息
     * @param orderCode 订单编号
     */
    @Override
    @Transactional(rollbackFor = BusinessException.class)
    public void handelOrder(OrderSettleDTO dto, String orderCode) {
        // 1. 支付金额是否足够
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        List<PaymentInfoDTO> paymentInfoList = dto.getPaymentInfoList();
        BigDecimal sumPay = paymentInfoList.stream()
                .map(PaymentInfoDTO::getPaymentAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        if (sumPay.compareTo(dto.getActualAmount()) < 0)
            throw new BusinessException("支付金额不足");
        // 2. 处理会员资产（校验+更新）
        // 使用会员资产则处理会员资产
        if (!CollectionUtil.isEmpty(dto.getAssetIds()))
            vipAssetService.handelOrder(dto);
        // 3. 插入支付信息
        List<PaymentDetail> payments = paymentDetailConvert.toEntities(paymentInfoList);
        payments.forEach(payment ->
                payment.setOrgId(auth.getOrgId())
                        .setActiveType(PaymentActiveTypeEnum.CONSUMER.getValue())
                        .setActiveCode(orderCode)
                        .setActiveName(PaymentActiveTypeEnum.CONSUMER.getType())
                        .setPaymentStatus(PaymentStatusEnum.PAID.getStatus())
                        .setOrgId(auth.getOrgId())
        );
        saveBatch(payments);
    }
}




