package org.haut.common.domain.vo.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 疗程卷信息VO
 *
 * @author mhding
 * @version 1.0
 * @since 2024-12-19
 */
@Data
@Accessors(chain = true)
@Schema(description = "疗程卷信息")
public class ServerCureTicketVO {
    /**
     * 主键
     */
    private Long id;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    private Integer isDelete;

    /**
     * 备注（其它描述）
     */
    private String remark;

    /**
     * 疗程卷名称
     */
    private String name;

    /**
     * 疗程编码
     */
    private String encode;

    /**
     * 疗程价格
     */
    private BigDecimal price;

    /**
     * 提成类型（0 固定金额，1 比例提成）
     */
    private Integer type;

    /**
     * 提成值（固定/比例）
     */
    private BigDecimal commissionValue;

    /**
     * 提成基准（0 标准价，1 实收价）
     */
    private Integer commissionBase;

    /**
     * 状态（0 启用，1 停用）
     */
    private Integer status;

    /**
     * 组织ID
     */
    private Long orgId;

    /**
     * 疗程关联优惠券列表
     */
    private List<TicketDetailVO> ticketDetails;

    @Data
    @Accessors(chain = true)
    @Schema(description = "疗程关联优惠券")
    public static class TicketDetailVO {

        /**
         * 关联优惠券ID
         */
        private Long vipTicketId;
        /**
         * 优惠券名称
         */
        private String vipTicketName;

        /**
         * 优惠券数量
         */
        private Integer vipTicketNum;
    }

}
