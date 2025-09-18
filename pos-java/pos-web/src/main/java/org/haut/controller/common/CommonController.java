package org.haut.controller.common;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.common.IdempotentService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/common")
@Tag(name = "通用接口")
@RequiredArgsConstructor
public class CommonController {
    private final IdempotentService idempotentService;

    @GetMapping("/idempotent/create")
    @Operation(summary = "创建幂等性令牌")
    public JsonVO<String> createToken() {
        return JsonVO.success(idempotentService.createToken());
    }

}
