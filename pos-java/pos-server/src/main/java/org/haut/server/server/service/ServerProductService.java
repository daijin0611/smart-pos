package org.haut.server.server.service;

import org.haut.common.domain.query.server.ServerProductListQuery;
import org.haut.common.domain.vo.server.ServerProductVO;
import org.haut.server.server.entity.ServerProduct;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_product(产品表)】的数据库操作Service
* @createDate 2025-04-25 00:22:51
*/
public interface ServerProductService extends IService<ServerProduct> {

    List<ServerProductVO> getList(ServerProductListQuery query);
}
