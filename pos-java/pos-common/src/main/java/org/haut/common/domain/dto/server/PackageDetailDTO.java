package org.haut.common.domain.dto.server;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

@Data
@Schema(description = "套餐项目信息对象")
public class PackageDetailDTO {


    /**
     * 服务套餐明细名称
     */
    @Schema(description = "套餐明细名称")
    private String packageDetailName;

    /**
     * 套餐明细使用物品数量
     */
    @Schema(description = "套餐明细使用物品数量")
    private Integer packageToolNumber;

    /**
     * 套餐id
     */
    @Schema(description = "套餐id")
    private Long packageId;
}
