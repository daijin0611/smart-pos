package org.haut.controller.system;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.system.OrgInfoVO;
import org.haut.server.system.entity.SysOrg;
import org.haut.server.system.service.SysOrgService;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import io.swagger.v3.oas.annotations.Operation;
import java.util.List;
import org.springframework.web.bind.annotation.RequestParam;
import org.haut.common.domain.query.system.OrgListQuery;
import cn.hutool.core.bean.BeanUtil;
import org.haut.common.domain.dto.system.OrgCreateDTO;
import org.haut.common.domain.dto.system.OrgUpdateDTO;
import org.haut.common.domain.dto.system.OrgDefaultRuleUpdateDTO;
import org.haut.common.domain.dto.system.OrgPrintWidthUpdateDTO;
import org.springframework.validation.annotation.Validated;
import org.haut.server.server.service.ServerRechargeRoleService;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

@RequestMapping("/system/org")
@RestController
@Tag(name = "机构管理", description = "机构管理")
@RequiredArgsConstructor
public class SysOrgController {
    private final SysOrgService sysOrgService;
    private final ServerRechargeRoleService serverRechargeRoleService;
    @GetMapping("/query-list")
    @Operation(description = "获取机构列表", summary = "获取机构列表")
    public JsonVO<List<OrgInfoVO>> queryList(OrgListQuery query) {
        return JsonVO.success(sysOrgService.queryList(query));
    }

    @GetMapping("/query-one")
    @Operation(description = "获取机构详情", summary = "获取机构详情")
    public JsonVO<OrgInfoVO> queryOne(@RequestParam("id") Long id) {
        return JsonVO.success(BeanUtil.copyProperties(sysOrgService.getById(id), OrgInfoVO.class));
    }

    @PostMapping("/add-org")
    @Operation(description = "添加机构", summary = "添加机构")
    public JsonVO<String> addOrg(@RequestBody OrgCreateDTO dto) {
        sysOrgService.addOrg(dto);
        return JsonVO.success();
    }

    @PutMapping("/update-org")
    @Operation(description = "更新机构", summary = "更新机构")
    public JsonVO<String> updateOrg(@RequestBody OrgUpdateDTO dto) {
        sysOrgService.updateById(BeanUtil.copyProperties(dto, SysOrg.class));
        return JsonVO.success();
    }

    @PutMapping("/update-default-rule")
    @Operation(description = "修改门店默认相关规则", summary = "修改门店默认相关规则")
    public JsonVO<String> updateDefaultRule(@RequestBody OrgDefaultRuleUpdateDTO dto) {
        sysOrgService.updateDefaultRule(dto);
        if (dto.getDefaultRechargeRoleId() != null) {
            serverRechargeRoleService.setDefaultRole(dto.getDefaultRechargeRoleId());
        }
        return JsonVO.success("设置成功");
    }

    @PutMapping("/update-org-status")
    @Operation(description = "更新机构状态", summary = "更新机构状态")
    public JsonVO<String> updateOrgStatus(@RequestParam("id") Long id, @RequestParam("status") Integer status) {
        LambdaUpdateWrapper<SysOrg> updateWrapper = Wrappers.lambdaUpdate(SysOrg.class)
                .eq(SysOrg::getId, id)
                .set(SysOrg::getOrgState, status);
        sysOrgService.update(updateWrapper);
        return JsonVO.success();
    }

    @PutMapping("/update-print-width")
    @Operation(description = "修改门店打印宽度", summary = "修改门店打印宽度")
    public JsonVO<String> updatePrintWidth(@RequestBody @Validated OrgPrintWidthUpdateDTO dto) {
        sysOrgService.updatePrintWidth(dto);
        return JsonVO.success();
    }

}
