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
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.stock.StockOutOrderCreateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.entity.stock.StockOutItem;
import org.haut.common.domain.entity.stock.StockOutOrder;
import org.haut.common.domain.entity.stock.StockProduct;
import org.haut.common.domain.entity.stock.StockLog;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockOutItemVO;
import org.haut.common.domain.vo.stock.StockOutOrderVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.stock.mapper.StockOutItemMapper;
import org.haut.server.stock.mapper.StockProductMapper;
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
    private final StockProductMapper stockProductMapper;
    private final StockLogMapper stockLogMapper;

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
        stockOutItemMapper.insert(outItems);

        // 扣减库存 - 优化性能，使用Map避免嵌套循环
        List<Long> productIds = outItems.stream().map(StockOutItem::getProductId).toList();
        
        // 查询当前机构下的库存产品
        LambdaQueryWrapper<StockProduct> queryWrapper = Wrappers.lambdaQuery(StockProduct.class)
                .eq(StockProduct::getOrgId, auth.getOrgId())
                .in(StockProduct::getProductId, productIds);
        List<StockProduct> stockProducts = stockProductMapper.selectList(queryWrapper);
        
        // 将库存产品转换为Map，提高查找效率
        Map<Long, StockProduct> stockProductMap = new HashMap<>();
        for (StockProduct stockProduct : stockProducts) {
            stockProductMap.put(stockProduct.getProductId(), stockProduct);
        }
        
        // 需要更新的库存产品列表
        List<StockProduct> stockProductsToUpdate = new ArrayList<>();
        
        // 处理库存扣减
        for (StockOutItem outItem : outItems) {
            StockProduct stockProduct = stockProductMap.get(outItem.getProductId());

            if (stockProduct == null) {
                // 如果没有找到对应的库存产品，说明该商品没有库存，直接抛出异常
                log.error("产品ID：{}，产品名称：{}，单位：{}，库存产品不存在，无法进行出库操作", outItem.getProductId(), outItem.getProductName(), outItem.getUnit());
                throw new BusinessException("产品ID：" + outItem.getProductId() + "，产品名称：" + outItem.getProductName() + "，单位：" + outItem.getUnit() + " 库存产品不存在，无法进行出库操作");
            }
            
            int currentQuantity = stockProduct.getQuantity();
            int outQuantity = outItem.getQuantity();
            
            // 检查库存是否充足
            if (currentQuantity < outQuantity) {
                log.error("产品ID：{}，产品名称：{}，单位：{}，库存不足，当前库存：{}，出库数量：{}", 
                        outItem.getProductId(), outItem.getProductName(), outItem.getUnit(), currentQuantity, outQuantity);
                throw new BusinessException("产品ID：" + outItem.getProductId() + "，产品名称：" + outItem.getProductName() + "，单位：" + outItem.getUnit() + " 库存不足，当前库存：" + currentQuantity + "，出库数量：" + outQuantity);
            }
            
            // 扣减库存
            int newQuantity = currentQuantity - outQuantity;
            stockProduct.setQuantity(newQuantity);
            stockProductsToUpdate.add(stockProduct);
            
            log.info("产品ID：{}，产品名称：{}，单位：{}，扣减前库存：{}，扣减数量：{}，扣减后库存：{}", 
                    outItem.getProductId(), outItem.getProductName(), outItem.getUnit(), currentQuantity, outQuantity, newQuantity);
        }
        
        // 批量更新库存产品
        if (!stockProductsToUpdate.isEmpty()) {
            stockProductMapper.updateById(stockProductsToUpdate);
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
}