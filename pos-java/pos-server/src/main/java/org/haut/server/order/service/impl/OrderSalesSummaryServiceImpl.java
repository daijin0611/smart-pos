package org.haut.server.order.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import lombok.AllArgsConstructor;

import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.order.OrderSummaryQuery;
import org.haut.common.domain.vo.order.OrderSummaryVO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.order.entity.OrderSalesSummary;
import org.haut.server.order.service.OrderSalesSummaryService;
import org.haut.server.order.mapper.OrderSalesSummaryMapper;
import org.mapstruct.Mapper;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

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
public class OrderSalesSummaryServiceImpl extends ServiceImpl<OrderSalesSummaryMapper, OrderSalesSummary>
    implements OrderSalesSummaryService{

    private final OrderSalesSummaryConvert orderSalesSummaryConvert;

    /**
     * 获取某时间段内的销售数据，并在最后添加汇总记录
     * @param query 查询条件
     * @return 销售数据列表（包含汇总记录）
     */
    @Override
    public List<OrderSummaryVO> getOrderSummaries(OrderSummaryQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        List<OrderSalesSummary> summaries = lambdaQuery().eq(OrderSalesSummary::getOrgId, auth.getOrgId())
                .between(
                        OrderSalesSummary::getStatsDate, query.getStartDate(), query.getEndDate()
                )
                .list();
        
        // 转换为VO对象
        List<OrderSummaryVO> result = orderSalesSummaryConvert.toVOList(summaries);
        
        // 如果有数据，则计算汇总并添加到列表末尾
        if (!result.isEmpty()) {
            OrderSummaryVO totalSummary = calculateTotal(result);
            // 设置汇总记录的特殊标识
            totalSummary.setId(-1L); // 使用特殊ID标识汇总记录
            totalSummary.setStatsDate(null); // 汇总记录不显示具体日期
            result.add(totalSummary);
        }
        
        return result;
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
}




