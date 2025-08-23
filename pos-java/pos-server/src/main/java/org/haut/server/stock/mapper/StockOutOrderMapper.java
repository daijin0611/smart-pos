package org.haut.server.stock.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.haut.server.stock.entity.StockOutOrder;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * 出库订单数据访问层
 * 
 * 提供出库订单的基础CRUD操作，继承MyBatis-Plus的BaseMapper
 * 支持出库订单的增删改查、分页查询、状态更新等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 * @Entity org.haut.server.stock.entity.StockOutOrder
 */
@Mapper
public interface StockOutOrderMapper extends BaseMapper<StockOutOrder> {

}