package org.haut.server.stock.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.haut.server.stock.entity.StockProduct;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * 库存产品数据访问层
 * 
 * 提供库存产品的基础CRUD操作，继承MyBatis-Plus的BaseMapper
 * 支持库存产品的增删改查、分页查询等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 * @Entity org.haut.server.stock.entity.StockProduct
 */
@Mapper
public interface StockProductMapper extends BaseMapper<StockProduct> {

}