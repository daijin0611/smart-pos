package org.haut.common.domain.vo.room;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

@Data
@Schema(description = "房间信息")
public class RoomInfoVO {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 备注
     */
    private String remark;

    /**
     * 房间名
     */
    private String roomName;

    /**
     * 房间床位总数
     */
    private Integer bedCount;

    /**
     * 房间空闲床位数
     */
    private Integer freeBedCount;

    /**
     * 组织id
     */
    private Long orgId;

}
