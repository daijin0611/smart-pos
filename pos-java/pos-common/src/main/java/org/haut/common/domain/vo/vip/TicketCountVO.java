package org.haut.common.domain.vo.vip;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "优惠券统计VO")
public class TicketCountVO {
    /**
     * 主键
     */
    private Long id;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
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
     * 组织id
     */
    private Long orgId;

    /**
     * 优惠券信息
     */
    private VipTicketVO ticketInfo;
}
