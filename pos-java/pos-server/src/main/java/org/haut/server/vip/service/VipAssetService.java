package org.haut.server.vip.service;

import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.dto.vip.AssetCreateDTO;
import org.haut.common.domain.dto.vip.PresentAssetDTO;
import org.haut.common.domain.vo.vip.VipCountVO;
import org.haut.server.vip.entity.VipAsset;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author tinwf
* @description 针对表【vip_asset(会员资产表)】的数据库操作Service
* @createDate 2025-05-07 00:36:29
*/
public interface VipAssetService extends IService<VipAsset> {

    /**
     * 创建会员资产
     * @param dto 创建信息
     * @return 资产编号
     */
    String createAsset(AssetCreateDTO dto);

    /**
     * 更新会员资产
     * @param asset 更新信息
     * @return 更新后的会员资产
     */
    VipAsset updateAsset(VipAsset asset);

    /**
     * 查询会员资产
     * @param vipId 会员id
     * @return 会员资产
     */
    VipCountVO queryAsset(Long vipId);

    /**
     * 处理下余额扣减
     * @param dto 订单结算信息
     */
    void handelOrder(OrderSettleDTO dto);

    /**
     * 修改会员资产备注
     *
     * 根据资产ID更新其备注信息。
     *
     * @param assetId 资产ID
     * @param remark  新的备注内容
     */
    void updateAssetRemark(Long assetId, String remark);

}
