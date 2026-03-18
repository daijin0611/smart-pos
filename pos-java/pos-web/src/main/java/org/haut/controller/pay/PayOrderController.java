package org.haut.controller.pay;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.pay.PayOrderDTO;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@Tag(name = "支付订单", description = "支付订单相关接口")
@RestController
@RequestMapping("/pay")
public class PayOrderController {

    @PostMapping("/pay-order")
    public Long pay(@RequestBody PayOrderDTO payOrderDTO) {
        return null;
    }

}
