package org.haut.server.order.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.OrderCreateDTO;

import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.order.OrderPageQuery;
import org.haut.common.domain.vo.order.OrderCreateVO;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.common.domain.vo.order.PaymentVO;
import org.haut.common.enums.BedStatusEnum;
import org.haut.common.enums.CustomerTypeEnum;
import org.haut.common.enums.OrderStatusEnum;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.kpi.service.KpiDetailService;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.order.mapper.OrderInfoMapper;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderInfoService;
import org.haut.server.payment.entity.PaymentDetail;
import org.haut.server.payment.service.PaymentDetailService;
import org.haut.server.room.entity.RoomBed;
import org.haut.server.room.service.RoomBedService;
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

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

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
    private final VipInfoService vipInfoService;
    private final OrderConvert orderConvert;
    private final VipInfoTicketService vipInfoTicketService;
    private final PaymentDetailService paymentDetailService;
    private final KpiDetailService kpiDetailService;
    private final RoomBedService roomBedService;



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
        orderDetailService.createOrderDetails(createOrderDTO.getOrderDetails(), orderInfo.getId());
        log.info("订单创建成功，订单号：{}", orderNo);

        // 更新床位状态
        roomBedService.lambdaUpdate()
                .eq(RoomBed::getId, orderInfo.getBedId())
                .set(RoomBed::getStatus, BedStatusEnum.USING.getCode())
                        .update();
        log.info("床位{}更新状态为:{}", orderInfo.getBedName(), BedStatusEnum.USING.getCode());
        return orderConvert.toCreateVO(orderInfo);
    }

    /**
     * 结算订单信息
     * @param settleOrderDTO 结算订单请求DTO
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void settleOrder(OrderSettleDTO settleOrderDTO) {
        // 校验会员信息
        VipInfo vipInfo = vipInfoService.getById(settleOrderDTO.getVipId());
        if (vipInfo == null && settleOrderDTO.getCustomerType().equals(CustomerTypeEnum.VIP.getValue()))
            throw new BusinessException("会员不存在");
        else if (vipInfo == null)
            vipInfo = new VipInfo();
        // 结算订单
        OrderInfoEntity order = initOrderInfo(settleOrderDTO,vipInfo);
        saveOrUpdate(order);
        // 更新床位状态为空闲
        roomBedService.lambdaUpdate()
                .eq(RoomBed::getId, order.getBedId())
                .set(RoomBed::getStatus, BedStatusEnum.FREE.getCode())
                .update();
        log.info("床位{}状态已更新为空闲", order.getBedName());
        // 结算订单明细
        orderDetailService.settleOrderDetail(order,settleOrderDTO.getDetails());
        log.info("订单明细结算完成");
        // 结算支付信息
        paymentDetailService.handelOrder(settleOrderDTO, order.getOrderCode());
        log.info("支付信息结算成功");
        // 结算会员优惠券
        vipInfoTicketService.handelOrder(settleOrderDTO, order.getOrderCode());
        log.info("会员优惠券结算成功");
        // 更新会员余额
        BigDecimal afterBalance = vipInfoService.updateVipBalance(vipInfo.getId());
        lambdaUpdate()
                .eq(OrderInfoEntity::getId, order.getId())
                .set(OrderInfoEntity::getAfterBalance, afterBalance)
                .update();
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
                    orderInfoVO.setCustomerName(orderInfo.getCustomerName());
                    break;
                }
            }
        }
        
        // 查询订单明细
        List<OrderDetailVO> orderDetails = orderDetailService.queryByOrderId(orderId);
        orderInfoVO.setOrderDetails(orderDetails);
        // 查询支付信息
        List<PaymentDetail> payments = paymentDetailService.lambdaQuery()
                .eq(PaymentDetail::getActiveCode, orderInfo.getOrderCode())
                .list();
        List<PaymentVO> paymentVOS = BeanUtil.copyToList(payments, PaymentVO.class);
        orderInfoVO.setPayments(paymentVOS);
        log.info("订单查询成功，订单编号：{}", orderInfo.getOrderCode());
        return orderInfoVO;
    }

    /**
     * 取消订单
     * @param orderId 订单ID
     * @return 订单取消结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String cancelOrder(Long orderId) {
        log.info("开始取消订单，订单ID：{}", orderId);
        
        // 查询订单信息
        OrderInfoEntity orderInfo = this.getById(orderId);
        if (orderInfo == null) {
            throw new BusinessException("订单不存在");
        }
        
        // 检查订单状态，只有未结算的订单才能取消
        if (!OrderStatusEnum.UNSETTLED.getCode().equals(orderInfo.getOrderStatus())) {
            throw new BusinessException("只有未结算的订单才能取消");
        }
        
        // 更新订单状态为已取消
        orderInfo.setOrderStatus(OrderStatusEnum.CANCELLED.getCode());
        this.updateById(orderInfo);
        
        // 更新订单明细状态为已取消
        List<OrderDetailEntity> orderDetails = orderDetailService.lambdaQuery()
                .eq(OrderDetailEntity::getOrderId, orderId)
                .list();
        
        if (orderDetails != null && !orderDetails.isEmpty()) {
            List<OrderDetailEntity> updatedDetails = new ArrayList<>();
            for (OrderDetailEntity detail : orderDetails) {
                detail.setOrderStatus(OrderStatusEnum.CANCELLED.getCode());
                updatedDetails.add(detail);
            }
            orderDetailService.updateBatchById(updatedDetails);
        }
        
        log.info("订单取消成功，订单编号：{}", orderInfo.getOrderCode());

        // 更新床位状态
        roomBedService.lambdaUpdate()
                .eq(RoomBed::getId, orderInfo.getBedId())
                .set(RoomBed::getStatus, BedStatusEnum.FREE.getCode());
        return "订单取消成功";
    }

    /**
     * 分页查询订单信息
     * @param query 查询参数
     * @return 分页结果 - 订单信息VO列表
     */
    @Override
    public PageDTO<OrderInfoVO> pageQuery(OrderPageQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        query.setOrgId(auth.getOrgId());
        Page<OrderInfoVO> page = Page.of(query.getPageNum(), query.getPageSize());
        IPage<OrderInfoVO> result = baseMapper.pageQuery(page,query);
        
        List<OrderInfoVO> records = result.getRecords();
        if (records.isEmpty()) {
            return PageDTO.create(result, OrderInfoVO.class);
        }
        
        // 批量查询订单明细
        List<Long> orderIds = records.stream().map(OrderInfoVO::getId).collect(Collectors.toList());
        List<OrderDetailEntity> allOrderDetails = orderDetailService.lambdaQuery()
                .in(OrderDetailEntity::getOrderId, orderIds)
                .list();
        
        // 转换为VO对象 - 使用BeanUtil进行转换
        List<OrderDetailVO> orderDetailVOs = allOrderDetails.stream()
                .map(entity -> BeanUtil.toBean(entity, OrderDetailVO.class))
                .collect(Collectors.toList());
        
        // 按订单ID分组订单明细
        Map<Long, List<OrderDetailVO>> orderDetailMap = orderDetailVOs.stream()
                .collect(Collectors.groupingBy(OrderDetailVO::getOrderId));
        
        // 批量查询支付信息
        List<String> orderCodes = records.stream().map(OrderInfoVO::getOrderCode).collect(Collectors.toList());
        List<PaymentDetail> allPayments = paymentDetailService.lambdaQuery()
                .in(PaymentDetail::getActiveCode, orderCodes)
                .eq(PaymentDetail::getOrgId, auth.getOrgId())
                .list();
        List<PaymentVO> paymentVOs = BeanUtil.copyToList(allPayments, PaymentVO.class);
        
        // 按订单编码分组支付信息
        Map<String, List<PaymentVO>> paymentMap = paymentVOs.stream()
                .collect(Collectors.groupingBy(PaymentVO::getActiveCode));
        
        // 为每个订单设置关联数据
        records.forEach(orderInfoVO -> {
            // 设置订单状态名称
            orderInfoVO.setOrderStatusName(OrderStatusEnum.getMessageByCode(orderInfoVO.getOrderStatus()));
            
            // 设置订单明细
            List<OrderDetailVO> orderDetails = orderDetailMap.getOrDefault(orderInfoVO.getId(), new ArrayList<>());
            orderInfoVO.setOrderDetails(orderDetails);
            
            // 设置支付信息
            List<PaymentVO> payments = paymentMap.getOrDefault(orderInfoVO.getOrderCode(), new ArrayList<>());
            orderInfoVO.setPayments(payments);
        });
        
        return PageDTO.create(result, OrderInfoVO.class);
    }

    /**
     * 根据床位查询订单信息
     * @param bedId 床位ID
     * @return 订单信息VO
     */
    @Override
    public OrderInfoVO queryByBedId(Long bedId) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        log.info("根据床位ID查询订单信息，床位ID：{}", bedId);
        
        if (bedId == null) {
            throw new BusinessException("床位ID不能为空");
        }
        
        // 查询该床位下未结算的订单信息
        List<OrderInfoEntity> orderInfoList = baseMapper.queryUnsettledByBedId(bedId,auth.getOrgId());
        
        if (orderInfoList == null || orderInfoList.isEmpty()) {
            log.info("床位ID：{} 下没有未结算的订单", bedId);
            return null;
        }
        
        // 取第一个未结算的订单（按创建时间倒序，最新的订单）
        OrderInfoEntity orderInfo = orderInfoList.get(0);
        
        // 转换为VO对象
        OrderInfoVO orderInfoVO = orderConvert.toInfoVO(orderInfo);
        
        // 设置枚举字段名称
        if (orderInfo.getOrderStatus() != null) {
            orderInfoVO.setOrderStatusName(OrderStatusEnum.getMessageByCode(orderInfo.getOrderStatus()));
        }
        
        if (orderInfo.getCustomerType() != null) {
            for (CustomerTypeEnum customerType : CustomerTypeEnum.values()) {
                if (customerType.getValue().equals(orderInfo.getCustomerType())) {
                    orderInfoVO.setCustomerName(orderInfo.getCustomerName());
                    break;
                }
            }
        }
        
        // 查询订单明细
        List<OrderDetailVO> orderDetails = orderDetailService.queryByOrderId(orderInfo.getId());
        orderInfoVO.setOrderDetails(orderDetails);
        
        // 查询支付信息
        List<PaymentDetail> payments = paymentDetailService.lambdaQuery()
                .eq(PaymentDetail::getActiveCode, orderInfo.getOrderCode())
                .eq(PaymentDetail::getOrgId, orderInfo.getOrgId())
                .list();
        List<PaymentVO> paymentVOS = BeanUtil.copyToList(payments, PaymentVO.class);
        orderInfoVO.setPayments(paymentVOS);
        
        log.info("根据床位ID查询订单成功，订单编号：{}", orderInfo.getOrderCode());
        return orderInfoVO;
    }

    /**
     * 根据订单编号查询订单信息
     * @param orderCode 订单编号
     * @return 订单信息VO
     */
    @Override
    public OrderInfoVO queryByOrderCode(String orderCode) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        log.info("根据订单编号查询订单信息，订单编号：{}", orderCode);
        OrderInfoEntity orderInfo = lambdaQuery().eq(OrderInfoEntity::getOrderCode, orderCode)
                .one();
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
                    orderInfoVO.setCustomerName(orderInfo.getCustomerName());
                    break;
                }
            }
        }
        
        // 查询订单明细
        List<OrderDetailVO> orderDetails = orderDetailService.queryByOrderId(orderInfo.getId());
        orderInfoVO.setOrderDetails(orderDetails);
        
        // 查询支付信息
        List<PaymentDetail> payments = paymentDetailService.lambdaQuery()
                .eq(PaymentDetail::getActiveCode, orderInfo.getOrderCode())
                .eq(PaymentDetail::getOrgId, orderInfo.getOrgId())
                .list();
        List<PaymentVO> paymentVOS = BeanUtil.copyToList(payments, PaymentVO.class);
        orderInfoVO.setPayments(paymentVOS);
        return orderInfoVO;
    }


    /**
     * 初始化一个结算订单
     * @param dto
     * @return
     */
    private OrderInfoEntity initOrderInfo(OrderSettleDTO dto, VipInfo vipInfo) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        OrderInfoEntity order = getById(dto.getOrderId());
        if (order!=null && order.getOrderStatus().equals(OrderStatusEnum.SETTLED.getCode())) {
            throw new BusinessException("订单已结算");
        }
        return new OrderInfoEntity()
                .setId(dto.getOrderId())
                .setRemark(dto.getRemark())
                .setOrderCode(order==null?
                        CodeUtils.generateByTime(PrefixConst.ORDER):order.getOrderCode())
                .setOrderTime(dto.getOrderTime()==null ?
                        new Date():dto.getOrderTime())
                .setOrderStatus(OrderStatusEnum.SETTLED.getCode())
                .setCustomerName(dto.getCustomerName())
                .setCustomerType(dto.getCustomerType())
                .setVipId(vipInfo.getId())
                .setVipPhoneNumber(vipInfo.getPhoneNumber())
                .setVipName(vipInfo.getName())
                .setVipCardNumber(vipInfo.getCardNumber())
                .setBeforeBalance(vipInfo.getBalance())
                .setAfterBalance(Optional.ofNullable(vipInfo.getBalance())
                                        .map(e->e.subtract(dto.getActualAmount()))
                                                .orElse(BigDecimal.ZERO))
                .setSettleTime(new Date())
                .setTotalAmount(dto.getTotalAmount())
                .setActualAmount(dto.getActualAmount())
                .setDiscountAmount(dto.getDiscountAmount())
                .setBedId(dto.getBedId())
                .setBedName(dto.getBedName())
                .setUserId(auth.getUserId())
                .setUserName(auth.getUserName())
                .setOrgId(auth.getOrgId());
    }
}