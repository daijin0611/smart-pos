package org.haut.server.server.service.impl;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import org.haut.common.domain.query.server.ServerProductListQuery;
import org.haut.common.domain.vo.server.ServerProductVO;
import org.haut.server.server.entity.ServerProduct;
import org.haut.server.server.service.ServerProductService;
import org.haut.server.server.mapper.ServerProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_product(产品表)】的数据库操作Service实现
* @createDate 2025-04-25 00:22:51
*/
@Service
public class ServerProductServiceImpl extends ServiceImpl<ServerProductMapper, ServerProduct>
    implements ServerProductService{

    @Autowired private ServerProductMapper serverProductMapper;

    /**
     * 查询服务产品列表,条件查询
     *
     * @param query
     * @return
     */
    @Override
    public List<ServerProductVO> getList(ServerProductListQuery query) {
        //构建条件查询器，当产品名称、产品编号不为空时，进行查询
        QueryWrapper<ServerProduct> queryWrapper = new QueryWrapper<>();
        queryWrapper.like(StringUtils.isNotBlank(query.getProductName()),"product_name",query.getProductName())
                .like(StringUtils.isNotBlank(query.getProductEncode()),"product_encode",query.getProductEncode())
               .eq(query.getProductStatus() != null,"product_status",query.getProductStatus());
        //查询数据库
        List<ServerProduct> serverProducts = serverProductMapper.selectList(queryWrapper);
        //转化为VO
        return BeanUtil.copyToList(serverProducts, ServerProductVO.class);
    }


}




