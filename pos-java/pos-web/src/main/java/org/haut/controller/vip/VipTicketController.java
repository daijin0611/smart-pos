package org.haut.controller.vip;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.vip.VipTicketCreateDTO;
import org.haut.common.domain.dto.vip.VipTicketUpdateDTO;
import org.haut.common.domain.query.vip.VipInfoTicketQuery;
import org.haut.common.domain.query.vip.VipTicketListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.vip.TicketCountVO;
import org.haut.common.domain.vo.vip.VipTicketVO;
import org.haut.server.vip.service.VipInfoTicketService;
import org.haut.server.vip.service.VipTicketService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/vip/ticket")
@Tag(name = "优惠券管理", description = "优惠券管理")
@Slf4j
@RequiredArgsConstructor
public class VipTicketController {
    private final VipTicketService vipTicketService;
    private final VipInfoTicketService vipInfoTicketService;
    @GetMapping("/ticket-list")
    @Operation(description = "获取优惠券列表", summary = "获取优惠券列表")
    public JsonVO<List<VipTicketVO>> getList(VipTicketListQuery query){
        log.info(query.toString());
        return JsonVO.success(vipTicketService.getList(query));
    }

    @GetMapping("/ticket-info")
    @Operation(description = "根据优惠券id查询详细信息", summary = "根据优惠券id查询详细信息")
    public JsonVO<VipTicketVO> getInfoById(@RequestParam Long id){
        log.info("优惠券id：{}",id);
        return JsonVO.success(vipTicketService.queryById(id));
    }

    @PostMapping("/add-ticket")
    @Operation(description = "添加优惠券", summary = "添加优惠券")
    public JsonVO<String> addTicket(@Validated @RequestBody VipTicketCreateDTO ticket){
        log.info(ticket.toString());
        vipTicketService.addTicket(ticket);
        return JsonVO.success();
    }

    @PutMapping("/update-ticket")
    @Operation(description = "修改优惠券", summary = "修改优惠券")
    public JsonVO<String> updateTicket(@Validated @RequestBody VipTicketUpdateDTO ticket){
        log.info(ticket.toString());
        vipTicketService.updateTicket(ticket);
        return JsonVO.success();
    }

    @PutMapping("/update-status")
    @Operation(description = "修改优惠券状态", summary = "修改优惠券状态")
    public JsonVO<String> updateStatus(@RequestParam Long id, @RequestParam Integer status){
        vipTicketService.updateStatus(id, status);
        return JsonVO.success();
    }

    @GetMapping("/count-ticket")
    @Operation(description = "分页查询会员优惠券明细", summary = "分页查询会员优惠券明细")
    public JsonVO<PageDTO<TicketCountVO>> queryPage(VipInfoTicketQuery query) {
        log.info("查询会员优惠券明细参数：{}", query);
        PageDTO<TicketCountVO> result = vipInfoTicketService.queryTicketCountPage(query);
        return JsonVO.success(result);
    }
}
