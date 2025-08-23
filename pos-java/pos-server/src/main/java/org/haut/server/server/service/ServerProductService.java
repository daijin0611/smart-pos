package org.haut.server.server.service;

import org.haut.common.domain.dto.server.ServerProductCreateDTO;
import org.haut.common.domain.dto.server.ServerProductUpdateDTO;
import org.haut.common.domain.query.server.ServerProductListQuery;
import org.haut.common.domain.vo.server.ServerProductInfoVO;
import org.haut.server.server.entity.ServerProduct;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_product(产品表)】的数据库操作Service
* @createDate 2025-04-25 00:22:51
*/
public interface ServerProductService extends IService<ServerProduct> {

    /**
     * 获取服务产品列表
     *
     * @param query 查询条件
     * @return 服务产品列表
     */
    List<ServerProductInfoVO> getList(ServerProductListQuery query);

    /**
     * 根据ID获取服务产品详情
     * @param id 产品ID
     * @param orgId 组织ID
     * @return 服务产品详情
     */
    ServerProductInfoVO getProductById(Long id, Long orgId);

    /**
     * 添加服务产品
     * @param product 产品信息
     * @return 操作结果消息
     */
    String addProduct(ServerProductCreateDTO product);
    
    /**
     * 更新服务产品
     * @param product 产品信息
     * @return 操作结果消息
     */
    String updateProduct(ServerProductUpdateDTO product);

    /**
     * 更新服务产品状态
     * @param id 产品ID
     * @param status 状态
     * @return 操作结果消息
     */
    String updateProductStatus(Long id, Integer status);
}
