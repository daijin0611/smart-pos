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
import java.security.Provider;
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
        String orderNo = CodeUtils.generateByTime(PrefixConst.ORDER);

        OrderInfoEntity orderInfo = orderConvert.toEntity(createOrderDTO);
        orderInfo.setOrderNo(orderNo)
                .setOrderTime(new Date())
                .setOrderStatus(OrderStatusEnum.UNSETTLED.getCode())// 1-未结算
                .setOrgId(auth.getOrgId());

        this.save(orderInfo);
        
        List<OrderDetailEntity> orderDetails = createOrderDetails(createOrderDTO.getOrderDetails(), orderInfo.getId(), orderNo);
        orderDetailService.saveBatch(orderDetails);
        
        log.info("订单创建成功，订单号：{}", orderNo);
        return orderConvert.toVO(orderInfo)
                .setOrderDetailVOList(BeanUtil.copyToList(orderDetails, OrderDetailVO.class));
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public OrderInfoVO settleOrder(SettleOrderDTO settleOrderDTO) {
        log.info("开始结算订单，请求参数：{}", settleOrderDTO);
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        VipInfo vipInfo = vipInfoService.getById(settleOrderDTO.getVipId());
        // 1. 查询订单信息
        OrderInfoEntity orderInfo = this.getById(settleOrderDTO.getOrderId());
        if (orderInfo == null) {
            throw new BusinessException("订单不存在");
        }
        if (orderInfo.getOrderStatus() != 0) {
            throw new BusinessException("订单状态异常，无法结算");
        }
        // 2. 处理相关信息
        handelOrderDetails(settleOrderDTO.getOrderDetails(), vipInfo);

        
        // 3. 更新订单明细结算时间
        orderDetailService.updateSettledTimeByOrderId(settleOrderDTO.getOrderId());
        
        // 4. 处理会员余额扣减（如果使用会员余额支付）
//        if (orderInfo.getVipId() != null && settleOrderDTO.getVipBalance() != null) {
//            processVipBalanceDeduction(orderInfo.getVipId(), settleOrderDTO.getVipBalance());
//        }
        
        // 5. 处理库存扣减（结算后创建出库单）
        List<OrderDetailEntity> orderDetailList = orderDetailService.queryDetailEntityByOrderId(settleOrderDTO.getOrderId());
        processInventoryDeductionAfterSettle(orderDetailList, orderInfo.getOrderNo());


        orderInfo.setSettleTime(LocalDateTime.now())
                .setTotalAmount(settleOrderDTO.getTotalAmount())
                .setActualAmount(settleOrderDTO.getActualAmount())
                .setDiscountAmount(settleOrderDTO.getDiscountAmount())
                .setOrderStatus(OrderStatusEnum.SETTLED.getCode()); // 1-已结算


        this.updateById(orderInfo);
        log.info("订单结算成功，订单ID：{}", settleOrderDTO.getOrderId());
        return queryOrderById(settleOrderDTO.getOrderId());
    }
    
    @Override
    public IPage<OrderInfoVO> queryOrderInfoPage(Page<OrderInfoEntity> page, OrderInfoQuery query) {
        IPage<OrderInfoEntity> entityPage = baseMapper.queryOrderInfoPage(page, query);
        return entityPage.convert(this::convertToVO);
    }
    
    @Override
    public List<OrderInfoVO> queryOrderInfoList(OrderInfoQuery query) {
        List<OrderInfoEntity> entities = baseMapper.queryOrderInfoList(query);
        return entities.stream().map(this::convertToVO).collect(Collectors.toList());
    }
    
    @Override
    public OrderInfoVO queryOrderById(Long orderId) {
        OrderInfoEntity entity = this.getById(orderId);
        if (entity == null) {
            return null;
        }
        return convertToVOWithDetails(entity);
    }
    
    @Override
    public OrderInfoVO queryOrderByNo(String orderNo) {
        OrderInfoEntity entity = baseMapper.queryByOrderNo(orderNo);
        if (entity == null) {
            return null;
        }
        return convertToVOWithDetails(entity);
    }
    
    @Override
    public List<OrderInfoVO> queryOrderByVipId(Long vipId) {
        List<OrderInfoEntity> entities = baseMapper.queryByVipId(vipId);
        return entities.stream().map(this::convertToVO).collect(Collectors.toList());
    }
    
    @Override
    public List<OrderInfoVO> queryUnsettledOrderByBedId(Long bedId) {
        List<OrderInfoEntity> entities = baseMapper.queryUnsettledByBedId(bedId);
        return entities.stream().map(this::convertToVO).collect(Collectors.toList());
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean cancelOrder(Long orderId) {
        OrderInfoEntity orderInfo = this.getById(orderId);
        if (orderInfo == null) {
            throw new BusinessException("订单不存在");
        }
        
        if (orderInfo.getOrderStatus() != 0) {
            throw new BusinessException("只能取消未结算的订单");
        }
        
        // 更新订单状态为已取消
        orderInfo.setOrderStatus(2).setUpdateTime(new Date());
        return this.updateById(orderInfo);
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean removeOrder(Long orderId) {
        // 删除订单明细
        orderDetailService.removeDetailByOrderId(orderId);
        // 删除订单主表
        return this.removeById(orderId);
    }
    
    @Override
    public Long countOrderInfo(OrderInfoQuery query) {
        return baseMapper.countOrderInfo(query);
    }
    
    /**
     * 验证订单明细
     */
    private void handelOrderDetails(List<CreateOrderDetailDTO> orderDetails, VipInfo vipInfo) {
        for (CreateOrderDetailDTO detail : orderDetails) {
            if (detail.getDetailType().equals(ServiceTypeEnum.PRODUCT.getValue())) { // 产品类型
                ServerProduct product = serverProductService.getById(detail.getBid());
                if (product == null) {
                    throw new BusinessException("产品不存在");
                }
                if (product.getQuantity() < detail.getQuantity()) {
                    throw new BusinessException("产品库存不足");
                }
            } else if (detail.getDetailType() == 2) { // 疗程券类型
                if (vipInfo == null) {
                    throw new BusinessException("疗程券销售需要会员信息");
                }
            }
        }
    }

    /**
     * 处理会员券
     * @param dto
     */
    private void handelTicket(SettleOrderDTO dto){
        Map<Object, Object> ticketMap = vipInfoTicketService.getBaseMapper().selectByIds(dto.getTicketIds())
                .stream().collect(Collectors.toMap(
                        VipInfoTicket::getId,
                        ticket -> ticket
                ));
        List<CreateOrderDetailDTO> orderDetails = dto.getOrderDetails()
                .stream()
                .filter(detail -> detail.getDetailType().equals(ServiceTypeEnum.SERVER.getValue()))
                .toList();
        for (Long ticketId : dto.getTicketIds()){
            if (!ticketMap.containsKey(ticketId))
                throw new BusinessException("会员券不存在");
            VipInfoTicket ticket = (VipInfoTicket) ticketMap.get(ticketId);

            if (ticket.getStatus().equals(TicketStatusEnum.USED.getStatus())){
                throw new BusinessException("会员券已使用");
            }else {
                vipInfoTicketService.lambdaUpdate()
                        .eq(VipInfoTicket::getId, ticketId)
                        .set(VipInfoTicket::getStatus, TicketStatusEnum.USED.getStatus())
                        .update();
            }

        }

    }
    
    /**
     * 完善订单明细
     */
    private List<OrderDetailEntity> createOrderDetails(List<CreateOrderDetailDTO> detailDTOs, Long orderId, String orderNo) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        List<OrderDetailEntity> orderDetails = new ArrayList<>();
        for (CreateOrderDetailDTO detailDTO : detailDTOs) {
            OrderDetailEntity detail = new OrderDetailEntity();
            BeanUtil.copyProperties(detailDTO, detail);
            detail.setDetailCode(CodeUtils.generateByTime(PrefixConst.ORDER_DETAIL))
                    .setOrderId(orderId)
                    .setOrderCode(orderNo)
                    .setOrderStatus(OrderStatusEnum.UNSETTLED.getCode())
                    .setOrgId(auth.getOrgId());
            orderDetails.add(detail);
        }
        return orderDetails;
    }
    
    /**
     * 处理库存扣减
     */
    private void processInventoryDeduction(List<CreateOrderDetailDTO> orderDetails) {
        // 汇总产品型明细
        List<CreateOrderDetailDTO> productDetails = orderDetails.stream()
                .filter(d -> d.getDetailType().equals(ServiceTypeEnum.PRODUCT.getValue()))
                .toList();
        if (productDetails.isEmpty()) {
            return;
        }

        // 组装出库单
        BigDecimal totalPrice = productDetails.stream()
                .map(d -> d.getStdPrice().multiply(new BigDecimal(d.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        StockOutOrderCreateDTO dto = new StockOutOrderCreateDTO();
        dto.setTotalPrice(totalPrice);
        dto.setOperator("order");
        dto.setRemark("订单销售出库");

        List<StockOutOrderCreateDTO.StockOutItemCreateDTO> items = productDetails.stream().map(d -> {
            StockOutOrderCreateDTO.StockOutItemCreateDTO item = new StockOutOrderCreateDTO.StockOutItemCreateDTO();
            item.setProductId(d.getBid());
            item.setQuantity(d.getQuantity());
            item.setPrice(d.getStdPrice());
            item.setRemark(d.getRemark());
            return item;
        }).collect(Collectors.toList());
        dto.setItems(items);

        // 创建出库单（内部已完成库存扣减与日志记录）
        stockOutOrderService.addOrder(dto);
    }
    
    /**
     * 处理结算后的库存扣减
     */
    private void processInventoryDeductionAfterSettle(List<OrderDetailEntity> orderDetails, String orderNo) {
        // 汇总产品型明细
        List<OrderDetailEntity> productDetails = orderDetails.stream()
                .filter(d -> d.getDetailType().equals(ServiceTypeEnum.PRODUCT.getValue()))
                .toList();
        if (productDetails.isEmpty()) {
            return;
        }

        // 组装出库单
        BigDecimal totalPrice = productDetails.stream()
                .map(d -> d.getTruePrice().multiply(new BigDecimal(d.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        StockOutOrderCreateDTO dto = new StockOutOrderCreateDTO();
        dto.setTotalPrice(totalPrice);
        dto.setOperator("order");
        dto.setRemark("订单结算出库 - " + orderNo);

        List<StockOutOrderCreateDTO.StockOutItemCreateDTO> items = productDetails.stream().map(d -> {
            StockOutOrderCreateDTO.StockOutItemCreateDTO item = new StockOutOrderCreateDTO.StockOutItemCreateDTO();
            item.setProductId(d.getBid());
            item.setQuantity(d.getQuantity());
            item.setPrice(d.getTruePrice());
            item.setRemark(d.getRemark());
            return item;
        }).collect(Collectors.toList());
        dto.setItems(items);

        // 创建出库单（内部已完成库存扣减与日志记录）
        stockOutOrderService.addOrder(dto);
    }
    
    /**
     * 处理会员余额扣减
     */
    private void processVipBalanceDeduction(Long vipId, BigDecimal newBalance) {
        VipInfo vipInfo = vipInfoService.getById(vipId);
        if (vipInfo != null) {
            vipInfo.setBalance(newBalance);
            vipInfoService.updateById(vipInfo);
        }
    }

    /**
     * 转换为VO（不包含明细）
     */
    private OrderInfoVO convertToVO(OrderInfoEntity entity) {
        OrderInfoVO vo = new OrderInfoVO();
        BeanUtil.copyProperties(entity, vo);
        
        // 设置状态名称
        vo.setOrderStatusName(getOrderStatusName(entity.getOrderStatus()));
        vo.setCustomerTypeName(getCustomerTypeName(entity.getCustomerType()));
        
        return vo;
    }
    
    /**
     * 转换为VO（包含明细）
     */
    private OrderInfoVO convertToVOWithDetails(OrderInfoEntity entity) {
        OrderInfoVO vo = convertToVO(entity);
        
        // 查询订单明细
        List<OrderDetailVO> orderDetails = orderDetailService.queryDetailByOrderId(entity.getId());
        vo.setOrderDetails(orderDetails);
        
        return vo;
    }
    
    /**
     * 获取订单状态名称
     */
    private String getOrderStatusName(Integer orderStatus) {
        if (orderStatus == null) return "未知";
        switch (orderStatus) {
            case 0: return "未结算";
            case 1: return "已结算";
            case 2: return "已取消";
            default: return "未知";
        }
    }
    
    /**
     * 获取顾客类型名称
     */
    private String getCustomerTypeName(Integer customerType) {
        if (customerType == null) return "未知";
        switch (customerType) {
            case 0: return "会员";
            case 1: return "散客";
            default: return "未知";
        }
    }
}