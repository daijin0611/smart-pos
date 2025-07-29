package org.haut.controller.server;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.server.ServerProductCreateDTO;
import org.haut.common.domain.dto.server.ServerProductUpdateDTO;
import org.haut.common.domain.query.server.ServerProductListQuery;
import org.haut.common.domain.vo.server.ServerProductInfoVO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.server.service.ServerProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.exception.BusinessException;

import java.util.List;

@RestController
@RequestMapping("/server/product")
@Tag(name = "服务产品管理", description = "服务产品管理")
@Slf4j
public class ServerProductController {

    @Autowired
    private ServerProductService serverProductService;

    @GetMapping("/query-list")
    @Operation(description = "获取服务产品列表", summary = "获取服务产品列表")
    public JsonVO<List<ServerProductInfoVO>> getList(ServerProductListQuery query){
        log.info(query.toString());
        // 调用服务层方法获取列表
        return JsonVO.success(serverProductService.getList(query));
    }

    @GetMapping("/query-info")
    @Operation(description = "根据服务产品id查询详细信息", summary = "根据服务产品id查询详细信息")
    public JsonVO<ServerProductInfoVO> getProductById(@RequestParam Long id) {
        log.info("产品id：{}", id);
        try {
            // 调用服务层方法获取产品详情
            Long orgId = AuthContextHolder.getAuth().getOrgId();
            ServerProductInfoVO productInfoVO = serverProductService.getProductById(id, orgId);
            return JsonVO.success(productInfoVO);
        } catch (BusinessException e) {
            throw new BusinessException(e.getMessage());
        }
    }

    @Operation(description = "添加服务产品", summary = "添加服务产品")
    @PostMapping("/add-product")
    public JsonVO<String> addServerProduct(@Validated @RequestBody ServerProductCreateDTO product) {
        String result = serverProductService.addProduct(product);
        if ("添加成功".equals(result)) {
            return JsonVO.success(result);
        } else {
            return JsonVO.fail(result);
        }
    }

    @PutMapping("/update-product")
    @Operation(description = "更新服务产品", summary = "更新服务产品")
    public JsonVO<String> updateServerProduct(@Validated @RequestBody ServerProductUpdateDTO product) {
        String result = serverProductService.updateProduct(product);
        if ("更新成功".equals(result)) {
            return JsonVO.success(result);
        } else {
            return JsonVO.fail(result);
        }
    }

    @Operation(description = "更新产品状态", summary = "更新产品状态")
    @PutMapping("/update-status")
    public JsonVO<String> updateProductStatus(@RequestParam Long id, @RequestParam Integer status) {
        String result = serverProductService.updateProductStatus(id, status);
        if ("更新成功".equals(result)) {
            return JsonVO.success(result);
        } else {
            return JsonVO.fail(result);
        }
    }

}
