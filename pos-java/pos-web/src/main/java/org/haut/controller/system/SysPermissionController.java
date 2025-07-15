package org.haut.controller.system;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.query.system.PermissionListQuery;
import org.haut.common.domain.vo.system.PermissionInfoVO;
import org.haut.server.system.service.SysPermissionService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@RestController
@RequestMapping("/system/permission")
@Tag(name = "权限管理", description = "权限管理")
@RequiredArgsConstructor
public class SysPermissionController {
    private final SysPermissionService sysPermissionService;

    @GetMapping("/query-list")
    @Operation(description = "获取权限列表", summary = "获取权限列表")
    public JsonVO<PermissionInfoVO> queryList(PermissionListQuery query){
        sysPermissionService.queryList(query);
        return null;
    }




}
