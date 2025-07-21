package org.haut.controller.room;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.dto.room.BedCreateDTO;
import org.haut.common.domain.dto.room.RoomCreateDTO;
import org.haut.common.domain.dto.room.RoomUpdateDTO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.room.RoomInfoVO;
import org.haut.common.exception.BusinessException;
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
        roomInfoService.save(BeanUtil.toBean(dto, RoomInfo.class));
        return JsonVO.success("添加成功");
    }

    @Operation(summary = "更新房间信息")
    @PutMapping("/update")
    public JsonVO<String> updateRoom(@Validated @RequestBody RoomUpdateDTO dto) {
        LambdaUpdateWrapper<RoomInfo> updateWrapper = Wrappers.lambdaUpdate(RoomInfo.class)
                        .set(StringUtils.isNotBlank(dto.getRoomName()),RoomInfo::getRoomName, dto.getRoomName())
                        .set(StringUtils.isNotBlank(dto.getRemark()),RoomInfo::getRemark, dto.getRemark())
                                .eq(RoomInfo::getId, dto.getId());
        roomInfoService.update(updateWrapper);
        return JsonVO.success("更新成功");
    }

    // 床位相关接口
    @Operation(summary = "获取所有床位列表")
    @GetMapping("/bed/query-all")
    public JsonVO<List<RoomBed>> getAllBeds() {
        //按房间ID降序
        return JsonVO.success(roomBedService.list(Wrappers.lambdaQuery(RoomBed.class)
                .orderByDesc(RoomBed::getRoomInfoId)));
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

        RoomBed bed = new RoomBed()
                .setRoomInfoId(dto.getRoomId())
                .setBedName(dto.getBedName());
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
}