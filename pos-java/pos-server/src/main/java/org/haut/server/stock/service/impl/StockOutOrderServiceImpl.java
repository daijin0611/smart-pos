package org.haut.server.stock.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.server.stock.entity.StockOutOrder;
import org.haut.server.stock.service.StockOutOrderService;
import org.haut.server.stock.mapper.StockOutOrderMapper;
import org.springframework.stereotype.Service;

/**
 * 出库订单服务实现类
 * 
 * 实现出库订单的业务逻辑处理，包括订单的创建、审核、完成等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
@Service
public class StockOutOrderServiceImpl extends ServiceImpl<StockOutOrderMapper, StockOutOrder>
    implements StockOutOrderService {

}