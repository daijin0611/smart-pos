package org.haut.config;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.haut.common.domain.dto.system.UserDTO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.ResultStatus;
import org.haut.common.domain.vo.auth.AuthorizeVO;
import org.haut.common.utils.UserContextHolder;
import org.haut.filter.JwtAuthorizeFilter;
import org.haut.common.component.JwtUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import java.io.IOException;
import java.io.PrintWriter;


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
     * @return SecurityFilterChain对象
     * @throws Exception 异常
     */
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        // 这里可以配置安全过滤链
        return http
                // 配置HTTP请求的授权规则
                .authorizeHttpRequests(conf -> conf
                        .requestMatchers("/auth/login").permitAll() // 登录接口
                        .requestMatchers("/doc.html", "/swagger-ui/**", "/v3/api-docs/**").permitAll() // 允许Swagger相关接口
                        .requestMatchers("/webjars/**", "/favicon.ico").permitAll() // 允许Knife4j相关资源
                        .requestMatchers("/knife4j/**").permitAll() // 允许Knife4j UI资源
                        .requestMatchers("/static/**").permitAll() // 允许静态资源访问
                        .requestMatchers("/druid/**").permitAll()
                        .requestMatchers("/actuator/**").permitAll()
                        .anyRequest().authenticated()
                )
                // 配置表单登录
                .formLogin(conf -> conf
                        .loginProcessingUrl("/auth/login") // 登录处理接口
                        .failureHandler(this::onAuthenticationFailure) // 认证失败处理
                        .successHandler(this::onAuthenticationSuccess) // 认证成功处理
                )
                // 配置未授权处理
                .exceptionHandling(conf -> conf
                        .authenticationEntryPoint(this::onUnAuthenticated)// 未认证处理
                        .accessDeniedHandler(this::onAccessDeny)// 无权限访问处理
                )
                // 配置登出处理
                .logout(conf -> conf
                        .logoutUrl("/auth/logout")
                        .logoutSuccessHandler(this::onLogoutSuccess)
                )
                .cors(AbstractHttpConfigurer::disable)
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

    /**
     * 处理没有权限访问的逻辑
     * @param request
     * @param response
     * @param accessDeniedException
     * @throws IOException
     * @throws ServletException
     */
    public void onAccessDeny(HttpServletRequest request,
                             HttpServletResponse response,
                             AccessDeniedException accessDeniedException) throws IOException, ServletException {
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(JsonVO.create(null, ResultStatus.FORBIDDEN).asJsonString());
    }


    /**
     * 处理未认证的逻辑
     * @param request
     * @param response
     * @param authException
     * @throws IOException
     * @throws ServletException
     */
    public void onUnAuthenticated(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException authException) throws IOException{
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(JsonVO.create(null, ResultStatus.UNAUTHORIZED).asJsonString());
    }


    /**
     * 处理认证失败的逻辑
     * @param request
     * @param response
     * @param exception
     * @throws IOException
     * @throws ServletException
     */
    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException exception) throws IOException{
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(JsonVO.create(null, ResultStatus.USERNAME_OR_PASSWORD_ERROR).asJsonString());
    }

    /**
     * 处理认证成功的逻辑
     * @param request
     * @param response
     * @param authentication
     * @throws IOException
     * @throws ServletException
     */
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException{
        // TODO:登录逻辑待完善
        // 处理登录成功逻辑
        response.setContentType("application/json;charset=utf-8");
        User user = (User) authentication.getPrincipal();
        UserDTO sysUser = UserContextHolder.getUser();
        // 这里的1和"jojo"是示例值，实际应用中应从UserDetails中获取用户ID和用户名
        String token = jwtUtils.createJwt(user, sysUser.getId(), sysUser.getUserCode(), sysUser.getOrgId());

        // 返回JWT令牌
        AuthorizeVO authorizeVO = AuthorizeVO.builder()
                .userName(sysUser.getUserName())
                .userCode(sysUser.getUserCode())
                .userId(sysUser.getId())
                .orgId(sysUser.getOrgId())
                .token(token)
                .expire(jwtUtils.expireTime())
                .build();

        response.getWriter().write(JsonVO.create(authorizeVO, ResultStatus.LOGIN_SUCCESS).asJsonString());
    }

    /**
     * 处理登出成功的逻辑
     * @param request
     * @param response
     * @param authentication
     * @throws IOException
     * @throws ServletException
     */
    public void onLogoutSuccess(HttpServletRequest request,
                                HttpServletResponse response,
                                Authentication authentication) throws IOException{
        response.setContentType("application/json;charset=utf-8");
        PrintWriter writer = response.getWriter();
        // 失效JWT令牌
        String headerToken = request.getHeader("Authorization");
        if (jwtUtils.invalidateJwt(headerToken)) {
            writer.write(JsonVO.create(null, ResultStatus.LOGOUT_SUCCESS).asJsonString());
        }else {
            // 如果失效失败，返回错误信息
            writer.write(JsonVO.create(null, ResultStatus.FAIL).asJsonString());
        }
    }
}
