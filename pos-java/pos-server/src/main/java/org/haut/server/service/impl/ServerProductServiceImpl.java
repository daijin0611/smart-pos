package org.haut.server.service.impl;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.server.ServerProductListDTO;
import org.haut.common.domain.query.ServerProductListQuery;
import org.haut.server.entity.ServerProduct;
import org.haut.server.service.ServerProductService;
import org.haut.server.mapper.ServerProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_product(产品表)】的数据库操作Service实现
* @createDate 2025-04-25 00:22:51
*/
@Service
@Slf4j
public class ServerProductServiceImpl extends ServiceImpl<ServerProductMapper, ServerProduct>
    implements ServerProductService{

    @Autowired private ServerProductMapper serverProductMapper;

    /**
     * 查询服务产品列表,条件查询
     * @param query
     * @return
     */
    @Override
    public List<ServerProductListDTO> getList(ServerProductListQuery query) {
        //构建条件查询器，当产品名称、产品编号不为空时，进行查询
        QueryWrapper<ServerProduct> queryWrapper = new QueryWrapper<>();
        queryWrapper.like(StringUtils.isNotBlank(query.getProductName()),"product_name",query.getProductName())
                .like(StringUtils.isNotBlank(query.getProductEncode()),"product_encode",query.getProductEncode());
        //查询数据库
        List<ServerProduct> serverProducts = serverProductMapper.selectList(queryWrapper);
        //转化为DTO
        return BeanUtil.copyToList(serverProducts, ServerProductListDTO.class);
    }


    @Override
    public boolean saveOrUpdateProduct(ServerProduct product) {
        try {
            if (product.getId() != null && serverProductMapper.selectById(product.getId()) != null) {
                // 如果主键存在且记录已存在，则更新
                return serverProductMapper.updateById(product) > 0;
            } else {
                // 如果主键不存在或记录不存在，则插入
                return serverProductMapper.insert(product) > 0;
            }
        } catch (Exception e) {
            // 捕获异常并记录日志
            log.error("保存或更新产品时发生异常: {}", e.getMessage(), e);
            return false;
        }
    }


}




