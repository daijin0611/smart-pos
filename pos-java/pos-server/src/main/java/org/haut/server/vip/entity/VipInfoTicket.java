package org.haut.server.vip.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDate;
import java.util.Date;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 会员信息与优惠券关联表（优惠券明细）
 * @TableName vip_info_ticket
 */
@TableName(value ="vip_info_ticket")
@Data
@Accessors(chain = true)
public class VipInfoTicket {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    private Integer isDelete;

    /**
     * 备注
     */
    private String remark;

    /**
     * 优惠券码
     */
    private String ticketCode;

    /**
     * 会员id
     */
    private Long vipInfoId;

    /**
     * 优惠券id
     */
    private Long vipTicketId;

    /**
     * 优惠券类型
     */
    private Integer ticketType;

    /**
     * 代金券名称
     */
    private String ticketName;

    /**
     * 领取人名称
     */
    private String vipName;

    /**
     * 领取人手机号
     */
    private String vipPhoneNumber;

    /**
     * 领取人卡号
     */
    private String vipCardNumber;

    /**
     * 使用状态
     */
    private String status;

    /**
     * 领取时间
     */
    private LocalDate claimTime;

    /**
     * 到期时间
     */
    private LocalDate expiryDate;

    /**
     * 活动id
     */
    private Long activeId;

    /**
     * 机构id
     */
    private Long orgId;

    /**
     * 来源类型（1：充值；2：活动；3：其他）
     */
    private Integer sourceType;

    /**
     * 来源编号
     */
    private String sourceCode;

    /**
     * 使用订单号
     */
    private String usedOrderCode;
}