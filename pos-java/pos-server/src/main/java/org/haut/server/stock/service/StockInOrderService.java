package org.haut.server.stock.service;

import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.stock.StockInOrderCreateDTO;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockInOrderVO;
import org.haut.server.stock.entity.StockInOrder;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 入库订单服务接口
 * 
 * 提供入库订单的业务逻辑处理，包括订单的创建、审核、完成等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
public interface StockInOrderService extends IService<StockInOrder> {

    void addOrder(StockInOrderCreateDTO dto);

    PageDTO<StockInOrderVO> queryPage(StockOrderQuery query);

    StockInOrderVO getOneByCode(String orderCode);


}