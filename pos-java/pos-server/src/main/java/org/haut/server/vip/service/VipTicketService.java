package org.haut.server.vip.service;

import org.haut.common.domain.dto.vip.VipTicketCreateDTO;
import org.haut.common.domain.entity.vip.VipTicket;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.query.vip.VipTicketListQuery;

/**
* @author Cdh
* @description 针对表【vip_ticket(会员优惠券)】的数据库操作Service
* @createDate 2025-05-11 10:14:04
*/
public interface VipTicketService extends IService<VipTicket> {

    void addTicket(VipTicketCreateDTO ticket);

    void getList(VipTicketListQuery query);
}
