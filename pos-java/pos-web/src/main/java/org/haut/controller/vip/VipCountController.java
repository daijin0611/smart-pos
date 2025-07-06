package org.haut.controller.vip;


import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.vip.VipAssetDTO;
import org.haut.common.domain.dto.vip.VipCountListDTO;
import org.haut.common.domain.query.vip.VipCountListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/vip/count")
@Tag(name = "会员统计管理", description = "会员统计管理（操作：查询资产详情）")
@Slf4j
public class VipCountController {

    @GetMapping("/query-list")
    @Operation(description = "获取会员统计列表", summary = "获取会员统计列表")
    public JsonVO<List<VipCountListDTO>> getList(VipCountListQuery query) {
        log.info(query.toString());
        return null;
    }

    @GetMapping("/query-asset")
    @Operation(description = "根据会员id查询资产详情", summary = "根据会员id查询资产详情")
    public JsonVO<VipAssetDTO> getById(@RequestParam Long id) {
        log.info("会员id：{}",id);
        //转化VipAssetDTO操作
        return null;
    }
}
