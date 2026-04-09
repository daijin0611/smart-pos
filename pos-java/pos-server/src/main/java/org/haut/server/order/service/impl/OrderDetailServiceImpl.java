package org.haut.server.order.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.OrderDetailCreateDTO;
import org.haut.common.domain.dto.order.OrderDetailSettleDTO;
import org.haut.common.domain.dto.order.OrderDetailTechnicianDTO;
import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.order.OrderDetailPageQuery;
import org.haut.common.domain.query.server.ServerItemQuery;
import org.haut.common.domain.query.server.ServerProductListQuery;
import org.haut.common.domain.vo.ResultStatus;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.common.domain.vo.server.ServerItemVO;
import org.haut.common.domain.vo.server.ServerProductInfoVO;
import org.haut.common.domain.vo.system.OrgSimpleVO;
import org.haut.common.enums.OrderStatusEnum;
import org.haut.common.enums.ServiceTypeEnum;
import org.haut.common.enums.Status;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.kpi.service.KpiDetailService;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderDetailTechnicianEntity;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.order.mapper.OrderDetailMapper;
import org.haut.server.order.mapper.OrderInfoMapper;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderDetailTechnicianService;
import org.haut.server.server.entity.ServerCureTicket;
import org.haut.server.system.service.SysOrgService;
import org.haut.server.system.service.SysOrgUserService;
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
import java.util.Map;
import java.util.Objects;
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
    private final OrderDetailTechnicianService orderDetailTechnicianService;
    private final SysOrgUserService sysOrgUserService;
    private final SysOrgService sysOrgService;

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
        this.saveOrUpdateBatch(list);

        // 保存技师关联
        for (int i = 0; i < list.size(); i++) {
            OrderDetailEntity entity = list.get(i);
            List<OrderDetailTechnicianDTO> technicians = orderDetails.get(i).getTechnicians();
            orderDetailTechnicianService.saveTechnicians(entity.getId(), technicians);
        }

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

        List<OrderDetailEntity> detailEntities = this.lambdaQuery()
                .eq(OrderDetailEntity::getOrderId, orderId)
                .list();

        List<OrderDetailVO> detailVOs = orderDetailConvert.toVo(detailEntities);

        // 填充技师列表
        fillTechnicians(detailEntities, detailVOs);

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
    public Long addDetails(OrderDetailCreateDTO dto, Long orderId) {
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
        
        // 保存订单明细
        boolean saved = this.save(detailEntity);
        if (!saved) {
            throw new BusinessException("添加订单明细失败");
        }

        // 保存技师关联
        orderDetailTechnicianService.saveTechnicians(detailEntity.getId(), dto.getTechnicians());

        log.info("订单明细添加成功，明细ID：{}，明细编号：{}", detailEntity.getId(), detailEntity.getDetailCode());
        return detailEntity.getId();
    }


    /**
     * 结算订单明细（返回保存后的实体列表）
     * @param order 订单信息
     * @param orderSettleDTO 订单结算信息
     * @return 保存后的订单明细实体列表
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public List<OrderDetailEntity> settleOrderDetailAndReturn(OrderInfoEntity order, OrderSettleDTO orderSettleDTO) {
        log.info("orderCode:{} 开始结算订单明细", order.getOrderCode());
        // 1. 处理库存明细
        List<OrderDetailSettleDTO> orderDetails = orderSettleDTO.getOrderDetails();
        stockOutOrderService.handelOrder(orderDetails);
        log.info("orderCode:{} 处理库存成功订单号", order.getOrderCode());

        // 2. 处理疗程券
        serverCureTicketService.handelOrder(orderDetails, order);
        log.info("orderCode:{} 处理疗程券成功", order.getOrderCode());

        // 3. 保存订单明细（先保存，以便KPI能获取正确的detailId）
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
        log.info("orderCode:{} 订单明细保存成功", order.getOrderCode());

        // 处理业绩提成（使用已保存的明细实体，包含正确的ID）
        kpiDetailService.handelOrder(order, orderSettleDTO, details);
        log.info("orderCode:{} 处理业绩提成成功", order.getOrderCode());

        // 保存/更新技师关联
        for (int i = 0; i < details.size(); i++) {
            OrderDetailEntity entity = details.get(i);
            List<OrderDetailTechnicianDTO> technicians = orderDetails.get(i).getTechnicians();
            if (technicians != null && !technicians.isEmpty()) {
                orderDetailTechnicianService.updateTechnicians(entity.getId(), technicians);
            }
        }

        // 返回保存后的实体列表（包含自动生成的ID）
        return details;
    }

    /**
     * 分页查询订单明细
     * @param query
     * @return
     */
    @Override
    public PageDTO<OrderDetailVO> pageQuery(OrderDetailPageQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        List<Long> orgIds = sysOrgUserService.resolveOrgIds(auth.getUserId(), auth.getOrgId(), query.getOrgIds());
        Page<OrderDetailEntity> page = new Page<>(query.getPageNum(), query.getPageSize());
        LocalDate[] date = query.getDate();

        LambdaQueryChainWrapper<OrderDetailEntity> wrapper = this.lambdaQuery()
                .eq(query.getUserId() != null, OrderDetailEntity::getUserId, query.getUserId())
                .eq(StringUtils.isNotBlank(query.getBusinessCode()), OrderDetailEntity::getBusinessCode, query.getBusinessCode())
                .eq(OrderDetailEntity::getOrderStatus, OrderStatusEnum.SETTLED.getCode())
                .in(OrderDetailEntity::getOrgId, orgIds);

        if (date != null && date.length >= 2) {
            if (date[0] != null) {
                wrapper.ge(OrderDetailEntity::getCreateTime, date[0]);
            }
            if (date[1] != null) {
                wrapper.lt(OrderDetailEntity::getCreateTime, date[1].plusDays(1));
            }
        }

        wrapper.orderByDesc(OrderDetailEntity::getSettledTime).page(page);

        PageDTO<OrderDetailVO> result = PageDTO.create(page, OrderDetailVO.class);

        // 批量填充门店信息
        List<OrderDetailVO> rows = result.getRows();
        if (rows != null && !rows.isEmpty()) {
            Map<Long, OrgSimpleVO> orgMap = sysOrgService.getOrgSimpleMapByIds(
                    page.getRecords().stream()
                            .map(OrderDetailEntity::getOrgId)
                            .filter(Objects::nonNull)
                            .collect(Collectors.toSet()));
            Map<Long, Long> entityIdToOrgId = page.getRecords().stream()
                    .collect(Collectors.toMap(OrderDetailEntity::getId, OrderDetailEntity::getOrgId));
            rows.forEach(vo -> {
                Long orgId = entityIdToOrgId.get(vo.getId());
                if (orgId != null) {
                    OrgSimpleVO org = orgMap.get(orgId);
                    if (org != null) {
                        vo.setOrgId(orgId);
                        vo.setOrgName(org.getOrgName());
                        vo.setOrgCode(org.getOrgCode());
                    }
                }
            });

            // 填充技师列表
            fillTechnicians(page.getRecords(), rows);
        }
        return result;
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateServerType(Long detailId, Integer serverType) {
        if (detailId == null || serverType == null) {
            throw new BusinessException(ResultStatus.PARAMS_INVALID.getMessage());
        }
        
        OrderDetailEntity detail = this.getById(detailId);
        if (detail == null) {
            throw new BusinessException("订单明细不存在");
        }
        
        // 只有服务类型才能有上钟类型，如果不是服务类型则报错或忽略，这里不强制限制。
        // 但我们要检查订单是否是未结算状态(未结算才能修改相关属性)。
        if (!OrderStatusEnum.UNSETTLED.getCode().equals(detail.getOrderStatus())) {
             throw new BusinessException("订单已结算，无法修改上钟类型");
        }
        
        detail.setServerType(serverType);
        boolean updated = this.updateById(detail);
        if (!updated) {
            throw new BusinessException("修改上钟类型失败");
        }
        log.info("修改订单明细上钟类型成功，明细ID：{}，新的上钟类型：{}", detailId, serverType);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateServerEmployee(Long detailId, List<OrderDetailTechnicianDTO> technicians) {
        if (detailId == null) {
            throw new BusinessException("订单明细id不能为空!");
        }
        if(technicians == null || technicians.isEmpty()){
            log.info("服务技师列表修改为空！");
            return;
        }
        OrderDetailEntity detail = this.getById(detailId);
        if (detail == null) {
            throw new BusinessException("订单明细不存在!");
        }

        // 通过订单主表判断是否可修改
        OrderInfoEntity orderInfo = orderInfoMapper.selectById(detail.getOrderId());
        if (orderInfo == null || !OrderStatusEnum.UNSETTLED.getCode().equals(orderInfo.getOrderStatus())) {
            throw new BusinessException("订单已结算，无法修改服务技师");
        }

        orderDetailTechnicianService.updateTechnicians(detailId, technicians);
        log.info("修改订单明细服务技师成功，明细ID：{}，技师数量：{}", detailId, technicians.size());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String deleteDetail(Long detailId) {
        if (detailId == null) {
            throw new BusinessException(ResultStatus.PARAMS_INVALID.getMessage());
        }

        OrderDetailEntity detail = this.getById(detailId);
        if (detail == null) {
            throw new BusinessException("订单明细不存在");
        }

        if (!OrderStatusEnum.UNSETTLED.getCode().equals(detail.getOrderStatus())) {
            throw new BusinessException("订单已结算，无法删除明细");
        }

        boolean removed = this.removeById(detailId);
        if (!removed) {
            throw new BusinessException("删除订单明细失败");
        }
        log.info("删除订单明细成功，明细ID：{}", detailId);
        return "订单明细删除成功";
    }

    @Override
    public OrderDetailEntity calculateDetailPriceInfo(OrderDetailCreateDTO dto) {
        return handelDetail(dto);
    }

    /**
     * 填充订单明细VO的技师列表
     */
    @Override
    public void fillTechnicians(List<OrderDetailEntity> entities, List<OrderDetailVO> vos) {
        if (entities == null || entities.isEmpty()) {
            return;
        }
        List<Long> detailIds = entities.stream()
                .map(OrderDetailEntity::getId)
                .toList();
        List<OrderDetailTechnicianEntity> allTechnicians =
                orderDetailTechnicianService.listByDetailIds(detailIds);
        Map<Long, List<OrderDetailTechnicianDTO>> techMap = allTechnicians.stream()
                .collect(Collectors.groupingBy(
                        OrderDetailTechnicianEntity::getDetailId,
                        Collectors.mapping(
                                e -> new OrderDetailTechnicianDTO()
                                        .setUserId(e.getUserId())
                                        .setUserName(e.getUserName())
                                        .setUserCode(e.getUserCode()),
                                Collectors.toList()
                        )
                ));
        for (int i = 0; i < vos.size(); i++) {
            Long detailId = entities.get(i).getId();
            vos.get(i).setTechnicians(techMap.getOrDefault(detailId, List.of()));
        }
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
                        .setStdPrice(dto.getStdPrice()) // 标准价格
                        .setTruePrice(dto.getTruePrice()) // 实收总价
                        .setVipPrice(item.getVipItemPrice()); // VIP价格
            }
            case PRODUCT -> {
                ServerProduct product = serverProductService.getById(dto.getBid());
                detail.setBusinessName(product.getProductName()) // 业务名称
                        .setStdPrice(dto.getStdPrice()) // 标准价格
                        .setTruePrice(dto.getTruePrice()) // 实收总价
                        .setVipPrice(product.getVipProductPrice()); // VIP价格
            }
            case CURE_TICKET -> {
                ServerCureTicket ticket = serverCureTicketService.getById(dto.getBid());
                detail.setBusinessName(ticket.getName()) // 业务名称
                        .setStdPrice(dto.getStdPrice())// 标准价格
                        .setTruePrice(dto.getTruePrice()) // 实收总价
                        .setVipPrice(dto.getStdPrice()); // 疗程券VIP价格与标准价一致
            }
            default -> throw new BusinessException("未知的业务类型");
        };
        return detail;
    }
}

