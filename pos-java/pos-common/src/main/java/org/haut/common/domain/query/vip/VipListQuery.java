package org.haut.common.domain.query.vip;


import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "会员列表查询对象")
public class VipListQuery {

    /**
     * 查询字段
     */
    @Schema(description = "查询字段", example = "vipName")
    private String queryField;

    /**
     * 当前页码
     */
    @Schema(description = "当前页码", example = "1")
    private Integer pageNum = 1;

    /**
     * 每页条数
     */
    @Schema(description = "每页条数", example = "10")
    private Integer pageSize = 10;
}
