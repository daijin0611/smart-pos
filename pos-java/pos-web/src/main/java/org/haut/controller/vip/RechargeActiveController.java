package org.haut.controller.vip;


import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.vip.RechargeActiveInfoDTO;
import org.haut.common.domain.dto.vip.RechargeActiveListDTO;
import org.haut.common.domain.vo.JsonVO;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/vip/recharge-active")
@Tag(name = "充值活动管理", description = "充值活动管理")
@Slf4j
public class RechargeActiveController {

    @GetMapping("/activeName-list")
    @Operation(description = "获取充值活动列表", summary = "获取充值活动列表")
    public JsonVO<RechargeActiveListDTO> getList(RechargeActiveListDTO activeName) {
        log.info(activeName.toString());
        return null;
    }

    @GetMapping("/querry-info")
    @Operation(description = "根据充值活动id查询详细信息", summary = "根据充值活动id查询详细信息")
    public JsonVO<RechargeActiveInfoDTO> getInfoById(@RequestParam Long id) {
        log.info("会员id：{}",id);
        return null;
    }

    @PostMapping("/add-active")
    @Operation(description = "添加充值活动", summary = "添加充值活动")
    public JsonVO<String> addActive(@Validated @RequestBody RechargeActiveInfoDTO active) {
        return null;
    }
}
