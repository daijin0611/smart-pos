package org.haut.server.vip.mapper;

import org.apache.ibatis.annotations.Param;
import org.haut.server.vip.entity.VipTicket;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.haut.common.domain.query.vip.VipTicketListQuery;
import org.haut.common.domain.vo.vip.VipTicketVO;

import java.util.List;

/**
* @author Cdh
* @description 针对表【vip_ticket(会员优惠券)】的数据库操作Mapper
* @createDate 2025-05-11 10:14:04
* @Entity org.haut.server.vip.entity.VipTicket
*/
public interface VipTicketMapper extends BaseMapper<VipTicket> {

    List<VipTicketVO> getList(@Param("query") VipTicketListQuery query, @Param("orgId") Long orgId);

    VipTicketVO getOneById(@Param("ticketId") Long ticketId);

    List<VipTicketVO> getListByIds(@Param("ticketIds") List<Long> ticketIds);
}




