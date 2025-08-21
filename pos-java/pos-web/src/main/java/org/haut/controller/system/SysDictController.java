package org.haut.controller.system;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import org.haut.server.system.service.SysDictTypeService;
import org.haut.server.system.service.SysDictItemService;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.system.DictTypeVO;
import org.haut.common.domain.vo.system.DictItemVO;
import org.haut.common.domain.dto.system.DictTypeCreateDTO;
import org.haut.common.domain.dto.system.DictTypeUpdateDTO;
import org.haut.common.domain.query.system.DictListQuery;
import org.haut.common.domain.dto.system.DictItemCreateDTO;
import org.haut.common.domain.dto.system.DictItemUpdateDTO;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/system/dict")
@Tag(name = "字典管理", description = "系统字典管理")
@RequiredArgsConstructor
public class SysDictController {
    private final SysDictTypeService sysDictTypeService;
    private final SysDictItemService sysDictItemService;

    @GetMapping("/query-list")
    @Operation(description = "获取字典列表", summary = "获取字典列表")
    public JsonVO<List<DictTypeVO>> queryList(DictListQuery query) {
        return JsonVO.success(sysDictTypeService.getDictList(query));
    }

    @PostMapping("/add-type")
    @Operation(summary = "新增字典类型", description = "创建新的字典类型")
    public JsonVO<Void> addDictType(@Valid @RequestBody DictTypeCreateDTO dto) {
        sysDictTypeService.addDictType(dto);
        return JsonVO.success();
    }

    @PutMapping("/update-type")
    @Operation(summary = "修改字典类型", description = "修改字典类型信息")
    public JsonVO<Void> updateDictType(@Valid @RequestBody DictTypeUpdateDTO dto) {
        sysDictTypeService.updateDictType(dto);
        return JsonVO.success();
    }

    @GetMapping("/query-items-by-code")
    @Operation(summary = "根据字典类型编码查询字典项", description = "根据字典类型编码查询该类型下的所有字典项")
    public JsonVO<List<DictItemVO>> queryItemsByDictCode(@RequestParam String dictCode) {
        return JsonVO.success(sysDictItemService.queryItemsByDictCode(dictCode));
    }

    @PostMapping("/add-item")
    @Operation(summary = "新增字典项", description = "在指定字典类型下创建新的字典项")
    public JsonVO<Void> addDictItem(@Valid @RequestBody DictItemCreateDTO dto) {
        sysDictItemService.addDictItem(dto);
        return JsonVO.success();
    }

    @PutMapping("/update-item")
    @Operation(summary = "修改字典项", description = "修改字典项信息")
    public JsonVO<Void> updateDictItem(@Valid @RequestBody DictItemUpdateDTO dto) {
        sysDictItemService.updateDictItem(dto);
        return JsonVO.success();
    }

    @PutMapping("/delete-item")
    @Operation(summary = "删除字典项", description = "根据字典项ID删除字典项")
    public JsonVO<Void> deleteDictItem(@RequestParam Long itemId) {
        sysDictItemService.removeById(itemId);
        return JsonVO.success();
    }

    @PutMapping("/delete-type")
    @Operation(summary = "删除字典类型", description = "根据字典类型ID删除字典类型")
    public JsonVO<Void> deleteDictType(@RequestParam Long dictTypeId) {
        sysDictTypeService.removeById(dictTypeId);
        return JsonVO.success();
    }

}
