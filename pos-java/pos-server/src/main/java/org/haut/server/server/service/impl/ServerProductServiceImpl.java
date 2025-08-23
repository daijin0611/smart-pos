package org.haut.server.server.service.impl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.dto.server.ServerProductCreateDTO;
import org.haut.common.domain.dto.server.ServerProductUpdateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.server.ServerProductListQuery;
import org.haut.common.domain.vo.server.ServerProductInfoVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.server.entity.ServerProduct;
import org.haut.server.server.service.ServerProductService;
import org.haut.server.server.mapper.ServerProductMapper;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.stereotype.Service;

import java.util.List;

@Mapper(componentModel = "spring")
interface ProductConvert {

    @Mapping(source = "status", target = "productStatus")
    ServerProductInfoVO toVo(ServerProduct serverProduct);

    @Mapping(source = "productStatus", target = "status")
    ServerProduct toEntity(ServerProductCreateDTO productCreateDTO);

    @Mapping(source = "productStatus", target = "status")
    ServerProduct toEntity(ServerProductUpdateDTO productUpdateDTO);

    @Mapping(source = "status", target = "productStatus")
    List<ServerProductInfoVO> toVoList(List<ServerProduct> serverProducts);
}


/**
* @author Cdh
* @description 针对表【server_product(产品表)】的数据库操作Service实现
* @createDate 2025-04-25 00:22:51
*/
@Service
@RequiredArgsConstructor
public class ServerProductServiceImpl extends ServiceImpl<ServerProductMapper, ServerProduct>
    implements ServerProductService{

    private final ServerProductMapper serverProductMapper;
    private final ProductConvert productConvert;

    /**
     * 查询服务产品列表,条件查询
     *
     * @param query
     * @return
     */
    @Override
    public List<ServerProductInfoVO> getList(ServerProductListQuery query) {
        // 如果查询条件中没有设置orgId，则从当前用户认证信息中获取
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        LambdaQueryWrapper<ServerProduct> wrapper = Wrappers.lambdaQuery(ServerProduct.class)
                .and(StringUtils.isNotBlank(query.getKeyWord()),w -> w
                        .like(ServerProduct::getProductEncode, query.getKeyWord())
                        .or()
                        .like(ServerProduct::getProductName, query.getKeyWord()))
                .eq(query.getProductStatus() != null, ServerProduct::getStatus, query.getProductStatus())
                .eq(ServerProduct::getOrgId, auth.getOrgId());
        return productConvert.toVoList(this.list(wrapper));
    }

    @Override
    public ServerProductInfoVO getProductById(Long id, Long orgId) {
        // 查询产品信息
        ServerProduct product = this.getById(id);
        
        // 验证产品是否存在且属于当前门店
        if (product == null || !orgId.equals(product.getOrgId())) {
            throw new BusinessException("产品不存在或不属于当前门店");
        }
        
        // 将 ServerProduct 转化为 ServerProductInfoVO
        return productConvert.toVo(product);
    }

    /**
     * 添加服务产品
     * @param product 产品信息
     * @return 操作结果消息
     */
    @Override
    public String addProduct(ServerProductCreateDTO product) {
        try {
            // 获取当前用户的认证信息
            AuthInfoDTO auth = AuthContextHolder.getAuth();
            Long orgId = auth.getOrgId();
            
            // 检查同一门店下是否存在相同名称的产品
            LambdaQueryWrapper<ServerProduct> nameQueryWrapper = new LambdaQueryWrapper<>();
            nameQueryWrapper.eq(ServerProduct::getProductName, product.getProductName())
                           .eq(ServerProduct::getOrgId, orgId);
            long nameCount = this.count(nameQueryWrapper);
            if (nameCount > 0) {
                throw new BusinessException("该门店下已存在相同名称的产品");
            }
            
            // 检查同一门店下是否存在相同编码的产品
            LambdaQueryWrapper<ServerProduct> encodeQueryWrapper = new LambdaQueryWrapper<>();
            encodeQueryWrapper.eq(ServerProduct::getProductEncode, product.getProductEncode())
                             .eq(ServerProduct::getOrgId, orgId);
            long encodeCount = this.count(encodeQueryWrapper);
            if (encodeCount > 0) {
                throw new BusinessException("该门店下已存在相同编码的产品");
            }
            
            // 设置组织ID
            ServerProduct serverProduct = productConvert.toEntity(product);
            serverProduct.setOrgId(orgId);
            serverProduct.setQuantity(0);
            
            // 保存产品
            this.save(serverProduct);
            return "添加成功";
        } catch (Exception e) {
            throw new BusinessException(e.getMessage());
        }
    }

    /**
     * 更新服务产品，库存不可直接更改
     * @param product 产品信息
     * @return 操作结果消息
     */
    @Override
    public String updateProduct(ServerProductUpdateDTO product) {
        try {
            // 获取当前用户的认证信息
            AuthInfoDTO auth = AuthContextHolder.getAuth();
            Long orgId = auth.getOrgId();
            
            // 检查是否存在相同名称的其他产品
            LambdaQueryWrapper<ServerProduct> nameQueryWrapper = new LambdaQueryWrapper<>();
            nameQueryWrapper.eq(ServerProduct::getProductName, product.getProductName())
                           .eq(ServerProduct::getOrgId, orgId)
                           .ne(ServerProduct::getId, product.getId());
            long nameCount = this.count(nameQueryWrapper);
            if (nameCount > 0) {
                throw new BusinessException("该门店下已存在相同名称的产品");
            }
            
            // 检查是否存在相同编码的其他产品
            LambdaQueryWrapper<ServerProduct> encodeQueryWrapper = new LambdaQueryWrapper<>();
            encodeQueryWrapper.eq(ServerProduct::getProductEncode, product.getProductEncode())
                             .eq(ServerProduct::getOrgId, orgId)
                             .ne(ServerProduct::getId, product.getId());
            long encodeCount = this.count(encodeQueryWrapper);
            if (encodeCount > 0) {
                throw new BusinessException("该门店下已存在相同编码的产品");
            }
            // 更新产品
            this.lambdaUpdate()
                    .set(ServerProduct::getProductName, product.getProductName())
                    .set(ServerProduct::getProductEncode, product.getProductEncode())
                    .set(ServerProduct::getStatus, product.getProductStatus())
                    .set(ServerProduct::getProductPrice, product.getProductPrice())
                    .set(ServerProduct::getVipProductPrice, product.getVipProductPrice())
                    .set(ServerProduct::getIsDiscount, product.getIsDiscount())
                    .set(ServerProduct::getCommissionType, product.getCommissionType())
                    .set(ServerProduct::getCommissionValue, product.getCommissionValue())
                    .set(ServerProduct::getCommissionBase, product.getCommissionBase())
                    .set(ServerProduct::getUnit, product.getUnit())
                    .set(ServerProduct::getRemark, product.getRemark())
                    .eq(ServerProduct::getId, product.getId())
                    .eq(ServerProduct::getOrgId, orgId)
                    .update();

            return "更新成功";
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    /**
     * 更新产品状态
     * @param id 产品ID
     * @param status 产品状态(0-启用，1-禁用)
     * @return 操作结果消息
     */
    @Override
    public String updateProductStatus(Long id, Integer status) {
        boolean update = this.lambdaUpdate().set(ServerProduct::getStatus, status)
                .eq(ServerProduct::getId, id)
                .update();
        return update ? "更新成功" : "更新失败";
    }

}




