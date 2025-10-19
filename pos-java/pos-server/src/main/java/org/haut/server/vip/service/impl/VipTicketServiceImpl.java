package org.haut.server.vip.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.vip.VipTicketCreateDTO;
import org.haut.common.domain.dto.vip.VipTicketUpdateDTO;
import org.haut.server.vip.entity.VipTicket;
import org.haut.server.vip.entity.VipTicketDetail;
import org.haut.common.domain.query.vip.VipTicketListQuery;
import org.haut.common.domain.vo.vip.VipTicketVO;
import org.haut.common.enums.TicketTypeEnum;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.vip.mapper.VipTicketDetailMapper;
import org.haut.server.vip.service.VipTicketService;
import org.haut.server.vip.mapper.VipTicketMapper;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Mapper(componentModel = "spring")
interface VipTicketConvert {
    @Mapping(target = "remark", source = "ticketDescription")
    VipTicket toEntity(VipTicketCreateDTO dto);
    @Mapping(target = "remark", source = "ticketDescription")
    VipTicket toEntity(VipTicketUpdateDTO dto);
    @Mapping(target = "ticketDescription", source = "remark")
    VipTicketVO toVO(VipTicket entity);
}
/**
* @author Cdh
* @description 针对表【vip_ticket(会员优惠券)】的数据库操作Service实现
* @createDate 2025-05-11 10:14:04
*/
@Service
@RequiredArgsConstructor
public class VipTicketServiceImpl extends ServiceImpl<VipTicketMapper, VipTicket>
    implements VipTicketService{
    private final VipTicketConvert convert;
    private final VipTicketDetailMapper vipTicketDetailMapper;
    @Override
    @Transactional
    public void addTicket(VipTicketCreateDTO ticket) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Long hasName = this.baseMapper.selectCount(Wrappers.lambdaQuery(VipTicket.class)
                .eq(VipTicket::getTicketName, ticket.getTicketName())
                .eq(auth.getOrgId() != null,VipTicket::getOrgId, auth.getOrgId()));
        if (hasName > 0){
            throw new BusinessException("优惠券名称已存在");
        }
        // 插入优惠券
        VipTicket entity = convert.toEntity(ticket).setOrgId(auth.getOrgId());
        this.baseMapper.insert(entity);

        // 插入关联表
        Long ticketId = entity.getId();
        List<VipTicketDetail> details = ticket.getServerItemIds().stream()
                .map(itemId -> new VipTicketDetail().setTicketId(ticketId).setServerItemId(itemId))
                .toList();
        vipTicketDetailMapper.insert(details);
    }

    @Override
    public List<VipTicketVO> getList(VipTicketListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        return this.baseMapper.getList(query,auth.getOrgId());
    }

    @Transactional
    @Override
    public void updateTicket(VipTicketUpdateDTO ticket) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Long hasName = this.baseMapper.selectCount(Wrappers.lambdaQuery(VipTicket.class)
                .eq(VipTicket::getTicketName, ticket.getTicketName())
                .eq(VipTicket::getOrgId, auth.getOrgId())
                .ne(VipTicket::getId, ticket.getId()));
        if (hasName > 0){
            throw new BusinessException("优惠券名称已存在");
        }
        // 更新优惠券
        VipTicket entity = convert.toEntity(ticket);
        this.baseMapper.updateById(entity);

        // 代金券类型直接结束
        if (ticket.getTicketType().equals(TicketTypeEnum.CONSUMER.getValue()))
            return;

        // 更新关联表
        if (ticket.getServerItemIds() == null || ticket.getServerItemIds().isEmpty())
            throw  new BusinessException("请选择关联项目");

        Long ticketId = entity.getId();
        List<VipTicketDetail> details = ticket
                .getServerItemIds().stream()
                .map(itemId -> new VipTicketDetail().setTicketId(ticketId).setServerItemId(itemId))
                .toList();
        // 先清除所有的关联id
        vipTicketDetailMapper.delete(Wrappers.lambdaQuery(VipTicketDetail.class)
                .eq(VipTicketDetail::getTicketId, ticketId));
        // 更新关联表
        vipTicketDetailMapper.insertOrUpdate(details);
    }

    @Override
    public void updateStatus(Long ticketId, Integer status) {
        if (status != 0 && status != 1){
            throw new BusinessException("状态修改失败");
        }
        this.baseMapper.update(Wrappers.lambdaUpdate(VipTicket.class)
                .eq(VipTicket::getId, ticketId)
                .set(VipTicket::getTicketStatus, status));
    }

    /**
     * 查询优惠券详情
     * @param ticketId 优惠券id
     * @return 优惠券详情
     */
    @Override
    public VipTicketVO queryById(Long ticketId) {
        return baseMapper.getOneById(ticketId);
    }

    @Override
    public List<VipTicketVO> queryByIds(List<Long> ticketIds) {
        return baseMapper.getListByIds(ticketIds);
    }

    private void checkDto(VipTicketUpdateDTO ticket) {
        if (ticket.getTicketType().equals(TicketTypeEnum.CONSUMER.getValue())){
            if (ticket.getTicketValue() == null)
                throw new BusinessException("优惠券面值不能为空");
            if (ticket.getTicketFullPayment() == null)
                throw new BusinessException("优惠券限额不能为空");
        }
    }

    private void checkDto(VipTicketCreateDTO ticket) {
        if (ticket.getTicketType().equals(TicketTypeEnum.CONSUMER.getValue())){
            if (ticket.getTicketValue() == null)
                throw new BusinessException("优惠券面值不能为空");
            if (ticket.getTicketFullPayment() == null)
                throw new BusinessException("优惠券限额不能为空");
        }
    }
}
