package org.haut.server.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.dto.order.OrderDetailCreateDTO;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.server.order.entity.OrderDetailEntity;

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
}