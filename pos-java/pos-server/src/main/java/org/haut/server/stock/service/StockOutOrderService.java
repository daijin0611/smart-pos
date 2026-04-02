package org.haut.server.stock.service;

import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.OrderDetailSettleDTO;
import org.haut.common.domain.dto.stock.StockOutOrderCreateDTO;
import org.haut.server.stock.entity.StockOutOrder;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockOutOrderVO;

import java.util.List;

/**
 * 出库订单服务接口
 * 
 * 提供出库订单的业务逻辑处理，包括订单的创建、审核、完成等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
public interface StockOutOrderService extends IService<StockOutOrder> {

    PageDTO<StockOutOrderVO> queryPage(StockOrderQuery query);

    void addOrder(StockOutOrderCreateDTO dto);

    StockOutOrderVO getOneByCode(String orderCode);

    /**
     * 处理订单
     * @param productDetails 结算订单明细
     */
    void handelOrder(List<OrderDetailSettleDTO> productDetails);
}