package org.haut.controller.vip;

import cn.hutool.core.bean.BeanUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.system.UserInfoDTO;
import org.haut.common.domain.dto.vip.VipInfoDTO;
import org.haut.common.domain.dto.vip.VipListDTO;
import org.haut.common.domain.query.VipListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.entity.SysUser;
import org.haut.server.entity.VipInfo;
import org.haut.server.service.VipInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/vip")
@Tag(name = "会员管理", description = "会员管理")
@Slf4j
public class VipConreoller {

    @Autowired
    private VipInfoService vipInfoService;

    @GetMapping("/query-list")
    @Operation(description = "获取会员列表", summary = "获取会员列表")
    public JsonVO<List<VipListDTO>> getList(VipListQuery query) {
        log.info(query.toString());
        //TODO
        return JsonVO.success(vipInfoService.getList(query));
    }

    @GetMapping("/query-info")
    @Operation(description = "根据会员id查询详细信息", summary = "根据会员id查询详细信息")
    public JsonVO<VipInfoDTO> getVipById(@RequestParam Long id) {
        log.info("会员id：{}",id);
        //将VipInfo转化为VipInfoDTO
        VipInfoDTO vipInfoDTO = BeanUtil.toBean(vipInfoService.getById(id),VipInfoDTO.class);
        return JsonVO.success(vipInfoDTO);
    }

    @PostMapping("/add-vip")
    @Operation(description = "添加会员", summary = "添加会员")
    public JsonVO<String> addVip(@Validated @RequestBody VipInfoDTO vip) {
        vipInfoService.save(BeanUtil.toBean(vip, VipInfo.class));
        return JsonVO.success("添加成功");
    }

    @PutMapping("/update-vip")
    @Operation(description = "更新会员", summary = "更新会员")
    public JsonVO<String> updateUser(@Validated @RequestBody VipInfoDTO vip){
        vipInfoService.updateById(BeanUtil.toBean(vip,VipInfo.class));
        return JsonVO.success("更新成功");
    }





}
