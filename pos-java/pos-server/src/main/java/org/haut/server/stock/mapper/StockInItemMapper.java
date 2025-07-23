package org.haut.server.stock.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.haut.server.stock.entity.StockInItem;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * 入库明细数据访问层
 * 
 * 提供入库明细的基础CRUD操作，继承MyBatis-Plus的BaseMapper
 * 支持入库明细的增删改查、批量操作等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2024/12/19
 */
@Mapper
public interface StockInItemMapper extends BaseMapper<StockInItem> {

}