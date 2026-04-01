package org.haut.common.domain.query.system;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@Schema(description = "操作日志查询对象")
public class OperLogQuery {

    @Schema(description = "操作模块")
    private String module;

    @Schema(description = "操作人姓名")
    private String operatorName;

    @Schema(description = "操作状态（0成功 1失败）")
    private Integer status;

    @Schema(description = "开始时间", example = "2024-12-01")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startTime;

    @Schema(description = "结束时间", example = "2024-12-31")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endTime;

    @Schema(description = "页码", example = "1")
    private Long pageNum = 1L;

    @Schema(description = "每页大小", example = "10")
    private Long pageSize = 10L;
}