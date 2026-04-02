package org.haut.server.vip.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 体验券详情表
 * @TableName vip_ticket_detail
 */
@TableName(value ="vip_ticket_detail")
@Data
@Accessors(chain = true)
public class VipTicketDetail {
    /**
     * 主键id
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 优惠券id
     */
    private Long ticketId;

    /**
     * 服务项目id
     */
    private Long serverItemId;
}