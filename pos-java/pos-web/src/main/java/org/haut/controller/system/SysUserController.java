package org.haut.controller.system;


import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.system.UserAllocateRoleDTO;
import org.haut.common.domain.dto.system.UserCreateDTO;
import org.haut.common.domain.dto.system.UserUpdateDTO;
import org.haut.server.system.entity.SysRole;
import org.haut.common.domain.query.system.UserListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.system.UserInfoVO;
import org.haut.server.system.entity.SysUser;
import org.haut.common.exception.BusinessException;
import org.haut.server.system.service.SysRoleService;
import org.haut.server.system.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/system/user")
@Tag(name = "人事管理", description = "系统人事管理")
@Slf4j
public class SysUserController {

    @Resource
    private SysUserService sysUserService;
    @Autowired
    private SysRoleService sysRoleService;

    /**
     * 获取用户列表, 分页+条件
     * 一个用户对应一个角色
     * @param query
     * @return
     */
    @GetMapping("/query-list")
    @Operation(description = "获取用户列表", summary = "获取用户列表")
    public JsonVO<PageDTO<UserInfoVO>> getList(UserListQuery query){
        log.info(query.toString());
        return JsonVO.success(sysUserService.getList(query));
    }

    /**
     * 根据用户id查询详细信息
     * @param id
     * @return
     */
    @GetMapping("/query-info")
    @Operation(description = "根据用户id查询详细信息", summary = "根据用户id查询详细信息")
    @Parameters(value = {
            @Parameter(name = "id", description = "用户id"),
            @Parameter(name = "userNumber", description = "用户电话号", required = true)
    })
    public JsonVO<UserInfoVO> getUserById(@RequestParam(required = false, value = "id") Long id,
                                          @RequestParam(required = false, value = "userNumber") String userNumber){
        log.info("用户id：{}",id);
        return JsonVO.success(sysUserService.queryOne(id, userNumber));
    }

    /**
     * 添加用户
     * @param user
     * @return
     */
    @PostMapping("/add-user")
    @Operation(description = "添加用户", summary = "添加用户")
    public JsonVO<String> addUser(@Validated @RequestBody UserCreateDTO user){
        if (judgeUserCodeExist(user.getUserCode(), null)) {
            return JsonVO.fail("用户编号" + user.getUserCode() + "已存在");
        }
        if (!judgeRoleExist(user.getRoleId())) {
            return JsonVO.fail("角色不存在");
        }
        sysUserService.addUser(user);
        return JsonVO.success("添加成功");
    }


    /**
     * 为用户分配角色
     * @param dto
     * @return
     */
    @PostMapping("/allocate-role")
    @Operation(description = "为用户分配角色", summary = "分配角色")
    public JsonVO<String> allocateRole(@RequestBody @Validated UserAllocateRoleDTO dto){
        if (!judgeRoleExist(dto.getRoleId())) {
            throw new BusinessException("角色不存在");
        }
        sysUserService.allocateRole(dto);
        return JsonVO.success("分配角色成功");
    }


    @PutMapping("/update-user")
    @Operation(description = "更新用户", summary = "更新用户")
    public JsonVO<String> updateUser(@Validated @RequestBody UserUpdateDTO user){
        if (judgeUserCodeExist(user.getUserCode(), user.getId())) {
            throw new BusinessException("用户编号"+ user.getUserCode() + "已存在");
        }
        if (!judgeRoleExist(user.getRoleId())) {
            throw new BusinessException("角色不存在");
        }
        sysUserService.updateById(BeanUtil.toBean(user,SysUser.class));
        return JsonVO.success("更新成功");
    }

    /**
     * 判断用户编号是否存在
     * @param userCode 用户编号
     * @return true:存在 false:不存在
     */
    private boolean judgeUserCodeExist(String userCode, Long id){
        SysUser sysUser = sysUserService.getOne(new QueryWrapper<SysUser>()
                .eq("user_code", userCode)
                .ne(id != null,"id", id));
        return sysUser != null;
    }

    /**
     * 判断角色是否存在
     * @param id 角色id
     * @return true:存在 false:不存在
     */
    private boolean judgeRoleExist(Long id){
        SysRole sysRole = sysRoleService.getById(id);
        return sysRole != null;
    }

}
