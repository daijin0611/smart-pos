package org.haut.controller.system;

import org.springframework.security.access.prepost.PreAuthorize;
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
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

@RequestMapping("/system/org")
@RestController
@Tag(name = "机构管理", description = "机构管理")
@RequiredArgsConstructor
public class SysOrgController {
    private final SysOrgService sysOrgService;
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
        sysOrgService.save(BeanUtil.copyProperties(dto, SysOrg.class));
        return JsonVO.success();
    }

    @PutMapping("/update-org")
    @Operation(description = "更新机构", summary = "更新机构")
    public JsonVO<String> updateOrg(@RequestBody OrgUpdateDTO dto) {
        sysOrgService.updateById(BeanUtil.copyProperties(dto, SysOrg.class));
        return JsonVO.success();
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


}
