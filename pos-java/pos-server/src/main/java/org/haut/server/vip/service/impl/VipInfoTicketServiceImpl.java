package org.haut.server.vip.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.dto.order.OrderTicketUseDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.vip.VipInfoTicketCreateDTO;
import org.haut.common.domain.query.vip.VipInfoTicketQuery;
import org.haut.common.domain.vo.ResultStatus;
import org.haut.common.domain.vo.vip.TicketCountVO;
import org.haut.common.domain.vo.server.ServerItemVO;
import org.haut.common.domain.vo.vip.VipTicketVO;
import org.haut.common.enums.TicketStatusEnum;
import org.haut.common.enums.TicketTypeEnum;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.mapper.OrderDetailMapper;
import org.haut.server.vip.entity.VipInfoTicket;
import org.haut.server.vip.entity.VipTicket;
import org.haut.server.vip.mapper.VipTicketMapper;
import org.haut.server.vip.service.VipInfoTicketService;
import org.haut.server.vip.mapper.VipInfoTicketMapper;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring")
interface VipInfoTicketConvert {
    VipInfoTicket toEntity(VipInfoTicketCreateDTO dto);
    List<TicketCountVO> toVOS(List<VipInfoTicket> entity);
}
/**
* @author daiji
* @description 针对表【vip_info_ticket(会员信息与优惠券关联表（优惠券明细）)】的数据库操作Service实现
* @createDate 2025-08-25 11:46:41
*/
@Service
@RequiredArgsConstructor
@Slf4j
public class VipInfoTicketServiceImpl extends ServiceImpl<VipInfoTicketMapper, VipInfoTicket>
    implements VipInfoTicketService{
    private final VipInfoTicketConvert vipInfoTicketConvert;
    private final VipTicketMapper vipTicketMapper;
    private final OrderDetailMapper orderDetailMapper;


    /**
     * 添加会员优惠券
     * @param dto 添加参数
     * @return 优惠券添加信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String createVipInfoTicket(VipInfoTicketCreateDTO dto) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        VipTicket vipTicket = vipTicketMapper.selectById(dto.getVipTicketId());
        List<VipInfoTicket> vipInfoTickets = new ArrayList<>();
        for (int i = 0; i < dto.getNumber(); i++){
            vipInfoTickets.add(vipInfoTicketConvert.toEntity(dto)
                    .setTicketCode(CodeUtils.generateByTime(PrefixConst.TICKET))
                    .setStatus(TicketStatusEnum.UNUSED.getStatus())
                    .setClaimTime(LocalDate.now())
                    .setOrgId(auth.getOrgId())
                    .setTicketType(vipTicket.getTicketType())
                    .setExpiryDate(vipTicket.getTicketEffectiveTime() == -1 ?
                            null : LocalDate.now().plusDays(vipTicket.getTicketEffectiveTime()))
            );
        }
        this.baseMapper.insert(vipInfoTickets);
        return vipTicket.getTicketName() + "(" + dto.getNumber() + "张)\n";
    }

    /**
     * 分页查询会员优惠券
     * @param query 查询参数
     * @return 分页结果
     */
    @Override
    public PageDTO<TicketCountVO> queryTicketCountPage(VipInfoTicketQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        // 使用LambdaQuery构建查询条件
        Page<VipInfoTicket> page = lambdaQuery()
                .and(StringUtils.hasText(query.getVipInfoFiled()), 
                    wrapper -> wrapper
                        .like(VipInfoTicket::getVipName, query.getVipInfoFiled())
                        .or()
                        .like(VipInfoTicket::getVipPhoneNumber, query.getVipInfoFiled())
                        .or()
                        .like(VipInfoTicket::getVipCardNumber, query.getVipInfoFiled())
                )
                .eq(StringUtils.hasText(query.getStatus()),
                    VipInfoTicket::getStatus, query.getStatus())
                .eq(query.getActiveId() != null,
                    VipInfoTicket::getActiveId, query.getActiveId())
                .eq(query.getVipTicketId() != null,
                    VipInfoTicket::getVipTicketId, query.getVipTicketId())
                .eq(VipInfoTicket::getOrgId, auth.getOrgId())
                .orderByDesc(VipInfoTicket::getCreateTime)
                .page(new Page<>(query.getPageNum(), query.getPageSize()));

        // 转换为VO并返回
        return PageDTO.create(page, TicketCountVO.class);
    }

    /**
     * 订单结算处理优惠券
     * @param settleOrderDTO 订单结算信息
     * @param orderCode 订单编号
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void handelOrder(OrderSettleDTO settleOrderDTO, String orderCode) {
        // 1. 校验优惠券是否已经使用
        List<OrderTicketUseDTO> useTickets = settleOrderDTO.getTicketUseList();
        List<Long> ticketIds = useTickets.stream()
                .map(OrderTicketUseDTO::getTicketId)
                .toList();
        if (ticketIds.isEmpty())
            return;
        List<VipInfoTicket> vipInfoTickets = listByIds(ticketIds);
        validateTickets(vipInfoTickets, useTickets, settleOrderDTO.getTotalAmount());
        // 2. 更新优惠券状态
        lambdaUpdate()
            .in(VipInfoTicket::getId, ticketIds)
            .set(VipInfoTicket::getStatus, TicketStatusEnum.USED.getStatus())
                .set(VipInfoTicket::getUsedOrderCode, orderCode)
            .update();
        log.info("更新优惠券状态完成");
    }

    /**
     * 优惠券使用校验
     * @param vipInfoTickets 优惠券列表
     */
    private void validateTickets(List<VipInfoTicket> vipInfoTickets, List<OrderTicketUseDTO> useTickets, BigDecimal totalValue){
        if (vipInfoTickets.isEmpty())
            return;
        log.info("开始校验优惠券");
        List<VipInfoTicket> usedTickets = vipInfoTickets.stream()
                // 已使用的优惠券
                .filter(t -> TicketStatusEnum.USED.getStatus().equals(t.getStatus()))
                .toList();
        if (!usedTickets.isEmpty())
            throw new BusinessException("优惠券已使用");
        List<VipInfoTicket> expireTickets = vipInfoTickets.stream()
                // 过期优惠券
                .filter(t -> t.getExpiryDate() != null && t.getExpiryDate().isBefore(LocalDate.now()))
                .toList();
        if (!expireTickets.isEmpty())
            throw new BusinessException("优惠券已过期");
        for (OrderTicketUseDTO ticket : useTickets){
            VipInfoTicket ticketEntity = getById(ticket.getTicketId());
            VipTicketVO ticketInfo = vipTicketMapper.getOneById(ticketEntity.getVipTicketId());
            OrderDetailEntity detail = orderDetailMapper.selectById(ticket.getDetailId());
            // 代金券类型
            //TODO: 目前代金券限额按照标准价校验
            if (TicketTypeEnum.CONSUMER.getValue().equals(ticket.getTicketType())){
                if (totalValue.compareTo(ticketInfo.getTicketFullPayment()) < 0)
                    throw new BusinessException(String.format("代金券需要满足%s元才可使用",
                            ticketInfo.getTicketFullPayment().toString()));
            }
            // 体验券类型
            else if (TicketTypeEnum.ITEM.getValue().equals(ticket.getTicketType())){
                if (ticket.getDetailId() == null)
                    throw new BusinessException("体验券未选择项目");
                Set<Long> itemIdSet = ticketInfo.getServerItems()
                        .stream()
                        .map(VipTicketVO.ServerItemVO::getId)
                        .collect(Collectors.toSet());
                if (!itemIdSet.contains(detail.getBid()))
                    throw new BusinessException(String.format("%s项目不在%s体验券使用范围内！",
                            detail.getBusinessName(),
                            ticketInfo.getTicketName()));
            }
            // 项目券类型
            else {
                log.warn("优惠券类型错误{}",ticket);
                throw new BusinessException("优惠券类型错误");
            }
        }
        log.info("优惠券校验通过");
    }

}





