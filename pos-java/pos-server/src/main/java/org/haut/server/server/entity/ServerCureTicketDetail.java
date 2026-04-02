package org.haut.server.server.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 疗程券内容表（关联server_cure_ticket, vip_ticket）
 * @TableName server_cure_ticket_detail
 */
@TableName(value ="server_cure_ticket_detail")
@Data
public class ServerCureTicketDetail {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 备注（其它描述）
     */
    private String remark;

    /**
     * 疗程券id
     */
    private Long cureTicketId;

    /**
     * 优惠券id
     */
    private Long vipTicketId;

    /**
     * 优惠券名称
     */
    private String vipTicketName;

    /**
     * 优惠券数量
     */
    private Integer vipTicketNum;


}