package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
@Schema(description = "套餐信息")
public class PackageInfoDTO {

    @Schema(description = "套餐ID", example = "1")
    private Long id;

    @Schema(description = "套餐创建时间")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @Schema(description = "套餐更新时间")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;


    /**
     * 删除状态(0 存在，1 删除)
     */
    @Schema(description = "删除状态(0 存在，1 删除)")
    private Integer isDelete;

    /**
     * 备注（其他描述）
     */
    @Schema(description = "备注（其他描述）")
    private String remark;

    /**
     * 服务套餐名称
     套餐名称
     */
    @Schema(description = "套餐名称")
    @NotBlank(message = "套餐名称不能为空")
    private String packageName;

    /**
     * 套餐编码
     */
    @Schema(description = "套餐编码")
    @NotBlank(message = "套餐编码不能为空")
    private String packageEncode;

    /**
     * 散客价
     */
    @Schema(description = "散客价")
    private BigDecimal packagePrice;

    /**
     * 会员价
     */
    @Schema(description = "会员价")
    private BigDecimal packagePriceVip;


    @Schema(description = "套餐项目信息")
    private List<PackageDetailDTO> packageDetailDTOList;
}
