package org.haut.server.order.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.order.CreateOrderDetailDTO;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.mapper.OrderDetailMapper;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.server.entity.ServerCureTicket;
import org.haut.server.server.entity.ServerProduct;
import org.haut.server.server.service.ServerCureTicketService;
import org.haut.server.server.service.ServerProductService;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring")
interface OrderDetailConvert {
    OrderDetailEntity toEntity(CreateOrderDetailDTO dto);
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

    private final OrderDetailConvert orderDetailConvert;
    private final ServerProductService serverProductService;
    private final ServerCureTicketService serverCureTicketService;
    
    @Override
    public List<OrderDetailVO> queryDetailByOrderId(Long orderId) {
        List<OrderDetailEntity> entities = baseMapper.queryByOrderId(orderId);
        return entities.stream().map(this::convertToVO).collect(Collectors.toList());
    }
    
    @Override
    public List<OrderDetailEntity> queryDetailEntityByOrderId(Long orderId) {
        return baseMapper.queryByOrderId(orderId);
    }
    
    @Override
    public List<OrderDetailVO> queryDetailByOrderCode(String orderCode) {
        List<OrderDetailEntity> entities = baseMapper.queryByOrderCode(orderCode);
        return entities.stream().map(this::convertToVO).collect(Collectors.toList());
    }
    
    @Override
    public List<OrderDetailVO> queryDetailByTypeAndBid(Integer detailType, Long bid) {
        List<OrderDetailEntity> entities = baseMapper.queryByDetailTypeAndBid(detailType, bid);
        return entities.stream().map(this::convertToVO).collect(Collectors.toList());
    }
    
    @Override
    public List<OrderDetailVO> queryDetailByUserId(Long userId) {
        List<OrderDetailEntity> entities = baseMapper.queryByUserId(userId);
        return entities.stream().map(this::convertToVO).collect(Collectors.toList());
    }
    
    @Override
    public Boolean addOrderDetailBatch(List<OrderDetailEntity> orderDetails) {
        if (CollUtil.isEmpty(orderDetails)) {
            return true;
        }
        return baseMapper.batchInsert(orderDetails) > 0;
    }
    
    @Override
    public Boolean removeDetailByOrderId(Long orderId) {
        return baseMapper.deleteByOrderId(orderId) >= 0;
    }
    
    @Override
    public Boolean updateSettledTimeByOrderId(Long orderId) {
        return baseMapper.updateSettledTimeByOrderId(orderId) >= 0;
    }
    
    @Override
    public Long countDetailByOrderId(Long orderId) {
        return baseMapper.countByOrderId(orderId);
    }
    
    /**
     * 转换为VO
     */
    private OrderDetailVO convertToVO(OrderDetailEntity entity) {
        OrderDetailVO vo = new OrderDetailVO();
        BeanUtil.copyProperties(entity, vo);
        
        // 设置业务类型名称
        vo.setDetailTypeName(getDetailTypeName(entity.getDetailType()));
        
        // 设置上钟类型名称
        vo.setServerTypeName(getServerTypeName(entity.getServerType()));
        
        // 计算小计金额
        if (entity.getTruePrice() != null && entity.getQuantity() != null) {
            vo.setSubtotalAmount(entity.getTruePrice().multiply(new BigDecimal(entity.getQuantity())));
        }
        
        // 根据业务类型设置业务名称和编码
        setBusinessInfo(vo, entity);
        
        return vo;
    }
    
    /**
     * 设置业务信息（名称和编码）
     */
    private void setBusinessInfo(OrderDetailVO vo, OrderDetailEntity entity) {
        if (entity.getDetailType() == null || entity.getBid() == null) {
            return;
        }
        
        switch (entity.getDetailType()) {
            case 0: // 产品
                ServerProduct product = serverProductService.getById(entity.getBid());
                if (product != null) {
                    vo.setBusinessName(product.getProductName());
                    vo.setBusinessCode(product.getProductEncode());
                }
                break;
            case 1: // 服务
                // TODO: 根据实际服务表设置服务名称和编码
                vo.setBusinessName("服务项目");
                vo.setBusinessCode("SRV" + entity.getBid());
                break;
            case 2: // 疗程券
                ServerCureTicket cureTicket = serverCureTicketService.getById(entity.getBid());
                if (cureTicket != null) {
                    vo.setBusinessName(cureTicket.getName());
                    vo.setBusinessCode(cureTicket.getEncode());
                }
                break;
            default:
                vo.setBusinessName("未知业务");
                vo.setBusinessCode("UNK" + entity.getBid());
                break;
        }
    }
    
    /**
     * 获取业务类型名称
     */
    private String getDetailTypeName(Integer detailType) {
        if (detailType == null) return "未知";
        switch (detailType) {
            case 0: return "产品";
            case 1: return "服务";
            case 2: return "疗程券";
            default: return "未知";
        }
    }
    
    /**
     * 获取上钟类型名称
     */
    private String getServerTypeName(Integer serverType) {
        if (serverType == null) return "";
        switch (serverType) {
            case 0: return "点钟";
            case 1: return "加钟";
            case 2: return "轮牌";
            default: return "";
        }
    }

}