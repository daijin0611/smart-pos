package org.haut.server.server.service.impl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import org.haut.common.domain.dto.server.ServerProductCreateDTO;
import org.haut.common.domain.dto.server.ServerProductUpdateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.server.ServerProductListQuery;
import org.haut.common.domain.vo.server.ServerProductInfoVO;
import org.haut.common.domain.vo.server.ServerProductVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
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
        // 如果查询条件中没有设置orgId，则从当前用户认证信息中获取
        if (query.getOrgId() == null) {
            AuthInfoDTO auth = AuthContextHolder.getAuth();
            query.setOrgId(auth.getOrgId());
        }
        
        //构建条件查询器
        QueryWrapper<ServerProduct> queryWrapper = new QueryWrapper<>();
        queryWrapper.like(StringUtils.isNotBlank(query.getProductName()),"product_name",query.getProductName())
                .like(StringUtils.isNotBlank(query.getProductEncode()),"product_encode",query.getProductEncode())
                .eq(query.getProductStatus() != null,"product_status",query.getProductStatus())
                // 必须使用orgId作为查询条件，确保只查询当前门店的产品
                .eq("org_id", query.getOrgId());
        //查询数据库
        List<ServerProduct> serverProducts = serverProductMapper.selectList(queryWrapper);
        //转化为VO
        return BeanUtil.copyToList(serverProducts, ServerProductVO.class);
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
        return BeanUtil.toBean(product, ServerProductInfoVO.class);
    }

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
                return "该门店下已存在相同名称的产品";
            }
            
            // 检查同一门店下是否存在相同编码的产品
            LambdaQueryWrapper<ServerProduct> encodeQueryWrapper = new LambdaQueryWrapper<>();
            encodeQueryWrapper.eq(ServerProduct::getProductEncode, product.getProductEncode())
                             .eq(ServerProduct::getOrgId, orgId);
            long encodeCount = this.count(encodeQueryWrapper);
            if (encodeCount > 0) {
                return "该门店下已存在相同编码的产品";
            }
            
            // 设置组织ID
            ServerProduct serverProduct = BeanUtil.toBean(product, ServerProduct.class);
            serverProduct.setOrgId(orgId);
            
            // 保存产品
            this.save(serverProduct);
            return "添加成功";
        } catch (Exception e) {
            return e.getMessage();
        }
    }
    
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
                return "该门店下已存在相同名称的产品";
            }
            
            // 检查是否存在相同编码的其他产品
            LambdaQueryWrapper<ServerProduct> encodeQueryWrapper = new LambdaQueryWrapper<>();
            encodeQueryWrapper.eq(ServerProduct::getProductEncode, product.getProductEncode())
                             .eq(ServerProduct::getOrgId, orgId)
                             .ne(ServerProduct::getId, product.getId());
            long encodeCount = this.count(encodeQueryWrapper);
            if (encodeCount > 0) {
                return "该门店下已存在相同编码的产品";
            }
            
            // 设置orgId，确保产品归属于当前门店
            ServerProduct serverProduct = BeanUtil.toBean(product, ServerProduct.class);
            serverProduct.setOrgId(orgId);
            
            // 更新产品
            this.updateById(serverProduct);
            return "更新成功";
        } catch (Exception e) {
            return e.getMessage();
        }
    }


}




