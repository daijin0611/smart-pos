package org.haut.controller.server;

import cn.hutool.core.bean.BeanUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.server.RechargeRoleCreateDTO;
import org.haut.common.domain.dto.server.RechargeRoleUpdateDTO;
import org.haut.common.domain.query.server.ServerRechaegeRoleListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.entity.server.ServerRechargeRole;
import org.haut.common.domain.vo.server.RechargeRoleVO;
import org.haut.server.server.service.ServerRechargeRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Tag(name = "充值提成规则管理", description = "充值提成规则管理")
@RestController
@RequestMapping("/server/recharge-role")
public class RechaegeRoleController {

    @Autowired private ServerRechargeRoleService serverRechargeRoleService;
    @GetMapping("/query-list")
    @Operation(description = "获取充值提成规则列表", summary = "获取充值提成规则列表")
    public JsonVO<List<RechargeRoleVO>> getList(ServerRechaegeRoleListQuery query) {
       log.info(query.toString());
       return JsonVO.success(serverRechargeRoleService.getList(query));
    }

    @PostMapping("/add-role")
    @Operation(description = "添加充值提成规则", summary = "添加充值提成规则")
    public JsonVO<String> addRole(@Validated @RequestBody RechargeRoleCreateDTO role) {
        log.info(role.toString());
        serverRechargeRoleService.save(BeanUtil.toBean(role, ServerRechargeRole.class));
        return JsonVO.success("添加成功");
    }

    @PutMapping("/update-role")
    @Operation(description = "更新充值提成规则", summary = "更新充值提成规则")
    public JsonVO<String> updateRole(@Validated @RequestBody RechargeRoleUpdateDTO role) {
        log.info(role.toString());
        serverRechargeRoleService.updateById(BeanUtil.toBean(role, ServerRechargeRole.class));
        return JsonVO.success("更新成功");
    }
}
