package org.haut.common.domain.dto.auth;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@Data
@Schema(description = "用户登录信息")
@Builder
public class LoginDTO implements UserDetails {

    @Schema(description = "用户编号")
    private String userCode;
    @Schema(description = "密码")
    private String password;
    @Schema(description = "组织id")
    private Long orgId;
    @Schema(description = "角色id")
    private Long roleId;
    @Schema(description = "角色标识")
    private String roleCode;


    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of();
    }

    @Override
    public String getPassword() {
        return this.password;
    }

    @Override
    public String getUsername() {
        return this.userCode;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
