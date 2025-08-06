package org.haut.controller.server;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.server.PackageInfoDTO;
import org.haut.common.domain.dto.server.PackageListDTO;
import org.haut.common.domain.query.server.ServerPackageListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.server.service.ServerPackageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Tag(name = "套餐管理", description = "套餐管理")
@RequestMapping("/server/package")
@Slf4j

public class PackageController {

    @Autowired
    private ServerPackageService packageService;

    // 1. 列表模糊查询
    @Operation(description = "套餐列表查询（支持模糊搜索）" , summary = "套餐列表查询（支持模糊搜索）")
    @GetMapping("/query-list")
    public JsonVO<List<PackageListDTO>> getPackageList(ServerPackageListQuery query) {
        return JsonVO.success(packageService.getPackageList(query));
    }

    // 2. 详情查询（通过ID）
    @GetMapping("/query-info")
    @Operation(description = "根据套餐id查询详细信息", summary = "根据套餐id查询详细信息")
    public JsonVO<PackageInfoDTO> getPackageInfo(@RequestParam  Long id) {
        log.info("套餐id：{}", id);
        PackageInfoDTO info = packageService.getPackageInfoById(id);
        return JsonVO.success(info);
    }
    // 3. 新增套餐
    @Operation(description = "新增套餐" ,summary = "新增套餐")
    @PostMapping("/add-package")
    public JsonVO<String> savePackage(@Validated @RequestBody PackageInfoDTO packageInfo) {
        packageService.savePackage(packageInfo);
        return JsonVO.success("新增成功");
    }

    // 4. 修改套餐
    @Operation(description = "修改套餐" ,summary = "修改套餐")
    @PutMapping("/update-package" )
    public JsonVO<String> updatePackage(@Validated @RequestBody PackageInfoDTO packageInfo) {
        packageService.updatePackage(packageInfo);
        return JsonVO.success("修改成功");
    }
}