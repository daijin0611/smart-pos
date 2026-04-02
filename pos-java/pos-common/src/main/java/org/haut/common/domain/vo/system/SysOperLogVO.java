package org.haut.common.domain.vo.system;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

@Data
@Schema(description = "操作日志信息")
public class SysOperLogVO {

    @Schema(description = "主键")
    private Long id;

    @Schema(description = "操作模块")
    private String module;

    @Schema(description = "操作描述")
    private String description;

    @Schema(description = "操作人ID")
    private Long operatorId;

    @Schema(description = "操作人姓名")
    private String operatorName;

    @Schema(description = "HTTP方法")
    private String requestMethod;

    @Schema(description = "请求路径")
    private String requestUrl;

    @Schema(description = "请求参数")
    private String requestParams;

    @Schema(description = "响应结果")
    private String responseResult;

    @Schema(description = "操作IP")
    private String ip;

    @Schema(description = "操作状态（0成功 1失败）")
    private Integer status;

    @Schema(description = "错误信息")
    private String errorMsg;

    @Schema(description = "耗时（毫秒）")
    private Long costTime;

    @Schema(description = "机构ID")
    private Long orgId;

    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
}