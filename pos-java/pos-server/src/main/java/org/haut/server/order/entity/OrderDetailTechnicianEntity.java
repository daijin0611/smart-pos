package org.haut.server.order.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

@TableName(value = "order_detail_technician")
@Data
@Accessors(chain = true)
@Schema(description = "订单明细技师关联表")
public class OrderDetailTechnicianEntity {

    @TableId(type = IdType.AUTO)
    @Schema(description = "主键ID")
    private Long id;

    @TableField(fill = FieldFill.INSERT)
    @Schema(description = "创建时间")
    private Date createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    @Schema(description = "更新时间")
    private Date updateTime;

    @Schema(description = "删除状态(0存在 1删除)")
    private Integer isDelete;

    @Schema(description = "订单明细ID")
    private Long detailId;

    @Schema(description = "技师ID")
    private Long userId;

    @Schema(description = "技师姓名")
    private String userName;

    @Schema(description = "员工编号")
    private String userCode;
}