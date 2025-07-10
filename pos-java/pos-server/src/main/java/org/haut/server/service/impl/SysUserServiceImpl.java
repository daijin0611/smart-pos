package org.haut.server.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.common.domain.dto.system.LoginDTO;
import org.haut.common.domain.query.system.UserListQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.system.AuthorizeVO;
import org.haut.common.domain.vo.system.UserInfoVO;
import org.haut.server.entity.SysUser;
import org.haut.server.service.SysUserService;
import org.haut.server.mapper.SysUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
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
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser>
    implements SysUserService{

    @Autowired
    private SysUserMapper sysUserMapper;

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
     * 用户登录
     * @param loginDTO
     * @return
     */
    @Override
    public JsonVO<AuthorizeVO> login(LoginDTO loginDTO) {
        return null;
    }


    /**
     * 根据用户名查询用户
     * @param username
     * @return
     * @throws UsernameNotFoundException
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return null;
    }




}




