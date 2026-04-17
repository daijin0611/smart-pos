package org.haut.server.kpi.service;

import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.kpi.KpiDetailCreateDTO;
import org.haut.common.domain.dto.order.OrderDetailSettleDTO;
import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.query.kpi.KpiListQuery;
import org.haut.common.domain.query.kpi.KpiSummaryQuery;
import org.haut.common.domain.vo.kpi.KpiListVO;
import org.haut.common.domain.vo.kpi.KpiSummaryVO;
import org.haut.server.kpi.entity.KpiDetail;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderInfoEntity;

import java.util.List;

/**
* @author daiji
* @description 针对表【kpi_detail(业绩明细)】的数据库操作Service
* @createDate 2025-08-25 16:35:17
*/
public interface KpiDetailService extends IService<KpiDetail> {

    boolean createKpiDetail(KpiDetailCreateDTO kpiDetailCreateDTO);

    /**
     * 获取员工业绩明细分页列表
     *
     * @param query 查询条件
     * @return KPI分页列表
     */
    PageDTO<KpiListVO> getKpiList(KpiListQuery query);

    /**
     * 处理订单结算
     *
     * @param order 订单信息
     * @param orderDetails 订单明细DTO
     */
//    void handelOrder(OrderInfoEntity order, List<OrderDetailSettleDTO> orderDetails);

    /**
     * 处理订单结算（使用已保存的订单明细实体，包含正确的ID）
     *
     * @param order 订单信息
     * @param orderSettleDTO 订单结算信息
     * @param savedDetails 已保存的订单明细实体列表（与orderDetails一一对应）
     */
    void handelOrder(OrderInfoEntity order, OrderSettleDTO orderSettleDTO, List<OrderDetailEntity> savedDetails);

    /**
     * 获取KPI总结
     *
     * @param kpiListQuery 查询条件
     * @return KPI总结列表
     */
    List<KpiSummaryVO> getKpiSummary(KpiSummaryQuery kpiListQuery);
}
