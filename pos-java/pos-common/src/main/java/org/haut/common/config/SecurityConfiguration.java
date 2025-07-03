package org.haut.common.config;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.ResultStatus;
import org.haut.common.domain.vo.system.AuthorizeVO;
import org.haut.common.filter.JwtAuthorizeFilter;
import org.haut.common.utils.JwtUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.io.IOException;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Configuration
public class SecurityConfiguration {

    @Resource
    JwtUtils jwtUtils;
    @Resource
    JwtAuthorizeFilter jwtAuthorizeFilter;

    /**
     * 配置安全过滤链
     * @param http HttpSecurity对象
     *
     * @return SecurityFilterChain对象
     * @throws Exception 异常
     */
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        // 这里可以配置安全过滤链
        return http
                // 配置HTTP请求的授权规则
                .authorizeHttpRequests(conf -> conf
                        .requestMatchers("/api/auth/**").permitAll() // 允许访问/auth下的所有接口
                        .anyRequest().authenticated()
                )
                // 配置表单登录
                .formLogin(conf -> conf
                        .loginProcessingUrl("/api/auth/login") // 登录处理接口
                        .failureHandler(this::onAuthenticationFailure)
                        .successHandler(this::onAuthenticationSuccess)
                )
                // 配置登出处理
                .logout(conf -> conf
                        .logoutUrl("/api/auth/logout")
                        .logoutSuccessHandler(this::onLogoutSuccess)
                )
                // 禁用CSRF保护
                .csrf(AbstractHttpConfigurer::disable)
                // 使用无状态会话
                .sessionManagement(conf -> conf
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                // 添加JWT授权过滤器
                .addFilterBefore(jwtAuthorizeFilter, UsernamePasswordAuthenticationFilter.class)
                .build();
    }

    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException authenticationException) throws IOException, ServletException {
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(JsonVO.create(null, ResultStatus.UNAUTHORIZED).asJsonString());
    }

    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        // TODO:登录逻辑待完善
        // 处理登录成功逻辑
        response.setContentType("application/json;charset=utf-8");
        User user = (User) authentication.getPrincipal();
        // 这里的1和"jojo"是示例值，实际应用中应从UserDetails中获取用户ID和用户名
        String token = jwtUtils.createJwt(user,1, "jojo");
        // 返回JWT令牌
        AuthorizeVO authorizeVO = AuthorizeVO.builder()
                .username("jojo")
                .role("admin")
                .token(token)
                .expire(jwtUtils.expireTime())
                .build();

        response.getWriter().write(JsonVO.create(authorizeVO, ResultStatus.LOGIN_SUCCESS).asJsonString());
    }

    public void onLogoutSuccess(HttpServletRequest request,
                                HttpServletResponse response,
                                Authentication authentication) throws IOException, ServletException {
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(JsonVO.success(null).asJsonString());
    }
}
