package org.haut.server.vip.service;

import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.vip.VipInfoTicketCreateDTO;
import org.haut.common.domain.query.vip.VipInfoTicketQuery;
import org.haut.common.domain.vo.vip.TicketCountVO;
import org.haut.server.vip.entity.VipInfoTicket;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author daiji
* @description 针对表【vip_info_ticket(会员信息与优惠券关联表（优惠券明细）)】的数据库操作Service
* @createDate 2025-08-25 11:46:41
*/
public interface VipInfoTicketService extends IService<VipInfoTicket> {

    String createVipInfoTicket(VipInfoTicketCreateDTO dto);

    PageDTO<TicketCountVO> queryTicketCountPage(VipInfoTicketQuery query);
}
