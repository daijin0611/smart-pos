package org.haut.server.stock.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.constant.Const;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.stock.StockInOrderCreateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockInOrderVO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.server.mapper.ServerProductMapper;
import org.haut.server.stock.entity.StockInItem;
import org.haut.server.stock.entity.StockInOrder;
import org.haut.server.stock.entity.StockLog;
import org.haut.server.stock.entity.StockProduct;
import org.haut.server.stock.mapper.StockInItemMapper;
import org.haut.server.stock.mapper.StockLogMapper;
import org.haut.server.stock.mapper.StockProductMapper;
import org.haut.server.stock.service.StockInOrderService;
import org.haut.server.stock.mapper.StockInOrderMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

/**
 * 入库订单服务实现类
 * 
 * 实现入库订单的业务逻辑处理，包括订单的创建、审核、完成等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class StockInOrderServiceImpl extends ServiceImpl<StockInOrderMapper, StockInOrder>
    implements StockInOrderService {
    private final ServerProductMapper serverProductMapper;
    private final StockInItemMapper stockInItemMapper;
    private final StockProductMapper stockProductMapper;
    private final StockLogMapper stockLogMapper;
    /**
     * 添加入库订单
     * @param dto
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addOrder(StockInOrderCreateDTO dto) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        String orderCode = CodeUtils.generateByTime(PrefixConst.STOCK_IN_ORDER);

        // 先创建入库单
        StockInOrder order = BeanUtil.toBean(dto, StockInOrder.class);
        order.setOrgId(auth.getOrgId());
        order.setOrderCode(orderCode);
        this.save(order);

        // 创建入库明细
        List<StockInItem> stockInItems = BeanUtil.copyToList(dto.getItems(), StockInItem.class);
        stockInItems.forEach(item -> {
            item.setInOrderCode(orderCode);
            item.setOrgId(auth.getOrgId());
            item.setInOrderId(order.getId());
        });
        stockInItemMapper.insert(stockInItems);

        // 更新库存
        List<Long> productIds = stockInItems.stream().map(StockInItem::getProductId).toList();
        LambdaQueryWrapper<StockProduct> queryWrapper = Wrappers.lambdaQuery(StockProduct.class)
            .eq(StockProduct::getOrgId, auth.getOrgId())
            .in(StockProduct::getProductId, productIds);
        List<StockProduct> stockProducts = stockProductMapper.selectList(queryWrapper);
        // 将入库明细的数量累加到库存产品中
        for (StockInItem item : stockInItems) {
            boolean found = false;
            for (StockProduct stockProduct : stockProducts) {
                // 如果库存产品的ID与入库明细的产品ID匹配，则累加数量
                if (stockProduct.getProductId().equals(item.getProductId())) {
                    int currentQuantity = stockProduct.getQuantity();
                    int addedQuantity = item.getQuantity();
                    stockProduct.setQuantity(stockProduct.getQuantity() + item.getQuantity());
                    int newQuantity = currentQuantity + addedQuantity;
                    found = true;
                    log.info("添加前数量{}\n，添加数量：{}\n，添加后数量：{}\n", currentQuantity, addedQuantity, newQuantity);
                }
            }
            if (!found) {
                // 如果没有找到对应的库存产品，则创建一个新的库存产品
                StockProduct newStockProduct = new StockProduct();
                newStockProduct.setQuantity(item.getQuantity());
                newStockProduct.setOrgId(auth.getOrgId());
                newStockProduct.setProductId(item.getProductId());
                stockProducts.add(newStockProduct);
                log.info("新建库存产品，产品ID：{}，数量：{}", item.getProductId(), item.getQuantity());
            }
        }
        stockProductMapper.insertOrUpdate(stockProducts);

        // 记录入库订单创建日志
        List<StockLog> stockLogs = BeanUtil.copyToList(stockInItems, StockLog.class);
        stockLogs.forEach(log -> {
            log.setOrgId(auth.getOrgId());
            log.setOrderCode(orderCode);
            log.setOrderType(Const.STOCK_IN);
            log.setOperator(dto.getOperator());
            BigDecimal totalPrice = log.getPrice().multiply(BigDecimal.valueOf(log.getQuantity()));
            log.setTotalPrice(totalPrice);
        });
        stockLogMapper.insert(stockLogs);
        log.info("入库订单创建成功，订单号：{}", orderCode);
    }

    /**
     * 查询入库订单分页列表
     * @param query
     * @return
     */
    @Override
    public Page<StockInOrderVO> queryPage(StockOrderQuery query) {

        return null;
    }
}