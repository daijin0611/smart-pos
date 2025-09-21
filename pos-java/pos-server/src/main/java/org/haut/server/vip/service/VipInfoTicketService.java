package org.haut.server.vip.service;

import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.OrderSettleDTO;
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

    /**
     * 创建会员信息与优惠券关联
     * @param dto 优惠券信息
     * @return 优惠券信息
     */
    String createVipInfoTicket(VipInfoTicketCreateDTO dto);

    /**
     * 查询会员优惠券列表
     * @param query 查询参数
     * @return 优惠券分页结果
     */
    PageDTO<TicketCountVO> queryTicketCountPage(VipInfoTicketQuery query);

    /**
     * 订单结算时处理会员优惠券
     * @param settleOrderDTO 订单结算信息
     * @param orderCode 订单编号
     */
    void handelOrder(OrderSettleDTO settleOrderDTO, String orderCode);
}
