package org.haut.config;

import lombok.RequiredArgsConstructor;
import org.haut.interceptor.OrgInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@RequiredArgsConstructor
public class WebConfiguration implements WebMvcConfigurer {
    private final OrgInterceptor orgInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(orgInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/doc.html", "/webjars/**", "/v3/**") //排除knife4j相关资源
                .excludePathPatterns("/static/**") //排除静态资源
                .excludePathPatterns("/login", "/logout");
    }
}
