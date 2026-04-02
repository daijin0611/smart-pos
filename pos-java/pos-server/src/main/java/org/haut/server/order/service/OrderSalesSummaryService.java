package org.haut.server.order.service;

import org.haut.common.domain.query.order.OrderSummaryQuery;
import org.haut.common.domain.vo.order.OrderSummaryVO;
import org.haut.server.order.entity.OrderSalesSummary;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author 86156
* @description 针对表【order_sales_summary(销售数据汇总表，整合销售、支付、充值相关数据)】的数据库操作Service
* @createDate 2025-10-21 23:07:19
*/
public interface OrderSalesSummaryService extends IService<OrderSalesSummary> {

    /**
     * 获取统计数据
     * @param query
     * @return
     */
    List<OrderSummaryVO> getOrderSummaries(OrderSummaryQuery query);

    /**
     * 执行统计逻辑
     */
    void executeSummaries();
}
