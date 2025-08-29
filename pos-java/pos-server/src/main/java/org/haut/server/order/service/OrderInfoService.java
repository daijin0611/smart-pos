package org.haut.server.order.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.dto.order.CreateOrderDTO;
import org.haut.common.domain.dto.order.SettleOrderDTO;
import org.haut.common.domain.query.order.OrderInfoQuery;
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
    OrderInfoVO addOrder(CreateOrderDTO createOrderDTO);
    
    /**
     * 结算订单
     * 
     * @param settleOrderDTO 结算订单请求DTO
     * @return 订单信息VO
     */
    OrderInfoVO settleOrder(SettleOrderDTO settleOrderDTO);
    
    /**
     * 分页查询订单信息
     * 
     * @param page 分页参数
     * @param query 查询条件
     * @return 分页结果
     */
    IPage<OrderInfoVO> queryOrderInfoPage(Page<OrderInfoEntity> page, OrderInfoQuery query);
    
    /**
     * 根据条件查询订单信息列表
     * 
     * @param query 查询条件
     * @return 订单信息VO列表
     */
    List<OrderInfoVO> queryOrderInfoList(OrderInfoQuery query);
    
    /**
     * 根据订单ID查询订单详情
     * 
     * @param orderId 订单ID
     * @return 订单信息VO
     */
    OrderInfoVO queryOrderById(Long orderId);
    
    /**
     * 根据订单号查询订单详情
     * 
     * @param orderNo 订单号
     * @return 订单信息VO
     */
    OrderInfoVO queryOrderByNo(String orderNo);
    
    /**
     * 根据会员ID查询订单信息列表
     * 
     * @param vipId 会员ID
     * @return 订单信息VO列表
     */
    List<OrderInfoVO> queryOrderByVipId(Long vipId);
    
    /**
     * 根据床位ID查询未结算的订单信息
     * 
     * @param bedId 床位ID
     * @return 订单信息VO列表
     */
    List<OrderInfoVO> queryUnsettledOrderByBedId(Long bedId);
    
    /**
     * 取消订单
     * 
     * @param orderId 订单ID
     * @return 是否成功
     */
    Boolean cancelOrder(Long orderId);
    
    /**
     * 删除订单
     * 
     * @param orderId 订单ID
     * @return 是否成功
     */
    Boolean removeOrder(Long orderId);
    
    /**
     * 统计订单数量
     * 
     * @param query 查询条件
     * @return 订单数量
     */
    Long countOrderInfo(OrderInfoQuery query);
}