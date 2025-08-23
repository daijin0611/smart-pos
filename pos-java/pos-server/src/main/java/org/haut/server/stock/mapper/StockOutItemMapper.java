package org.haut.server.stock.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.haut.server.stock.entity.StockOutItem;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * 出库明细数据访问层
 * 
 * 提供出库明细的基础CRUD操作，继承MyBatis-Plus的BaseMapper
 * 支持出库明细的增删改查、批量操作等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
@Mapper
public interface StockOutItemMapper extends BaseMapper<StockOutItem> {

}