package org.haut.server.vip.service;

import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.vip.*;
import org.haut.common.domain.query.vip.VipListQuery;
import org.haut.server.vip.entity.VipInfo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.vo.vip.VipInfoVO;

import java.math.BigDecimal;

/**
* @author tinwf
* @description 针对表【vip_info(会员信息表)】的数据库操作Service
* @createDate 2025-04-26 18:30:22
*/
public interface VipInfoService extends IService<VipInfo> {

    // 获取会员列表的接口
    PageDTO<VipInfoVO> getList(VipListQuery query);

    /**
     * 根据会员ID查询详细信息（含资产余额）
     */
    VipInfoVO getVipById(Long id);

    BigDecimal updateVipBalance(Long vipId);

    VipInfoVO addVip(VipCreateDTO dto);

    void updateVip(VipUpdateDTO vip);

    void recharge(RechargeDTO dto);

    /**
     * 为会员赠送优惠券
     * 
     * @param vipId 会员ID
     * @param dto 赠送优惠券参数
     */
    void presentTicket(Long vipId, PresentTicketDTO dto);

    /**
     * 批量取消会员优惠券
     * 
     * @param vipId 会员ID
     * @param dto 取消优惠券参数
     */
    void cancelTicket(Long vipId, CancelTicketDTO dto);

    /**
     * 为会员赠送资产
     *
     * @param vipId 会员ID
     * @param dto 赠送资产参数
     */
    void presentAsset(Long vipId, PresentAssetDTO dto);

     /**
     * 更新会员备注
     *
     * @param vipId 会员ID
     * @param dto 更新会员备注参数
     */
    void updateRemark(Long vipId, VipRemarkUpdateDTO dto);

    /**
     * 充值冲正
     * @param dto 冲正参数
     */
    void reverseRecharge(RechargeReverseDTO dto);
}
