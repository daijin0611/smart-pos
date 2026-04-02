package org.haut.server.stock.service;

import org.haut.common.domain.dto.PageDTO;
import org.haut.server.stock.entity.StockLog;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockLogVO;

/**
 * 库存日志服务接口
 * 
 * 提供库存日志的业务逻辑处理，包括日志的查询、统计分析等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
public interface StockLogService extends IService<StockLog> {

    PageDTO<StockLogVO> queryPage(StockOrderQuery query);
}