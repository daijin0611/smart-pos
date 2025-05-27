package org.haut.common.domain.dto.server;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.util.Date;

@Schema(description = "疗程券项目信息对象")
@Data
public class CureTicketDetailInfoDTO {




    @Schema(description = "疗程券项目信息ID", example = "1")
    @TableId(type = IdType.AUTO)
    private Long id;

    @Schema(description = "删除状态(0 存在，1 删除")
    private Integer isDelete;


    @Schema(description = "疗程券ID", example = "1")
    private Long cureTicketId;

    @Schema(description = "会员券ID")
    private Long vipTicketId;

    @Schema(description = "会员券数量")
    private Integer vipTicketNum;

    @Schema(description = "会员券名称")
    private String vipTicketName;

}
