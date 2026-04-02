package org.haut.server.order.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import lombok.AllArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.order.OrderSummaryQuery;
import org.haut.common.domain.vo.order.OrderSummaryVO;
import org.haut.common.enums.*;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.order.entity.OrderSalesSummary;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderInfoService;
import org.haut.server.order.service.OrderSalesSummaryService;
import org.haut.server.order.mapper.OrderSalesSummaryMapper;
import org.haut.server.payment.entity.PaymentDetail;
import org.haut.server.payment.service.PaymentDetailService;
import org.haut.server.system.entity.SysOrg;
import org.haut.server.system.service.SysOrgService;
import org.haut.server.vip.entity.VipRechargeHistory;
import org.haut.server.vip.service.VipRechargeHistoryService;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * OrderSalesSummary转换器
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-08-20
 */
@Mapper(componentModel = "spring")
interface OrderSalesSummaryConvert {
    /**
     * 将实体对象转换为VO对象
     * @param entity 销售汇总实体
     * @return 销售汇总VO
     */
    OrderSummaryVO toVO(OrderSalesSummary entity);
    
    /**
     * 将实体对象列表转换为VO对象列表
     * @param entityList 销售汇总实体列表
     * @return 销售汇总VO列表
     */
    List<OrderSummaryVO> toVOList(List<OrderSalesSummary> entityList);
}

/**
* @author 86156
* @description 针对表【order_sales_summary(销售数据汇总表，整合销售、支付、充值相关数据)】的数据库操作Service实现
* @createDate 2025-10-21 23:07:19
*/
@Service
@AllArgsConstructor
@Slf4j
public class OrderSalesSummaryServiceImpl extends ServiceImpl<OrderSalesSummaryMapper, OrderSalesSummary>
    implements OrderSalesSummaryService{

    private final OrderSalesSummaryConvert orderSalesSummaryConvert;
    private final OrderInfoService orderInfoService;
    private final VipRechargeHistoryService vipRechargeHistoryService;
    private final OrderDetailService orderDetailService;
    private final PaymentDetailService paymentDetailService;
    private final SysOrgService sysOrgService;
        
    /**
     * 获取某时间段内的销售数据，并在最后添加汇总记录
     * @param query 查询条件
     * @return 销售数据列表（包含汇总记录）
     */
    @Override
    public List<OrderSummaryVO> getOrderSummaries(OrderSummaryQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        LocalDate[] date = query.getDate();
        if (date == null) {
            date = new LocalDate[]{LocalDate.now(), LocalDate.now()};
        }
        List<OrderSalesSummary> summaries = lambdaQuery().eq(OrderSalesSummary::getOrgId, auth.getOrgId())
                .between(OrderSalesSummary::getStatsDate, date[0], date[1])
                .list();
        
        // 转换为VO对象
        return orderSalesSummaryConvert.toVOList(summaries);
    }


    @Override
    public void executeSummaries() {
        log.info("开始执行每日销售数据统计任务 - {}", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        // 1. 获取所有机构
        List<SysOrg> orgList = sysOrgService.lambdaQuery().list();
        for (SysOrg org : orgList) {
            // 2. 执行统计任务
            execute(org);
            // 3. 更新订单状态
            updateOrderStatus(org);
            log.info("机构 {} 的销售数据统计任务执行完成", org.getOrgName());
        }
    }

    /**
     * 更新订单状态
     * @param org 机构
     */
    private void updateOrderStatus(SysOrg org) {
        LocalDate statsDate = LocalDate.now().minusDays(1);
        // 计算统计日期的开始时间（0点）和结束时间（24点）
        LocalDateTime startTime = statsDate.atStartOfDay();
        LocalDateTime endTime = statsDate.plusDays(1).atStartOfDay();
        // 1. 获取所有待处理订单
        List<OrderInfoEntity> pendingOrders = orderInfoService.lambdaQuery()
                .eq(OrderInfoEntity::getOrgId, org.getId())
                .eq(OrderInfoEntity::getOrderStatus, OrderStatusEnum.SETTLED.getCode())
                .list();
        
        // 2. 更新订单状态为已对单
        if (!pendingOrders.isEmpty()) {
            orderInfoService.lambdaUpdate()
                    .set(OrderInfoEntity::getOrderStatus, OrderStatusEnum.RECONCILED.getCode())
                    .gt(OrderInfoEntity::getSettleTime, startTime)
                    .lt(OrderInfoEntity::getSettleTime, endTime)
                    .in(OrderInfoEntity::getId, pendingOrders)
                    .update();
        }
    }


    /**
     * 计算所有记录的汇总数据
     * @param summaries 销售汇总列表
     * @return 汇总记录
     */
    private OrderSummaryVO calculateTotal(List<OrderSummaryVO> summaries) {
        OrderSummaryVO totalSummary = new OrderSummaryVO();
        
        // 初始化数值类型字段为0
        totalSummary.setTotalTurnover(BigDecimal.ZERO);
        totalSummary.setTotalActualReceipt(BigDecimal.ZERO);
        totalSummary.setTotalSingleTime(0);
        totalSummary.setTotalPeopleTime(0);
        totalSummary.setTotalProjectCount(0);
        totalSummary.setAlipayPayment(BigDecimal.ZERO);
        totalSummary.setBankCardPayment(BigDecimal.ZERO);
        totalSummary.setCashPayment(BigDecimal.ZERO);
        totalSummary.setElectronicCouponPayment(BigDecimal.ZERO);
        totalSummary.setMembershipCardPayment(BigDecimal.ZERO);
        totalSummary.setOtherPayment(BigDecimal.ZERO);
        totalSummary.setWechatPayment(BigDecimal.ZERO);
        totalSummary.setCashRecharge(BigDecimal.ZERO);
        totalSummary.setWechatRecharge(BigDecimal.ZERO);
        totalSummary.setOtherRecharge(BigDecimal.ZERO);
        
        // 累加所有记录的数值
        for (OrderSummaryVO summary : summaries) {
            // 累加BigDecimal类型字段
            if (summary.getTotalTurnover() != null) {
                totalSummary.setTotalTurnover(totalSummary.getTotalTurnover().add(summary.getTotalTurnover()));
            }
            if (summary.getTotalActualReceipt() != null) {
                totalSummary.setTotalActualReceipt(totalSummary.getTotalActualReceipt().add(summary.getTotalActualReceipt()));
            }
            if (summary.getAlipayPayment() != null) {
                totalSummary.setAlipayPayment(totalSummary.getAlipayPayment().add(summary.getAlipayPayment()));
            }
            if (summary.getBankCardPayment() != null) {
                totalSummary.setBankCardPayment(totalSummary.getBankCardPayment().add(summary.getBankCardPayment()));
            }
            if (summary.getCashPayment() != null) {
                totalSummary.setCashPayment(totalSummary.getCashPayment().add(summary.getCashPayment()));
            }
            if (summary.getElectronicCouponPayment() != null) {
                totalSummary.setElectronicCouponPayment(totalSummary.getElectronicCouponPayment().add(summary.getElectronicCouponPayment()));
            }
            if (summary.getMembershipCardPayment() != null) {
                totalSummary.setMembershipCardPayment(totalSummary.getMembershipCardPayment().add(summary.getMembershipCardPayment()));
            }
            if (summary.getOtherPayment() != null) {
                totalSummary.setOtherPayment(totalSummary.getOtherPayment().add(summary.getOtherPayment()));
            }
            if (summary.getWechatPayment() != null) {
                totalSummary.setWechatPayment(totalSummary.getWechatPayment().add(summary.getWechatPayment()));
            }
            if (summary.getCashRecharge() != null) {
                totalSummary.setCashRecharge(totalSummary.getCashRecharge().add(summary.getCashRecharge()));
            }
            if (summary.getWechatRecharge() != null) {
                totalSummary.setWechatRecharge(totalSummary.getWechatRecharge().add(summary.getWechatRecharge()));
            }
            if (summary.getOtherRecharge() != null) {
                totalSummary.setOtherRecharge(totalSummary.getOtherRecharge().add(summary.getOtherRecharge()));
            }
            
            // 累加Integer类型字段
            if (summary.getTotalSingleTime() != null) {
                totalSummary.setTotalSingleTime(totalSummary.getTotalSingleTime() + summary.getTotalSingleTime());
            }
            if (summary.getTotalPeopleTime() != null) {
                totalSummary.setTotalPeopleTime(totalSummary.getTotalPeopleTime() + summary.getTotalPeopleTime());
            }
            if (summary.getTotalProjectCount() != null) {
                totalSummary.setTotalProjectCount(totalSummary.getTotalProjectCount() + summary.getTotalProjectCount());
            }
        }
        
        return totalSummary;
    }

    /**
     * 统计单个机构的汇总数据
     * @param org
     */
    private void execute(SysOrg org) {
        LocalDate statsDate = LocalDate.now().minusDays(1);
        // 计算统计日期的开始时间（0点）和结束时间（24点）
        LocalDateTime startTime = statsDate.atStartOfDay();
        LocalDateTime endTime = statsDate.plusDays(1).atStartOfDay();
        
        OrderSalesSummary summary = new OrderSalesSummary();
        try {
            // 1. 统计营业额相关（订单+充值）
            List<OrderInfoEntity> orderList = orderInfoService.lambdaQuery()
                    .ge(OrderInfoEntity::getCreateTime, startTime)
                    .lt(OrderInfoEntity::getCreateTime, endTime)
                    .eq(OrderInfoEntity::getOrderStatus, OrderStatusEnum.SETTLED.getCode())
                    .eq(OrderInfoEntity::getOrgId, org.getId()).list();
            List<VipRechargeHistory> rechargeHistoryList = vipRechargeHistoryService.lambdaQuery()
                    .ge(VipRechargeHistory::getCreateTime, startTime)
                    .lt(VipRechargeHistory::getCreateTime, endTime)
                    .eq(VipRechargeHistory::getRechargeStatus, RechargeStatusEnum.SUCCESS.getValue())
                    .eq(VipRechargeHistory::getOrgId, org.getId())
                    .list();
            List<OrderDetailEntity> orderDetailList = orderDetailService.lambdaQuery()
                    .ge(OrderDetailEntity::getCreateTime, startTime)
                    .lt(OrderDetailEntity::getCreateTime, endTime)
                    .eq(OrderDetailEntity::getOrgId, org.getId())
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
                    .ge(PaymentDetail::getCreateTime, startTime)
                    .lt(PaymentDetail::getCreateTime, endTime)
                    .eq(PaymentDetail::getPaymentStatus, PaymentStatusEnum.PAID.getStatus())
                    .eq(PaymentDetail::getOrgId, org.getId())
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
            summary.setOrgId(org.getId())
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
            save(summary);

            log.info("每日销售数据统计任务执行完成 - 统计日期: {}, 营业额: {}, 实收: {}, 订单数: {}, 人次: {}, 项目数: {}",
                    statsDate, totalTurnover, totalActualReceipt, totalSingleTime, totalPeopleTime, totalProjectCount);
        } catch (Exception e) {
            log.error("每日销售数据统计任务执行失败", e);
        }
    }
}




