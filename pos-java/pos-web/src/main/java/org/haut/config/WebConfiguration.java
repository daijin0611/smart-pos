package org.haut.config;

import lombok.RequiredArgsConstructor;
import org.haut.interceptor.OrgInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
                .excludePathPatterns("/login", "/logout");
    }
}
