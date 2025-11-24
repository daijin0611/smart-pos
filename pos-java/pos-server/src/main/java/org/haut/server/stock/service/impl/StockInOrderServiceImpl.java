package org.haut.server.stock.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.executor.BatchResult;
import org.haut.common.constant.Const;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.stock.StockInOrderCreateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockInItemVO;
import org.haut.common.domain.vo.stock.StockInOrderVO;
import org.haut.common.enums.ServiceTypeEnum;
import org.haut.common.enums.Status;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.server.mapper.ServerProductMapper;
import org.haut.server.server.entity.ServerProduct;
import org.haut.server.stock.entity.StockInItem;
import org.haut.server.stock.entity.StockInOrder;
import org.haut.server.stock.entity.StockLog;
import org.haut.server.stock.mapper.StockInItemMapper;
import org.haut.server.stock.mapper.StockLogMapper;
import org.haut.server.stock.service.StockInOrderService;
import org.haut.server.stock.mapper.StockInOrderMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
    private final OrderDetailService orderDetailService;
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

        // 更新库存，顺便完善产品明细信息
        List<ServerProduct> productToUpdate = getProductToUpdate(stockInItems, auth);
        stockInItemMapper.insert(stockInItems);
        List<BatchResult> update = serverProductMapper.updateById(productToUpdate);

        // 如果更新为空，说明没有库存变化，可能触发了乐观锁异常，重新获取产品信息
        if (update.isEmpty()) {
            productToUpdate = getProductToUpdate(stockInItems, auth);
            serverProductMapper.updateById(productToUpdate);
        }


        // 记录入库订单创建日志
        List<StockLog> stockLogs = BeanUtil.copyToList(stockInItems, StockLog.class);
        stockLogs.forEach(log -> {
            log.setOrgId(auth.getOrgId());
            log.setOrderCode(orderCode);
            log.setOrderType(Const.STOCK_IN);
            log.setOperator(dto.getOperator());
            BigDecimal totalPrice = log.getPrice().multiply(BigDecimal.valueOf(log.getQuantity()));
            log.setTotalPrice(totalPrice);
            log.setId(null);
        });
        stockLogMapper.insert(stockLogs);
        log.info("入库订单创建成功，订单号：{}", orderCode);
    }

    /**
     * 查询入库订单分页列表
     *
     * @param query
     * @return
     */
    @Override
    public PageDTO<StockInOrderVO> queryPage(StockOrderQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        LambdaQueryWrapper<StockInOrder> wrapper = Wrappers.lambdaQuery(StockInOrder.class)
                .eq(StockInOrder::getOrgId, auth.getOrgId())
                // 根据订单编号模糊查询
                .like(query.getOrderCode() != null, StockInOrder::getOrderCode, query.getOrderCode())
                // 根据操作员模糊查询
                .like(query.getOperator() != null, StockInOrder::getOperator, query.getOperator())
                // 根据创建时间范围查询
                .ge(query.getStartDate() != null, StockInOrder::getCreateTime, query.getStartDate())
                .le(query.getEndDate() != null, StockInOrder::getCreateTime, query.getEndDate())
                // 按创建时间降序排序
                .orderByDesc(StockInOrder::getCreateTime);

        // 执行分页查询
        Page<StockInOrder> page = this.page(
            new Page<>(query.getPageNum(), query.getPageSize()),
            wrapper
        );
        PageDTO<StockInOrderVO> stockInOrderVOPageDTO = PageDTO.create(page, StockInOrderVO.class);

        List<Long> orderIds = page.getRecords().stream().map(StockInOrder::getId).toList();
        // 查询入库明细
        List<StockInItem> stockInItems = stockInItemMapper.selectList(Wrappers.lambdaQuery(StockInItem.class)
                .in(!orderIds.isEmpty(),StockInItem::getInOrderId, orderIds));
        Map<Long, List<StockInItem>> itemMap = stockInItems.stream()
                .collect(Collectors.groupingBy(StockInItem::getInOrderId));
        stockInOrderVOPageDTO.getRows().forEach(stockInOrderVO -> {
            if (itemMap.containsKey(stockInOrderVO.getId())) {
                List<StockInItemVO> items = BeanUtil.copyToList(itemMap.get(stockInOrderVO.getId()), StockInItemVO.class);
                stockInOrderVO.setItems(items);
            }
        });

        // 构建分页结果
        return stockInOrderVOPageDTO;
    }

    @Override
    public StockInOrderVO getOneByCode(String orderCode) {
        LambdaQueryWrapper<StockInItem> wrapper = Wrappers.lambdaQuery(StockInItem.class)
                        .eq(StockInItem::getInOrderCode, orderCode);
        List<StockInItem> stockInItems = stockInItemMapper.selectList(wrapper);

        StockInOrder order = this.lambdaQuery().eq(StockInOrder::getOrderCode, orderCode).one();
        if (order == null) {
            throw new BusinessException("入库订单不存在，订单号：" + orderCode);
        }
        StockInOrderVO orderVO = BeanUtil.copyProperties(order, StockInOrderVO.class);
        orderVO.setItems(BeanUtil.copyToList(stockInItems, StockInItemVO.class));
        return orderVO;
    }


    /**
     * 组装需要更新的产品列表，添加库存
     * @param stockInItems
     * @param auth
     * @return
     */
    private List<ServerProduct> getProductToUpdate(List<StockInItem> stockInItems, AuthInfoDTO auth) {
        List<Long> productIds = stockInItems.stream().map(StockInItem::getProductId).toList();
        LambdaQueryWrapper<ServerProduct> productWrapper = Wrappers.lambdaQuery(ServerProduct.class)
                .in(ServerProduct::getId, productIds)
                .eq(ServerProduct::getOrgId, auth.getOrgId());
        List<ServerProduct> serverProducts = serverProductMapper.selectList(productWrapper);
        // 现有产品转换为Map，方便后续查找
        Map<Long, ServerProduct> productMap = serverProducts.stream()
                .collect(Collectors.toMap(ServerProduct::getId, product -> product));
        // 创建一个新的库存产品列表，用于存储更新后的库存数据
        List<ServerProduct> productsToUpdate = new ArrayList<>();
        for (StockInItem item : stockInItems) {
            ServerProduct product = productMap.get(item.getProductId());

            if (product == null) {
                throw new BusinessException("产品不存在，ID：" + item.getProductId());
            }
            if (product.getStatus() == Status.DISABLED.getValue()) {
                throw new BusinessException("产品已停用，无法入库，产品ID：" + item.getProductId());
            }
            // 更新一下产品明细
            item.setProductCode(product.getProductEncode());
            item.setProductName(product.getProductName());
            item.setUnit(product.getUnit());

            int newQuantity = product.getQuantity() + item.getQuantity();
            product.setQuantity(newQuantity);
            productsToUpdate.add(product);
        }
        return productsToUpdate;
    }
}