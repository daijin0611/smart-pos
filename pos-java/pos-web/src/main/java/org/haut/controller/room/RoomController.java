package org.haut.controller.room;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.room.BedCreateDTO;
import org.haut.common.domain.dto.room.RoomCreateDTO;
import org.haut.common.domain.dto.room.RoomUpdateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.room.RoomInfoVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.room.entity.RoomBed;
import org.haut.server.room.entity.RoomInfo;
import org.haut.server.room.service.RoomBedService;
import org.haut.server.room.service.RoomInfoService;
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
    public JsonVO<List<RoomInfoVO>> getAllRooms() {
        return JsonVO.success(roomInfoService.getAllRooms());
    }

    @Operation(summary = "添加房间")
    @PostMapping("/add")
    public JsonVO<String> addRoom(@Validated @RequestBody RoomCreateDTO dto) {
        roomInfoService.addRoom(dto);
        return JsonVO.success("添加成功");
    }

    @Operation(summary = "更新房间信息")
    @PutMapping("/update")
    public JsonVO<String> updateRoom(@Validated @RequestBody RoomUpdateDTO dto) {
        roomInfoService.updateRoom(dto);
        return JsonVO.success("更新成功");
    }

    // 床位相关接口
    @Operation(summary = "获取所有床位列表")
    @GetMapping("/bed/query-all")
    public JsonVO<List<RoomBed>> getAllBeds() {
        return JsonVO.success(roomBedService.getAllBeds());
    }

    @Operation(summary = "根据房间ID获取床位列表")
    @GetMapping("/bed/list")
    public JsonVO<List<RoomBed>> getBedsByRoomId(@RequestParam Long roomId) {
        return JsonVO.success(roomBedService.lambdaQuery()
                .eq(RoomBed::getRoomInfoId, roomId)
                .list());
    }

    @Operation(summary = "添加床位")
    @PostMapping("/bed/add")
    public JsonVO<String> addBed(@Validated @RequestBody BedCreateDTO dto) {
        RoomInfo room = roomInfoService.getById(dto.getRoomId());
        if (room == null){
            throw new BusinessException("房间不存在");
        }
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        RoomBed bed = new RoomBed()
                .setRoomInfoId(dto.getRoomId())
                .setRemark(dto.getRemark())
                .setBedName(dto.getBedName())
                .setOrgId(auth.getOrgId());
        boolean save = roomBedService.save(bed);
        return save ? JsonVO.success("添加成功") : JsonVO.fail("添加失败");
    }

    @Operation(summary = "更新床位状态")
    @PutMapping("/bed/update-status")
    public JsonVO<String> updateBedStatus(@RequestParam Long bedId,
                                          @RequestParam Integer status) {
        RoomBed bed = new RoomBed();
        bed.setId(bedId);
        bed.setStatus(status);
        roomBedService.updateById(bed);
        return JsonVO.success("状态更新成功");
    }

    @Operation(summary = "更新床位名称")
    @PutMapping("/bed/update-name")
    public JsonVO<String> updateBedName(@RequestParam String bedName,
                                        @RequestParam Long roomId) {
        roomBedService.lambdaUpdate()
                .set(RoomBed::getBedName, bedName)
                .eq(RoomBed::getId, roomId)
                .update();
        return JsonVO.success();
    }
}