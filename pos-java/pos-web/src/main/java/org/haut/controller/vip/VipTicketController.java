package org.haut.controller.vip;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.vip.VipTicketListDTO;
import org.haut.common.domain.vo.JsonVO;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/vip/ticket")
@Tag(name = "优惠券管理", description = "优惠券管理")
@Slf4j
public class VipTicketController {

    @GetMapping("/ticket-list")
    @Operation(description = "获取优惠券列表", summary = "获取优惠券列表")
    public JsonVO<VipTicketListDTO> getList(VipTicketListDTO ticketName){
        log.info(ticketName.toString());
        return null;
    }

    @GetMapping("/ticket-info")
    @Operation(description = "根据优惠券id查询详细信息", summary = "根据优惠券id查询详细信息")
    public JsonVO<VipTicketListDTO> getInfoById(@RequestParam Long id){
        log.info("优惠券id：{}",id);
        return null;
    }

    @PostMapping("/add-ticket")
    @Operation(description = "添加优惠券", summary = "添加优惠券")
    public JsonVO<String> addTicket(@Validated @RequestBody VipTicketListDTO ticket){
        log.info(ticket.toString());
        return null;
    }
}
