package org.haut.common.domain.query.vip;


import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Schema(description = "优惠券统计查询对象")
public class TicketCountQuery {
    @Schema(description = "会员信息关键字", example = "张三")
    private String vipInfoFiled;
    @Schema(description = "优惠券状态", example = "1")
    private Integer status;
    @Schema(description = "活动id",example = "1")
    private Long activityId;
}
