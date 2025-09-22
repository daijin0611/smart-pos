package org.haut.server.server.mapper;

import org.apache.ibatis.annotations.Param;
import org.haut.server.server.entity.ServerCureTicket;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.haut.common.domain.query.server.ServerCureTicketListQuery;
import org.haut.common.domain.vo.server.ServerCureTicketVO;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_cure_ticket(疗程券表)】的数据库操作Mapper
* @createDate 2025-05-06 14:07:02
* @Entity org.haut.server.server.entity.ServerCureTicket
*/
public interface ServerCureTicketMapper extends BaseMapper<ServerCureTicket> {

    List<ServerCureTicketVO> getList(
            @Param("query") ServerCureTicketListQuery query,
            @Param("orgId") Long orgId);

    ServerCureTicketVO getOneById(@Param("id") Long id);

}




