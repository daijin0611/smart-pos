package org.haut.server.stock.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.haut.server.stock.entity.StockLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * 库存日志数据访问层
 * 
 * 提供库存日志的基础CRUD操作，继承MyBatis-Plus的BaseMapper
 * 支持库存变动记录的查询、统计分析等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
@Mapper
public interface StockLogMapper extends BaseMapper<StockLog> {

}