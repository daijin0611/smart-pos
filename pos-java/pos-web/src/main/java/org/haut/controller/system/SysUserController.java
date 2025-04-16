package org.haut.controller.system;


import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.system.UserInfoDTO;
import org.haut.common.domain.dto.system.UserListDTO;
import org.haut.common.domain.query.UserListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.entity.SysUser;
import org.haut.server.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/system/user")
@Tag(name = "系统用户管理", description = "系统用户管理")
@Slf4j
public class SysUserController {

    @Autowired
    private SysUserService sysUserService;


    @GetMapping("/query-list")
    @Operation(description = "获取用户列表", summary = "获取用户列表")
    public JsonVO<List<UserListDTO>> getList(UserListQuery query){
        log.info(query.toString());
        return JsonVO.success(sysUserService.getList(query));
    }

    @GetMapping("/query-info")
    @Operation(description = "根据用户id查询详细信息", summary = "根据用户id查询详细信息")
    public JsonVO<UserInfoDTO> getUserById(@RequestParam Long id){
        log.info("用户id：{}",id);
        //将SysUser转化为UserInfoDTO
        UserInfoDTO userInfoDTO = BeanUtil.toBean(sysUserService.getById(id),UserInfoDTO.class);
        return JsonVO.success(userInfoDTO);
    }


    @PostMapping("/add-user")
    @Operation(description = "添加用户", summary = "添加用户")
    public JsonVO<String> addUser(@Validated @RequestBody UserInfoDTO user){
        sysUserService.save(BeanUtil.toBean(user,SysUser.class));
        return JsonVO.success("添加成功");
    }

    @PutMapping("/update-user")
    @Operation(description = "更新用户", summary = "更新用户")
    public JsonVO<String> updateUser(@Validated @RequestBody UserInfoDTO user){
        sysUserService.updateById(BeanUtil.toBean(user,SysUser.class));
        return JsonVO.success("更新成功");
    }

}
