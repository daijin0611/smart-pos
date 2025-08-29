package org.haut.common.domain.query.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import lombok.experimental.SuperBuilder;
import org.haut.common.domain.query.PageQuery;

/**
 * 会员优惠券查询对象
 *
 * @author mhding
 * @version 1.0
 * @since 2025-01-20
 */
@Data
@Accessors(chain = true)
@Schema(description = "会员优惠券查询对象")
public class VipInfoTicketQuery{
    
    @Schema(description = "会员信息关键字", example = "张三")
    private String vipInfoFiled;
    
    @Schema(description = "优惠券状态", example = "未使用")
    private String status;
    
    @Schema(description = "活动id", example = "1")
    private Long activeId;
    
    @Schema(description = "优惠券id", example = "1")
    private Long vipTicketId;

    @Schema(description = "当前页码", example = "1")
    @NotNull
    private Long pageNum = 1L;

    @Schema(description = "每页大小", example = "20")
    @NotNull
    private Long pageSize =  20L;
}