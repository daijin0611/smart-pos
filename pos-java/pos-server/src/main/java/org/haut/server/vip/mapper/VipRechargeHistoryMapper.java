package org.haut.server.vip.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.haut.common.domain.query.vip.RechargeHistoryQuery;
import org.haut.common.domain.vo.vip.RechargeHistoryVO;
import org.haut.server.vip.entity.VipRechargeHistory;

/**
* @author daiji
* @description 针对表【vip_recharge_history(充值记录表)】的数据库操作Mapper
* @createDate 2025-08-24 00:44:27
* @Entity org.haut.server.vip.entity.VipRechargeHistory
*/
public interface VipRechargeHistoryMapper extends BaseMapper<VipRechargeHistory> {

    IPage<RechargeHistoryVO> getList(Page<RechargeHistoryVO> page, @Param("query") RechargeHistoryQuery query, @Param("orgId") Long orgId);
}




