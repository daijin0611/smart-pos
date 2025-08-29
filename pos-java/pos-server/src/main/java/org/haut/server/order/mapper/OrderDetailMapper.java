package org.haut.server.order.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.haut.server.order.entity.OrderDetailEntity;

import java.util.List;

/**
 * 订单明细表Mapper接口
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Mapper
public interface OrderDetailMapper extends BaseMapper<OrderDetailEntity> {
    
    /**
     * 根据订单ID查询订单明细列表
     * 
     * @param orderId 订单ID
     * @return 订单明细列表
     */
    List<OrderDetailEntity> queryByOrderId(@Param("orderId") Long orderId);
    
    /**
     * 根据订单编号查询订单明细列表
     * 
     * @param orderCode 订单编号
     * @return 订单明细列表
     */
    List<OrderDetailEntity> queryByOrderCode(@Param("orderCode") String orderCode);
    
    /**
     * 根据业务类型和业务ID查询订单明细列表
     * 
     * @param detailType 业务类型
     * @param bid 业务ID
     * @return 订单明细列表
     */
    List<OrderDetailEntity> queryByDetailTypeAndBid(@Param("detailType") Integer detailType, @Param("bid") Long bid);
    
    /**
     * 根据员工ID查询订单明细列表
     * 
     * @param userId 员工ID
     * @return 订单明细列表
     */
    List<OrderDetailEntity> queryByUserId(@Param("userId") Long userId);
    
    /**
     * 批量插入订单明细
     * 
     * @param orderDetails 订单明细列表
     * @return 插入行数
     */
    int batchInsert(@Param("orderDetails") List<OrderDetailEntity> orderDetails);
    
    /**
     * 根据订单ID删除订单明细
     * 
     * @param orderId 订单ID
     * @return 删除行数
     */
    int deleteByOrderId(@Param("orderId") Long orderId);
    
    /**
     * 更新订单明细结算时间
     * 
     * @param orderId 订单ID
     * @return 更新行数
     */
    int updateSettledTimeByOrderId(@Param("orderId") Long orderId);
    
    /**
     * 统计订单明细数量
     * 
     * @param orderId 订单ID
     * @return 明细数量
     */
    Long countByOrderId(@Param("orderId") Long orderId);
}