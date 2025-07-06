package org.haut.controller.system;

import io.swagger.v3.oas.annotations.Operation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 用户认证控制器
 * @author 丁铭瀚
 * @version 1.0
 */
@RestController
@RequestMapping("/system/auth")
public class AuthController {

    /**
     * 用户登录接口
     */
    @Operation(description = "用户登录")
    @PostMapping("/login")
    public void login() {
        // TODO登录逻辑
    }

    /**
     * 用户登出接口
     */
    @Operation(description = "用户登出")
    @PostMapping("/logout")
    public void logout() {
        // TODO登出逻辑
    }

    @Operation(description = "用户注册")
    @PostMapping("/signup")
    public void signUp() {
        // TODO注册逻辑
    }

}
