package org.haut.server.order.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.dto.order.CreateOrderDTO;
import org.haut.common.domain.dto.order.SettleOrderDTO;
import org.haut.common.domain.query.order.OrderInfoQuery;
import org.haut.common.domain.vo.order.OrderCreateVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.server.order.entity.OrderInfoEntity;

import java.util.List;

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
    OrderCreateVO addOrderWithBed(CreateOrderDTO createOrderDTO);
    
    /**
     * 结算订单
     * 
     * @param settleOrderDTO 结算订单请求DTO
     * @return 订单信息VO
     */
    OrderInfoVO settleOrder(SettleOrderDTO settleOrderDTO);
}