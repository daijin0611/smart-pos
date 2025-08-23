package org.haut.controller.server;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.server.ServerItemCreateDTO;
import org.haut.common.domain.dto.server.ServerItemUpdateDTO;
import org.haut.common.domain.query.server.ServerItemQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.server.entity.ServerItem;
import org.haut.common.domain.vo.server.ServerItemVO;
import org.haut.server.server.service.ServerItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Tag(name = "服务项目管理", description = "服务项目管理")
@RestController
@RequestMapping("/server/item")
@Slf4j
public class ServerItemController {
    @Autowired private ServerItemService serverItemService;

    @GetMapping("/query-list")
    @Operation(description = "获取服务项目列表", summary = "获取服务项目列表")
    public JsonVO<List<ServerItemVO>> getList(ServerItemQuery query) {
        log.info(query.toString());
        return JsonVO.success(serverItemService.getList(query));
    }

    @GetMapping("/query-info")
    @Operation(description = "获取服务项目详细信息", summary = "获取服务项目详细信息")
    public JsonVO<ServerItemVO> getServerItemById(@RequestParam Long id) {
        log.info("服务项目id：{}", id);
        return JsonVO.success(serverItemService.queryById(id));
    }
    @PostMapping("/add-item")
    @Operation(description = "添加服务项目", summary = "添加服务项目")
    public JsonVO<String> addServerItem(@Validated @RequestBody ServerItemCreateDTO item) {
        serverItemService.addServerItem(item);
        return JsonVO.success("添加成功");
    }

    @PutMapping("/update-item")
    @Operation(description = "更新服务项目", summary = "更新服务项目")
    public JsonVO<String> updateServerItem(@Validated @RequestBody ServerItemUpdateDTO item) {
        log.info(item.toString());
        serverItemService.updateServerItem(item);
        return JsonVO.success("更新成功");
    }

    @PutMapping("/update-status")
    @Operation(description = "更新服务项目状态", summary = "更新服务项目状态")
    public JsonVO<String> updateStatus(@RequestParam Long id, @RequestParam Integer status) {
        log.info("更新服务项目状态，id: {}, status: {}", id, status);
        serverItemService.lambdaUpdate().set(ServerItem::getItemStatus, status)
                .eq(ServerItem::getId, id)
                .update();
        return JsonVO.success("更新成功");
    }

}
