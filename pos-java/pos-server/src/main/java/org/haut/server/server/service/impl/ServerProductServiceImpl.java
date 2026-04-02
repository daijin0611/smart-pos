package org.haut.server.server.service.impl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.dto.server.ServerProductCreateDTO;
import org.haut.common.domain.dto.server.ServerProductUpdateDTO;
import org.haut.common.domain.query.server.ServerProductListQuery;
import org.haut.common.domain.vo.server.ServerProductInfoVO;
import org.haut.common.enums.OrgRelationTypeEnum;
import org.haut.common.exception.BusinessException;
import org.haut.server.server.entity.ServerProduct;
import org.haut.server.server.service.ServerProductService;
import org.haut.server.server.mapper.ServerProductMapper;
import org.haut.server.system.service.OrgRelationService;
import org.haut.server.system.service.SysOrgService;
import org.haut.common.domain.vo.system.OrgSimpleVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

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
 * 服务产品 ServiceImpl
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ServerProductServiceImpl extends ServiceImpl<ServerProductMapper, ServerProduct>
    implements ServerProductService{

    private final ServerProductMapper serverProductMapper;
    private final ProductConvert productConvert;
    private final OrgRelationService orgRelationService;
    private final SysOrgService sysOrgService;

    @Override
    public List<ServerProductInfoVO> getList(ServerProductListQuery query) {
        log.info("查询服务产品列表，查询条件：{}", query);
        LambdaQueryWrapper<ServerProduct> wrapper = Wrappers.lambdaQuery(ServerProduct.class)
                .and(StringUtils.isNotBlank(query.getKeyWord()), w -> w
                        .like(ServerProduct::getProductEncode, query.getKeyWord())
                        .or()
                        .like(ServerProduct::getProductName, query.getKeyWord()))
                .eq(query.getProductStatus() != null, ServerProduct::getStatus, query.getProductStatus())
                .eq(StringUtils.isNotBlank(query.getCategory()), ServerProduct::getCategory, query.getCategory());
        if (query.getOrgId() != null) {
            List<Long> itemIds = orgRelationService.getItemIdsByOrg(
                    OrgRelationTypeEnum.SERVER_PRODUCT.getValue(), query.getOrgId());
            if (itemIds.isEmpty()) {
                return Collections.emptyList();
            }
            wrapper.in(ServerProduct::getId, itemIds);
        }
        List<ServerProductInfoVO> voList = productConvert.toVoList(this.list(wrapper));
        if (!voList.isEmpty()) {
            List<Long> itemIds = voList.stream().map(ServerProductInfoVO::getId).toList();
            Map<Long, List<Long>> orgIdMap = orgRelationService.getOrgIdsByItems(
                    OrgRelationTypeEnum.SERVER_PRODUCT.getValue(), itemIds);
            Set<Long> allOrgIds = orgIdMap.values().stream()
                    .flatMap(List::stream).collect(Collectors.toSet());
            Map<Long, OrgSimpleVO> orgVoMap = sysOrgService.getOrgSimpleMapByIds(allOrgIds);
            voList.forEach(vo -> {
                List<Long> idList = orgIdMap.getOrDefault(vo.getId(), Collections.emptyList());
                vo.setOrgs(idList.stream().map(orgVoMap::get)
                        .filter(Objects::nonNull).toList());
            });
        }
        log.info("查询服务产品列表完成，共{}条", voList.size());
        return voList;
    }

    @Override
    public ServerProductInfoVO getProductById(Long id, Long orgId) {
        log.info("查询服务产品详情，id：{}", id);
        ServerProduct product = this.getById(id);
        if (product == null) {
            throw new BusinessException("产品不存在");
        }
        ServerProductInfoVO vo = productConvert.toVo(product);
        vo.setOrgs(sysOrgService.getOrgSimpleListByIds(orgRelationService.getOrgIdsByItem(
                OrgRelationTypeEnum.SERVER_PRODUCT.getValue(), id)));
        return vo;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String addProduct(ServerProductCreateDTO product) {
        log.info("新增服务产品，数据：{}", product);
        long nameCount = this.count(Wrappers.lambdaQuery(ServerProduct.class)
                .eq(ServerProduct::getProductName, product.getProductName()));
        if (nameCount > 0) {
            throw new BusinessException("已存在相同名称的产品");
        }
        long encodeCount = this.count(Wrappers.lambdaQuery(ServerProduct.class)
                .eq(ServerProduct::getProductEncode, product.getProductEncode()));
        if (encodeCount > 0) {
            throw new BusinessException("已存在相同编码的产品");
        }
        ServerProduct serverProduct = productConvert.toEntity(product);
        serverProduct.setQuantity(0);
        this.save(serverProduct);
        if (product.getOrgIds() != null && !product.getOrgIds().isEmpty()) {
            log.info("绑定服务产品门店关联，productId：{}，orgIds：{}", serverProduct.getId(), product.getOrgIds());
            orgRelationService.bindOrgs(OrgRelationTypeEnum.SERVER_PRODUCT.getValue(),
                    serverProduct.getId(), product.getOrgIds());
        }
        return "添加成功";
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String updateProduct(ServerProductUpdateDTO product) {
        log.info("更新服务产品，数据：{}", product);
        long nameCount = this.count(Wrappers.lambdaQuery(ServerProduct.class)
                .eq(ServerProduct::getProductName, product.getProductName())
                .ne(ServerProduct::getId, product.getId()));
        if (nameCount > 0) {
            throw new BusinessException("已存在相同名称的产品");
        }
        long encodeCount = this.count(Wrappers.lambdaQuery(ServerProduct.class)
                .eq(ServerProduct::getProductEncode, product.getProductEncode())
                .ne(ServerProduct::getId, product.getId()));
        if (encodeCount > 0) {
            throw new BusinessException("已存在相同编码的产品");
        }
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
                .set(ServerProduct::getCategory, product.getCategory())
                .eq(ServerProduct::getId, product.getId())
                .update();
        if (product.getOrgIds() != null) {
            log.info("更新服务产品门店关联，productId：{}，orgIds：{}", product.getId(), product.getOrgIds());
            orgRelationService.unbindOrgs(OrgRelationTypeEnum.SERVER_PRODUCT.getValue(), product.getId());
            orgRelationService.bindOrgs(OrgRelationTypeEnum.SERVER_PRODUCT.getValue(),
                    product.getId(), product.getOrgIds());
        }
        return "更新成功";
    }

    @Override
    public String updateProductStatus(Long id, Integer status) {
        log.info("更新服务产品状态，id：{}，status：{}", id, status);
        boolean update = this.lambdaUpdate().set(ServerProduct::getStatus, status)
                .eq(ServerProduct::getId, id)
                .update();
        return update ? "更新成功" : "更新失败";
    }

}
