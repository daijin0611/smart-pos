package org.haut.server.order.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.OrderDetailCreateDTO;
import org.haut.common.domain.dto.order.OrderDetailSettleDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.order.OrderDetailPageQuery;
import org.haut.common.domain.query.server.ServerItemQuery;
import org.haut.common.domain.query.server.ServerProductListQuery;
import org.haut.common.domain.vo.ResultStatus;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.common.domain.vo.server.ServerItemVO;
import org.haut.common.domain.vo.server.ServerProductInfoVO;
import org.haut.common.enums.OrderStatusEnum;
import org.haut.common.enums.ServiceTypeEnum;
import org.haut.common.enums.Status;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.kpi.service.KpiDetailService;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.order.mapper.OrderDetailMapper;
import org.haut.server.order.mapper.OrderInfoMapper;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.server.entity.ServerCureTicket;
import org.haut.server.server.entity.ServerItem;
import org.haut.server.server.entity.ServerProduct;
import org.haut.server.server.service.ServerCureTicketService;
import org.haut.server.server.service.ServerItemService;
import org.haut.server.server.service.ServerProductService;
import org.haut.server.stock.service.StockOutOrderService;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;


@Mapper(componentModel = "spring")
interface OrderDetailConvert {
    OrderDetailEntity toEntity(OrderDetailCreateDTO dto);
    OrderDetailEntity toEntity(OrderDetailSettleDTO dto);
    List<OrderDetailVO> toVo(List<OrderDetailEntity> entityList);
}

/**
 * 订单明细服务实现类
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class OrderDetailServiceImpl extends ServiceImpl<OrderDetailMapper, OrderDetailEntity> implements OrderDetailService {
    private final OrderInfoMapper orderInfoMapper;
    private final OrderDetailConvert orderDetailConvert;
    private final ServerItemService serverItemService;
    private final ServerProductService serverProductService;
    private final ServerCureTicketService serverCureTicketService;
    private final StockOutOrderService stockOutOrderService;
    private final KpiDetailService kpiDetailService;

    /**
     * 创建订单明细
     * @param orderDetails 订单明细
     * @param orderId 订单ID
     * @return 订单明细列表
     */
    @Override
    @Transactional
    public List<OrderDetailVO> createOrderDetails(List<OrderDetailCreateDTO> orderDetails, Long orderId) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        if (orderId == null)
            throw new BusinessException(ResultStatus.PARAMS_INVALID.getMessage());
        OrderInfoEntity orderInfo = orderInfoMapper.selectById(orderId);
        if (orderInfo == null)
            throw new BusinessException("订单不存在");

        List<OrderDetailEntity> list = orderDetails.stream()
                .map(e -> this.handelDetail(e)
                        .setDetailCode(CodeUtils.generateByTime(PrefixConst.ORDER_DETAIL))
                        .setOrderId(orderId)
                        .setOrderCode(orderInfo.getOrderCode())
                        .setOrderStatus(OrderStatusEnum.UNSETTLED.getCode())
                        .setOrgId(auth.getOrgId()))
                .toList();
        this.saveBatch(list);
        return orderDetailConvert.toVo(list);
    }
    
    /**
     * 根据订单ID查询订单明细列表
     *
     * @param orderId 订单ID
     * @return 订单明细列表
     */
    @Override
    public List<OrderDetailVO> queryByOrderId(Long orderId) {
        log.info("查询订单明细列表，订单ID：{}", orderId);
        
        if (orderId == null) {
            throw new BusinessException("订单ID不能为空");
        }
        
        // 使用MyBatis Plus的LambdaQueryWrapper进行查询
        List<OrderDetailEntity> detailEntities = this.lambdaQuery()
                .eq(OrderDetailEntity::getOrderId, orderId)
                .list();
        
        // 转换为VO对象
        List<OrderDetailVO> detailVOs = orderDetailConvert.toVo(detailEntities);
        
        log.info("查询到订单明细数量：{}", detailVOs.size());
        return detailVOs;
    }

    /**
     * 添加订单明细
     * @param dto 订单明细DTO
     * @param orderId 订单ID
     * @return 操作结果信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String addDetails(OrderDetailCreateDTO dto, Long orderId) {
        log.info("添加订单明细，订单ID：{}，明细信息：{}", orderId, dto);
        
        // 参数校验
        if (orderId == null) {
            throw new BusinessException("订单ID不能为空");
        }
        if (dto == null) {
            throw new BusinessException("订单明细信息不能为空");
        }
        
        // 获取当前用户信息
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        
        // 检查订单是否存在
        OrderInfoEntity orderInfo = orderInfoMapper.selectById(orderId);
        if (orderInfo == null) {
            throw new BusinessException("订单不存在");
        }
        
        // 检查订单状态是否允许添加明细（只有未结算的订单才能添加明细）
        if (!OrderStatusEnum.UNSETTLED.getCode().equals(orderInfo.getOrderStatus())) {
            throw new BusinessException("订单已结算，无法添加明细");
        }
        
        // 处理订单明细信息
        OrderDetailEntity detailEntity = handelDetail(dto)
                .setDetailCode(CodeUtils.generateByTime(PrefixConst.ORDER_DETAIL))
                .setOrderId(orderId)
                .setOrderCode(orderInfo.getOrderCode())
                .setOrderStatus(OrderStatusEnum.UNSETTLED.getCode())
                .setOrgId(auth.getOrgId());
        
        // 设置实际单价为0（结算前为0，结算时统一计算折扣）
        detailEntity.setTruePrice(BigDecimal.ZERO);
        
        // 保存订单明细
        boolean saved = this.save(detailEntity);
        if (!saved) {
            throw new BusinessException("添加订单明细失败");
        }
        
        log.info("订单明细添加成功，明细编号：{}", detailEntity.getDetailCode());
        return "订单明细添加成功";
    }

    /**
     * 结算订单明细
     * @param order 订单信息
     * @param orderDetails 待结算订单明细
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void settleOrderDetail(OrderInfoEntity order, List<OrderDetailSettleDTO> orderDetails) {
        log.info("orderCode:{} 开始结算订单明细", order.getOrderCode());
        // 处理库存明细
        stockOutOrderService.handelOrder(orderDetails);
        log.info("orderCode:{} 处理库存成功订单号", order.getOrderCode());
        // 处理疗程券
        serverCureTicketService.handelOrder(orderDetails, order);
        log.info("orderCode:{} 处理疗程券成功", order.getOrderCode());
        // 处理业绩提成
        kpiDetailService.handelOrder(order, orderDetails);
        log.info("orderCode:{} 处理疗业绩提成成功", order.getOrderCode());
        // 删除开单时的明细，具体订单明细由结算时决定
        lambdaUpdate().eq(OrderDetailEntity::getOrderCode, order.getOrderCode()).remove();
        log.info("orderCode:{} 删除暂存订单明细成功", order.getOrderCode());
        // 保存订单明细
        List<OrderDetailEntity> details = orderDetails.stream()
                .map(e -> orderDetailConvert.toEntity(e)
                        .setOrderCode(order.getOrderCode())
                        .setDetailCode(StringUtils.isBlank(e.getDetailCode()) ?
                                CodeUtils.generateByTime(PrefixConst.ORDER_DETAIL) : e.getDetailCode())
                        .setOrderId(order.getId())
                        .setSettledTime(order.getSettleTime())
                        .setOrderStatus(order.getOrderStatus())
                        .setOrgId(order.getOrgId()))
                .toList();

        // 更新或者保存订单明细
        saveOrUpdateBatch(details);
        log.info("orderCode:{} 订单明细处理成功", order.getOrderCode());
    }

    /**
     * 分页查询订单明细
     * @param query
     * @return
     */
    @Override
    public PageDTO<OrderDetailVO> pageQuery(OrderDetailPageQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Page<OrderDetailEntity> page = new Page<>(query.getPageNum(), query.getPageSize());
        LocalDate[] date = query.getDate();

        lambdaQuery().eq(query.getUserId() != null, OrderDetailEntity::getUserId, query.getUserId())
                .eq(StringUtils.isNotBlank(query.getBusinessCode()), OrderDetailEntity::getBusinessCode, query.getBusinessCode())
                .eq(OrderDetailEntity::getOrderStatus, OrderStatusEnum.SETTLED.getCode())
                .between(date != null && date.length >= 2 && date[0] != null && date[1] != null, 
                        OrderDetailEntity::getCreateTime, date != null && date.length >= 2 ? date[0] : null,
                        date != null && date.length >= 2 ? date[1] : null)
                .eq(OrderDetailEntity::getOrgId, auth.getOrgId())
                .orderByDesc(OrderDetailEntity::getSettledTime)
                .page(page);
        return PageDTO.create(page, OrderDetailVO.class);
    }

    /**
     * 根据不同业务类型处理订单业务信息
     * @param dto 订单明细DTO
     * @return 订单明细VO
     */
    private OrderDetailEntity handelDetail(OrderDetailCreateDTO dto){
        Integer detailType = dto.getDetailType();
        ServiceTypeEnum type = ServiceTypeEnum.getByValue(detailType);
        OrderDetailEntity detail = orderDetailConvert.toEntity(dto);
        switch (type){
            case SERVER -> {
                ServerItem item = serverItemService.getById(dto.getBid());
                detail.setBusinessName(item.getItemName()) // 业务名称
                        .setStdPrice(item.getItemPrice()) // 标准价格
                        .setTruePrice(item.getItemPrice()); // 实际单价，这里先使用标准价格，后续会根据折扣规则计算
            }
            case PRODUCT -> {
                ServerProduct product = serverProductService.getById(dto.getBid());
                detail.setBusinessName(product.getProductName()) // 业务名称
                        .setStdPrice(product.getProductPrice()) // 标准价格
                        .setTruePrice(product.getProductPrice()); // 实际单价
            }
            case CURE_TICKET -> {
                ServerCureTicket ticket = serverCureTicketService.getById(dto.getBid());
                detail.setBusinessName(ticket.getName()) // 业务名称
                        .setStdPrice(ticket.getPrice())
                        .setTruePrice(ticket.getPrice()); // 标准价格
            }
            default -> throw new BusinessException("未知的业务类型");
        };
        return detail;
    }
}