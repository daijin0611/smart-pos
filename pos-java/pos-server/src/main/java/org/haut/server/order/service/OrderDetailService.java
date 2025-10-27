package org.haut.server.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.OrderDetailCreateDTO;
import org.haut.common.domain.dto.order.OrderDetailSettleDTO;
import org.haut.common.domain.query.order.OrderDetailPageQuery;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderInfoEntity;

import java.util.List;

/**
 * 订单明细服务接口
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
public interface OrderDetailService extends IService<OrderDetailEntity> {

    /**
     * 创建订单明细
     * @param orderDetails 订单明细
     * @param orderId 订单ID
     */
    List<OrderDetailVO> createOrderDetails (List<OrderDetailCreateDTO> orderDetails, Long orderId);
    
    /**
     * 根据订单ID查询订单明细列表
     * 
     * @param orderId 订单ID
     * @return 订单明细列表
     */
    List<OrderDetailVO> queryByOrderId(Long orderId);

    /**
     * 添加订单明细
     * @param dto
     * @param orderId
     * @return
     */
    String addDetails(OrderDetailCreateDTO dto, Long orderId);

    /**
     * 结算订单明细
     * @param orderInfoEntity 订单信息
     * @param orderDetails 待结算订单明细
     */
    void settleOrderDetail(OrderInfoEntity orderInfoEntity, List<OrderDetailSettleDTO> orderDetails);

    /**
     * 订单明细分页查询
     * @return
     */
    PageDTO<OrderDetailVO> pageQuery(OrderDetailPageQuery query);
}