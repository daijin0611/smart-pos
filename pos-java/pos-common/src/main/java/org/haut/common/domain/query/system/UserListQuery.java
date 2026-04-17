package org.haut.common.domain.query.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "用户列表查询对象")
public class UserListQuery {
    /**
     * 真实姓名
     */
    @Schema(description = "真实姓名")
    private String userName;

    /**
     * 手机号
     */
    @Schema(description = "手机号")
    private String userNumber;

    /**
     * 在职状态
     */
    @Schema(description = "在职状态")
    private String userStatus;

    /**
     * 角色id
     */
    @Schema(description = "角色id")
    private Long roleId;

    /**
     * 门店ID列表，不传则查全部关联门店
     */
    @Schema(description = "门店ID列表，不传则查全部关联门店")
    private List<Long> orgIds;

    /**
     * 分页页码
     */
    @Schema(description = "分页页码")
    private Integer pageNum = 1;

    /**
     * 分页大小
     */
    @Schema(description = "分页大小")
    private Integer pageSize = 20;
}
