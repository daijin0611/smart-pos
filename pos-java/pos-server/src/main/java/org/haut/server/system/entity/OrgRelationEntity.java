package org.haut.server.system.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * 设定与门店关联表
 * @TableName sys_org_relation
 */
@TableName(value = "sys_org_relation")
@Data
@Accessors(chain = true)
public class OrgRelationEntity {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 设定类型：1-服务项 2-服务产品 3-疗程券 4-优惠券 5-充值活动
     */
    private Integer itemType;

    /**
     * 设定项目ID
     */
    private Long itemId;

    /**
     * 门店ID
     */
    private Long orgId;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
}
