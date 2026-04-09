package org.haut.server.order.service.impl;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ArrayUtils;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.order.OrderSummaryQuery;
import org.haut.common.domain.vo.order.OrderSummaryVO;
import org.haut.common.domain.vo.system.OrgSimpleVO;
import org.haut.common.enums.OrderStatusEnum;
import org.haut.common.enums.PaymentStatusEnum;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderInfoService;
import org.haut.server.order.service.OrderSalesSummaryService;
import org.haut.server.payment.entity.PaymentDetail;
import org.haut.server.payment.service.PaymentDetailService;
import org.haut.server.system.service.SysOrgService;
import org.haut.server.system.service.SysOrgUserService;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Slf4j
public class OrderSalesSummaryServiceImpl implements OrderSalesSummaryService {

    private final OrderInfoService orderInfoService;
    private final OrderDetailService orderDetailService;
    private final PaymentDetailService paymentDetailService;
    private final SysOrgService sysOrgService;
    private final SysOrgUserService sysOrgUserService;

    @Override
    public List<OrderSummaryVO> getOrderSummaries(OrderSummaryQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        List<Long> orgIds = sysOrgUserService.resolveOrgIds(auth.getUserId(), auth.getOrgId(), query.getOrgIds());
        LocalDate[] date = query.getDate();

        // 构建日期范围条件
        Date startTime = null;
        Date endTime = null;
        if (ArrayUtils.isNotEmpty(date) && date.length == 2) {
            startTime = java.sql.Date.valueOf(date[0]);
            endTime = java.sql.Date.valueOf(date[1].plusDays(1));
        }

        // 1. 查询订单（已结算 + 已对账）
        List<OrderInfoEntity> orderList = orderInfoService.lambdaQuery()
                .in(OrderInfoEntity::getOrgId, orgIds)
                .ge(startTime != null, OrderInfoEntity::getCreateTime, startTime)
                .lt(endTime != null, OrderInfoEntity::getCreateTime, endTime)
                .in(OrderInfoEntity::getOrderStatus,
                        OrderStatusEnum.SETTLED.getCode(), OrderStatusEnum.RECONCILED.getCode())
                .list();

        // 2. 查询订单明细
        List<OrderDetailEntity> detailList = orderDetailService.lambdaQuery()
                .in(OrderDetailEntity::getOrgId, orgIds)
                .ge(startTime != null, OrderDetailEntity::getCreateTime, startTime)
                .lt(endTime != null, OrderDetailEntity::getCreateTime, endTime)
                .list();

        // 3. 查询支付明细（已结算）
        List<PaymentDetail> paymentList = paymentDetailService.lambdaQuery()
                .in(PaymentDetail::getOrgId, orgIds)
                .ge(startTime != null, PaymentDetail::getCreateTime, startTime)
                .lt(endTime != null, PaymentDetail::getCreateTime, endTime)
                .eq(PaymentDetail::getPaymentStatus, PaymentStatusEnum.PAID.getStatus())
                .list();

        // 4. 按门店+日期分组聚合
        Map<String, List<OrderInfoEntity>> ordersByGroup = orderList.stream()
                .collect(Collectors.groupingBy(o -> groupKey(o.getOrgId(), o.getCreateTime())));
        Map<String, List<OrderDetailEntity>> detailsByGroup = detailList.stream()
                .collect(Collectors.groupingBy(d -> groupKey(d.getOrgId(), d.getCreateTime())));
        Map<String, List<PaymentDetail>> paymentsByGroup = paymentList.stream()
                .collect(Collectors.groupingBy(p -> groupKey(p.getOrgId(), p.getCreateTime())));

        // 合并所有出现的分组key
        Set<String> allKeys = new HashSet<>();
        allKeys.addAll(ordersByGroup.keySet());
        allKeys.addAll(detailsByGroup.keySet());
        allKeys.addAll(paymentsByGroup.keySet());

        List<OrderSummaryVO> result = new ArrayList<>();
        for (String key : allKeys) {
            String[] parts = key.split("\\|");
            Long orgId = Long.parseLong(parts[0]);
            LocalDate statsDate = LocalDate.parse(parts[1]);

            OrderSummaryVO vo = new OrderSummaryVO();
            vo.setOrgId(orgId);
            vo.setStatsDate(statsDate);

            // 聚合订单数据
            List<OrderInfoEntity> groupOrders = ordersByGroup.getOrDefault(key, Collections.emptyList());
            vo.setTotalSingleTime(groupOrders.size());

            // 聚合订单明细数据
            List<OrderDetailEntity> groupDetails = detailsByGroup.getOrDefault(key, Collections.emptyList());
            int totalPeopleTime = groupDetails.size();
            int totalProjectCount = 0;
            for (OrderDetailEntity detail : groupDetails) {
                if (detail.getQuantity() != null) {
                    totalProjectCount += detail.getQuantity();
                }
            }
            vo.setTotalPeopleTime(totalPeopleTime);
            vo.setTotalProjectCount(totalProjectCount);

            // 聚合支付数据
            List<PaymentDetail> groupPayments = paymentsByGroup.getOrDefault(key, Collections.emptyList());
            BigDecimal totalTurnover = BigDecimal.ZERO;
            BigDecimal qrPayment = BigDecimal.ZERO;
            BigDecimal cashPayment = BigDecimal.ZERO;
            BigDecimal posPayment = BigDecimal.ZERO;
            BigDecimal douyinPayment = BigDecimal.ZERO;
            BigDecimal meituanPayment = BigDecimal.ZERO;
            BigDecimal memberCardPayment = BigDecimal.ZERO;
            BigDecimal ticketConsumerPayment = BigDecimal.ZERO;
            BigDecimal ticketItemPayment = BigDecimal.ZERO;

            for (PaymentDetail payment : groupPayments) {
                if (payment.getTotalAmount() == null) {
                    continue;
                }
                BigDecimal amount = payment.getTotalAmount();
                totalTurnover = totalTurnover.add(amount);
                Integer paymentType = payment.getPaymentType();

                switch (paymentType) {
                    case 0 -> qrPayment = qrPayment.add(amount);
                    case 1 -> cashPayment = cashPayment.add(amount);
                    case 2 -> posPayment = posPayment.add(amount);
                    case 3 -> douyinPayment = douyinPayment.add(amount);
                    case 4 -> meituanPayment = meituanPayment.add(amount);
                    case 5 -> memberCardPayment = memberCardPayment.add(amount);
                    case 6 -> ticketConsumerPayment = ticketConsumerPayment.add(amount);
                    case 7 -> ticketItemPayment = ticketItemPayment.add(amount);
                    default -> log.warn("未知的支付类型: {}", paymentType);
                }
            }

            vo.setTotalTurnover(totalTurnover);
            vo.setTotalActualReceipt(totalTurnover
                    .subtract(memberCardPayment)
                    .subtract(ticketConsumerPayment)
                    .subtract(ticketItemPayment));
            vo.setQrPayment(qrPayment);
            vo.setCashPayment(cashPayment);
            vo.setPosPayment(posPayment);
            vo.setDouyinPayment(douyinPayment);
            vo.setMeituanPayment(meituanPayment);
            vo.setMemberCardPayment(memberCardPayment);
            vo.setTicketConsumerPayment(ticketConsumerPayment);
            vo.setTicketItemPayment(ticketItemPayment);

            result.add(vo);
        }

        // 5. 按日期降序排序
        result.sort(Comparator.comparing(OrderSummaryVO::getStatsDate).reversed());

        // 6. 批量填充门店信息
        if (!result.isEmpty()) {
            Map<Long, OrgSimpleVO> orgMap = sysOrgService.getOrgSimpleMapByIds(
                    result.stream().map(OrderSummaryVO::getOrgId).collect(Collectors.toSet()));
            result.forEach(vo -> {
                OrgSimpleVO org = orgMap.get(vo.getOrgId());
                if (org != null) {
                    vo.setOrgName(org.getOrgName());
                    vo.setOrgCode(org.getOrgCode());
                }
            });
        }

        return result;
    }

    /**
     * 生成分组key: orgId|yyyy-MM-dd
     */
    private String groupKey(Long orgId, Date date) {
        LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        return orgId + "|" + localDate;
    }
}
