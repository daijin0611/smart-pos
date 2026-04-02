package org.haut.server.server.service;

import org.haut.common.domain.dto.order.OrderDetailSettleDTO;
import org.haut.common.domain.dto.server.CureTicketCreateDTO;
import org.haut.common.domain.dto.server.CureTicketStatusDTO;
import org.haut.common.domain.dto.server.CureTicketUpdateDTO;
import org.haut.common.domain.query.server.ServerCureTicketListQuery;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.server.entity.ServerCureTicket;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.vo.server.ServerCureTicketVO;
import org.haut.server.vip.entity.VipInfo;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_cure_ticket(疗程券表)】的数据库操作Service
* @createDate 2025-05-06 14:07:02
*/
public interface ServerCureTicketService extends IService<ServerCureTicket> {

    List<ServerCureTicketVO> getList(ServerCureTicketListQuery query);

    void saveCureTicket(CureTicketCreateDTO cureTicket);

    void updateCureTicket(CureTicketUpdateDTO cureTicket);

    void updateCureTicketStatus(CureTicketStatusDTO cureTicketStatus);

    void handelOrder(List<OrderDetailSettleDTO> dto, OrderInfoEntity order);
}
