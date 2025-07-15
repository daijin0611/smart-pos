package org.haut.controller.auth;

import io.swagger.v3.oas.annotations.Operation;
import org.haut.common.domain.dto.auth.LoginDTO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.auth.AuthorizeVO;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 用户登录接口
 * @author 丁铭瀚
 * @version 1.0
 */
@RestController
@RequestMapping("/auth")
public class AuthController {

    /**
     * 用户登录接口
     */
    @Operation(description = "用户登录")
    @PostMapping("/login")
    public JsonVO<AuthorizeVO> login(@RequestBody LoginDTO loginDTO) {
        // TODO登录逻辑
        return null;
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
