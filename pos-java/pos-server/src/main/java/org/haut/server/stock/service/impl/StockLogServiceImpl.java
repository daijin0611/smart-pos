package org.haut.server.stock.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.server.stock.entity.StockLog;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockLogVO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.stock.service.StockInOrderService;
import org.haut.server.stock.service.StockLogService;
import org.haut.server.stock.mapper.StockLogMapper;
import org.haut.server.stock.service.StockOutOrderService;
import org.springframework.stereotype.Service;

/**
 * 库存日志服务实现类
 * 
 * 实现库存日志的业务逻辑处理，包括日志的查询、统计分析等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
@Service
@RequiredArgsConstructor
public class StockLogServiceImpl extends ServiceImpl<StockLogMapper, StockLog>
    implements StockLogService {
    private final StockLogMapper stockLogMapper;
    private final StockInOrderService stockInOrderService;
    private final StockOutOrderService stockOutOrderService;
    @Override
    public PageDTO<StockLogVO> queryPage(StockOrderQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        LambdaQueryWrapper<StockLog> queryWrapper = Wrappers.lambdaQuery(StockLog.class)
                .eq(auth.getOrgId() != null, StockLog::getOrgId, auth.getOrgId())
                .like(StringUtils.isNotBlank(query.getOperator()), StockLog::getOperator, query.getOperator())
                .like(StringUtils.isNotBlank(query.getOrderCode()), StockLog::getOrderCode, query.getOrderCode())
                .gt(query.getStartDate() != null, StockLog::getCreateTime, query.getStartDate())
                .lt(query.getEndDate() != null, StockLog::getCreateTime, query.getEndDate())
                .orderByDesc(StockLog::getCreateTime);
        Page<StockLog> page = new Page<>(query.getPageNum(), query.getPageSize());
        this.page(page, queryWrapper);
        return PageDTO.create(page, StockLogVO.class);
    }
}