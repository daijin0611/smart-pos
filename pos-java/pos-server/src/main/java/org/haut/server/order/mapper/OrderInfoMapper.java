package org.haut.server.order.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.haut.common.domain.query.order.OrderInfoQuery;
import org.haut.common.domain.query.order.OrderPageQuery;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.order.entity.OrderSalesSummary;

import java.util.List;

/**
 * 订单信息表Mapper接口
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Mapper
public interface OrderInfoMapper extends BaseMapper<OrderInfoEntity> {
    
    /**
     * 分页查询订单信息
     * 
     * @param page 分页参数
     * @param query 查询条件
     * @return 分页结果
     */
    IPage<OrderInfoEntity> queryOrderInfoPage(Page<OrderInfoEntity> page, @Param("query") OrderInfoQuery query);
    
    /**
     * 根据条件查询订单信息列表
     * 
     * @param query 查询条件
     * @return 订单信息列表
     */
    List<OrderInfoEntity> queryOrderInfoList(@Param("query") OrderInfoQuery query);
    
    /**
     * 根据订单号查询订单信息
     * 
     * @param orderNo 订单号
     * @return 订单信息
     */
    OrderInfoEntity queryByOrderNo(@Param("orderNo") String orderNo);
    
    /**
     * 根据会员ID查询订单信息列表
     * 
     * @param vipId 会员ID
     * @return 订单信息列表
     */
    List<OrderInfoEntity> queryByVipId(@Param("vipId") Long vipId);
    
    /**
     * 根据床位ID查询最新的订单信息
     * 
     * @param bedId 床位ID
     * @return 订单信息
     */
    OrderInfoEntity queryLatestByBedId(@Param("bedId") Long bedId, @Param("orgId") Long orgId);
    
    /**
     * 统计订单数量
     * 
     * @param query 查询条件
     * @return 订单数量
     */
    Long countOrderInfo(@Param("query") OrderInfoQuery query);
    
    /**
     * 更新订单状态
     * 
     * @param orderId 订单ID
     * @param orderStatus 订单状态
     * @return 更新行数
     */
    int updateOrderStatus(@Param("orderId") Long orderId, @Param("orderStatus") Integer orderStatus);

    /**
     * 分页查询订单信息
     *
     * @param page 分页参数
     * @param query 查询条件
     * @return 分页结果
     */
    IPage<OrderInfoVO> pageQuery(Page<OrderInfoVO> page, @Param("query") OrderPageQuery query);


}