package org.haut.server.order.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.haut.server.order.entity.OrderDetailEntity;

/**
 * 订单明细表Mapper接口
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Mapper
public interface OrderDetailMapper extends BaseMapper<OrderDetailEntity> {
    
}