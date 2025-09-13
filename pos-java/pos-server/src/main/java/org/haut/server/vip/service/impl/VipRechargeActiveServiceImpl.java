package org.haut.server.vip.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

import org.haut.common.constant.Const;
import org.haut.common.domain.dto.server.RelatedTicketDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.vip.VipRechargeActiveAddDTO;
import org.haut.common.domain.dto.vip.VipRechargeActiveStatusDTO;
import org.haut.common.domain.query.vip.ActiveStatQuery;
import org.haut.common.domain.vo.vip.RechargeHistoryVO;
import org.haut.common.enums.RechargeActiveTypeEnum;
import org.haut.server.vip.entity.VipRechargeActive;
import org.haut.server.vip.entity.VipRechargeActiveTicket;
import org.haut.common.domain.query.vip.VipRechargeActiveQuery;
import org.haut.common.domain.vo.vip.VipRechargeActiveVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.vip.entity.VipRechargeHistory;
import org.haut.server.vip.mapper.VipRechargeActiveMapper;
import org.haut.server.vip.mapper.VipRechargeActiveTicketMapper;
import org.haut.server.vip.mapper.VipRechargeHistoryMapper;
import org.haut.server.vip.service.VipRechargeActiveService;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 充值活动服务实现类
 * 
 * 实现充值活动的业务逻辑处理，包括查询、新增、状态修改等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025-08-20
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class VipRechargeActiveServiceImpl extends ServiceImpl<VipRechargeActiveMapper, VipRechargeActive>
        implements VipRechargeActiveService {

    private final VipRechargeActiveConvert vipRechargeActiveConvert;
    private final VipRechargeActiveTicketMapper vipRechargeActiveTicketMapper;
    /**
     * 查询充值活动列表
     * 
     * @param query 查询条件
     * @return 充值活动列表
     */
    @Override
    public List<VipRechargeActiveVO> queryList(VipRechargeActiveQuery query) {
        log.info("查询充值活动列表，查询条件：{}", query);
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        // 转换为VO并返回
        return this.baseMapper.queryList(query, auth.getOrgId());
    }
    
    /**
     * 新增充值活动
     * 
     * @param addDTO 新增数据
     * @return 操作结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean addRechargeActive(VipRechargeActiveAddDTO addDTO) {
        log.info("新增充值活动，数据：{}", addDTO);
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        VipRechargeActive entity = vipRechargeActiveConvert.toEntity(addDTO).setOrgId(auth.getOrgId());
        long count = this.count(Wrappers.lambdaQuery(VipRechargeActive.class)
                .eq(VipRechargeActive::getActiveName, entity.getActiveName())
                .eq(VipRechargeActive::getOrgId, entity.getOrgId()));
        if (count > 0)
            throw new BusinessException("活动名称已存在");

        // 插入活动
        if (Const.YES.equals(entity.getPresentDiscountIsSame()) &&
                entity.getActiveType().equals(RechargeActiveTypeEnum.AMOUNT.getValue())){
            entity.setPresentDiscount(entity.getActiveDiscount())
                    .setPresentBase(entity.getActiveBase())
                    .setPresentIsCrossStore(entity.getIsCrossStore());
        }
        this.save(entity);

        // 插入关联表
        List<RelatedTicketDTO> ticketIds = addDTO.getTicketIds();
        List<VipRechargeActiveTicket> list = ticketIds.stream().map((ticket) -> new VipRechargeActiveTicket()
                .setTicketId(ticket.getVipTicketId())
                .setActiveId(entity.getId())
                .setNumber(ticket.getVipTicketNum())
                .setTicketName(ticket.getVipTicketName())
        ).toList();
        vipRechargeActiveTicketMapper.insert(list);
        return true;
    }
    
    /**
     * 修改充值活动状态
     * 
     * @param statusDTO 状态修改数据
     * @return 操作结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateStatus(VipRechargeActiveStatusDTO statusDTO) {
        log.info("修改充值活动状态，数据：{}", statusDTO);
        this.lambdaUpdate().eq(VipRechargeActive::getId, statusDTO.getId())
                .set(VipRechargeActive::getActiveStatus, statusDTO.getActiveStatus())
                .update();
        return true;
    }

}

@Mapper(componentModel = "spring")
interface VipRechargeActiveConvert {
    VipRechargeActive toEntity(VipRechargeActiveAddDTO addDTO);
}