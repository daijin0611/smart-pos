package org.haut.controller.server;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.server.RechargeRoleCreateDTO;
import org.haut.common.domain.dto.server.RechargeRoleUpdateDTO;
import org.haut.common.domain.query.server.ServerRechargeRoleListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.server.entity.ServerRechargeRole;
import org.haut.common.domain.vo.server.RechargeRoleVO;
import org.haut.server.server.service.ServerRechargeRoleService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Tag(name = "充值提成规则管理", description = "充值提成规则管理")
@RestController
@RequiredArgsConstructor
@RequestMapping("/server/recharge-role")
public class RechargeRoleController {
    private final ServerRechargeRoleService serverRechargeRoleService;
    @GetMapping("/query-list")
    @Operation(description = "获取充值提成规则列表", summary = "获取充值提成规则列表")
    public JsonVO<List<RechargeRoleVO>> getList(ServerRechargeRoleListQuery query) {
       log.info(query.toString());
       return JsonVO.success(serverRechargeRoleService.getList(query));
    }

    @PostMapping("/add-role")
    @Operation(description = "添加充值提成规则", summary = "添加充值提成规则")
    public JsonVO<String> addRole(@Validated @RequestBody RechargeRoleCreateDTO role) {
        log.info(role.toString());
        serverRechargeRoleService.addRole(role);
        return JsonVO.success("添加成功");
    }

    @PutMapping("/update-role")
    @Operation(description = "更新充值提成规则", summary = "更新充值提成规则")
    public JsonVO<String> updateRole(@Validated @RequestBody RechargeRoleUpdateDTO role) {
        log.info(role.toString());
        serverRechargeRoleService.updateRole(role);
        return JsonVO.success("更新成功");
    }

    @PutMapping("/set-default/{roleId}")
    @Operation(description = "设置默认充值提成规则", summary = "设置默认充值提成规则")
    public JsonVO<String> setDefaultRole(@PathVariable Long roleId) {
        log.info("设置默认充值提成规则，roleId: {}", roleId);
        serverRechargeRoleService.setDefaultRole(roleId);
        return JsonVO.success("设置成功");
    }

    @PutMapping("/update-status")
    @Operation(description = "更新充值提成规则状态", summary = "更新充值提成规则状态")
    public JsonVO<String> updateStatus(@RequestParam Long id, @RequestParam Integer status) {
        log.info("更新充值提成规则状态，id: {}, status: {}", id, status);
        serverRechargeRoleService.lambdaUpdate().set(ServerRechargeRole::getStatus, status)
                .eq(ServerRechargeRole::getId, id)
                .update();
        return JsonVO.success("更新成功");
    }

    @GetMapping("/get-default")
    @Operation(description = "获取默认充值提成规则", summary = "获取默认充值提成规则")
    public JsonVO<RechargeRoleVO> getDefaultRole() {
        return JsonVO.success(serverRechargeRoleService.getDefaultRole());
    }
}
