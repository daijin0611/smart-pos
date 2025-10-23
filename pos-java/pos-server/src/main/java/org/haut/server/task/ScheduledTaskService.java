package org.haut.server.task;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.enums.OrderStatusEnum;
import org.haut.common.enums.RechargeStatusEnum;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.order.entity.OrderSalesSummary;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderInfoService;
import org.haut.server.order.service.OrderSalesSummaryService;
import org.haut.server.payment.entity.PaymentDetail;
import org.haut.server.payment.service.PaymentDetailService;
import org.haut.common.enums.PaymentActiveTypeEnum;
import org.haut.common.enums.PaymentStatusEnum;
import org.haut.common.enums.PaymentTypeEnum;
import org.haut.server.vip.entity.VipRechargeHistory;
import org.haut.server.vip.service.VipRechargeHistoryService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * 定时任务服务类
 * 提供POS收银系统的销售数据统计功能
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-10-22
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ScheduledTaskService {

    private final OrderSalesSummaryService orderSalesSummaryService;
    private final OrderInfoService orderInfoService;
    private final VipRechargeHistoryService vipRechargeHistoryService;
    private final OrderDetailService orderDetailService;
    private final PaymentDetailService paymentDetailService;

    /**
     * 每日销售数据统计任务
     * 每天凌晨1点执行，统计前一天的销售数据
     */
    @Scheduled(cron = "0 0 1 * * ?")
    public void dailySalesStatistics() {
        log.info("开始执行每日销售数据统计任务 - {}", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        LocalDate statsDate = LocalDate.now().minusDays(1);
        OrderSalesSummary summary = new OrderSalesSummary();
        try {
            // 1. 统计营业额相关（订单+充值）
            List<OrderInfoEntity> orderList = orderInfoService.lambdaQuery()
                    .eq(OrderInfoEntity::getCreateTime, Date.valueOf(statsDate))
                    .eq(OrderInfoEntity::getOrderStatus, OrderStatusEnum.SETTLED.getCode())
                    .eq(OrderInfoEntity::getOrgId, auth.getOrgId()).list();
            List<VipRechargeHistory> rechargeHistoryList = vipRechargeHistoryService.lambdaQuery()
                    .eq(VipRechargeHistory::getCreateTime, Date.valueOf(statsDate))
                    .eq(VipRechargeHistory::getRechargeStatus, RechargeStatusEnum.SUCCESS.getValue())
                    .eq(VipRechargeHistory::getOrgId, auth.getOrgId())
                    .list();
            List<OrderDetailEntity> orderDetailList = orderDetailService.lambdaQuery()
                    .eq(OrderDetailEntity::getCreateTime,  Date.valueOf(statsDate))
                    .eq(OrderDetailEntity::getOrgId, auth.getOrgId())
                    .list();
            
            // 2. 计算基础统计数据
            BigDecimal totalTurnover = BigDecimal.ZERO;
            BigDecimal totalActualReceipt = BigDecimal.ZERO;
            Integer totalSingleTime = 0;
            Integer totalPeopleTime = 0;
            Integer totalProjectCount = 0;

            // 2.1 统计订单相关数据
            for (OrderInfoEntity order : orderList) {
                // 累加应收金额（营业额）
                if (order.getTotalAmount() != null) {
                    totalTurnover = totalTurnover.add(order.getTotalAmount());
                }
                // 累加实收金额
                if (order.getActualAmount() != null) {
                    totalActualReceipt = totalActualReceipt.add(order.getActualAmount());
                }
                // 累加订单数量（单次数量）
                totalSingleTime++;
            }

            // 2.2 统计订单明细相关数据
            for (OrderDetailEntity detail : orderDetailList) {
                // 累加人次（订单明细数量）
                totalPeopleTime++;
                // 累加项目数量（按销售数量计算）
                if (detail.getQuantity() != null) {
                    totalProjectCount += detail.getQuantity();
                }
            }

            // 2.3 统计充值相关数据
            for (VipRechargeHistory recharge : rechargeHistoryList) {
                // 充值金额计入营业额和实收金额
                if (recharge.getRechargeValue() != null) {
                    totalTurnover = totalTurnover.add(recharge.getRechargeValue());
                    totalActualReceipt = totalActualReceipt.add(recharge.getRechargeValue());
                }
            }

            // 3. 统计各种支付方式金额
            List<PaymentDetail> paymentList = paymentDetailService.lambdaQuery()
                    .eq(PaymentDetail::getCreateTime, Date.valueOf(statsDate))
                    .eq(PaymentDetail::getPaymentStatus, PaymentStatusEnum.PAID.getStatus())
                    .eq(PaymentDetail::getOrgId, auth.getOrgId())
                    .list();

            // 初始化各支付方式金额
            BigDecimal alipayPayment = BigDecimal.ZERO;
            BigDecimal bankCardPayment = BigDecimal.ZERO;
            BigDecimal cashPayment = BigDecimal.ZERO;
            BigDecimal electronicCouponPayment = BigDecimal.ZERO;
            BigDecimal membershipCardPayment = BigDecimal.ZERO;
            BigDecimal otherPayment = BigDecimal.ZERO;
            BigDecimal wechatPayment = BigDecimal.ZERO;

            // 3.1 统计订单支付方式金额
            for (PaymentDetail payment : paymentList) {
                if (PaymentActiveTypeEnum.CONSUMER.getValue().equals(payment.getActiveType()) 
                    && payment.getTotalAmount() != null) {
                    Integer paymentType = payment.getPaymentType();
                    BigDecimal amount = payment.getTotalAmount();
                    
                    if (PaymentTypeEnum.WECHAT.getCode().equals(String.valueOf(paymentType))) {
                        wechatPayment = wechatPayment.add(amount);
                    } else if (PaymentTypeEnum.ALIPAY.getCode().equals(String.valueOf(paymentType))) {
                        alipayPayment = alipayPayment.add(amount);
                    } else if (PaymentTypeEnum.CASH.getCode().equals(String.valueOf(paymentType))) {
                        cashPayment = cashPayment.add(amount);
                    } else if (PaymentTypeEnum.ASSET.getCode().equals(String.valueOf(paymentType))) {
                        membershipCardPayment = membershipCardPayment.add(amount);
                    } else {
                        otherPayment = otherPayment.add(amount);
                    }
                }
            }

            // 4. 统计充值方式金额
            BigDecimal cashRecharge = BigDecimal.ZERO;
            BigDecimal wechatRecharge = BigDecimal.ZERO;
            BigDecimal otherRecharge = BigDecimal.ZERO;

            // 4.1 统计充值支付方式金额
            for (PaymentDetail payment : paymentList) {
                if (PaymentActiveTypeEnum.RECHARGER.getValue().equals(payment.getActiveType())
                    && payment.getTotalAmount() != null) {
                    Integer paymentType = payment.getPaymentType();
                    BigDecimal amount = payment.getTotalAmount();
                    
                    if (PaymentTypeEnum.WECHAT.getCode().equals(String.valueOf(paymentType))) {
                        wechatRecharge = wechatRecharge.add(amount);
                    } else if (PaymentTypeEnum.CASH.getCode().equals(String.valueOf(paymentType))) {
                        cashRecharge = cashRecharge.add(amount);
                    } else {
                        otherRecharge = otherRecharge.add(amount);
                    }
                }
            }

            // 5. 构建销售汇总对象
            summary.setOrgId(auth.getOrgId())
                    .setStatsDate(statsDate)
                    .setCreateTime(LocalDateTime.now())
                    .setTotalTurnover(totalTurnover)
                    .setTotalActualReceipt(totalActualReceipt)
                    .setTotalSingleTime(totalSingleTime)
                    .setTotalPeopleTime(totalPeopleTime)
                    .setTotalProjectCount(totalProjectCount)
                    .setAlipayPayment(alipayPayment)
                    .setBankCardPayment(bankCardPayment)
                    .setCashPayment(cashPayment)
                    .setElectronicCouponPayment(electronicCouponPayment)
                    .setMembershipCardPayment(membershipCardPayment)
                    .setOtherPayment(otherPayment)
                    .setWechatPayment(wechatPayment)
                    .setCashRecharge(cashRecharge)
                    .setWechatRecharge(wechatRecharge)
                    .setOtherRecharge(otherRecharge);

            // 6. 保存统计结果
            orderSalesSummaryService.save(summary);
            
            log.info("每日销售数据统计任务执行完成 - 统计日期: {}, 营业额: {}, 实收: {}, 订单数: {}, 人次: {}, 项目数: {}", 
                    statsDate, totalTurnover, totalActualReceipt, totalSingleTime, totalPeopleTime, totalProjectCount);
        } catch (Exception e) {
            log.error("每日销售数据统计任务执行失败", e);
        }
    }

    /**
     * 每周销售数据统计任务
     * 每周一凌晨2点执行，统计上周的销售数据
     */
    @Scheduled(cron = "0 0 2 ? * MON")
    public void weeklySalesStatistics() {
        log.info("开始执行每周销售数据统计任务 - {}", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        
        try {
            // TODO: 实现周销售数据统计逻辑
            // 1. 统计周订单总数和总金额
            // 2. 统计周销售趋势
            // 3. 统计热门服务项目排行
            // 4. 统计技师周业绩排行
            // 5. 统计会员消费活跃度
            // 6. 生成销售周报表
            
            log.info("每周销售数据统计任务执行完成");
        } catch (Exception e) {
            log.error("每周销售数据统计任务执行失败", e);
        }
    }

    /**
     * 每月销售数据统计任务
     * 每月1号凌晨3点执行，统计上月的销售数据
     */
    @Scheduled(cron = "0 0 3 1 * ?")
    public void monthlySalesStatistics() {
        log.info("开始执行每月销售数据统计任务 - {}", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        
        try {
            // TODO: 实现月销售数据统计逻辑
            // 1. 统计月订单总数和总金额
            // 2. 统计月销售增长率
            // 3. 统计服务项目月销售排行
            // 4. 统计技师月业绩和提成汇总
            // 5. 统计会员消费分析
            // 6. 统计营销活动效果
            // 7. 生成销售月报表
            
            log.info("每月销售数据统计任务执行完成");
        } catch (Exception e) {
            log.error("每月销售数据统计任务执行失败", e);
        }
    }
}