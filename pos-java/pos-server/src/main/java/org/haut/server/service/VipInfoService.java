package org.haut.server.service;

import org.haut.common.domain.dto.system.UserListDTO;
import org.haut.common.domain.dto.vip.VipInfoDTO;
import org.haut.common.domain.dto.vip.VipListDTO;
import org.haut.common.domain.query.UserListQuery;
import org.haut.common.domain.query.VipListQuery;
import org.haut.server.entity.VipInfo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author tinwf
* @description 针对表【vip_info(会员信息表)】的数据库操作Service
* @createDate 2025-04-26 18:30:22
*/
public interface VipInfoService extends IService<VipInfo> {

    // 获取会员列表的接口
    List<VipListDTO> getList(VipListQuery query);

    /**
     *根据会员ID查询详细信息（含资产余额）
     */
    VipInfoDTO getVipById(Long id);


}
