package org.haut.server.vip.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.vip.VipTicketCreateDTO;
import org.haut.common.domain.entity.vip.VipTicket;
import org.haut.common.domain.entity.vip.VipTicketDetail;
import org.haut.common.domain.query.vip.VipTicketListQuery;
import org.haut.common.exception.BusinessException;
import org.haut.server.vip.mapper.VipTicketDetailMapper;
import org.haut.server.vip.service.VipTicketService;
import org.haut.server.vip.mapper.VipTicketMapper;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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
        Long hasName = this.baseMapper.selectCount(Wrappers.lambdaQuery(VipTicket.class)
                .eq(VipTicket::getTicketName, ticket.getTicketName()));
        if (hasName > 0){
            throw new BusinessException("优惠券名称已存在");
        }
        // 插入优惠券
        VipTicket entity = convert.toEntity(ticket);
        this.baseMapper.insert(entity);

        // 插入关联表
        Long ticketId = entity.getId();
        List<VipTicketDetail> details = ticket.getServerItemIds().stream()
                .map(itemId -> new VipTicketDetail().setTicketId(ticketId).setServerItemId(itemId))
                .toList();
        vipTicketDetailMapper.insert(details);
    }

    @Override
    public void getList(VipTicketListQuery query) {
        this.baseMapper.getList(query);
    }
}




@Mapper(componentModel = "spring")
interface VipTicketConvert {
    VipTicket toEntity(VipTicketCreateDTO dto);
}