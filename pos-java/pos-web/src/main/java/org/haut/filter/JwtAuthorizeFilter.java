package org.haut.filter;

import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.annotation.Resource;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.haut.common.component.JwtUtils;
import org.haut.common.utils.UserContextHolder;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

/**
 * JWT授权过滤器
 * @author 丁铭瀚
 * @version 1.0
 */
@Component
public class JwtAuthorizeFilter extends OncePerRequestFilter {

    @Resource
    JwtUtils jwtUtils;

    /**
     * 过滤器的核心方法，处理每个请求
     * @param request
     * @param response
     * @param filterChain
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        try {
            // 获取请求头中的Authorization字段
            String header = request.getHeader("Authorization");
            // 将请求头解析为JWT令牌
            DecodedJWT decodedJWT = jwtUtils.resoleJwt(header);
            if (decodedJWT != null) {
                UserDetails user = jwtUtils.toUser(decodedJWT);
                // 创建认证令牌
                UsernamePasswordAuthenticationToken authenticationToken =
                        new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
                authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                // 将认证信息存入SecurityContextHolder中
                SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                // 将用户名存入请求属性中，便于后续使用
                request.setAttribute("userCode", user.getUsername());
            }
            // 继续过滤链
            filterChain.doFilter(request, response);
        } finally {
            UserContextHolder.clearUser();
        }
    }
}
