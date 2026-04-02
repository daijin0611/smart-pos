# 用户多门店关联 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现用户与多家门店的关联关系，保留 SysUser.orgId 作为主门店，新增 sys_org_user 关联表存储额外门店。

**Architecture:** 混合模式 — 保留 `SysUser.orgId` 作为主门店（收银登录等核心流程不变），新建 `SysOrgUser` 实体 + 关联表存储额外门店关系。OrgInterceptor 扩展加载用户全部关联门店到 AuthInfoDTO.orgIds。用户创建/更新时同步维护关联表。

**Tech Stack:** Java 17, Spring Boot 3.5.0, MyBatis-Plus 3.5.11, MySQL 8.2.0

---

## File Structure

| 操作 | 文件路径 | 说明 |
|------|----------|------|
| Create | `pos-server/.../entity/SysOrgUser.java` | 用户门店关联实体 |
| Create | `pos-server/.../mapper/SysOrgUserMapper.java` | 关联表 Mapper |
| Create | `pos-server/.../service/SysOrgUserService.java` | 关联管理接口 |
| Create | `pos-server/.../service/impl/SysOrgUserServiceImpl.java` | 关联管理实现 |
| Modify | `pos-common/.../dto/system/AuthInfoDTO.java` | 新增 orgIds 字段 |
| Modify | `pos-common/.../dto/system/UserCreateDTO.java` | 新增 orgIds 字段 |
| Modify | `pos-common/.../dto/system/UserUpdateDTO.java` | 新增 orgIds 字段 |
| Modify | `pos-common/.../vo/system/UserInfoVO.java` | 新增 orgIds 字段 |
| Modify | `pos-web/.../interceptor/OrgInterceptor.java` | 查询并设置 orgIds |
| Modify | `pos-server/.../service/SysUserService.java` | 新增 updateUser 方法签名 |
| Modify | `pos-server/.../service/impl/SysUserServiceImpl.java` | addUser/updateUser 中同步维护关联 |
| Modify | `pos-web/.../controller/system/SysUserController.java` | updateUser 改用 Service 方法 |
| Create | `sql/V1.0.9__alter_sys_org_user_pk.sql` | 调整表主键顺序 |

---

### Task 1: 数据库迁移 — 调整 sys_org_user 主键顺序

**Files:**
- Create: `sql/V1.0.9__alter_sys_org_user_pk.sql`

现有 `sys_org_user` 表主键为 `(org_id, usr_id)`，设计规格要求 `(usr_id, org_id)` 以优化"查某用户的门店列表"这一主要查询场景。需重建主键。

- [ ] **Step 1: 创建迁移脚本**

```sql
-- V1.0.9__alter_sys_org_user_pk.sql
-- 调整 sys_org_user 表主键顺序为 (usr_id, org_id)，优化用户维度的查询性能

ALTER TABLE sys_org_user
    DROP PRIMARY KEY,
    DROP FOREIGN KEY fk_sys_org_user_sys_org_1,
    DROP FOREIGN KEY fk_sys_org_user_sys_user_1;

ALTER TABLE sys_org_user
    ADD PRIMARY KEY (usr_id, org_id),
    ADD CONSTRAINT fk_sys_org_user_sys_org FOREIGN KEY (org_id) REFERENCES sys_org(id),
    ADD CONSTRAINT fk_sys_org_user_sys_user FOREIGN KEY (usr_id) REFERENCES sys_user(id);
```

- [ ] **Step 2: 在测试环境执行迁移**

Run: `mysql --default-character-set=utf8mb4 -h <host> -u <user> -p <database> < sql/V1.0.9__alter_sys_org_user_pk.sql`

- [ ] **Step 3: 提交**

```bash
git add sql/V1.0.9__alter_sys_org_user_pk.sql
git commit -m "sql: 调整sys_org_user表主键顺序为(usr_id, org_id)"
```

---

### Task 2: 创建 SysOrgUser 实体和 Mapper

**Files:**
- Create: `pos-server/src/main/java/org/haut/server/system/entity/SysOrgUser.java`
- Create: `pos-server/src/main/java/org/haut/server/system/mapper/SysOrgUserMapper.java`

- [ ] **Step 1: 创建 SysOrgUser 实体**

```java
package org.haut.server.system.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("sys_org_user")
public class SysOrgUser {
    private Long usrId;
    private Long orgId;
}
```

- [ ] **Step 2: 创建 SysOrgUserMapper**

```java
package org.haut.server.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.haut.server.system.entity.SysOrgUser;

@Mapper
public interface SysOrgUserMapper extends BaseMapper<SysOrgUser> {
}
```

- [ ] **Step 3: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/system/entity/SysOrgUser.java pos-server/src/main/java/org/haut/server/system/mapper/SysOrgUserMapper.java
git commit -m "feat(system): 新增SysOrgUser实体和Mapper"
```

---

### Task 3: 创建 SysOrgUserService

**Files:**
- Create: `pos-server/src/main/java/org/haut/server/system/service/SysOrgUserService.java`
- Create: `pos-server/src/main/java/org/haut/server/system/service/impl/SysOrgUserServiceImpl.java`

- [ ] **Step 1: 创建 SysOrgUserService 接口**

```java
package org.haut.server.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.server.system.entity.SysOrgUser;

import java.util.List;

public interface SysOrgUserService extends IService<SysOrgUser> {

    /**
     * 批量绑定门店（先删后插）
     */
    void bindOrgs(Long userId, List<Long> orgIds);

    /**
     * 解除用户所有门店关联
     */
    void unbindOrgs(Long userId);

    /**
     * 查询用户关联的门店ID列表（不含主门店）
     */
    List<Long> getOrgIdsByUserId(Long userId);

    /**
     * 查询门店下的用户ID列表
     */
    List<Long> getUserIdsByOrgId(Long orgId);
}
```

- [ ] **Step 2: 创建 SysOrgUserServiceImpl**

```java
package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.server.system.entity.SysOrgUser;
import org.haut.server.system.mapper.SysOrgUserMapper;
import org.haut.server.system.service.SysOrgUserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SysOrgUserServiceImpl extends ServiceImpl<SysOrgUserMapper, SysOrgUser>
        implements SysOrgUserService {

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void bindOrgs(Long userId, List<Long> orgIds) {
        if (orgIds == null || orgIds.isEmpty()) {
            return;
        }
        List<SysOrgUser> records = orgIds.stream().map(orgId -> {
            SysOrgUser entity = new SysOrgUser();
            entity.setUsrId(userId);
            entity.setOrgId(orgId);
            return entity;
        }).toList();
        saveBatch(records);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void unbindOrgs(Long userId) {
        remove(new LambdaQueryWrapper<SysOrgUser>().eq(SysOrgUser::getUsrId, userId));
    }

    @Override
    public List<Long> getOrgIdsByUserId(Long userId) {
        List<SysOrgUser> list = list(new LambdaQueryWrapper<SysOrgUser>()
                .eq(SysOrgUser::getUsrId, userId));
        if (list.isEmpty()) {
            return Collections.emptyList();
        }
        return list.stream().map(SysOrgUser::getOrgId).toList();
    }

    @Override
    public List<Long> getUserIdsByOrgId(Long orgId) {
        List<SysOrgUser> list = list(new LambdaQueryWrapper<SysOrgUser>()
                .eq(SysOrgUser::getOrgId, orgId));
        if (list.isEmpty()) {
            return Collections.emptyList();
        }
        return list.stream().map(SysOrgUser::getUsrId).toList();
    }
}
```

- [ ] **Step 3: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/system/service/SysOrgUserService.java pos-server/src/main/java/org/haut/server/system/service/impl/SysOrgUserServiceImpl.java
git commit -m "feat(system): 新增SysOrgUserService关联管理服务"
```

---

### Task 4: 扩展 AuthInfoDTO

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/dto/system/AuthInfoDTO.java`

- [ ] **Step 1: 添加 orgIds 字段**

在现有 `AuthInfoDTO.java` 中添加 `orgIds` 字段和 import。保留 `@Builder` 注解（Builder 会自动包含新字段）：

在文件头部添加 import：
```java
import java.util.List;
```

在 `userName` 字段后添加：
```java
@Schema(description = "用户关联的所有门店ID列表")
private List<Long> orgIds;
```

完整文件应为：

```java
package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "登录信息")
@Builder
public class AuthInfoDTO {
    @Schema(description = "用户ID")
    private Long userId;
    @Schema(description = "组织ID（主门店）")
    private Long orgId;
    @Schema(description = "用户名")
    private String userName;
    @Schema(description = "用户关联的所有门店ID列表")
    private List<Long> orgIds;
}
```

- [ ] **Step 2: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/domain/dto/system/AuthInfoDTO.java
git commit -m "feat(system): AuthInfoDTO新增orgIds字段"
```

---

### Task 5: 扩展 DTO（UserCreateDTO、UserUpdateDTO、UserInfoVO）

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/dto/system/UserCreateDTO.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/dto/system/UserUpdateDTO.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/system/UserInfoVO.java`

- [ ] **Step 1: UserCreateDTO 添加 orgIds 字段**

在 `UserCreateDTO.java` 文件头部添加 import：
```java
import java.util.List;  // 已存在则不重复添加
```

在 `roleId` 字段后添加：
```java
@Schema(description = "额外关联门店ID列表（不含主门店）")
private List<Long> orgIds;
```

- [ ] **Step 2: UserUpdateDTO 添加 orgIds 字段**

在 `UserUpdateDTO.java` 文件头部添加 import：
```java
import java.util.List;  // 已存在则不重复添加
```

在 `roleId` 字段后添加：
```java
@Schema(description = "额外关联门店ID列表（不含主门店）")
private List<Long> orgIds;
```

- [ ] **Step 3: UserInfoVO 添加 orgIds 字段**

在 `UserInfoVO.java` 文件头部添加 import：
```java
import java.util.List;  // 已存在则不重复添加
```

在 `role` 字段后添加：
```java
@Schema(description = "用户关联的所有门店ID列表")
private List<Long> orgIds;
```

- [ ] **Step 4: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/domain/dto/system/UserCreateDTO.java pos-common/src/main/java/org/haut/common/domain/dto/system/UserUpdateDTO.java pos-common/src/main/java/org/haut/common/domain/vo/system/UserInfoVO.java
git commit -m "feat(system): 用户DTO/VO新增orgIds字段"
```

---

### Task 6: 改造 OrgInterceptor — 加载关联门店

**Files:**
- Modify: `pos-web/src/main/java/org/haut/interceptor/OrgInterceptor.java`

- [ ] **Step 1: 注入 SysOrgUserService 并加载 orgIds**

改造 `OrgInterceptor.java`，注入 `SysOrgUserService`，在 `preHandle` 中查询用户关联门店并设置到 `AuthInfoDTO.orgIds`：

完整替换后的文件：

```java
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
import org.haut.server.system.service.SysOrgUserService;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class OrgInterceptor implements HandlerInterceptor {
    private final JwtUtils jwtUtils;
    private final SysUserMapper sysUserMapper;
    private final SysOrgUserService sysOrgUserService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        try {
            String token = request.getHeader("Authorization");
            DecodedJWT decodedJWT = jwtUtils.resoleJwt(token);
            AuthInfoDTO authInfo = jwtUtils.toAuthInfo(decodedJWT);
            SysUser sysUser = sysUserMapper.selectById(authInfo.getUserId());
            authInfo.setUserName(sysUser.getUserName());

            // 查询用户关联门店，合并主门店
            List<Long> extraOrgIds = sysOrgUserService.getOrgIdsByUserId(authInfo.getUserId());
            List<Long> allOrgIds = new ArrayList<>();
            allOrgIds.add(authInfo.getOrgId());
            allOrgIds.addAll(extraOrgIds);
            authInfo.setOrgIds(allOrgIds);

            AuthContextHolder.setAuth(authInfo);
            return true;
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return false;
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        AuthContextHolder.clearAuth();
    }
}
```

- [ ] **Step 2: 提交**

```bash
git add pos-web/src/main/java/org/haut/interceptor/OrgInterceptor.java
git commit -m "feat(system): OrgInterceptor加载用户关联门店列表"
```

---

### Task 7: 改造 SysUserService — 创建/更新用户时同步关联

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/system/service/SysUserService.java`
- Modify: `pos-server/src/main/java/org/haut/server/system/service/impl/SysUserServiceImpl.java`

- [ ] **Step 1: SysUserService 接口添加 updateUser 方法**

在 `SysUserService.java` 中添加方法签名：

```java
void updateUser(UserUpdateDTO user);
```

注意：需要添加 `import org.haut.common.domain.dto.system.UserUpdateDTO;`（如果不存在）。

- [ ] **Step 2: 改造 SysUserServiceImpl**

修改点：
1. 注入 `SysOrgUserService`
2. 改造 `addUser` — 创建用户后绑定额外门店
3. 新增 `updateUser` — 更新用户信息并同步门店关联
4. 改造 `queryOne` — 返回用户关联门店列表

完整替换后的文件：

```java
package org.haut.server.system.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.system.UserAllocateRoleDTO;
import org.haut.common.domain.dto.system.UserCreateDTO;
import org.haut.common.domain.dto.system.UserDTO;
import org.haut.common.domain.dto.system.UserUpdateDTO;
import org.haut.common.domain.query.system.UserListQuery;
import org.haut.common.domain.vo.system.RoleInfoVo;
import org.haut.common.domain.vo.system.UserInfoVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.UserContextHolder;
import org.haut.server.system.entity.SysRole;
import org.haut.server.system.entity.SysUser;
import org.haut.server.system.entity.SysUserRole;
import org.haut.server.system.mapper.SysOrgMapper;
import org.haut.server.system.mapper.SysRoleMapper;
import org.haut.server.system.mapper.SysUserRoleMapper;
import org.haut.server.system.mapper.SysUserMapper;
import org.haut.server.system.service.SysOrgUserService;
import org.haut.server.system.service.SysUserService;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@RequiredArgsConstructor
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser>
        implements SysUserService {

    private final SysUserMapper sysUserMapper;
    private final SysOrgMapper sysOrgMapper;
    private final SysUserRoleMapper sysUserRoleMapper;
    private final SysRoleMapper sysRoleMapper;
    private final SysOrgUserService sysOrgUserService;
    private final BCryptPasswordEncoder encoder;

    @Override
    public PageDTO<UserInfoVO> getList(UserListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Page<UserInfoVO> page = new Page<>();
        page.setCurrent(query.getPageNum());
        page.setSize(query.getPageSize());
        sysUserMapper.getList(page, query, auth.getOrgId());
        return PageDTO.create(page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addUser(UserCreateDTO user) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Long roleId = user.getRoleId();
        if (roleId == null) {
            throw new BusinessException("用户必须分配一个角色");
        }
        // 创建用户
        SysUser sysUser = BeanUtil.toBean(user, SysUser.class);
        sysUser.setOrgId(auth.getOrgId());
        this.save(sysUser);

        // 绑定额外关联门店
        if (user.getOrgIds() != null && !user.getOrgIds().isEmpty()) {
            sysOrgUserService.bindOrgs(sysUser.getId(), user.getOrgIds());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateUser(UserUpdateDTO user) {
        // 更新用户基本信息
        SysUser sysUser = BeanUtil.toBean(user, SysUser.class);
        this.updateById(sysUser);

        // 同步更新门店关联（先删后插）
        sysOrgUserService.unbindOrgs(user.getId());
        if (user.getOrgIds() != null && !user.getOrgIds().isEmpty()) {
            sysOrgUserService.bindOrgs(user.getId(), user.getOrgIds());
        }
    }

    @Override
    public void allocateRole(UserAllocateRoleDTO dto) {
        this.lambdaUpdate().set(SysUser::getRoleId, dto.getRoleId())
                .eq(SysUser::getId, dto.getUserId())
                .update();
    }

    @Override
    public List<RoleInfoVo> queryRoleList(Long userId) {
        return sysUserMapper.queryRoleList(userId);
    }

    @Override
    public UserInfoVO queryOne(Long id, String userNumber) {
        LambdaQueryWrapper<SysUser> queryWrapper = Wrappers.lambdaQuery(SysUser.class)
                .eq(id != null, SysUser::getId, id)
                .eq(userNumber != null, SysUser::getUserNumber, userNumber);
        SysUser user = this.getOne(queryWrapper);
        if (user == null) {
            throw new BusinessException("用户不存在");
        }
        SysRole sysRole = sysRoleMapper.selectById(user.getRoleId());
        RoleInfoVo roleInfoVo = BeanUtil.toBean(sysRole, RoleInfoVo.class);
        UserInfoVO userInfoVO = BeanUtil.toBean(user, UserInfoVO.class);
        userInfoVO.setRole(roleInfoVo);

        // 查询关联门店，合并主门店
        List<Long> extraOrgIds = sysOrgUserService.getOrgIdsByUserId(user.getId());
        List<Long> allOrgIds = new ArrayList<>();
        allOrgIds.add(user.getOrgId());
        allOrgIds.addAll(extraOrgIds);
        userInfoVO.setOrgIds(allOrgIds);

        return userInfoVO;
    }

    @Override
    public UserDetails loadUserByUsername(String userCode) throws UsernameNotFoundException {
        SysUser sysUser = sysUserMapper.selectOne(Wrappers.lambdaQuery(SysUser.class)
                .eq(SysUser::getUserCode, userCode));

        if (sysUser == null) {
            throw new UsernameNotFoundException("用户名或密码错误");
        }

        UserContextHolder.setUser(BeanUtil.toBean(sysUser, UserDTO.class));

        List<SysUserRole> sysUserRole = sysUserRoleMapper.selectList(Wrappers.lambdaQuery(SysUserRole.class)
                .eq(SysUserRole::getUserId, sysUser.getId()));
        List<SysRole> sysRoleList = new ArrayList<>();
        String[] roles;
        if (!sysUserRole.isEmpty()) {
            sysRoleList = sysRoleMapper.selectByIds(sysUserRole.stream().map(SysUserRole::getRoleId).toList());
            roles = sysRoleList.stream().map(SysRole::getRoleCode).toArray(String[]::new);
        } else {
            roles = new String[0];
        }

        return User.withUsername(userCode)
                .roles(roles)
                .password(encoder.encode(sysUser.getUserPassword()))
                .build();
    }
}
```

- [ ] **Step 3: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/system/service/SysUserService.java pos-server/src/main/java/org/haut/server/system/service/impl/SysUserServiceImpl.java
git commit -m "feat(system): 用户创建/更新时同步维护门店关联"
```

---

### Task 8: 改造 SysUserController — updateUser 调用 Service

**Files:**
- Modify: `pos-web/src/main/java/org/haut/controller/system/SysUserController.java`

- [ ] **Step 1: 修改 updateUser 方法**

将 `updateUser` 方法中的 `sysUserService.updateById(BeanUtil.toBean(user, SysUser.class))` 替换为 `sysUserService.updateUser(user)`：

修改前：
```java
sysUserService.updateById(BeanUtil.toBean(user,SysUser.class));
```

修改后：
```java
sysUserService.updateUser(user);
```

- [ ] **Step 2: 移除 updateById 相关的无用 import（如有）**

检查 `org.haut.server.system.entity.SysUser` 的 import 是否在 `updateUser` 之外仍被使用（`judgeUserCodeExist` 方法中使用），如果仍使用则保留。

实际上 `SysUser` 在 `judgeUserCodeExist` 中仍有使用，所以 import 保留不变。

- [ ] **Step 3: 提交**

```bash
git add pos-web/src/main/java/org/haut/controller/system/SysUserController.java
git commit -m "feat(system): updateUser改用Service方法处理门店关联"
```

---

### Task 9: 编译验证

- [ ] **Step 1: 全量编译**

Run: `mvn clean compile -DskipTests`
Expected: BUILD SUCCESS

- [ ] **Step 2: 如有编译错误，逐一修复**

常见问题：
- import 缺失
- `@Builder` 与新增字段不兼容（AuthInfoDTO 的 `toAuthInfo` 构建处需更新）

如果 `JwtUtils.toAuthInfo()` 中使用 `AuthInfoDTO.builder()` 构建，需要确保 `.orgIds(null)` 或不设置（builder 默认 null）。当前代码只设置了 userId、orgId，orgIds 会默认为 null，这是正确的。

- [ ] **Step 3: 提交（如有修复）**

```bash
git add -A
git commit -m "fix: 修复编译问题"
```

---

## Self-Review

### 1. Spec 覆盖检查

| 规格要求 | 对应任务 |
|----------|----------|
| sys_org_user 表主键调整为 (usr_id, org_id) | Task 1 |
| SysOrgUser 实体 + Mapper | Task 2 |
| SysOrgUserService (bind/unbind/query) | Task 3 |
| AuthInfoDTO 新增 orgIds | Task 4 |
| UserCreateDTO/UserUpdateDTO 新增 orgIds | Task 5 |
| UserInfoVO 新增 orgIds | Task 5 |
| OrgInterceptor 查询关联门店 | Task 6 |
| addUser 绑定额外门店 | Task 7 |
| updateUser 同步更新关联 | Task 7, 8 |
| queryOne 返回关联门店 | Task 7 |
| JWT/登录流程不变 | 未修改 ✓ |
| 收银系统操作不变 | 未修改 ✓ |
| 现有 orgId 过滤逻辑不变 | 未修改 ✓ |

### 2. Placeholder 扫描

无 TBD/TODO/类似模式。所有步骤包含完整代码。

### 3. 类型一致性

- `SysOrgUser.usrId` / `SysOrgUser.orgId` — 与 SQL 列名 `usr_id`/`org_id` 一致（MyBatis-Plus 自动映射）
- `AuthInfoDTO.orgIds` 类型 `List<Long>` — 与 `SysOrgUserService.getOrgIdsByUserId()` 返回 `List<Long>` 一致
- `UserCreateDTO.orgIds` / `UserUpdateDTO.orgIds` 类型 `List<Long>` — 与 `SysOrgUserService.bindOrgs(Long, List<Long>)` 参数一致
- `UserInfoVO.orgIds` 类型 `List<Long>` — 与 `SysUserServiceImpl.queryOne()` 中赋值一致
