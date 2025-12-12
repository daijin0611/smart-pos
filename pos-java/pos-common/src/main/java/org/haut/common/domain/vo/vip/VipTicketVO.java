package org.haut.common.domain.vo.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
@Accessors(chain = true)
@Schema(description = "会员优惠券详细信息")
public class VipTicketVO {
    /**
     * 主键
     */
    @Schema(description = "主键")
    private Long id;

    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    private Date createTime;

    /**
     * 更新时间
     */
    @Schema(description = "更新时间")
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    @Schema(description = "删除状态(0 存在，1 删除)")
    private Integer isDelete;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;

    /**
     * 优惠券状态（0 启用，1 禁用）
     */
    @Schema(description = "优惠券状态（0 启用，1 禁用）")
    private Integer ticketStatus;

    /**
     * 优惠券名称
     */
    @Schema(description = "优惠券名称")
    private String ticketName;

    /**
     * 优惠券类型
     */
    @Schema(description = "优惠券类型")
    private Integer ticketType;

    /**
     * 有效天数（-1 代表无限期）
     */
    @Schema(description = "有效天数（-1 代表无限期）")
    private Integer ticketEffectiveTime;

    /**
     * 限额满多少元可用
     */
    @Schema(description = "限额满多少元可用")
    private BigDecimal ticketFullPayment;

    /**
     * 优惠券面值
     */
    @Schema(description = "优惠券面值")
    private BigDecimal ticketValue;

    /**
     * 优惠券适用项目
     */
    @Schema(description = "优惠券适用项目")
    private List<ServerItemVO> serverItems;

    /**
     * 门店id
     */
    @Schema(description = "门店id")
    private Long orgId;

    /**
     * 优惠券描述
     */
    @Schema(description = "优惠券描述")
    private String ticketDescription;

    @Data
    @Schema(description = "服务项目信息")
    public static class ServerItemVO {
        @Schema(description = "项目ID")
        private Long id;
        
        @Schema(description = "项目名称")
        private String itemName;
    }
}
