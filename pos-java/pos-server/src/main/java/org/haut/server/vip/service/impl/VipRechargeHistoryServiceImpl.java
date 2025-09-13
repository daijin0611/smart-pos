package org.haut.server.vip.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.vip.ActiveStatQuery;
import org.haut.common.domain.query.vip.RechargeHistoryQuery;
import org.haut.common.domain.vo.vip.RechargeHistoryVO;
import org.haut.common.domain.vo.vip.StatRechargeActiveVO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.vip.entity.VipRechargeHistory;
import org.haut.server.vip.service.VipRechargeHistoryService;
import org.haut.server.vip.mapper.VipRechargeHistoryMapper;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Mapper(componentModel = "spring")
interface VipRechargeHistoryConvert {
    VipRechargeHistory toEntity(RechargeHistoryVO vo);
    RechargeHistoryVO toVO(VipRechargeHistory entity);
    List<RechargeHistoryVO> toVO(List<VipRechargeHistory> entityList);
}

/**
* @author daiji
* @description 针对表【vip_recharge_history(充值记录表)】的数据库操作Service实现
* @createDate 2025-08-24 00:44:27
*/
@Service
@Slf4j
@RequiredArgsConstructor
public class VipRechargeHistoryServiceImpl extends ServiceImpl<VipRechargeHistoryMapper, VipRechargeHistory>
    implements VipRechargeHistoryService{
    private final VipRechargeHistoryConvert convert;
    /**
     * 获取会员充值记录列表
     * @param query 查询参数
     * @return 充值记录列表
     */
    @Override
    public List<RechargeHistoryVO> getList(RechargeHistoryQuery query) {
        return this.baseMapper.getList(query);
    }


    /**
     * 统计会员充值记录
     *
     * @param query
     * @return
     */
    @Override
    public StatRechargeActiveVO statRechargeActive(ActiveStatQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        List<VipRechargeHistory> vipRechargeHistories = this.list(Wrappers.lambdaQuery(VipRechargeHistory.class)
                .eq(VipRechargeHistory::getActivityId, query.getActiveId())
                .eq(VipRechargeHistory::getOrgId, auth.getOrgId())
                .between(query.getStartTime() != null && query.getEndTime() != null,
                        VipRechargeHistory::getRechargeTime,
                        query.getStartTime(),
                        query.getEndTime())
                .orderByDesc(VipRechargeHistory::getId)
        );
        // 总赠送优惠券数量
        int ticketSum = vipRechargeHistories.stream().mapToInt(VipRechargeHistory::getTicketNum).sum();
        // 总赠送金额
        BigDecimal presentValueSum = vipRechargeHistories.stream()
                .map(VipRechargeHistory::getPresentValue)
                .reduce(BigDecimal::add)
                .orElse(BigDecimal.ZERO);
        // 总充值金额
        BigDecimal rechargeValueSum = vipRechargeHistories.stream()
                .map(VipRechargeHistory::getRechargeValue)
                .reduce(BigDecimal::add)
                .orElse(BigDecimal.ZERO);
        // 总人数
        int vipNum = vipRechargeHistories.stream().map(VipRechargeHistory::getVipId).distinct().toList().size();
        return null;
    }
}




