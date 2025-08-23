package org.haut.controller.system;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.dto.system.RoleCreateDTO;
import org.haut.common.domain.dto.system.RolePermissionAddDTO;
import org.haut.common.domain.dto.system.RoleUpdateDTO;
import org.haut.common.domain.dto.system.RoleUserAddDTO;
import org.haut.common.domain.query.system.AllocatedListQuery;
import org.haut.common.domain.query.system.RoleListQuery;
import org.haut.common.domain.query.system.UnAllocatedListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.system.RoleInfoVo;
import org.haut.common.domain.vo.system.UserInfoVO;
import org.haut.server.system.entity.SysRole;
import org.haut.server.system.service.SysPermissionService;
import org.haut.server.system.service.SysRolePermissionService;
import org.haut.server.system.service.SysRoleService;
import org.haut.server.system.service.SysUserRoleService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/system/role")
@RequiredArgsConstructor
@Tag(name = "角色管理", description = "系统角色管理")
public class SysRoleController {
    private final SysRoleService sysRoleService;
    private final SysUserRoleService sysUserRoleService;
    private final SysRolePermissionService sysRolePermissionService;
    private final SysPermissionService sysPermissionService;
    @GetMapping("/query-list")
    @Operation(description = "获取角色列表", summary = "获取角色列表")
    public JsonVO<List<RoleInfoVo>> queryList(RoleListQuery query) {
        List<SysRole> list = sysRoleService.list(Wrappers.lambdaQuery(SysRole.class)
                .like(StringUtils.isNotBlank(query.getRoleName()), SysRole::getRoleName, query.getRoleName())
                .like(StringUtils.isNotBlank(query.getRoleCode()), SysRole::getRoleCode, query.getRoleCode())
                .eq(ObjectUtils.isNotEmpty(query.getStatus()), SysRole::getRoleStatus, query.getStatus())
        );
        return JsonVO.success(BeanUtil.copyToList(list, RoleInfoVo.class));
    }

    @PostMapping("/add-role")
    @Operation(description = "添加角色", summary = "添加角色")
    public JsonVO<String> addRole(@RequestBody @Validated RoleCreateDTO dto) {
        sysRoleService.save(BeanUtil.toBean(dto, SysRole.class));
        return JsonVO.success();
    }

    @PutMapping("/update-role")
    @Operation(description = "更新角色", summary = "更新角色")
    public JsonVO<String> updateRole(@RequestBody @Validated RoleUpdateDTO dto) {
        sysRoleService.updateById(BeanUtil.toBean(dto, SysRole.class));
        return JsonVO.success();
    }

    @PutMapping("/update-status")
    @Operation(description = "更新角色状态(0 正常， 1 停用)", summary = "更新角色状态")
    public JsonVO<String> updateStatus(@RequestParam Long roleId, @RequestParam Integer status) {
        sysRoleService.update(Wrappers.lambdaUpdate(SysRole.class)
                .eq(SysRole::getId, roleId)
                .set(SysRole::getRoleStatus, status)
        );
        return JsonVO.success();
    }

    @GetMapping("/query-allocated-list")
    @Operation(description = "获取当前角色所分配的用户", summary = "获取分配用户")
    public JsonVO<List<UserInfoVO>> queryList(AllocatedListQuery query){
        List<UserInfoVO> allocatedUserList = sysRoleService.getAllocatedUserList(query);
        return JsonVO.success(allocatedUserList);
    }

    @GetMapping("/query-unallocated-list")
    @Operation(description = "获取当前角色所未分配的用户", summary = "获取未分配用户")
    public JsonVO<List<UserInfoVO>> queryList(UnAllocatedListQuery query){
        List<UserInfoVO> unAllocatedUserList = sysRoleService.getUnAllocatedUserList(query);
        return JsonVO.success(unAllocatedUserList);
    }

    @PostMapping("/add-user")
    @Operation(description = "批量为角色分配用户", summary = "批量分配用户")
    public JsonVO<String> addUser(@RequestBody @Validated RoleUserAddDTO dto) {
        sysRoleService.addUserToRole(dto);
        return JsonVO.success();
    }

    @PostMapping("/add-permission")
    @Operation(description = "批量为角色分配权限", summary = "批量分配权限")
    public JsonVO<String> addPermission(@RequestBody @Validated RolePermissionAddDTO dto) {
        sysRoleService.addPermToRole(dto);
        return JsonVO.success();
    }



}
