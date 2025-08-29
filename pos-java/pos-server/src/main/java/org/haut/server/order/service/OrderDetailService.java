package org.haut.server.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
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
     * 根据订单ID查询订单明细列表
     * 
     * @param orderId 订单ID
     * @return 订单明细VO列表
     */
    List<OrderDetailVO> queryDetailByOrderId(Long orderId);
    
    /**
     * 根据订单ID查询订单明细实体列表
     * 
     * @param orderId 订单ID
     * @return 订单明细实体列表
     */
    List<OrderDetailEntity> queryDetailEntityByOrderId(Long orderId);
    
    /**
     * 根据订单编号查询订单明细列表
     * 
     * @param orderCode 订单编号
     * @return 订单明细VO列表
     */
    List<OrderDetailVO> queryDetailByOrderCode(String orderCode);
    
    /**
     * 根据业务类型和业务ID查询订单明细列表
     * 
     * @param detailType 业务类型
     * @param bid 业务ID
     * @return 订单明细VO列表
     */
    List<OrderDetailVO> queryDetailByTypeAndBid(Integer detailType, Long bid);
    
    /**
     * 根据员工ID查询订单明细列表
     * 
     * @param userId 员工ID
     * @return 订单明细VO列表
     */
    List<OrderDetailVO> queryDetailByUserId(Long userId);
    
    /**
     * 批量添加订单明细
     * 
     * @param orderDetails 订单明细实体列表
     * @return 是否成功
     */
    Boolean addOrderDetailBatch(List<OrderDetailEntity> orderDetails);
    
    /**
     * 根据订单ID删除订单明细
     * 
     * @param orderId 订单ID
     * @return 是否成功
     */
    Boolean removeDetailByOrderId(Long orderId);
    
    /**
     * 更新订单明细结算时间
     * 
     * @param orderId 订单ID
     * @return 是否成功
     */
    Boolean updateSettledTimeByOrderId(Long orderId);
    
    /**
     * 统计订单明细数量
     * 
     * @param orderId 订单ID
     * @return 明细数量
     */
    Long countDetailByOrderId(Long orderId);
}