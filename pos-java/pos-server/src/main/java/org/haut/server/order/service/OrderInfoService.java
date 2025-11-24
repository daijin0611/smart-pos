package org.haut.server.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.OrderCreateDTO;
import org.haut.common.domain.dto.order.OrderRollBackDTO;
import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.dto.order.OrderReconcileDTO;
import org.haut.common.domain.vo.order.OrderReceiptVO;
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
     * @return
     */
    Long settleOrder(OrderSettleDTO settleOrderDTO);

    /**
     * 对单（结算后24小时内允许修改订单明细与支付信息）
     * @param dto 对单请求对象
     */
    void reconcileOrder(OrderReconcileDTO dto);

    /**
     * 根据订单ID装配并返回小票信息
     * @param orderId 订单ID
     * @return 小票信息
     */
    OrderReceiptVO getReceiptByOrderId(Long orderId);
    
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

    /**
     * 根据床位ID查询订单信息
     *
     * @param bedId 床位ID
     * @return 订单信息VO
     */
    OrderInfoVO queryByBedId(Long bedId);


    /**
     * 根据订单编号查询订单信息
     *
     * @param orderCode 订单编号
     * @return 订单信息VO
     */
    OrderInfoVO queryByOrderCode(String orderCode);

     /**
      * 订单冲正
      * @param dto 订单冲正请求对象
      */
    void rollBackOrder(OrderRollBackDTO dto);
}
