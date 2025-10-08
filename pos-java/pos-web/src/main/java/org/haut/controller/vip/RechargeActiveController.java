package org.haut.controller.vip;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

import org.haut.common.domain.dto.vip.VipRechargeActiveAddDTO;
import org.haut.common.domain.dto.vip.VipRechargeActiveStatusDTO;
import org.haut.common.domain.query.vip.ActiveStatQuery;
import org.haut.common.domain.query.vip.VipRechargeActiveQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.vip.RechargeHistoryVO;
import org.haut.common.domain.vo.vip.VipRechargeActiveVO;
import org.haut.server.vip.service.VipRechargeActiveService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/vip/recharge-active")
@Tag(name = "充值活动管理", description = "充值活动管理")
@Slf4j
@RequiredArgsConstructor
public class RechargeActiveController {
    
    private final VipRechargeActiveService vipRechargeActiveService;

    /**
     * 获取充值活动列表
     * 
     * @param query 查询条件
     * @return 充值活动列表
     */
    @GetMapping("/query-list")
    @Operation(description = "获取充值活动列表", summary = "获取充值活动列表")
    public JsonVO<List<VipRechargeActiveVO>> queryList(VipRechargeActiveQuery query) {
        log.info("查询充值活动列表，查询条件：{}", query);
        return JsonVO.success(vipRechargeActiveService.queryList(query));

    }
    
    /**
     * 新增充值活动
     * 
     * @param addDTO 新增数据
     * @return 操作结果
     */
    @PostMapping("/add")
    @Operation(description = "新增充值活动", summary = "新增充值活动")
    public JsonVO<String> addRechargeActive(@Validated @RequestBody VipRechargeActiveAddDTO addDTO) {
        log.info("新增充值活动，数据：{}", addDTO);
        vipRechargeActiveService.addRechargeActive(addDTO);
        return JsonVO.success("新增成功");
    }
    
    /**
     * 修改充值活动状态
     * 
     * @param statusDTO 状态修改数据
     * @return 操作结果
     */
    @PutMapping("/update-status")
    @Operation(description = "修改充值活动状态", summary = "修改充值活动状态")
    public JsonVO<String> updateStatus(@Validated @RequestBody VipRechargeActiveStatusDTO statusDTO) {
        log.info("修改充值活动状态，数据：{}", statusDTO);
        vipRechargeActiveService.updateStatus(statusDTO);
        return JsonVO.success("状态修改成功");
    }

}
