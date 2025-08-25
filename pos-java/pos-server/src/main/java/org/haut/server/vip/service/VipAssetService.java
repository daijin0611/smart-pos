package org.haut.server.vip.service;

import org.haut.common.domain.dto.vip.AssetCreateDTO;
import org.haut.server.vip.entity.VipAsset;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author tinwf
* @description 针对表【vip_asset(会员资产表)】的数据库操作Service
* @createDate 2025-05-07 00:36:29
*/
public interface VipAssetService extends IService<VipAsset> {

    String createAsset(AssetCreateDTO dto);
}
