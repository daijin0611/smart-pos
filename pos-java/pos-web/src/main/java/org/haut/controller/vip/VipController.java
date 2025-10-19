package org.haut.controller.vip;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.vip.*;
import org.haut.common.domain.query.vip.VipListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.vip.VipCountVO;
import org.haut.common.domain.vo.vip.VipInfoVO;
import org.haut.server.vip.service.VipAssetService;
import org.haut.server.vip.service.VipInfoService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/vip")
@Tag(name = "会员管理", description = "会员管理")
@Slf4j
@RequiredArgsConstructor
public class VipController {
    private final VipInfoService vipInfoService;
    private final VipAssetService vipAssetService;

    @GetMapping("/query-list")
    @Operation(description = "获取会员列表（分页+条件）", summary = "获取会员列表")
    public JsonVO<PageDTO<VipInfoVO>> getList(VipListQuery query) {
        log.info(query.toString());
        return JsonVO.success(vipInfoService.getList(query));
    }

    @GetMapping("/query-info")
    @Operation(description = "根据会员id查询详细信息", summary = "根据会员id查询详细信息")
    public JsonVO<VipInfoVO> getVipById(@RequestParam Long id) {
        log.info("会员id：{}",id);
        //将VipInfo转化为VipInfoDTO
        //VipInfoDTO vipInfoDTO = BeanUtil.toBean(vipInfoService.getById(id),VipInfoDTO.class);该行代码在VipInfoServiceImpl.java中已经实现
        return JsonVO.success(vipInfoService.getVipById(id));
    }

    @PostMapping("/add-vip")
    @Operation(description = "添加会员", summary = "添加会员")
    public JsonVO<String> addVip(@Validated @RequestBody VipCreateDTO dto) {
        vipInfoService.addVip(dto);
        return JsonVO.success("添加成功");
    }

    @PutMapping("/update-vip")
    @Operation(description = "更新会员", summary = "更新会员")
    public JsonVO<String> updateVip(@Validated @RequestBody VipUpdateDTO vip){
        vipInfoService.updateVip(vip);
        return JsonVO.success("更新成功");
    }

    @PostMapping("/recharge")
    @Operation(description = "会员充值", summary = "会员充值")
    public JsonVO<String> recharge(
            @RequestBody @Validated RechargeDTO dto,
            @Schema(description = "幂等校验令牌") String token){
        vipInfoService.recharge(dto);
        return JsonVO.success("充值成功");
    }

    @Operation(description = "查询会员资产列表", summary = "查询会员资产列表")
    @GetMapping("/query-asset-list/{vipId}")
    public JsonVO<VipCountVO> getAssetsByVipId(@PathVariable("vipId") Long vipId){
        return JsonVO.success(vipAssetService.queryAsset(vipId));
    }

    @Operation(description = "为会员赠送优惠券", summary = "赠送优惠券")
    @PostMapping("/present-ticket/{vipId}")
    public JsonVO<String> presentTicket (
            @PathVariable Long vipId,
            @RequestBody @Validated PresentTicketDTO dto){
        vipInfoService.presentTicket(vipId,dto);
        return JsonVO.success("赠送成功");
    }

    @Operation(description = "批量取消会员优惠券", summary = "取消会员优惠券")
    @PostMapping("/cancel-ticket/{vipId}")
    public JsonVO<String> cancelTicket (
            @PathVariable Long vipId,
            @RequestBody @Validated CancelTicketDTO dto){
        vipInfoService.cancelTicket(vipId,dto);
        return JsonVO.success("取消成功");
    }

    @Operation(description = "为会员赠送资产", summary = "赠送资产")
    @PostMapping("/present-asset/{vipId}")
    public JsonVO<String> presentAsset (
            @PathVariable Long vipId,
            @RequestBody @Validated PresentAssetDTO dto){
        vipAssetService.presentAsset(vipId,dto);
        return JsonVO.success("赠送成功");
    }
}
