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
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
@RequiredArgsConstructor
public class OrgInterceptor implements HandlerInterceptor {
    private final JwtUtils jwtUtils;
    private final SysUserMapper sysUserMapper;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        try {
            String token = request.getHeader("Authorization");
            DecodedJWT decodedJWT = jwtUtils.resoleJwt(token);
            // 解析 token（你可以替换为你自己的解析逻辑）
            AuthInfoDTO authInfo = jwtUtils.toAuthInfo(decodedJWT);
            SysUser sysUser = sysUserMapper.selectById(authInfo.getUserId());
            authInfo.setUserName(sysUser.getUserName());
            // 保存 认证信息 到 ThreadLocal
            AuthContextHolder.setAuth(authInfo);
            return true;
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return false;
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        // 清理 ThreadLocal
        AuthContextHolder.clearAuth();
    }


}
