package org.haut.controller.vip;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.vip.RechargeHistoryListDTO;
import org.haut.common.domain.query.vip.ActiveStatQuery;
import org.haut.common.domain.query.vip.RechargeHistoryQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.vip.RechargeHistoryVO;
import org.haut.common.domain.vo.vip.StatRechargeActiveVO;
import org.haut.server.vip.service.VipRechargeHistoryService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/vip/recharge-history")
@Tag(name = "会员充值记录管理", description = "会员充值记录管理")
@Slf4j
@RequiredArgsConstructor
public class RechargeHistoryController {
    private final VipRechargeHistoryService vipRechargeHistoryService;
    @GetMapping("/query-list")
    @Operation(description = "获取会员充值记录列表", summary = "获取会员充值记录列表")
    public JsonVO<List<RechargeHistoryVO>> getList(RechargeHistoryQuery query) {
        log.info(query.toString());
        return JsonVO.success(vipRechargeHistoryService.getList(query));
    }

    @PutMapping("/update-status")
    @Operation(description = "更新充值状态/充值单据", summary = "更新充值状态/充值单据")
    public JsonVO<String> updateStatus(@Validated @RequestBody RechargeHistoryListDTO rechargeHistory) {
        return null;
    }

    @PostMapping("/stat-active")
    @Operation(description = "统计充值活动", summary = "统计充值活动")
    public JsonVO<StatRechargeActiveVO> statRechargeActive(@RequestBody @Validated ActiveStatQuery query){
        return JsonVO.success(vipRechargeHistoryService.statRechargeActive(query));
    }
}
