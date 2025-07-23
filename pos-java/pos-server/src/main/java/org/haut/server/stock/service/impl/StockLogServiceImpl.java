package org.haut.server.stock.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.server.stock.entity.StockLog;
import org.haut.server.stock.service.StockLogService;
import org.haut.server.stock.mapper.StockLogMapper;
import org.springframework.stereotype.Service;

/**
 * 库存日志服务实现类
 * 
 * 实现库存日志的业务逻辑处理，包括日志的查询、统计分析等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2024/12/19
 */
@Service
public class StockLogServiceImpl extends ServiceImpl<StockLogMapper, StockLog>
    implements StockLogService {

}