package org.haut.server.vip.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.vip.*;
import org.haut.common.domain.query.vip.VipListQuery;
import org.haut.common.domain.vo.vip.VipInfoVO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.domain.entity.vip.VipInfo;
import org.haut.server.vip.mapper.VipAssetMapper;
import org.haut.server.vip.service.VipInfoService;
import org.haut.server.vip.mapper.VipInfoMapper;
import org.mapstruct.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Mapper(componentModel = "spring")
interface VipInfoConvert{

    VipInfoVO toVO(VipInfo entity);

    List<VipInfoVO> toVOs(List<VipInfo> list);

    VipInfo toEntity(VipCreateDTO dto);

    VipInfo toEntity(VipUpdateDTO dto);
}

/**
* @author tinwf
* @description 针对表【vip_info(会员信息表)】的数据库操作Service实现
* @createDate 2025-04-26 18:30:22
*/
@Service
@RequiredArgsConstructor
@Slf4j
public class VipInfoServiceImpl extends ServiceImpl<VipInfoMapper, VipInfo>
    implements VipInfoService{
    private final VipInfoMapper vipInfoMapper;
    private final VipInfoConvert vipInfoConvert;
    private final VipAssetMapper vipAssetMapper;
    /**
     * 获取会员列表,条件查询
     *
     * @param query
     * @return
     */

    @Override
    public PageDTO<VipInfoVO> getList(VipListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        LambdaQueryWrapper<VipInfo> queryWrapper = Wrappers.lambdaQuery(VipInfo.class)
                .eq(VipInfo::getOrgId,auth.getOrgId());
        // 条件查询
        if (query.getQueryField() != null) {
            queryWrapper
            .like(VipInfo::getPhoneNumber, query.getQueryField()).or()
            .like(VipInfo::getName, query.getQueryField()).or()
            .like(VipInfo::getCardNumber, query.getQueryField());
        }
        //查询数据库
        Page<VipInfo> page = new Page<>(query.getPageNum(), query.getPageSize());
        vipInfoMapper.selectPage(page, queryWrapper);
        //转化为DTO
        return PageDTO.create(page, VipInfoVO.class);
    }

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

    /**
     * 添加vip
     * @param dto
     */
    @Override
    public void addVip(VipCreateDTO dto) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        VipInfo entity = vipInfoConvert.toEntity(dto);
        entity.setOrgId(auth.getOrgId());
        log.info("会员信息：{}", entity);
        this.save(entity);
    }

    /**
     * 修改会员信息
     * @param vip
     */
    @Override
    public void updateVip(VipUpdateDTO vip) {
        VipInfo entity = vipInfoConvert.toEntity(vip);
        log.info("会员信息：{}", entity);
        this.updateById(entity);
    }

}
