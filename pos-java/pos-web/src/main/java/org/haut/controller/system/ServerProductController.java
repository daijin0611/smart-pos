package org.haut.controller.system;

import cn.hutool.core.bean.BeanUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.server.ServerProductInfoDTO;
import org.haut.common.domain.dto.server.ServerProductListDTO;
import org.haut.common.domain.query.ServerProductListQuery;
import org.haut.server.entity.ServerProduct;
import org.haut.server.service.ServerProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.haut.common.domain.vo.JsonVO;

import java.util.List;

@RestController
@RequestMapping("/server/product")
@Tag(name = "服务产品管理", description = "服务产品管理")
@Slf4j
public class ServerProductController {

    @Autowired private ServerProductService serverProductService;

    @GetMapping("/query-list")
    @Operation(description = "获取服务产品列表", summary = "获取服务产品列表")
    public JsonVO<List<ServerProductListDTO>> getList(ServerProductListQuery query){
        log.info(query.toString());
        return JsonVO.success(serverProductService.getList(query));
    }

    @GetMapping("/query-info")
    @Operation(description = "根据服务产品id查询详细信息", summary = "根据服务产品id查询详细信息")
    public JsonVO<ServerProductInfoDTO> getProductById(@RequestParam Long id) {
        log.info("产品id：{}", id);
        // 将 ServerProduct 转化为 ServerProductInfoDTO
        ServerProductInfoDTO productInfoDTO = BeanUtil.toBean(serverProductService.getById(id), ServerProductInfoDTO.class);
        return JsonVO.success(productInfoDTO);
    }

    @PostMapping("/add-product")
    @Operation(description = "添加服务产品", summary = "添加服务产品")
    public JsonVO<String> addServerProduct(@Validated @RequestBody ServerProductInfoDTO product) {
        // 将 ServerProductInfoDTO 转换为 ServerProduct 实体类
        product.setId(null);
        serverProductService.save(BeanUtil.toBean(product, ServerProduct.class));
        return JsonVO.success("添加成功");
    }


    @PutMapping("/update-product")
    @Operation(description = "更新服务产品", summary = "更新服务产品")
    public JsonVO<String> updateServerProduct(@Validated @RequestBody ServerProductInfoDTO product) {
        // 将 ServerProductInfoDTO 转换为 ServerProduct 实体类并更新
        serverProductService.updateById(BeanUtil.toBean(product, ServerProduct.class));
        return JsonVO.success("更新成功");
    }

}
