package org.haut.server.server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.haut.server.server.entity.ServerProduct;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
* @author Cdh
* @description 针对表【server_product(产品表)】的数据库操作Mapper
* @createDate 2025-04-25 00:22:51
* @Entity org.haut.server.server.entity.ServerProduct
*/
@Mapper
public interface ServerProductMapper extends BaseMapper<ServerProduct> {

}




