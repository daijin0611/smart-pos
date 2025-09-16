package org.haut.server.order.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.order.CreateOrderDTO;
import org.haut.common.domain.dto.order.CreateOrderDetailDTO;
import org.haut.common.domain.dto.order.SettleOrderDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.order.OrderInfoQuery;
import org.haut.common.domain.vo.order.OrderCreateVO;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.common.enums.CustomerTypeEnum;
import org.haut.common.enums.OrderStatusEnum;
import org.haut.common.enums.ServiceTypeEnum;
import org.haut.common.enums.TicketStatusEnum;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.order.mapper.OrderInfoMapper;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderInfoService;
import org.haut.server.server.entity.ServerProduct;
import org.haut.server.server.service.ServerProductService;
import org.haut.server.stock.service.StockOutOrderService;
import org.haut.common.domain.dto.stock.StockOutOrderCreateDTO;
import org.haut.server.vip.entity.VipInfo;
import org.haut.server.vip.entity.VipInfoTicket;
import org.haut.server.vip.service.VipInfoService;
import org.haut.server.vip.service.VipInfoTicketService;
import org.haut.server.vip.service.VipTicketService;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring")
interface OrderConvert {
    OrderInfoEntity toEntity(CreateOrderDTO dto);
    OrderCreateVO toVO(OrderInfoEntity entity);
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
    public OrderCreateVO addOrderWithBed(CreateOrderDTO createOrderDTO) {
        log.info("开始创建订单，请求参数：{}", createOrderDTO);
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        VipInfo vipInfo = vipInfoService.getById(createOrderDTO.getVipId());
        boolean isVip = createOrderDTO.getCustomerType().equals(CustomerTypeEnum.VIP.getValue());
        if (vipInfo == null && isVip)
            throw  new BusinessException("会员信息不存在！");
        String orderNo = CodeUtils.generateByTime(PrefixConst.ORDER);

        // 创建订单
        OrderInfoEntity orderInfo = orderConvert.toEntity(createOrderDTO)
                .setVipCardNumber(isVip ? vipInfo.getCardNumber() : null)
                .setVipPhoneNumber(isVip ? vipInfo.getPhoneNumber() : null)
                .setVipName(isVip ? vipInfo.getName() : null)
                .setOrderCode(orderNo)
                .setOrderTime(new Date())
                .setOrderStatus(OrderStatusEnum.UNSETTLED.getCode())// 1-未结算
                .setOrgId(auth.getOrgId());
        this.save(orderInfo);

        // 创建订单明细
        List<OrderDetailEntity> orderDetails = createOrderDetails(createOrderDTO.getOrderDetails(), orderInfo.getId(), orderNo);
        orderDetailService.saveBatch(orderDetails);

        log.info("订单创建成功，订单号：{}", orderNo);
        return orderConvert.toVO(orderInfo)
                .setOrderDetailVOList(BeanUtil.copyToList(orderDetails, OrderDetailVO.class));
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public OrderInfoVO settleOrder(SettleOrderDTO settleOrderDTO) {
        return null;
    }


    /**
     * 创建订单明细
     * @param orderDetails
     * @param orderId
     * @param orderNo
     * @return
     */
    private List<OrderDetailEntity> createOrderDetails(List<CreateOrderDetailDTO> orderDetails, Long orderId, String orderNo){
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        return orderDetails.stream()
                .map(orderDetail ->
                    BeanUtil.toBean(orderDetail, OrderDetailEntity.class)
                            .setOrderId(orderId)
                            .setOrderCode(orderNo)
                            .setOrderStatus(OrderStatusEnum.UNSETTLED.getCode())
                            .setOrgId(auth.getOrgId())
                            .setDetailCode(CodeUtils.generateByTime(PrefixConst.ORDER_DETAIL)))
                .toList();
    }
}