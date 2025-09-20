package org.haut.server.vip.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.vip.AssetCreateDTO;
import org.haut.common.domain.dto.vip.PaymentInfoDTO;
import org.haut.common.domain.vo.ResultStatus;
import org.haut.common.domain.vo.vip.VipAssetVO;
import org.haut.common.domain.vo.vip.VipCountVO;
import org.haut.common.enums.PaymentStatusEnum;
import org.haut.common.enums.PaymentTypeEnum;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.system.entity.SysDictItem;
import org.haut.server.system.service.SysDictItemService;
import org.haut.server.vip.entity.VipAsset;
import org.haut.server.vip.entity.VipInfo;
import org.haut.server.vip.entity.VipInfoTicket;
import org.haut.server.vip.entity.VipTicket;
import org.haut.server.vip.mapper.VipInfoMapper;
import org.haut.server.vip.mapper.VipTicketMapper;
import org.haut.server.vip.service.VipAssetService;
import org.haut.server.vip.mapper.VipAssetMapper;
import org.haut.server.vip.service.VipInfoTicketService;
import org.haut.server.vip.service.VipTicketService;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

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
    private final VipInfoTicketService vipInfoTicketService;
    private final VipInfoConvert vipInfoConvert;
    private final VipInfoTicketConvert vipInfoTicketConvert;
    private final SysDictItemService sysDictItemService;

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

    @Override
    public VipAsset updateAsset(VipAsset asset) {
        return null;
    }

    /**
     * 查询单个会员资产(余额+优惠券)
     * @param vipId 会员id
     * @return 会员资产
     */
    @Override
    public VipCountVO queryAsset(Long vipId) {
        VipInfo vipInfo = vipInfoMapper.selectById(vipId);
        if ( vipInfo == null)
            throw new BusinessException("会员不存在");
        List<VipAsset> assets = lambdaQuery().eq(VipAsset::getVipId, vipId).list();
        List<VipInfoTicket> tickets = vipInfoTicketService.lambdaQuery().eq(VipInfoTicket::getVipInfoId, vipId).list();
        return new VipCountVO()
                .setVipAssetVOList(vipAssetConvert.toVOS(assets))
                .setVipInfoVO(vipInfoConvert.toVO(vipInfo))
                .setVipTicketVOList(vipInfoTicketConvert.toVOS(tickets));
    }

    /**
     * 处理下余额扣减
     * 1. 校验余额是否符合要求
     * 2. 更新余额和会员信息
     * 3. 记录跨店消费
     * @param dto 订单结算信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void handelOrder(OrderSettleDTO dto) {
        AuthInfoDTO authInfo = AuthContextHolder.getAuth();
        List<VipAsset> vipAssets = listByIds(dto.getAssetIds());
        // 1. 校验是否折扣相同
        long c = vipAssets.stream()
                .map(VipAsset::getAssetDiscountRate)
                .distinct()
                .count();
        if (c > 0)
            throw new BusinessException("会员资产折扣率不同，请重新选择");
        // 2. 更新余额
        // 筛选会员卡支付的总金额
        BigDecimal totalAmount = dto.getPaymentInfoList().stream()
                .filter(p -> p.getPaymentType().toString().equals(PaymentTypeEnum.ASSET.getCode()))
                .map(PaymentInfoDTO::getPaymentAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        vipAssets.sort(Comparator.comparing(VipAsset::getAssetNum));
        for (VipAsset vipAsset : vipAssets) {
            // 当前金额大于等于卡中余额，直接清空余额
            if (totalAmount.compareTo(vipAsset.getAssetBalance()) >= 0){
                totalAmount = totalAmount.subtract(vipAsset.getAssetBalance());
                vipAssets.set(vipAssets.indexOf(vipAsset), vipAsset.setAssetBalance(BigDecimal.ZERO));
            }else {
                // 会员卡余额足够直接扣减
                vipAssets.set(vipAssets.indexOf(vipAsset), vipAsset.setAssetBalance(totalAmount));
            }
        }
        int count = 0;
        // 乐观锁
        while (saveOrUpdateBatch(vipAssets)){
            if (count > 10){
                log.error("会员资产更新异常");
                throw new BusinessException(ResultStatus.SERVER_BUSY.getMessage());
            }
            saveOrUpdateBatch(vipAssets);
            count++;
        }
        //3. TODO 跨店结算逻辑
    }


}

@Mapper(componentModel = "spring")
interface VipAssetConvert{
    VipAsset toEntity(AssetCreateDTO dto);
    List<VipAssetVO> toVOS(List<VipAsset> entity);
}




