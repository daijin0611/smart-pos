package org.haut.server.vip.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.query.vip.RechargeHistoryQuery;
import org.haut.common.domain.vo.vip.RechargeHistoryVO;
import org.haut.server.vip.entity.VipRechargeHistory;
import org.haut.server.vip.service.VipRechargeHistoryService;
import org.haut.server.vip.mapper.VipRechargeHistoryMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author daiji
* @description 针对表【vip_recharge_history(充值记录表)】的数据库操作Service实现
* @createDate 2025-08-24 00:44:27
*/
@Service
@Slf4j
public class VipRechargeHistoryServiceImpl extends ServiceImpl<VipRechargeHistoryMapper, VipRechargeHistory>
    implements VipRechargeHistoryService{

    /**
     * 获取会员充值记录列表
     * @param query 查询参数
     * @return 充值记录列表
     */
    @Override
    public List<RechargeHistoryVO> getList(RechargeHistoryQuery query) {
        return this.baseMapper.getList(query);
    }
}




