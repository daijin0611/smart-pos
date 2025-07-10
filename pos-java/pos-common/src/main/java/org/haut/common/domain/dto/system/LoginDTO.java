package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@Data
@Schema(description = "用户登录信息")
public class LoginDTO implements UserDetails {

    @Schema(description = "用户编号")
    private String userCode;
    @Schema(description = "密码")
    private String password;
    @Schema(description = "组织编号")
    private String orgCode;
    @Schema(description = "角色名称")
    private String roleName;
    @Schema(description = "角色id")
    private String roleId;


    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of();
    }

    @Override
    public String getPassword() {
        return "";
    }

    @Override
    public String getUsername() {
        return "";
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
