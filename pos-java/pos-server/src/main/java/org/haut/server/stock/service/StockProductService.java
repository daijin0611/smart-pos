package org.haut.server.stock.service;

import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.entity.stock.StockProduct;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.query.stock.StockProductPageQuery;
import org.haut.common.domain.vo.stock.StockProductVO;

/**
 * 库存产品服务接口
 * 
 * 提供库存产品的业务逻辑处理，包括产品的增删改查、库存管理等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
public interface StockProductService extends IService<StockProduct> {

    PageDTO<StockProductVO> queryPage(StockProductPageQuery query);
}