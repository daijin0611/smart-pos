package org.haut.server.vip.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.vip.VipAssetDTO;
import org.haut.common.domain.dto.vip.VipInfoDTO;
import org.haut.common.domain.dto.vip.VipListDTO;
import org.haut.common.domain.query.vip.VipListQuery;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.domain.entity.vip.VipInfo;
import org.haut.server.vip.mapper.VipAssetMapper;
import org.haut.server.vip.service.VipInfoService;
import org.haut.server.vip.mapper.VipInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author tinwf
* @description 针对表【vip_info(会员信息表)】的数据库操作Service实现
* @createDate 2025-04-26 18:30:22
*/
@Service
public class VipInfoServiceImpl extends ServiceImpl<VipInfoMapper, VipInfo>
    implements VipInfoService{

    @Autowired
    private VipInfoMapper vipInfoMapper;

    /**
     * 获取会员列表,条件查询
     * @param query
     * @return
     */

    @Override
    public List<VipListDTO> getList(VipListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        LambdaQueryWrapper<VipInfo> queryWrapper = Wrappers.lambdaQuery(VipInfo.class)
                .eq(VipInfo::getOrgId,auth.getOrgId());
        // 条件查询
        if (query.getQueryField() != null) {
            queryWrapper
            .like(VipInfo::getInfoPhoneNumber, query.getQueryField()).or()
            .like(VipInfo::getInfoName, query.getQueryField()).or()
            .like(VipInfo::getInfoCardNumber, query.getQueryField());
        }
        //查询数据库
        List<VipInfo> vipInfos = vipInfoMapper.selectList(queryWrapper);
        //转化为DTO
        return BeanUtil.copyToList(vipInfos, VipListDTO.class);
    }

    @Autowired
    private VipAssetMapper vipAssetMapper;

    /*
     * 1.将会员信息表和会员资产表关联查询，查询会员详细信息
     * 2.根据会员id查询会员详细信息（会员资产表中的余额部分）
     */
    @Override
    public VipInfoDTO getVipById(Long id) {
        VipInfo vipInfo = getById(id);

        //自定义方法
        VipAssetDTO vipAssetDTO = vipAssetMapper.selectByVipId(id);

        ////将VipInfo转化为VipInfoDTO
        VipInfoDTO dto = BeanUtil.toBean(vipInfo, VipInfoDTO.class);
        if(vipAssetDTO != null){
            dto.setAssetBalance(vipAssetDTO.getAssetBalance());
        }
        return dto;
    }

}
