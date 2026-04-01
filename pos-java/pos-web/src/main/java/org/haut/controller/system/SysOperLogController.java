package org.haut.controller.system;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.query.system.OperLogQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.system.SysOperLogVO;
import org.haut.server.system.service.SysOperLogService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/system/oper-log")
@Tag(name = "操作日志管理", description = "系统操作日志查询")
@RequiredArgsConstructor
public class SysOperLogController {

    private final SysOperLogService sysOperLogService;

    @GetMapping("/page")
    @Operation(summary = "分页查询操作日志", description = "根据条件分页查询系统操作日志")
    public JsonVO<PageDTO<SysOperLogVO>> queryPage(OperLogQuery query) {
        return JsonVO.success(sysOperLogService.queryPage(query));
    }
}