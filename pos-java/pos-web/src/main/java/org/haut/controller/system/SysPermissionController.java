package org.haut.controller.system;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

import org.haut.common.domain.dto.system.PermissionCreateDTO;
import org.haut.common.domain.dto.system.PermissionUpdateDTO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.query.system.PermissionListQuery;
import org.haut.common.domain.vo.system.PermissionInfoVO;
import org.haut.server.system.entity.SysPermission;
import org.haut.server.system.service.SysPermissionService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    public JsonVO<List<PermissionInfoVO>> queryList(PermissionListQuery query){
        return JsonVO.success(sysPermissionService.queryList(query));
    }


    @PostMapping("/add-permission")
    @Operation(description = "添加权限", summary = "添加权限")
    public JsonVO<String> addPermission(@RequestBody @Validated PermissionCreateDTO dto){
        sysPermissionService.save(BeanUtil.copyProperties(dto, SysPermission.class));
        return JsonVO.success();
    }

    @PutMapping("/update-permission")
    @Operation(description = "更新权限", summary = "更新权限")
    public JsonVO<String> updatePermission(@RequestBody @Validated PermissionUpdateDTO dto){
        sysPermissionService.updateById(BeanUtil.copyProperties(dto, SysPermission.class));
        return JsonVO.success();
    }

    @PutMapping("/update-permission-status")
    @Operation(description = "更新权限状态(0 正常， 1 停用)", summary = "更新权限状态")
    public JsonVO<String> updatePermissionStatus(@RequestParam("id") Long id, @RequestParam("status") Integer status){
        LambdaUpdateWrapper<SysPermission> updateWrapper = Wrappers.lambdaUpdate(SysPermission.class)
                .eq(SysPermission::getId, id)
                .set(SysPermission::getPermStatus, status);
        sysPermissionService.update(updateWrapper);
        return JsonVO.success();
    }

}
