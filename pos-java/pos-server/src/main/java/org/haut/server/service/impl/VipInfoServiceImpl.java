package org.haut.server.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.common.domain.dto.vip.VipAssetDTO;
import org.haut.common.domain.dto.vip.VipInfoDTO;
import org.haut.common.domain.dto.vip.VipListDTO;
import org.haut.common.domain.query.VipListQuery;
import org.haut.server.entity.VipInfo;
import org.haut.server.mapper.VipAssetMapper;
import org.haut.server.service.VipInfoService;
import org.haut.server.mapper.VipInfoMapper;
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
        //构造条件查询器，当会员卡号、会员名、会员手机号不为空时，进行查询
        QueryWrapper<VipInfo> queryWrapper = new QueryWrapper<>();
        queryWrapper.like(StringUtils.isNotBlank(query.getVipCardNumber()),"info_card_number",query.getVipCardNumber())
                .like(StringUtils.isNotBlank(query.getVipName()),"info_name",query.getVipName())
                .like(StringUtils.isNotBlank(query.getVipPhone()),"info_phone_number",query.getVipPhone());
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




