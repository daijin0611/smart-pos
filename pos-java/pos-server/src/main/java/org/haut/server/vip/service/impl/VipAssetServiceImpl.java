package org.haut.server.vip.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.vip.AssetCreateDTO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.vip.entity.VipAsset;
import org.haut.server.vip.entity.VipInfo;
import org.haut.server.vip.mapper.VipInfoMapper;
import org.haut.server.vip.service.VipAssetService;
import org.haut.server.vip.mapper.VipAssetMapper;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
* @author tinwf
* @description 针对表【vip_asset(会员资产表)】的数据库操作Service实现
* @createDate 2025-05-07 00:36:29
*/
@Service
@RequiredArgsConstructor
@Slf4j
public class VipAssetServiceImpl extends ServiceImpl<VipAssetMapper, VipAsset>
    implements VipAssetService{
    private final VipAssetConvert vipAssetConvert;
    private final VipInfoMapper vipInfoMapper;

    /**
     * 创建会员资产
     * @param dto 创建信息
     * @return 资产编号
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String createAsset(AssetCreateDTO dto) {
        AuthInfoDTO authInfo = AuthContextHolder.getAuth();
        VipAsset vipAsset = vipAssetConvert.toEntity(dto);
        String assetNum = CodeUtils.generateByTime(PrefixConst.ASSET);
        vipAsset.setAssetNum(assetNum)
                .setOrgId(authInfo.getOrgId());
        this.save(vipAsset);
        log.info("会员资产：{}", vipAsset);
        return assetNum;
    }
}

@Mapper(componentModel = "spring")
interface VipAssetConvert{
    VipAsset toEntity(AssetCreateDTO dto);
}




