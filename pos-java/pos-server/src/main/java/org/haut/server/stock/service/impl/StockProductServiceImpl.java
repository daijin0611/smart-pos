package org.haut.server.stock.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.server.stock.entity.StockProduct;
import org.haut.server.stock.service.StockProductService;
import org.haut.server.stock.mapper.StockProductMapper;
import org.springframework.stereotype.Service;

/**
 * 库存产品服务实现类
 * 
 * 实现库存产品的业务逻辑处理，包括产品的增删改查、库存管理等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2024/12/19
 */
@Service
public class StockProductServiceImpl extends ServiceImpl<StockProductMapper, StockProduct>
    implements StockProductService {

}