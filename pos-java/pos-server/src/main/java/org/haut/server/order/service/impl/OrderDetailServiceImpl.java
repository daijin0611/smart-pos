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

}