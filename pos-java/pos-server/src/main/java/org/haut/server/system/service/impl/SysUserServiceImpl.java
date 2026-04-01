package org.haut.server.system.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.system.UserAllocateRoleDTO;
import org.haut.common.domain.dto.system.UserCreateDTO;
import org.haut.common.domain.dto.system.UserDTO;
import org.haut.common.domain.dto.system.UserUpdateDTO;
import org.haut.common.domain.query.system.UserListQuery;
import org.haut.common.domain.vo.system.RoleInfoVo;
import org.haut.common.domain.vo.system.UserInfoVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.UserContextHolder;
import org.haut.server.system.entity.SysRole;
import org.haut.server.system.entity.SysUser;
import org.haut.server.system.entity.SysUserRole;
import org.haut.server.system.mapper.SysOrgMapper;
import org.haut.server.system.mapper.SysRoleMapper;
import org.haut.server.system.mapper.SysUserRoleMapper;
import org.haut.server.system.mapper.SysUserMapper;
import org.haut.server.system.service.SysOrgUserService;
import org.haut.server.system.service.SysUserService;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@RequiredArgsConstructor
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser>
        implements SysUserService {

    private final SysUserMapper sysUserMapper;
    private final SysOrgMapper sysOrgMapper;
    private final SysUserRoleMapper sysUserRoleMapper;
    private final SysRoleMapper sysRoleMapper;
    private final SysOrgUserService sysOrgUserService;
    private final BCryptPasswordEncoder encoder;

    @Override
    public PageDTO<UserInfoVO> getList(UserListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Page<UserInfoVO> page = new Page<>();
        page.setCurrent(query.getPageNum());
        page.setSize(query.getPageSize());
        sysUserMapper.getList(page, query, auth.getOrgId());
        return PageDTO.create(page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addUser(UserCreateDTO user) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Long roleId = user.getRoleId();
        if (roleId == null) {
            throw new BusinessException("用户必须分配一个角色");
        }
        // 创建用户
        SysUser sysUser = BeanUtil.toBean(user, SysUser.class);
        sysUser.setOrgId(auth.getOrgId());
        this.save(sysUser);

        // 绑定额外关联门店
        if (user.getOrgIds() != null && !user.getOrgIds().isEmpty()) {
            sysOrgUserService.bindOrgs(sysUser.getId(), user.getOrgIds());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateUser(UserUpdateDTO user) {
        // 更新用户基本信息
        SysUser sysUser = BeanUtil.toBean(user, SysUser.class);
        this.updateById(sysUser);

        // 同步更新门店关联（先删后插）
        sysOrgUserService.unbindOrgs(user.getId());
        if (user.getOrgIds() != null && !user.getOrgIds().isEmpty()) {
            sysOrgUserService.bindOrgs(user.getId(), user.getOrgIds());
        }
    }

    @Override
    public void allocateRole(UserAllocateRoleDTO dto) {
        this.lambdaUpdate().set(SysUser::getRoleId, dto.getRoleId())
                .eq(SysUser::getId, dto.getUserId())
                .update();
    }

    @Override
    public List<RoleInfoVo> queryRoleList(Long userId) {
        return sysUserMapper.queryRoleList(userId);
    }

    @Override
    public UserInfoVO queryOne(Long id, String userNumber) {
        LambdaQueryWrapper<SysUser> queryWrapper = Wrappers.lambdaQuery(SysUser.class)
                .eq(id != null, SysUser::getId, id)
                .eq(userNumber != null, SysUser::getUserNumber, userNumber);
        SysUser user = this.getOne(queryWrapper);
        if (user == null) {
            throw new BusinessException("用户不存在");
        }
        SysRole sysRole = sysRoleMapper.selectById(user.getRoleId());
        RoleInfoVo roleInfoVo = BeanUtil.toBean(sysRole, RoleInfoVo.class);
        UserInfoVO userInfoVO = BeanUtil.toBean(user, UserInfoVO.class);
        userInfoVO.setRole(roleInfoVo);

        // 查询关联门店，合并主门店
        List<Long> extraOrgIds = sysOrgUserService.getOrgIdsByUserId(user.getId());
        List<Long> allOrgIds = new ArrayList<>();
        allOrgIds.add(user.getOrgId());
        allOrgIds.addAll(extraOrgIds);
        userInfoVO.setOrgIds(allOrgIds);

        return userInfoVO;
    }

    @Override
    public UserDetails loadUserByUsername(String userCode) throws UsernameNotFoundException {
        SysUser sysUser = sysUserMapper.selectOne(Wrappers.lambdaQuery(SysUser.class)
                .eq(SysUser::getUserCode, userCode));

        if (sysUser == null) {
            throw new UsernameNotFoundException("用户名或密码错误");
        }

        UserContextHolder.setUser(BeanUtil.toBean(sysUser, UserDTO.class));

        List<SysUserRole> sysUserRole = sysUserRoleMapper.selectList(Wrappers.lambdaQuery(SysUserRole.class)
                .eq(SysUserRole::getUserId, sysUser.getId()));
        List<SysRole> sysRoleList = new ArrayList<>();
        String[] roles;
        if (!sysUserRole.isEmpty()) {
            sysRoleList = sysRoleMapper.selectByIds(sysUserRole.stream().map(SysUserRole::getRoleId).toList());
            roles = sysRoleList.stream().map(SysRole::getRoleCode).toArray(String[]::new);
        } else {
            roles = new String[0];
        }

        return User.withUsername(userCode)
                .roles(roles)
                .password(encoder.encode(sysUser.getUserPassword()))
                .build();
    }
}
