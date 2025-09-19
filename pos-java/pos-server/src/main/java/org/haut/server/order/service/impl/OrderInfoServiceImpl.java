package org.haut.server.order.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.order.OrderCreateDTO;

import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.vo.order.OrderCreateVO;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.common.enums.CustomerTypeEnum;
import org.haut.common.enums.OrderStatusEnum;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.order.mapper.OrderInfoMapper;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderInfoService;
import org.haut.server.server.service.ServerProductService;
import org.haut.server.stock.service.StockOutOrderService;
import org.haut.server.vip.entity.VipInfo;
import org.haut.server.vip.service.VipInfoService;
import org.haut.server.vip.service.VipInfoTicketService;
import org.haut.server.vip.service.VipTicketService;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Mapper(componentModel = "spring")
interface OrderConvert {
    OrderInfoEntity toEntity(OrderCreateDTO dto);
    @Mapping(target = "orderId", source = "id")
    OrderCreateVO toCreateVO(OrderInfoEntity entity);
    OrderInfoVO toInfoVO(OrderInfoEntity entity);
}

/**
 * 订单信息服务实现类
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class OrderInfoServiceImpl extends ServiceImpl<OrderInfoMapper, OrderInfoEntity> implements OrderInfoService {
    
    private final OrderDetailService orderDetailService;
    private final ServerProductService serverProductService;
    private final StockOutOrderService stockOutOrderService;
    private final VipInfoService vipInfoService;
    private final OrderConvert orderConvert;
    private final VipTicketService vipTicketService;
    private final VipInfoTicketService vipInfoTicketService;
    /**
     * 床态界面创建订单信息
     *
     * @param createOrderDTO 创建订单请求DTO
     * @return 创建订单响应VO
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public OrderCreateVO addOrderWithBed(OrderCreateDTO createOrderDTO) {
        log.info("开始创建订单，请求参数：{}", createOrderDTO);
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        VipInfo vipInfo = vipInfoService.getById(createOrderDTO.getVipId());
        boolean isVip = createOrderDTO.getCustomerType().equals(CustomerTypeEnum.VIP.getValue());
        if (vipInfo == null && isVip)
            throw new BusinessException("会员信息不存在！");
        String orderNo = CodeUtils.generateByTime(PrefixConst.ORDER);

        // 创建订单信息
        OrderInfoEntity orderInfo = orderConvert.toEntity(createOrderDTO)
                .setVipCardNumber(isVip ? vipInfo.getCardNumber() : null)
                .setVipPhoneNumber(isVip ? vipInfo.getPhoneNumber() : null)
                .setVipName(isVip ? vipInfo.getName() : null)
                .setCustomerName(isVip ? vipInfo.getName() : createOrderDTO.getCustomerName())
                .setOrderCode(orderNo)
                .setOrderTime(new Date())
                .setOrderStatus(OrderStatusEnum.UNSETTLED.getCode())// 1-未结算
                .setOrgId(auth.getOrgId());
        this.save(orderInfo);

        // 创建订单明细
        List<OrderDetailVO> orderDetailVOS = orderDetailService.createOrderDetails(createOrderDTO.getOrderDetails(), orderInfo.getId());

        log.info("订单创建成功，订单号：{}", orderNo);
        return orderConvert.toCreateVO(orderInfo);
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public OrderInfoVO settleOrder(OrderSettleDTO settleOrderDTO) {
        return null;
    }
    
    /**
     * 根据订单ID查询订单信息
     *
     * @param orderId 订单ID
     * @return 订单信息VO
     */
    @Override
    public OrderInfoVO queryById(Long orderId) {
        log.info("查询订单信息，订单ID：{}", orderId);
        
        if (orderId == null) {
            throw new BusinessException("订单ID不能为空");
        }
        
        // 查询订单基本信息
        OrderInfoEntity orderInfo = this.getById(orderId);
        if (orderInfo == null) {
            throw new BusinessException("订单不存在");
        }
        
        // 转换为VO对象
        OrderInfoVO orderInfoVO = orderConvert.toInfoVO(orderInfo);
        
        // 设置枚举字段名称
        if (orderInfo.getOrderStatus() != null) {
            orderInfoVO.setOrderStatusName(OrderStatusEnum.getMessageByCode(orderInfo.getOrderStatus()));
        }
        
        if (orderInfo.getCustomerType() != null) {
            for (CustomerTypeEnum customerType : CustomerTypeEnum.values()) {
                if (customerType.getValue().equals(orderInfo.getCustomerType())) {
                    orderInfoVO.setCustomerTypeName(customerType.getType());
                    break;
                }
            }
        }
        
        // 查询订单明细
        List<OrderDetailVO> orderDetails = orderDetailService.queryByOrderId(orderId);
        orderInfoVO.setOrderDetails(orderDetails);
        
        log.info("订单查询成功，订单编号：{}", orderInfo.getOrderCode());
        return orderInfoVO;
    }

}