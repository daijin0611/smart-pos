package org.haut.server.vip.mapper;

import org.apache.ibatis.annotations.Select;
import org.haut.common.domain.dto.vip.VipAssetDTO;
import org.haut.common.domain.entity.vip.VipAsset;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
* @author tinwf
* @description 针对表【vip_asset(会员资产表)】的数据库操作Mapper
* @createDate 2025-05-07 00:36:29
* @Entity org.haut.common.domain.entity.vip.VipAsset
*/
public interface VipAssetMapper extends BaseMapper<VipAsset> {

    @Select("SELECT * FROM vip_asset WHERE vip_id = #{vipId}")
    VipAssetDTO selectByVipId(Long vipId);
}




