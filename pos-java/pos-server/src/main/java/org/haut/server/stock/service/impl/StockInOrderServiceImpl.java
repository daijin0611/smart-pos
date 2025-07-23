package org.haut.server.stock.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.server.stock.entity.StockInOrder;
import org.haut.server.stock.service.StockInOrderService;
import org.haut.server.stock.mapper.StockInOrderMapper;
import org.springframework.stereotype.Service;

/**
 * 入库订单服务实现类
 * 
 * 实现入库订单的业务逻辑处理，包括订单的创建、审核、完成等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2024/12/19
 */
@Service
public class StockInOrderServiceImpl extends ServiceImpl<StockInOrderMapper, StockInOrder>
    implements StockInOrderService {

}