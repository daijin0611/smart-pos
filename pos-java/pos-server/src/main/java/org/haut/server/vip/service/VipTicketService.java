package org.haut.server.vip.service;

import org.haut.common.domain.dto.vip.VipTicketCreateDTO;
import org.haut.common.domain.dto.vip.VipTicketUpdateDTO;
import org.haut.server.vip.entity.VipTicket;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.query.vip.VipTicketListQuery;
import org.haut.common.domain.vo.vip.VipTicketVO;

import java.util.List;

/**
* @author Cdh
* @description 针对表【vip_ticket(会员优惠券)】的数据库操作Service
* @createDate 2025-05-11 10:14:04
*/
public interface VipTicketService extends IService<VipTicket> {

    void addTicket(VipTicketCreateDTO ticket);

    List<VipTicketVO> getList(VipTicketListQuery query);

    void updateTicket(VipTicketUpdateDTO ticket);

    void updateStatus(Long ticketId, Integer status);

    VipTicketVO queryById(Long ticketId);

    List<VipTicketVO> queryByIds(List<Long> ticketIds);
}
