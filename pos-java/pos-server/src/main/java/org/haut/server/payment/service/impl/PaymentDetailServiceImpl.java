package org.haut.server.payment.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.server.payment.entity.PaymentDetail;
import org.haut.server.payment.service.PaymentDetailService;
import org.haut.server.payment.mapper.PaymentDetailMapper;
import org.springframework.stereotype.Service;

/**
* @author 86156
* @description 针对表【payment_detail(支付明细表，记录各种业务的支付详情。)】的数据库操作Service实现
* @createDate 2025-08-25 23:22:33
*/
@Service
public class PaymentDetailServiceImpl extends ServiceImpl<PaymentDetailMapper, PaymentDetail>
    implements PaymentDetailService{

}




