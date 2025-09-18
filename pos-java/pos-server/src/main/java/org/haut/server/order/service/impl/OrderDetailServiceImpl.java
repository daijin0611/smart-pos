package org.haut.server.order.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.order.OrderDetailCreateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.vo.ResultStatus;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.common.enums.OrderStatusEnum;
import org.haut.common.enums.ServiceTypeEnum;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
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
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;


@Mapper(componentModel = "spring")
interface OrderDetailConvert {
    OrderDetailEntity toEntity(OrderDetailCreateDTO dto);
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
                        .setOrderStatus(OrderStatusEnum.UNSETTLED.getCode()))
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
                        .setTruePrice(item.getVipItemPrice()); // 实际单价
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
                        .setStdPrice(ticket.getPrice()) // 标准价格
                        .setTruePrice(ticket.getPrice()); // 实际单价
            }
            default -> throw new BusinessException("未知的业务类型");
        };
        return detail;
    }
}