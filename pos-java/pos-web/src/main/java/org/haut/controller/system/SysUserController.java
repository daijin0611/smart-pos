package org.haut.controller.system;


import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.system.UserCreateDTO;
import org.haut.common.domain.dto.system.UserUpdateDTO;
import org.haut.common.domain.query.system.UserListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.system.UserInfoVO;
import org.haut.server.system.entity.SysUser;
import org.haut.server.system.service.SysUserService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/system/user")
@Tag(name = "人事管理", description = "系统人事管理")
@Slf4j
public class SysUserController {

    @Resource
    private SysUserService sysUserService;


    @GetMapping("/query-list")
    @Operation(description = "获取用户列表", summary = "获取用户列表")
    public JsonVO<List<UserInfoVO>> getList(UserListQuery query){
        log.info(query.toString());
        return JsonVO.success(sysUserService.getList(query));
    }

    @GetMapping("/query-info")
    @Operation(description = "根据用户id查询详细信息", summary = "根据用户id查询详细信息")
    public JsonVO<UserInfoVO> getUserById(@RequestParam Long id){
        log.info("用户id：{}",id);
        UserInfoVO userInfoVO = BeanUtil.toBean(sysUserService.getById(id),UserInfoVO.class);
        return JsonVO.success(userInfoVO);
    }


    @PostMapping("/add-user")
    @Operation(description = "添加用户", summary = "添加用户")
    public JsonVO<String> addUser(@Validated @RequestBody UserCreateDTO user){
        if (judgeUserCodeExist(user.getUserCode())) {
            throw new RuntimeException("用户编号"+ user.getUserCode() + "已存在");
        }
        sysUserService.save(BeanUtil.toBean(user,SysUser.class));
        return JsonVO.success("添加成功");
    }



    @PutMapping("/update-user")
    @Operation(description = "更新用户", summary = "更新用户")
    public JsonVO<String> updateUser(@Validated @RequestBody UserUpdateDTO user){
        if (judgeUserCodeExist(user.getUserCode())) {
            throw new RuntimeException("用户编号"+ user.getUserCode() + "已存在");
        }
        sysUserService.updateById(BeanUtil.toBean(user,SysUser.class));
        return JsonVO.success("更新成功");
    }

    /**
     * 判断用户编号是否存在
     * @param userCode 用户编号
     * @return true:存在 false:不存在
     */
    private boolean judgeUserCodeExist(String userCode){
        long count = sysUserService.count(new QueryWrapper<SysUser>()
               .eq("user_code", userCode)
               .eq("is_delete", 0));
        return count > 0;
    }
}
