package org.haut.server.stock.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.server.stock.entity.StockInItem;
import org.haut.server.stock.service.StockInItemService;
import org.haut.server.stock.mapper.StockInItemMapper;
import org.springframework.stereotype.Service;

/**
 * 入库明细服务实现类
 * 
 * 实现入库明细的业务逻辑处理，包括明细的增删改查、批量操作等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
@Service
public class StockInItemServiceImpl extends ServiceImpl<StockInItemMapper, StockInItem>
    implements StockInItemService {

}