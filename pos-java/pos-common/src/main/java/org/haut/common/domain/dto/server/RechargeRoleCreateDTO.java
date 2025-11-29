package org.haut.common.domain.dto.server;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Schema(description = "充值提成规则创建对象")
@Accessors(chain = true)
public class RechargeRoleCreateDTO {


    /**
     * 备注（其他描述）
     */
    @Schema(description = "备注（其他描述）")
    private String remark;

    /**
     * 充值提成规则名称
     */
    @Schema(description = "充值提成规则名称")
    @NotBlank(message = "充值提成规则名称不能为空")
    @Size(max = 20, message = "充值提成规则名称长度不能超过20")
    private String rechargeRoleName;

    /**
     * 充值金额
     */
    @Schema(description = "充值金额")
    private BigDecimal rechargePrice;

    /**
     * 提成类型
     */
    @Schema(description = "提成类型")
    private Integer commissionType;

    /**
     * 提成值（比例）
     */
    @Schema(description = "提成值（比例）")
    private BigDecimal rechargeCommissionValue;

    /**
     * 状态
     */
    @Schema(description = "状态（0 启用，1 禁用）")
    private Integer status;

    /**
     * 是否为默认规则
     */
    @Schema(description = "是否为默认规则 0-否 1-是")
    private Integer isDefault;
}
