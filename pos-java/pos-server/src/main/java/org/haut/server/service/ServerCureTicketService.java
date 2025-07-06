package org.haut.server.service;

import org.haut.common.domain.dto.server.CureTicketInfoDTO;
import org.haut.common.domain.dto.server.CureTicketListDTO;
import org.haut.common.domain.query.server.ServerCureTicketListQuery;
import org.haut.server.entity.ServerCureTicket;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_cure_ticket(疗程券表)】的数据库操作Service
* @createDate 2025-05-06 14:07:02
*/
public interface ServerCureTicketService extends IService<ServerCureTicket> {

    @Transactional(readOnly = true)
    CureTicketInfoDTO getCureTicketInfo(Long id);

    List<CureTicketListDTO> getList(ServerCureTicketListQuery query);

    List<CureTicketListDTO> getCureTicketWithVipTickets(ServerCureTicketListQuery query);

    CureTicketInfoDTO getCureTicketInfoById(Long id);

    void saveCureTicket(CureTicketInfoDTO cureTicket);

    void updateCureTicket(CureTicketInfoDTO cureTicket);
}
