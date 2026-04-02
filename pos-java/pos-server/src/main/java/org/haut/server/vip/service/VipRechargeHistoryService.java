package org.haut.server.vip.service;

import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.query.vip.ActiveStatQuery;
import org.haut.common.domain.query.vip.RechargeHistoryQuery;
import org.haut.common.domain.vo.vip.RechargeHistoryVO;
import org.haut.common.domain.vo.vip.StatRechargeActiveVO;
import org.haut.server.vip.entity.VipRechargeHistory;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author daiji
* @description 针对表【vip_recharge_history(充值记录表)】的数据库操作Service
* @createDate 2025-08-24 00:44:27
*/
public interface VipRechargeHistoryService extends IService<VipRechargeHistory> {

    PageDTO<RechargeHistoryVO> getList(RechargeHistoryQuery query);

    StatRechargeActiveVO statRechargeActive(ActiveStatQuery query);

}
