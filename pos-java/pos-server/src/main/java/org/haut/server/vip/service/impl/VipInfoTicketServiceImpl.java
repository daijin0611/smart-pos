package org.haut.server.vip.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.vip.VipInfoTicketCreateDTO;
import org.haut.common.enums.TicketStatusEnum;
import org.haut.server.vip.entity.VipInfoTicket;
import org.haut.server.vip.entity.VipTicket;
import org.haut.server.vip.mapper.VipTicketMapper;
import org.haut.server.vip.service.VipInfoTicketService;
import org.haut.server.vip.mapper.VipInfoTicketMapper;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
* @author daiji
* @description 针对表【vip_info_ticket(会员信息与优惠券关联表（优惠券明细）)】的数据库操作Service实现
* @createDate 2025-08-25 11:46:41
*/
@Service
@RequiredArgsConstructor
public class VipInfoTicketServiceImpl extends ServiceImpl<VipInfoTicketMapper, VipInfoTicket>
    implements VipInfoTicketService{
    private final VipInfoTicketConvert vipInfoTicketConvert;
    private final VipTicketMapper vipTicketMapper;


    /**
     * 添加会员优惠券
     * @param dto 添加参数
     * @return 优惠券添加信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String createVipInfoTicket(VipInfoTicketCreateDTO dto) {
        VipTicket vipTicket = vipTicketMapper.selectById(dto.getVipTicketId());
        List<VipInfoTicket> vipInfoTickets = new ArrayList<>();
        for (int i = 0; i < dto.getNumber(); i++){
            vipInfoTickets.add(vipInfoTicketConvert.toEntity(dto)
                    .setStatus(TicketStatusEnum.UNUSED.getStatus())
                    .setClaimTime(LocalDate.now())
                    .setExpiryDate(vipTicket.getTicketEffectiveTime() == -1 ?
                            null : LocalDate.now().plusDays(vipTicket.getTicketEffectiveTime()))
            );
        }
        this.baseMapper.insert(vipInfoTickets);
        return vipTicket.getTicketName() + "(" + dto.getNumber() + "张)\n";
    }
}

@Mapper(componentModel = "spring")
interface VipInfoTicketConvert {
    VipInfoTicket toEntity(VipInfoTicketCreateDTO dto);
}




