package org.haut.controller.room;

import cn.hutool.core.bean.BeanUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.entity.RoomBed;
import org.haut.server.entity.RoomInfo;
import org.haut.server.service.RoomBedService;
import org.haut.server.service.RoomInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Tag(name = "房间管理", description = "房间和床位管理")
@RestController
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomInfoService roomInfoService;

    @Autowired
    private RoomBedService roomBedService;

    // 房间相关接口
    @Operation(summary = "获取所有房间列表")
    @GetMapping("/list")
    public JsonVO<List<RoomInfo>> getAllRooms() {
        return JsonVO.success(roomInfoService.list());
    }

    @Operation(summary = "添加房间")
    @PostMapping("/add")
    public JsonVO<String> addRoom(@Validated @RequestBody RoomInfo roomInfo) {
        roomInfoService.save(roomInfo);
        return JsonVO.success("添加成功");
    }

    @Operation(summary = "更新房间信息")
    @PutMapping("/update")
    public JsonVO<String> updateRoom(@Validated @RequestBody RoomInfo roomInfo) {
        roomInfoService.updateById(roomInfo);
        return JsonVO.success("更新成功");
    }

    // 床位相关接口
    @Operation(summary = "根据房间ID获取床位列表")
    @GetMapping("/bed/list")
    public JsonVO<List<RoomBed>> getBedsByRoomId(@RequestParam Long roomId) {
        return JsonVO.success(roomBedService.lambdaQuery()
                .eq(RoomBed::getRoomInfoId, roomId)
                .list());
    }

    @Operation(summary = "添加床位")
    @PostMapping("/bed/add")
    public JsonVO<String> addBed(@Validated @RequestBody RoomBed roomBed) {
        roomBedService.save(roomBed);
        return JsonVO.success("添加成功");
    }

    @Operation(summary = "更新床位状态")
    @PutMapping("/bed/update-status")
    public JsonVO<String> updateBedStatus(@RequestParam Long bedId,
                                          @RequestParam String status) {
        RoomBed bed = new RoomBed();
        bed.setId(bedId);
        bed.setStatus(status);
        roomBedService.updateById(bed);
        return JsonVO.success("状态更新成功");
    }
}