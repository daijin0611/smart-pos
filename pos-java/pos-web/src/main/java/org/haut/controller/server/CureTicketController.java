package org.haut.controller.server;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.server.CureTicketCreateDTO;
import org.haut.common.domain.dto.server.CureTicketStatusDTO;
import org.haut.common.domain.dto.server.CureTicketUpdateDTO;
import org.haut.common.domain.query.server.ServerCureTicketListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.server.ServerCureTicketVO;
import org.haut.server.server.service.ServerCureTicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Tag(name = "疗程券管理", description = "疗程券管理")
@RequestMapping("/server/cureTicket")
@Slf4j
public class CureTicketController {

    @Autowired
    private ServerCureTicketService serverCureTicketService;

    /**
     * 查询疗程券列表（含多对多关联数据）
     */
    @Operation(description = "获取疗程券列表", summary = "获取疗程券列表")
    @GetMapping("/query-list")
    public JsonVO<List<ServerCureTicketVO>> getList(ServerCureTicketListQuery query) {
        return JsonVO.success(serverCureTicketService.getList(query));
    }

    /**
     * 添加疗程券（含关联的中间表数据）
     */
    @Operation(description = "添加疗程券", summary = "添加疗程券")
    @PostMapping("/add-cureTicket")
    public JsonVO<String> addCureTicket(
            @Validated @RequestBody CureTicketCreateDTO cureTicket) {
        serverCureTicketService.saveCureTicket(cureTicket);
        return JsonVO.success("添加成功");
    }

    /**
     * 更新疗程券（含关联的中间表数据）
     */
    @Operation(description = "更新疗程券", summary = "更新疗程券")
    @PutMapping("/update-cureTicket")
    public JsonVO<String> updateCureTicket(
            @Validated @RequestBody CureTicketUpdateDTO cureTicket) {
        serverCureTicketService.updateCureTicket(cureTicket);
        return JsonVO.success("更新成功");
    }

    /**
     * 修改疗程券状态
     */
    @Operation(description = "修改疗程券状态", summary = "修改疗程券状态")
    @PutMapping("/update-status")
    public JsonVO<String> updateCureTicketStatus(
            @Validated @RequestBody CureTicketStatusDTO cureTicketStatus) {
        serverCureTicketService.updateCureTicketStatus(cureTicketStatus);
        return JsonVO.success("状态修改成功");
    }

}