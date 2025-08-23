package org.haut.server.server.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.server.server.entity.ServerCureTicketDetail;
import org.haut.server.server.service.ServerCureTicketDetailService;
import org.haut.server.server.mapper.ServerCureTicketDetailMapper;
import org.springframework.stereotype.Service;

/**
* @author Cdh
* @description 针对表【server_cure_ticket_detail(疗程券内容表（关联server_cure_ticket, vip_ticket）)】的数据库操作Service实现
* @createDate 2025-05-06 14:25:45
*/
@Service
public class ServerCureTicketDetailServiceImpl extends ServiceImpl<ServerCureTicketDetailMapper, ServerCureTicketDetail>
    implements ServerCureTicketDetailService{

}




