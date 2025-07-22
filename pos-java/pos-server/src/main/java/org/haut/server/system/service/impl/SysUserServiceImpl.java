package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.query.system.UserListQuery;
import org.haut.server.system.entity.SysRole;
import org.haut.server.system.entity.SysUser;
import org.haut.server.system.entity.SysUserRole;
import org.haut.server.system.mapper.SysOrgMapper;
import org.haut.server.system.mapper.SysRoleMapper;
import org.haut.server.system.mapper.SysUserRoleMapper;
import org.haut.server.system.service.SysUserService;
import org.haut.server.system.mapper.SysUserMapper;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.*;

/**
* @author daiji
* @description 针对表【sys_user(系统用户表（员工表）)】的数据库操作Service实现
* @createDate 2025-04-15 11:13:13
*/
@Service
@RequiredArgsConstructor
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser>
    implements SysUserService{

    private final SysUserMapper sysUserMapper;
    private final SysOrgMapper sysOrgMapper;
    private final SysUserRoleMapper sysUserRoleMapper;
    private final SysRoleMapper sysRoleMapper;
    private final BCryptPasswordEncoder encoder;
    /**
     * 查询用户列表,条件查询
     *
     * @param query
     * @return
     */ 
    @Override
    public Page<SysUser> getList(UserListQuery query) {
        LambdaQueryWrapper<SysUser> queryWrapper = Wrappers.lambdaQuery(SysUser.class)
                .like(StringUtils.isNotBlank(query.getUserName()), SysUser::getUserName, query.getUserName())
                .eq(StringUtils.isNotBlank(query.getUserStatus()), SysUser::getUserStatus, query.getUserStatus())
                .like(StringUtils.isNotBlank(query.getUserNumber()), SysUser::getUserNumber, query.getUserNumber());
        Page<SysUser> page = new Page<>(query.getPageNum(), query.getPageSize());
        return sysUserMapper.selectPage(page, queryWrapper);
    }


    /**
     * 根据用户名查询用户
     * @param userCode
     * @return
     * @throws UsernameNotFoundException
     */
    @Override
    public UserDetails loadUserByUsername(String userCode) throws UsernameNotFoundException {
        // 根据用户名从数据库查询用户
        SysUser sysUser = sysUserMapper.selectOne(Wrappers.lambdaQuery(SysUser.class)
                .eq(SysUser::getUserCode, userCode));

        if (sysUser == null) {
            throw new UsernameNotFoundException("用户名或密码错误");
        }

        List<SysUserRole> sysUserRole = sysUserRoleMapper.selectList(Wrappers.lambdaQuery(SysUserRole.class)
                .eq(SysUserRole::getUserId, sysUser.getId()));
        List<SysRole> sysRoleList = new ArrayList<>();
        String[] roles;
        if (!sysUserRole.isEmpty()) {
            sysRoleList = sysRoleMapper.selectByIds(sysUserRole.stream().map(SysUserRole::getRoleId).toList());
            roles = sysRoleList.stream().map(SysRole::getRoleCode).toArray(String[]::new);
        }else {
            // 如果用户没有角色，返回一个空的角色数组
            roles = new String[0];
        }

        // 构建Spring Security所需的User对象
        // 第一个参数是用户名
        // 第二个参数是加密后的密码
        // 第三个参数是权限列表（这里假设只有一个角色）
        return User.withUsername(userCode)
                .roles(roles)
                .password(encoder.encode(sysUser.getUserPassword()))
                .build();

    }
}




