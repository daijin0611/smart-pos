package org.haut.server.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.OrderCreateDTO;
import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.query.order.OrderPageQuery;
import org.haut.common.domain.vo.order.OrderCreateVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.server.order.entity.OrderInfoEntity;

/**
 * 订单信息服务接口
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
public interface OrderInfoService extends IService<OrderInfoEntity> {
    
    /**
     * 创建订单
     *
     * @param createOrderDTO 创建订单请求DTO
     * @return 订单信息VO
     */
    OrderCreateVO addOrderWithBed(OrderCreateDTO createOrderDTO);
    
    /**
     * 结算订单
     * 
     * @param settleOrderDTO 结算订单请求DTO
     */
    void settleOrder(OrderSettleDTO settleOrderDTO);
    
    /**
     * 根据订单ID查询订单信息
     * 
     * @param orderId 订单ID
     * @return 订单信息VO
     */
    OrderInfoVO queryById(Long orderId);

    /**
     * 取消订单
     * @param orderId
     * @return
     */
    String cancelOrder(Long orderId);

    /**
     * 分页查询订单信息
     *
     * @return 订单信息VO
     */
    PageDTO<OrderInfoVO> pageQuery(OrderPageQuery query);
}