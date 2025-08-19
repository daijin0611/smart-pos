package org.haut.server.vip.mapper;

import org.apache.ibatis.annotations.Select;
import org.haut.common.domain.entity.vip.VipTicket;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.haut.common.domain.query.vip.VipTicketListQuery;

/**
* @author Cdh
* @description 针对表【vip_ticket(会员优惠券)】的数据库操作Mapper
* @createDate 2025-05-11 10:14:04
* @Entity org.haut.common.domain.entity.vip.VipTicket
*/
public interface VipTicketMapper extends BaseMapper<VipTicket> {

    void getList(VipTicketListQuery query);
}




