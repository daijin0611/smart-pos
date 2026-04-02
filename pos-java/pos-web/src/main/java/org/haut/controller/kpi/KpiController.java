package org.haut.controller.kpi;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.kpi.KpiDetailCreateDTO;
import org.haut.common.domain.query.kpi.KpiListQuery;
import org.haut.common.domain.query.kpi.KpiSummaryQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.kpi.KpiListVO;
import org.haut.common.domain.vo.kpi.KpiSummaryVO;
import org.haut.server.kpi.service.KpiDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/kpi")
@RequiredArgsConstructor
@Validated
@Tag(name = "绩效管理相关接口", description = "绩效管理相关接口")
public class KpiController {

    @Autowired
    private KpiDetailService kpiDetailService;

    @PostMapping("/create")
    public JsonVO<Boolean> createKpiDetail(@RequestBody KpiDetailCreateDTO kpiDetailCreateDTO) {
        boolean result = kpiDetailService.createKpiDetail(kpiDetailCreateDTO);
        return JsonVO.success(result);
    }

    @PostMapping("/list")
    @Operation(summary = "获取绩效列表", description = "获取绩效列表")
    public JsonVO<PageDTO<KpiListVO>> getKpiList(@Validated @RequestBody KpiListQuery kpiListQuery) {
        PageDTO<KpiListVO> kpiList = kpiDetailService.getKpiList(kpiListQuery);
        return JsonVO.success(kpiList);
    }

    @PostMapping("/summary")
    @Operation(summary = "获取绩效总结", description = "获取绩效总结")
    public JsonVO<List<KpiSummaryVO>> getKpiSummary(@Validated @RequestBody KpiSummaryQuery query) {
        List<KpiSummaryVO> kpiSummaryVOS = kpiDetailService.getKpiSummary(query);
        return JsonVO.success(kpiSummaryVOS);
    }
}