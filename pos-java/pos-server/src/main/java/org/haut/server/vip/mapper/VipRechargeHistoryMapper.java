package org.haut.server.vip.mapper;

import org.apache.ibatis.annotations.Param;
import org.haut.common.domain.query.vip.RechargeHistoryQuery;
import org.haut.common.domain.vo.vip.RechargeHistoryVO;
import org.haut.server.vip.entity.VipRechargeHistory;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author daiji
* @description 针对表【vip_recharge_history(充值记录表)】的数据库操作Mapper
* @createDate 2025-08-24 00:44:27
* @Entity org.haut.server.vip.entity.VipRechargeHistory
*/
public interface VipRechargeHistoryMapper extends BaseMapper<VipRechargeHistory> {

    List<RechargeHistoryVO> getList(@Param("query") RechargeHistoryQuery query, @Param("orgId") Long orgId);
}




