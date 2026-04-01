package org.haut.interceptor;

import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.component.JwtUtils;
import org.haut.server.system.entity.SysUser;
import org.haut.server.system.mapper.SysUserMapper;
import org.haut.server.system.service.SysOrgUserService;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class OrgInterceptor implements HandlerInterceptor {
    private final JwtUtils jwtUtils;
    private final SysUserMapper sysUserMapper;
    private final SysOrgUserService sysOrgUserService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        try {
            String token = request.getHeader("Authorization");
            DecodedJWT decodedJWT = jwtUtils.resoleJwt(token);
            AuthInfoDTO authInfo = jwtUtils.toAuthInfo(decodedJWT);
            SysUser sysUser = sysUserMapper.selectById(authInfo.getUserId());
            authInfo.setUserName(sysUser.getUserName());

            // 查询用户关联门店，合并主门店
            List<Long> extraOrgIds = sysOrgUserService.getOrgIdsByUserId(authInfo.getUserId());
            List<Long> allOrgIds = new ArrayList<>();
            allOrgIds.add(authInfo.getOrgId());
            allOrgIds.addAll(extraOrgIds);
            authInfo.setOrgIds(allOrgIds);

            AuthContextHolder.setAuth(authInfo);
            return true;
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return false;
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        AuthContextHolder.clearAuth();
    }
}
