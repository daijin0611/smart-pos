package org.haut.server.server.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.order.OrderDetailSettleDTO;
import org.haut.common.domain.dto.server.RelatedTicketDTO;
import org.haut.common.domain.dto.server.CureTicketCreateDTO;
import org.haut.common.domain.dto.server.CureTicketStatusDTO;
import org.haut.common.domain.dto.server.CureTicketUpdateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.server.ServerCureTicketListQuery;
import org.haut.common.domain.vo.vip.VipTicketVO;
import org.haut.common.enums.ServiceTypeEnum;
import org.haut.common.enums.TicketSourceType;
import org.haut.common.enums.TicketStatusEnum;
import org.haut.common.utils.CodeUtils;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.server.entity.ServerCureTicket;
import org.haut.server.server.entity.ServerCureTicketDetail;
import org.haut.common.domain.vo.server.ServerCureTicketVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.server.mapper.ServerCureTicketDetailMapper;
import org.haut.server.server.mapper.ServerCureTicketMapper;
import org.haut.server.server.service.ServerCureTicketService;
import org.haut.server.vip.entity.VipInfo;
import org.haut.server.vip.entity.VipInfoTicket;
import org.haut.server.vip.mapper.VipTicketMapper;
import org.haut.server.vip.service.VipInfoTicketService;
import org.haut.server.vip.service.impl.VipInfoServiceImpl;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.*;

@Service
@RequiredArgsConstructor
public class ServerCureTicketServiceImpl extends ServiceImpl<ServerCureTicketMapper, ServerCureTicket>
        implements ServerCureTicketService {
    private final ServerCureTicketDetailMapper serverCureTicketDetailMapper;
    private final CureTicketConvert cureTicketConvert;
    private final CureTicketDetailConvert cureTicketDetailConvert;
    private final VipTicketMapper vipTicketMapper;
    private final VipInfoTicketService vipInfoTicketService;


    /**
     * 保存疗程券
     * @param cureTicket
     */
    @Override
    @Transactional
    public void saveCureTicket(CureTicketCreateDTO cureTicket) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Long count = this.baseMapper.selectCount(Wrappers.lambdaQuery(ServerCureTicket.class)
                .eq(ServerCureTicket::getName, cureTicket.getName())
                .eq(auth.getOrgId() != null, ServerCureTicket::getOrgId, auth.getOrgId()));
        if (count > 0){
            throw new BusinessException("疗程券名称已存在");
        }
        // 插入疗程券
        ServerCureTicket entity = cureTicketConvert.toEntity(cureTicket);
        entity.setOrgId(auth.getOrgId());
        this.baseMapper.insert(entity);

        // 插入关联表
        Long ticketId = entity.getId();
        List<ServerCureTicketDetail> details = cureTicket.getVipTicketList().stream()
                .map(detailDTO -> {
                    ServerCureTicketDetail detail = cureTicketDetailConvert.toEntity(detailDTO);
                    detail.setCureTicketId(ticketId);
                    return detail;
                })
                .toList();
        serverCureTicketDetailMapper.insert(details);
    }

    /**
     * 更新疗程券
     * @param cureTicket
     */
    @Override
    public void updateCureTicket(CureTicketUpdateDTO cureTicket) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Long count = this.baseMapper.selectCount(Wrappers.lambdaQuery(ServerCureTicket.class)
                .eq(ServerCureTicket::getName, cureTicket.getName())
                .eq(auth.getOrgId() != null, ServerCureTicket::getOrgId, auth.getOrgId())
                .ne(ServerCureTicket::getId, cureTicket.getId()));
        if (count > 0){
            throw new BusinessException("疗程券名称已存在");
        }
        // 更新优惠券主表
        ServerCureTicket entity = cureTicketConvert.toEntity(cureTicket);
        this.updateById(entity);
        // 删除关联表
        serverCureTicketDetailMapper.delete(Wrappers.lambdaQuery(ServerCureTicketDetail.class)
                .eq(ServerCureTicketDetail::getCureTicketId, cureTicket.getId()));
        // 插入关联表
        Long cureTicketId = cureTicket.getId();
        List<ServerCureTicketDetail> details = cureTicket.getVipTicketList().stream()
                .map(detailDTO -> {
                    ServerCureTicketDetail detail = cureTicketDetailConvert.toEntity(detailDTO);
                    detail.setCureTicketId(cureTicketId);
                    return detail;
                })
                .toList();
        serverCureTicketDetailMapper.insert(details);
    }

    /**
     * 获取治疗券列表
     * @param query
     * @return
     */
    @Override
    public List<ServerCureTicketVO> getList(ServerCureTicketListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        return this.baseMapper.getList(query, auth.getOrgId());
    }

    /**
     * 修改疗程券状态
     * @param cureTicketStatus
     */
    @Override
    public void updateCureTicketStatus(CureTicketStatusDTO cureTicketStatus) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        // 检查疗程券是否存在
        ServerCureTicket existingTicket = this.baseMapper.selectOne(Wrappers.lambdaQuery(ServerCureTicket.class)
                .eq(ServerCureTicket::getId, cureTicketStatus.getId())
                .eq(auth.getOrgId() != null, ServerCureTicket::getOrgId, auth.getOrgId()));
        if (existingTicket == null) {
            throw new BusinessException("疗程券不存在");
        }
        
        // 更新状态
        ServerCureTicket updateEntity = new ServerCureTicket();
        updateEntity.setId(cureTicketStatus.getId());
        updateEntity.setStatus(cureTicketStatus.getStatus());
        this.updateById(updateEntity);
    }

    /**
     * 处理订单中的疗程券
     * @param dto
     */
    @Override
    public void handelOrder(List<OrderDetailSettleDTO> dto, OrderInfoEntity order) {
        List<VipInfoTicket> insertTicket = new ArrayList<>();
        dto.stream()
                .filter(e -> e.getDetailType().equals(ServiceTypeEnum.CURE_TICKET.getValue()))
                .forEach(e->{
                    if (order.getVipId()==null)
                        throw new BusinessException("购买疗程券必须选择会员");
                    ServerCureTicketVO cureTicketVO = baseMapper.getOneById(e.getBid());
                    List<VipInfoTicket> ticketInfoList = new ArrayList<>();
                    cureTicketVO.getTicketDetails()
                    .forEach(detail -> {
                        VipTicketVO ticketInfo = vipTicketMapper.getOneById(detail.getVipTicketId());
                        VipInfoTicket ticket = new VipInfoTicket()
                                .setTicketType(ticketInfo.getTicketType())
                                .setTicketName(ticketInfo.getTicketName())
                                .setTicketCode(CodeUtils.generateByTime(PrefixConst.TICKET))
                                .setVipInfoId(order.getVipId())
                                .setVipTicketId(detail.getVipTicketId())
                                .setVipName(order.getVipName())
                                .setVipPhoneNumber(order.getVipPhoneNumber())
                                .setVipCardNumber(order.getVipCardNumber())
                                .setStatus(TicketStatusEnum.UNUSED.getStatus())
                                .setClaimTime(LocalDate.now())
                                .setExpiryDate(ticketInfo.getTicketEffectiveTime() == -1 ?
                                        null : LocalDate.now().plusDays(ticketInfo.getTicketEffectiveTime()))
                                .setActiveId(null)
                                .setOrgId(order.getOrgId())
                                .setRemark("疗程券获取[订单：" + order.getOrderCode() + "]")
                                .setSourceType(TicketSourceType.ORDER.getCode())
                                .setSourceCode(order.getOrderCode());
                        for (int i=0; i<detail.getVipTicketNum(); i++){
                            ticketInfoList.add(ticket);
                        }
                    });
            insertTicket.addAll(ticketInfoList);
        });
        vipInfoTicketService.saveBatch(insertTicket);
    }

}

@Mapper(componentModel = "spring")
interface CureTicketConvert {
    ServerCureTicket toEntity(CureTicketCreateDTO dto);
    ServerCureTicket toEntity(CureTicketUpdateDTO dto);
}

@Mapper(componentModel = "spring")
interface CureTicketDetailConvert {
    ServerCureTicketDetail toEntity(RelatedTicketDTO dto);
}