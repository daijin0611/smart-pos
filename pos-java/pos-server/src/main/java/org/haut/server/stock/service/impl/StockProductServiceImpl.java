package org.haut.server.stock.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.entity.server.ServerProduct;
import org.haut.common.domain.entity.stock.StockProduct;
import org.haut.common.domain.query.stock.StockProductPageQuery;
import org.haut.common.domain.vo.stock.StockProductVO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.server.mapper.ServerProductMapper;
import org.haut.server.stock.service.StockProductService;
import org.haut.server.stock.mapper.StockProductMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 库存产品服务实现类
 * 
 * 实现库存产品的业务逻辑处理，包括产品的增删改查、库存管理等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 */
@Service
@RequiredArgsConstructor
public class StockProductServiceImpl extends ServiceImpl<StockProductMapper, StockProduct>
    implements StockProductService {
    private final ServerProductMapper serverProductMapper;

    @Override
    public PageDTO<StockProductVO> queryPage(StockProductPageQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Page<StockProduct> page = new Page<>(query.getPageNum(), query.getPageSize());
        Page<StockProductVO> stockProductVOPage = serverProductMapper.stockQueryPage(page, query, auth.getOrgId());
        // TODO 查询逻辑有误
        return PageDTO.create(stockProductVOPage);
    }
}