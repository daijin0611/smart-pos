package org.haut.server.room.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.util.Date;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 床位表
 * @TableName room_bed
 */
@TableName(value ="room_bed")
@Data
@Accessors(chain = true)
public class RoomBed {
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
     * 床位名称
     */
    private String bedName;

    /**
     * 房间id
     */
    private Long roomInfoId;

    /**
     * 床位状态（0 空闲中， 1 服务中， 2 暂停使用）
     */
    private Integer status = 0;

    /**
     * 结构id
     */
    private Long orgId;
}