package org.haut.server.order.service;

import org.haut.common.domain.query.order.OrderSummaryQuery;
import org.haut.common.domain.vo.order.OrderSummaryVO;

import java.util.List;

/**
 * 销售数据汇总服务（实时计算）
 */
public interface OrderSalesSummaryService {

    /**
     * 实时获取销售汇总数据
     * @param query 查询条件
     * @return 销售汇总列表
     */
    List<OrderSummaryVO> getOrderSummaries(OrderSummaryQuery query);
}
