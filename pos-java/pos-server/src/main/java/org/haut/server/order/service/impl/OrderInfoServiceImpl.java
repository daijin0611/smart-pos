package org.haut.server.order.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.OrderCreateDTO;

import org.haut.common.domain.dto.order.OrderRollBackDTO;
import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.dto.order.OrderReconcileDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.order.OrderPageQuery;
import org.haut.common.domain.vo.order.OrderCreateVO;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.common.domain.vo.order.PaymentVO;
import org.haut.common.domain.vo.order.OrderReceiptVO;
import org.haut.common.domain.vo.order.ReceiptItemVO;
import org.haut.common.enums.*;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.kpi.entity.KpiDetail;
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
import org.haut.server.vip.entity.VipInfo;
import org.haut.server.vip.service.VipInfoService;
import org.haut.server.vip.service.VipInfoTicketService;
import org.haut.server.vip.service.VipAssetService;
import org.haut.server.vip.entity.VipAsset;
import org.haut.server.vip.entity.VipInfoTicket;
import org.haut.server.stock.service.StockInOrderService;
import org.haut.common.domain.dto.stock.StockInOrderCreateDTO;
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
    private final VipAssetService vipAssetService;
    private final StockInOrderService stockInOrderService;



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
     *
     * @param settleOrderDTO 结算订单请求DTO
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long settleOrder(OrderSettleDTO settleOrderDTO) {
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
        return order.getId();
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

        OrderInfoVO orderInfoVO = buildOrderInfoVO(orderInfo);
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

        // 检查订单状态
        if (OrderStatusEnum.CANCELLED.getCode().equals(orderInfo.getOrderStatus())) {
            throw new BusinessException("订单已取消，请勿重复操作");
        }
        if (!OrderStatusEnum.UNSETTLED.getCode().equals(orderInfo.getOrderStatus())) {
            throw new BusinessException("只有未结算的订单才能取消");
        }

        // 更新订单状态为已取消
        orderInfo.setOrderStatus(OrderStatusEnum.CANCELLED.getCode());
        this.updateById(orderInfo);

        // 更新订单明细状态为已取消
        orderDetailService.lambdaUpdate()
                .eq(OrderDetailEntity::getOrderId, orderId)
                .set(OrderDetailEntity::getOrderStatus, OrderStatusEnum.CANCELLED.getCode())
                .update();

        log.info("订单取消成功，订单编号：{}", orderInfo.getOrderCode());

        // 更新床位状态
        if (orderInfo.getBedId() != null) {
            roomBedService.lambdaUpdate()
                    .eq(RoomBed::getId, orderInfo.getBedId())
                    .set(RoomBed::getStatus, BedStatusEnum.FREE.getCode())
                    .update();
        }
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
     * 构建订单信息VO
     * @param orderInfo 订单实体
     * @return 订单信息VO
     */
    private OrderInfoVO buildOrderInfoVO(OrderInfoEntity orderInfo) {
        // 转换为VO对象
        OrderInfoVO orderInfoVO = orderConvert.toInfoVO(orderInfo);

        // 设置枚举字段名称
        if (orderInfo.getOrderStatus() != null) {
            orderInfoVO.setOrderStatusName(OrderStatusEnum.getMessageByCode(orderInfo.getOrderStatus()));
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

        // 查询该床位下最新的订单信息
        OrderInfoEntity orderInfo = baseMapper.queryLatestByBedId(bedId, auth.getOrgId());

        if (orderInfo == null) {
            log.info("床位ID：{} 下没有订单", bedId);
            return null;
        }

        // 检查订单状态，只有未结算的订单才返回
        if (!OrderStatusEnum.UNSETTLED.getCode().equals(orderInfo.getOrderStatus())) {
            log.info("床位ID：{} 最新的订单不是未结算状态，状态：{}", bedId, orderInfo.getOrderStatus());
            return null;
        }

        OrderInfoVO orderInfoVO = buildOrderInfoVO(orderInfo);

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
        return buildOrderInfoVO(orderInfo);
    }

    /**
     * 订单冲正
     *
     * 功能点：
     * - 订单状态/明细状态：已结算 -> 已冲正
     * - 回滚员工业绩（删除本订单产生的KPI明细）
     * - 回滚支付信息（支付明细标记为已冲正）
     * - 会员资产回滚（退还会员卡支付的金额、恢复会员余额）
     * - 优惠券回滚（恢复本订单使用的优惠券为未使用，取消本订单新增的疗程券）
     * - 回滚产品库存（按订单中商品明细生成入库单）
     *
     * @param dto 订单冲正请求对象
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void rollBackOrder(OrderRollBackDTO dto) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        OrderInfoEntity order = getById(dto.getOrderId());
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        if (!OrderStatusEnum.SETTLED.getCode().equals(order.getOrderStatus())) {
            throw new BusinessException("订单不可冲正");
        }

        String orderCode = order.getOrderCode();

        // 1) 更新订单与明细为已冲正
        lambdaUpdate()
                .eq(OrderInfoEntity::getOrderCode, orderCode)
                .set(OrderInfoEntity::getOrderStatus, OrderStatusEnum.ROLLBACK.getCode())
                .set(OrderInfoEntity::getRemark, buildRollbackRemark(order.getRemark(), dto.getReason(), orderCode))
                .update();

        orderDetailService.lambdaUpdate()
                .eq(OrderDetailEntity::getOrderCode, orderCode)
                .set(OrderDetailEntity::getOrderStatus, OrderStatusEnum.ROLLBACK.getCode())
                .update();

        // 2) 回滚支付信息：标记为已冲正
        paymentDetailService.lambdaUpdate()
                .eq(PaymentDetail::getActiveCode, orderCode)
                .eq(PaymentDetail::getOrgId, auth.getOrgId())
                .set(PaymentDetail::getPaymentStatus, PaymentStatusEnum.ROLLBACK.getStatus())
                .update();

        // 3) 会员相关资产回滚（会员卡余额、优惠券）
        if (order.getVipId() != null) {
            // 3.1 退还会员卡支付金额
            List<PaymentDetail> assetPays = paymentDetailService.lambdaQuery()
                    .eq(PaymentDetail::getActiveCode, orderCode)
                    .eq(PaymentDetail::getOrgId, auth.getOrgId())
                    .eq(PaymentDetail::getPaymentType, Integer.parseInt(PaymentTypeEnum.ASSET.getCode()))
                    .list();

            if (assetPays != null && !assetPays.isEmpty()) {
                Map<String, BigDecimal> refundMap = new HashMap<>();
                for (PaymentDetail p : assetPays) {
                    if (p.getAssetCode() == null || p.getTotalAmount() == null) continue;
                    refundMap.merge(p.getAssetCode(), p.getTotalAmount(), BigDecimal::add);
                }
                if (!refundMap.isEmpty()) {
                    List<VipAsset> assets = vipAssetService.lambdaQuery()
                            .in(VipAsset::getAssetNum, refundMap.keySet())
                            .list();
                    for (VipAsset asset : assets) {
                        BigDecimal add = refundMap.getOrDefault(asset.getAssetNum(), BigDecimal.ZERO);
                        asset.setAssetBalance(asset.getAssetBalance() == null ? add : asset.getAssetBalance().add(add));
                    }
                    if (!assets.isEmpty()) {
                        vipAssetService.saveOrUpdateBatch(assets);
                        BigDecimal afterBalance = vipInfoService.updateVipBalance(order.getVipId());
                        lambdaUpdate()
                                .eq(OrderInfoEntity::getId, order.getId())
                                .set(OrderInfoEntity::getAfterBalance, afterBalance)
                                .update();
                    }
                }
            }

            // 3.2 恢复本订单使用的优惠券为未使用
            vipInfoTicketService.lambdaUpdate()
                    .eq(VipInfoTicket::getUsedOrderCode, orderCode)
                    .set(VipInfoTicket::getStatus, TicketStatusEnum.UNUSED.getStatus())
                    .update();

            // 3.3 取消本订单新增的疗程券（购买疗程券场景）
            vipInfoTicketService.lambdaUpdate()
                    .eq(VipInfoTicket::getSourceCode, orderCode)
                    .remove();
        }

        // 4) 回滚员工业绩：删除本订单KPI明细
        kpiDetailService.lambdaUpdate()
                .eq(KpiDetail::getOrderCode, orderCode)
                .set(KpiDetail::getRemark, "冲正")
                .remove();

        // 5) 回滚产品库存：将商品明细数量入库
        List<OrderDetailEntity> details = orderDetailService.lambdaQuery()
                .eq(OrderDetailEntity::getOrderCode, orderCode)
                .list();
        if (details != null && !details.isEmpty()) {
            List<OrderDetailEntity> productDetails = details.stream()
                    .filter(d -> ServiceTypeEnum.PRODUCT.getValue().equals(d.getDetailType()))
                    .toList();
            if (!productDetails.isEmpty()) {
                BigDecimal totalPrice = productDetails.stream()
                        .map(d -> d.getStdPrice() == null ? BigDecimal.ZERO : d.getStdPrice())
                        .reduce(BigDecimal.ZERO, BigDecimal::add);
                List<StockInOrderCreateDTO.StockInItemCreateDTO> items = productDetails.stream()
                        .map(d -> new StockInOrderCreateDTO.StockInItemCreateDTO()
                                .setProductId(d.getBid())
                                .setQuantity(d.getQuantity() == null ? 0 : d.getQuantity())
                                .setPrice(d.getStdPrice() == null ? BigDecimal.ZERO : d.getStdPrice())
                                .setRemark("订单冲正入库"))
                        .toList();
                StockInOrderCreateDTO inOrder = new StockInOrderCreateDTO()
                        .setOperator(auth.getUserName())
                        .setRemark("订单" + orderCode + "冲正入库")
                        .setTotalPrice(totalPrice)
                        .setItems(items);
                stockInOrderService.addOrder(inOrder);
            }
        }

        log.info("订单冲正完成，订单编号：{}", orderCode);
    }

    /**
     * 构造订单冲正备注标识
     * @param original 原始备注
     * @param reason   冲正原因
     * @param orderCode 订单编号
     * @return 组合备注
     */
    private String buildRollbackRemark(String original, String reason, String orderCode) {
        String base = original == null ? "" : original;
        String r = reason == null ? "" : (" " + reason.trim());
        return base + r + " [ROLLBACK]" + "[ORDER:" + orderCode + "]";
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
                .setCustomerName(StringUtils.isEmpty(dto.getCustomerName())?vipInfo.getName():dto.getCustomerName())
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

    /**
     * 根据订单ID返回小票信息
     * @param orderId 订单ID
     * @return 小票信息
     */
    @Override
    public OrderReceiptVO getReceiptByOrderId(Long orderId) {
        OrderInfoEntity orderInfo = this.getById(orderId);
        if (orderInfo == null) {
            throw new BusinessException("订单不存在");
        }
        // 明细
        List<OrderDetailVO> details = orderDetailService.queryByOrderId(orderId);
        List<ReceiptItemVO> items = details.stream().map(d -> {
            java.math.BigDecimal qty = new java.math.BigDecimal(d.getQuantity() == null ? 0 : d.getQuantity());
            java.math.BigDecimal price = d.getTruePrice() == null ? java.math.BigDecimal.ZERO : d.getTruePrice();
            java.math.BigDecimal amount = price.multiply(qty);
            return new ReceiptItemVO()
                    .setItemName(d.getBusinessName())
                    .setTechnicianName(d.getUserName())
                    .setQuantity(d.getQuantity())
                    .setStdPrice(d.getStdPrice())
                    .setTruePrice(d.getTruePrice())
                    .setAmount(amount)
                    .setServerTypeName(serverTypeName(d.getServerType()));
        }).toList();

        // 支付
        List<PaymentDetail> payments = paymentDetailService.lambdaQuery()
                .eq(PaymentDetail::getActiveCode, orderInfo.getOrderCode())
                .eq(PaymentDetail::getOrgId, orderInfo.getOrgId())
                .list();
        List<PaymentVO> paymentVOS = cn.hutool.core.bean.BeanUtil.copyToList(payments, PaymentVO.class);

        // 组装小票
        return new OrderReceiptVO()
                .setOrderCode(orderInfo.getOrderCode())
                .setOrderTime(orderInfo.getOrderTime())
                .setSettleTime(orderInfo.getSettleTime())
                .setBedName(orderInfo.getBedName())
                .setCashierName(orderInfo.getUserName())
                .setCustomerName(orderInfo.getCustomerName())
                .setTotalAmount(orderInfo.getTotalAmount())
                .setActualAmount(orderInfo.getActualAmount())
                .setDiscountAmount(orderInfo.getDiscountAmount())
                .setItems(items)
                .setPayments(paymentVOS);
    }

    /**
     * 上钟类型名称映射
     * @param type 上钟类型值
     * @return 名称
     */
    private String serverTypeName(Integer type) {
        if (type == null) return null;
        return switch (type) {
            case 0 -> "点钟";
            case 1 -> "加钟";
            case 2 -> "轮牌";
            default -> null;
        };
    }

    /**
     * 订单对单处理
     * - 更新订单状态为已对单
     * - 更新订单备注，包含对单标识
     * 
     * @param dto 对单请求对象
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void reconcileOrder(OrderReconcileDTO dto) {
        log.info("开始订单对单，订单ID：{}", dto.getOrderId());
        // 载入订单
        OrderInfoEntity order = this.getById(dto.getOrderId());
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        // 必须是已结算订单
        if (!OrderStatusEnum.SETTLED.getCode().equals(order.getOrderStatus())) {
            throw new BusinessException("仅支持对已结算订单进行对单");
        }
        // 更新状态以及备注
        lambdaUpdate().eq(OrderInfoEntity::getId, dto.getOrderId())
                        .set(OrderInfoEntity::getOrderStatus, OrderStatusEnum.RECONCILED.getCode())
                        .set(OrderInfoEntity::getRemark, buildReconciledRemark(order.getRemark(), dto.getRemark()))
                        .update();

        log.info("订单对单完成，订单编号：{}", order.getOrderCode());
    }

    /**
     * 构造已对单备注标识
     * @param original 原始备注
     * @param append 追加备注
     * @return 组合后的备注，包含已对单标记
     */
    private String buildReconciledRemark(String original, String append) {
        String base = original == null ? "" : original;
        String extra = append == null ? "" : (" " + append.trim());
        return base + extra + " [已对单]";
    }
}
