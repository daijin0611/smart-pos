package org.haut.server.system.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.query.system.UserListQuery;
import org.haut.common.domain.vo.system.UserInfoVO;
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
import org.springframework.stereotype.Service;
import java.util.List;

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
    /**
     * 查询用户列表,条件查询
     *
     * @param query
     * @return
     */ 
    @Override
    public List<UserInfoVO> getList(UserListQuery query) {
        //构建条件查询器，当用户名、用户编号、用户状态不为空时，进行查询
        QueryWrapper<SysUser> queryWrapper = new QueryWrapper<>();
        queryWrapper.like(StringUtils.isNotBlank(query.getUserName()),"user_name",query.getUserName())
                .like(StringUtils.isNotBlank(query.getUserNumber()),"user_number",query.getUserNumber())
                .eq(StringUtils.isNotBlank(query.getUserNumber()),"user_status",query.getUserStatus());
        //查询数据库
        List<SysUser> sysUsers = sysUserMapper.selectList(queryWrapper);
        //转化为DTO
        return BeanUtil.copyToList(sysUsers, UserInfoVO.class);
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

        List<SysRole> sysRole = sysRoleMapper.selectByIds(sysUserRole.stream().map(SysUserRole::getRoleId).toList());


        // 构建Spring Security所需的User对象
        // 第一个参数是用户名
        // 第二个参数是加密后的密码
        // 第三个参数是权限列表（这里假设只有一个角色）
        return User.withUsername(userCode)
                .roles(sysRole.stream().map(SysRole::getRoleCode).toArray(String[]::new))
                .password(sysUser.getUserPassword())
                .build();

    }




}




