package org.haut.controller.server;

import cn.hutool.core.bean.BeanUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.server.ServerItemInfoDTO;
import org.haut.common.domain.dto.server.ServerItemListDTO;
import org.haut.common.domain.query.ServerItemListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.entity.ServerItem;
import org.haut.server.service.ServerItemService;
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
    public JsonVO<List<ServerItemListDTO>> getList(ServerItemListQuery query) {
        log.info(query.toString());
        return JsonVO.success(serverItemService.getList(query));
    }

    @GetMapping("/query-info")
    @Operation(description = "获取服务项目详细信息", summary = "获取服务项目详细信息")
    public JsonVO<ServerItemInfoDTO> getServerItemById(@RequestParam Long id) {
        log.info("服务项目id：{}", id);
        ServerItemInfoDTO serverItemInfoDTO = BeanUtil.toBean(serverItemService.getById(id), ServerItemInfoDTO.class);
        return JsonVO.success(serverItemInfoDTO);
    }
    @PostMapping("/add-item")
    @Operation(description = "添加服务项目", summary = "添加服务项目")
    public JsonVO<String> addServerItem(@Validated @RequestBody ServerItemListDTO item) {
        log.info(item.toString());
//        item.setId(null);
        serverItemService.save(BeanUtil.toBean(item, ServerItem.class));
        return JsonVO.success("添加成功");
    }

    @PutMapping("/update-item")
    @Operation(description = "更新服务项目", summary = "更新服务项目")
    public JsonVO<String> updateServerItem(@Validated @RequestBody ServerItemListDTO item) {
        log.info(item.toString());
        serverItemService.updateById(BeanUtil.toBean(item, ServerItem.class));
        return JsonVO.success("更新成功");
    }

}
