package org.haut.server.server.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.haut.common.domain.entity.server.ServerProduct;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.haut.common.domain.query.stock.StockProductPageQuery;
import org.haut.common.domain.vo.stock.StockProductVO;

/**
* @author Cdh
* @description 针对表【server_product(产品表)】的数据库操作Mapper
* @createDate 2025-04-25 00:22:51
* @Entity org.haut.common.domain.entity.server.ServerProduct
*/
@Mapper
public interface ServerProductMapper extends BaseMapper<ServerProduct> {

}




