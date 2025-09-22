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
import org.haut.common.domain.dto.order.OrderDetailSettleDTO;
import org.haut.common.domain.dto.stock.StockOutOrderCreateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.vo.ResultStatus;
import org.haut.common.enums.ServiceTypeEnum;
import org.haut.server.server.entity.ServerProduct;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockOutItemVO;
import org.haut.common.domain.vo.stock.StockOutOrderVO;
import org.haut.common.enums.Status;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.server.mapper.ServerProductMapper;
import org.haut.server.stock.entity.StockLog;
import org.haut.server.stock.entity.StockOutItem;
import org.haut.server.stock.entity.StockOutOrder;
import org.haut.server.stock.mapper.StockOutItemMapper;
import org.haut.server.stock.mapper.StockLogMapper;
import org.haut.server.stock.service.StockOutOrderService;
import org.haut.server.stock.mapper.StockOutOrderMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.commons.lang3.StringUtils;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.stream.Collectors;

/**
 * 出库订单服务实现类
 * 
 * 实现出库订单的业务逻辑处理，包括订单的创建、审核、完成等功能
 * 支持库存扣减、库存不足检查等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class StockOutOrderServiceImpl extends ServiceImpl<StockOutOrderMapper, StockOutOrder>
    implements StockOutOrderService {
    private final StockOutItemMapper stockOutItemMapper;
    private final StockLogMapper stockLogMapper;
    private final ServerProductMapper serverProductMapper;

    @Override
    public PageDTO<StockOutOrderVO> queryPage(StockOrderQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        LambdaQueryWrapper<StockOutOrder> queryWrapper = Wrappers.lambdaQuery(StockOutOrder.class)
                .eq(auth.getOrgId() != null, StockOutOrder::getOrgId, auth.getOrgId())
                .like(StringUtils.isNotBlank(query.getOrderCode()), StockOutOrder::getOrderCode, query.getOrderCode())
                .like(StringUtils.isNotBlank(query.getOperator()), StockOutOrder::getOperator, query.getOperator())
                .gt(query.getStartDate() != null, StockOutOrder::getCreateTime, query.getStartDate())
                .lt(query.getEndDate() != null, StockOutOrder::getCreateTime, query.getEndDate())
                .orderByDesc(StockOutOrder::getCreateTime);
        Page<StockOutOrder> page = new Page<>(query.getPageNum(), query.getPageSize());
        Page<StockOutOrder> result = this.page(page, queryWrapper);
        if (result.getTotal() == 0) {
            return new PageDTO<>();
        }

        PageDTO<StockOutOrderVO> stockOutOrderVOPageDTO = PageDTO.create(result, StockOutOrderVO.class);

        // 查询子项
        List<Long> orderIds = result.getRecords().stream().map(StockOutOrder::getId).toList();
        LambdaQueryWrapper<StockOutItem> itemQueryWrapper = Wrappers.lambdaQuery(StockOutItem.class)
                .in(StockOutItem::getOutOrderId, orderIds);
        List<StockOutItem> outItems = stockOutItemMapper.selectList(itemQueryWrapper);
        // 将子项转换为Map，方便后续查询
        Map<Long, List<StockOutItem>> itemMap = new HashMap<>();
        for (StockOutItem item : outItems) {
            itemMap.computeIfAbsent(item.getOutOrderId(), k -> new ArrayList<>()).add(item);
        }
        // 设置子项到VO中
        for (StockOutOrderVO orderVO : stockOutOrderVOPageDTO.getRows()) {
            List<StockOutItem> items = itemMap.get(orderVO.getId());
            if (items != null) {
                orderVO.setItems(BeanUtil.copyToList(items, StockOutItemVO.class));
            }
        }
        return stockOutOrderVOPageDTO;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addOrder(StockOutOrderCreateDTO dto) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        String code = CodeUtils.generateByTime(PrefixConst.STOCK_OUT_ORDER);
        
        // 数据校验
        if (dto.getItems() == null || dto.getItems().isEmpty()) {
            throw new BusinessException("出库明细不能为空");
        }
        
        // 校验出库数量
        for (StockOutOrderCreateDTO.StockOutItemCreateDTO item : dto.getItems()) {
            if (item.getQuantity() == null || item.getQuantity() <= 0) {
                throw new BusinessException("出库数量必须大于0");
            }
        }
        
        // 创建出库单
        StockOutOrder order = new StockOutOrder()
                .setOrderCode(code)
                .setOperator(dto.getOperator())
                .setRemark(dto.getRemark())
                .setOrgId(auth.getOrgId())
                .setTotalPrice(dto.getTotalPrice());
        this.save(order);

        // 创建出库明细
        List<StockOutOrderCreateDTO.StockOutItemCreateDTO> items = dto.getItems();
        List<StockOutItem> outItems = items.stream().map(item -> BeanUtil.toBean(item, StockOutItem.class)
                .setOutOrderCode(code)
                .setOutOrderId(order.getId())
                .setOrgId(auth.getOrgId())
        ).toList();
        // 获取需要更新的产品列表
        List<ServerProduct> productsToUpdate = getProductToUpdate(outItems, auth);
        stockOutItemMapper.insert(outItems);
        // 更新库存
        // 如果更新为空，说明没有库存变化，可能触发了乐观锁异常，重新获取产品信息
        int count = 0;
        while (serverProductMapper.updateById(productsToUpdate).isEmpty()) {
            if (count == 10){
                log.error("库存更新冲突");
                // 响应前端服务器繁忙
                throw new BusinessException(ResultStatus.SERVER_BUSY.getMessage());
            }
            productsToUpdate = getProductToUpdate(outItems, auth);
            serverProductMapper.updateById(productsToUpdate);
            count++;
        }

        // 记录库存日志
        List<StockLog> stockLogs = outItems.stream().map(item -> {
            StockLog stockLog = new StockLog();
            stockLog.setOrgId(auth.getOrgId());
            stockLog.setOrderCode(code);
            stockLog.setOrderType(Const.STOCK_OUT);
            stockLog.setProductId(item.getProductId());
            stockLog.setProductName(item.getProductName());
            stockLog.setProductCode(item.getProductCode());
            stockLog.setOperator(order.getOperator());
            stockLog.setQuantity(item.getQuantity());
            stockLog.setPrice(item.getPrice());
            stockLog.setTotalPrice(item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
            return stockLog;
        }).toList();

        if (!stockLogs.isEmpty()) {
            stockLogMapper.insert(stockLogs);
            log.info("成功记录出库日志，订单编码：{}，日志数量：{}", code, stockLogs.size());
        }
        
        log.info("出库订单创建成功，订单号：{}", code);
    }

    @Override
    public StockOutOrderVO getOneByCode(String orderCode) {
        StockOutOrder order = this.lambdaQuery().eq(StockOutOrder::getOrderCode, orderCode).one();
        if (order == null) {
            throw new BusinessException("出库订单不存在");
        }
        List<StockOutItem> items = stockOutItemMapper.selectList(Wrappers.lambdaQuery(StockOutItem.class)
                .eq(StockOutItem::getOutOrderCode, orderCode));
        StockOutOrderVO vo = BeanUtil.toBean(order, StockOutOrderVO.class);
        vo.setItems(BeanUtil.copyToList(items, StockOutItemVO.class));
        return vo;
    }

    /**
     * 出库销售商品
     * @param consumerOrderDetails 结算订单明细
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void handelOrder(List<OrderDetailSettleDTO> consumerOrderDetails) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        // 筛选出产品类型的明细
        List<OrderDetailSettleDTO> productDetails = consumerOrderDetails.stream()
                .filter(o -> o.getDetailType().equals(ServiceTypeEnum.PRODUCT.getValue()))
                .toList();
        if (productDetails.isEmpty())
            return;
        BigDecimal totalPrice = productDetails.stream()
                .map(OrderDetailSettleDTO::getStdPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        List<StockOutOrderCreateDTO.StockOutItemCreateDTO> itemCreateDTOS = productDetails.stream()
                .map(p -> new StockOutOrderCreateDTO.StockOutItemCreateDTO()
                        .setPrice(p.getStdPrice())
                        .setProductId(p.getBid())
                        .setQuantity(p.getQuantity())
                        .setRemark(p.getRemark()))
                .toList();

        StockOutOrderCreateDTO stockOrder = new StockOutOrderCreateDTO()
                .setTotalPrice(totalPrice)
                .setOperator(auth.getUserName())
                .setRemark("销售出库")
                .setItems(itemCreateDTOS);
        addOrder(stockOrder);
    }

    /**
     * 组装需要更新的产品列表，扣减库存
     * @param stockOutItems
     * @param auth
     * @return
     */
    private List<ServerProduct> getProductToUpdate(List<StockOutItem> stockOutItems, AuthInfoDTO auth) {
        List<Long> productIds = stockOutItems.stream().map(StockOutItem::getProductId).toList();
        LambdaQueryWrapper<ServerProduct> productWrapper = Wrappers.lambdaQuery(ServerProduct.class)
                .in(ServerProduct::getId, productIds)
                .eq(ServerProduct::getOrgId, auth.getOrgId());
        List<ServerProduct> serverProducts = serverProductMapper.selectList(productWrapper);
        // 现有产品转换为Map，方便后续查找
        Map<Long, ServerProduct> productMap = serverProducts.stream()
                .collect(Collectors.toMap(ServerProduct::getId, product -> product));
        // 创建一个新的库存产品列表，用于存储更新后的库存数据
        List<ServerProduct> productsToUpdate = new ArrayList<>();
        for (StockOutItem item : stockOutItems) {
            ServerProduct product = productMap.get(item.getProductId());

            if (product == null) {
                throw new BusinessException("产品不存在，ID：" + item.getProductId());
            }
            if (product.getStatus() == Status.DISABLED.getValue()) {
                throw new BusinessException("产品已停用，无法出库，产品ID：" + item.getProductId());
            }
            // 更新一下产品明细
            item.setProductCode(product.getProductEncode());
            item.setProductName(product.getProductName());
            item.setUnit(product.getUnit());

            int newQuantity = product.getQuantity() - item.getQuantity();
            if (newQuantity < 0) {
                throw new BusinessException("库存不足\n产品：" + product.getProductName() + "\n当前库存：" + product.getQuantity() + "\n出库数量：" + item.getQuantity());
            }
            product.setQuantity(newQuantity);
            productsToUpdate.add(product);
        }
        return productsToUpdate;
    }
}