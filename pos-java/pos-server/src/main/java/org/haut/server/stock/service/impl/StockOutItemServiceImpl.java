package org.haut.server.stock.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.server.stock.entity.StockOutItem;
import org.haut.server.stock.service.StockOutItemService;
import org.haut.server.stock.mapper.StockOutItemMapper;
import org.springframework.stereotype.Service;

/**
 * 出库明细服务实现类
 * 
 * 实现出库明细的业务逻辑处理，包括明细的增删改查、批量操作等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
@Service
public class StockOutItemServiceImpl extends ServiceImpl<StockOutItemMapper, StockOutItem>
    implements StockOutItemService {

}