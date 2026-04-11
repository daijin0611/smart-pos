package org.haut.server.server.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.order.OrderDetailSettleDTO;
import org.haut.common.domain.dto.server.RelatedTicketDTO;
import org.haut.common.domain.dto.server.CureTicketCreateDTO;
import org.haut.common.domain.dto.server.CureTicketStatusDTO;
import org.haut.common.domain.dto.server.CureTicketUpdateDTO;
import org.haut.common.domain.query.server.ServerCureTicketListQuery;
import org.haut.common.domain.vo.vip.VipTicketVO;
import org.haut.common.enums.OrgRelationTypeEnum;
import org.haut.common.enums.ServiceTypeEnum;
import org.haut.common.enums.TicketSourceType;
import org.haut.common.enums.TicketStatusEnum;
import org.haut.common.utils.CodeUtils;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.server.entity.ServerCureTicket;
import org.haut.server.server.entity.ServerCureTicketDetail;
import org.haut.common.domain.vo.server.ServerCureTicketVO;
import org.haut.common.exception.BusinessException;
import org.haut.server.server.mapper.ServerCureTicketDetailMapper;
import org.haut.server.server.mapper.ServerCureTicketMapper;
import org.haut.server.server.service.ServerCureTicketService;
import org.haut.server.system.service.OrgRelationService;
import org.haut.server.system.service.SysOrgService;
import org.haut.common.domain.vo.system.OrgSimpleVO;
import org.haut.server.vip.entity.VipInfoTicket;
import org.haut.server.vip.mapper.VipTicketMapper;
import org.haut.server.vip.service.VipInfoTicketService;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ServerCureTicketServiceImpl extends ServiceImpl<ServerCureTicketMapper, ServerCureTicket>
        implements ServerCureTicketService {
    private final ServerCureTicketDetailMapper serverCureTicketDetailMapper;
    private final CureTicketConvert cureTicketConvert;
    private final CureTicketDetailConvert cureTicketDetailConvert;
    private final VipTicketMapper vipTicketMapper;
    private final VipInfoTicketService vipInfoTicketService;
    private final OrgRelationService orgRelationService;
    private final SysOrgService sysOrgService;


    /**
     * 保存疗程券
     * @param cureTicket
     */
    @Override
    @Transactional
    public void saveCureTicket(CureTicketCreateDTO cureTicket) {
        log.info("新增疗程券，数据：{}", cureTicket);
        // 校验编码唯一
        Long encodeCount = this.baseMapper.selectCount(Wrappers.lambdaQuery(ServerCureTicket.class)
                .eq(ServerCureTicket::getEncode, cureTicket.getEncode()));
        if (encodeCount > 0) {
            throw new BusinessException("疗程券编码已存在");
        }
        // 插入疗程券
        ServerCureTicket entity = cureTicketConvert.toEntity(cureTicket);
        this.baseMapper.insert(entity);

        // 绑定门店关联
        if (cureTicket.getOrgIds() != null && !cureTicket.getOrgIds().isEmpty()) {
            log.info("绑定疗程券门店关联，ticketId：{}，orgIds：{}", entity.getId(), cureTicket.getOrgIds());
            orgRelationService.bindOrgs(OrgRelationTypeEnum.CURE_TICKET.getValue(),
                    entity.getId(), cureTicket.getOrgIds());
        }

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
    @Transactional
    public void updateCureTicket(CureTicketUpdateDTO cureTicket) {
        log.info("更新疗程券，数据：{}", cureTicket);
        // 校验编码唯一
        Long encodeCount = this.baseMapper.selectCount(Wrappers.lambdaQuery(ServerCureTicket.class)
                .eq(ServerCureTicket::getEncode, cureTicket.getEncode())
                .ne(ServerCureTicket::getId, cureTicket.getId()));
        if (encodeCount > 0) {
            throw new BusinessException("疗程券编码已存在");
        }
        // 更新优惠券主表
        ServerCureTicket entity = cureTicketConvert.toEntity(cureTicket);
        this.updateById(entity);

        // 替换门店关联
        if (cureTicket.getOrgIds() != null) {
            log.info("更新疗程券门店关联，ticketId：{}，orgIds：{}", cureTicket.getId(), cureTicket.getOrgIds());
            orgRelationService.unbindOrgs(OrgRelationTypeEnum.CURE_TICKET.getValue(), cureTicket.getId());
            orgRelationService.bindOrgs(OrgRelationTypeEnum.CURE_TICKET.getValue(),
                    cureTicket.getId(), cureTicket.getOrgIds());
        }

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
        log.info("查询疗程券列表，查询条件：{}", query);
        List<Long> filteredItemIds = null;
        if (query.getOrgId() != null) {
            filteredItemIds = orgRelationService.getItemIdsByOrg(
                    OrgRelationTypeEnum.CURE_TICKET.getValue(), query.getOrgId());
            if (filteredItemIds.isEmpty()) {
                return Collections.emptyList();
            }
        }
        List<ServerCureTicketVO> voList = this.baseMapper.getList(query, filteredItemIds);
        if (!voList.isEmpty()) {
            List<Long> itemIds = voList.stream().map(ServerCureTicketVO::getId).toList();
            Map<Long, List<Long>> orgIdMap = orgRelationService.getOrgIdsByItems(
                    OrgRelationTypeEnum.CURE_TICKET.getValue(), itemIds);
            Set<Long> allOrgIds = orgIdMap.values().stream()
                    .flatMap(List::stream).collect(Collectors.toSet());
            Map<Long, OrgSimpleVO> orgVoMap = sysOrgService.getOrgSimpleMapByIds(allOrgIds);
            voList.forEach(vo -> {
                List<Long> idList = orgIdMap.getOrDefault(vo.getId(), Collections.emptyList());
                vo.setOrgs(idList.stream().map(orgVoMap::get)
                        .filter(Objects::nonNull).toList());
            });
        }
        return voList;
    }

    /**
     * 修改疗程券状态
     * @param cureTicketStatus
     */
    @Override
    public void updateCureTicketStatus(CureTicketStatusDTO cureTicketStatus) {
        // 检查疗程券是否存在
        ServerCureTicket existingTicket = this.getById(cureTicketStatus.getId());
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
                    // 计算总券数和每张券面额
                    int totalTicketCount = cureTicketVO.getTicketDetails().stream()
                            .mapToInt(ServerCureTicketVO.TicketDetailVO::getVipTicketNum)
                            .sum();
                    BigDecimal faceValue = cureTicketVO.getPrice().divide(
                            BigDecimal.valueOf(totalTicketCount), 2, RoundingMode.HALF_UP);
                    List<VipInfoTicket> ticketInfoList = new ArrayList<>();
                    cureTicketVO.getTicketDetails()
                            .forEach(detail -> {
                                VipTicketVO ticketInfo = vipTicketMapper.getOneById(detail.getVipTicketId());
                                for (int i = 0; i < detail.getVipTicketNum(); i++) {
                                    ticketInfoList.add(new VipInfoTicket()
                                            .setTicketType(ticketInfo.getTicketType())
                                            .setTicketName(ticketInfo.getTicketName())
                                            .setAmount(faceValue)
                                            .setTicketCode(CodeUtils.generateByTime(PrefixConst.TICKET))
                                            .setVipInfoId(order.getVipId())
                                            .setVipTicketId(detail.getVipTicketId())
                                            .setVipName(order.getVipName())
                                            .setVipPhoneNumber(order.getVipPhoneNumber())
                                            .setVipCardNumber(order.getVipCardNumber())
                                            .setStatus(TicketStatusEnum.UNUSED.getValue())
                                            .setClaimTime(LocalDate.now())
                                            .setExpiryDate(ticketInfo.getTicketEffectiveTime() == -1 ?
                                                    null : LocalDate.now().plusDays(ticketInfo.getTicketEffectiveTime()))
                                            .setActiveId(null)
                                            .setOrgId(order.getOrgId())
                                            .setRemark("疗程券获取[订单：" + order.getOrderCode() + "]")
                                            .setSourceType(TicketSourceType.ORDER.getCode())
                                            .setSourceCode(order.getOrderCode()));
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