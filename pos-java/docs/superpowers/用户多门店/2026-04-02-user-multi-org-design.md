# 用户多门店关联设计

## 背景

当前系统中每个用户（`SysUser`）通过 `orgId` 字段绑定到唯一一家门店。实际业务中，管理角色需要管理多家门店，普通员工也可能在多家店任职。需要支持用户与多家门店的关联关系。

## 需求

1. 用户可以关联多家门店
2. 管理角色：关联的门店即为其管辖范围，可查看和操作这些门店的数据
3. 普通员工：关联的门店即为其任职门店，避免重复创建员工账号，便于统一统计绩效
4. 前端根据用户关联的门店列表提供筛选功能，用户可选择查看某家门店的数据
5. 本期不涉及设定下发功能

## 方案选择

选择**混合模式**：保留 `SysUser.orgId` 作为主门店 + 新建 `sys_org_user` 关联表存储额外门店。

理由：
- 主门店（orgId）用于收银系统登录、日常操作，保持现有逻辑不变
- 关联表（sys_org_user）用于数据查询范围的授权，避免重复员工、统一绩效统计
- 两者职责分明，改动范围可控

## 数据模型

### sys_org_user 表（已存在，需确认/调整结构）

```sql
CREATE TABLE sys_org_user (
    usr_id BIGINT UNSIGNED NOT NULL COMMENT '用户id',
    org_id BIGINT UNSIGNED NOT NULL COMMENT '机构id',
    PRIMARY KEY (usr_id, org_id),
    CONSTRAINT fk_sys_org_user_sys_org FOREIGN KEY (org_id) REFERENCES sys_org(id),
    CONSTRAINT fk_sys_org_user_sys_user FOREIGN KEY (usr_id) REFERENCES sys_user(id)
) COMMENT '用户门店关联表';
```

说明：
- 主键顺序为 `(usr_id, org_id)`，查询场景以"查某用户的门店列表"为主
- 不含 item_type 等通用字段，这是专用的用户-门店关系表
- 不重复存储主门店（orgId），主门店直接从 SysUser.orgId 获取

### SysUser.orgId 保留不变

继续作为用户的主门店/默认门店，收银登录等核心流程不受影响。

## 认证上下文

### AuthInfoDTO 扩展

```java
@Data
@Builder
public class AuthInfoDTO {
    private Long userId;
    private Long orgId;          // 主门店（来自 SysUser.orgId）
    private String userName;
    private List<Long> orgIds;   // 所有关联门店ID（主门店 + sys_org_user 中的门店）
}
```

### OrgInterceptor 改造

在现有拦截器中，查询用户信息后，额外查询 `sys_org_user` 获取关联门店，合并设置到 `AuthInfoDTO.orgIds`：

```
1. 解析 JWT → 获取 userId、orgId
2. 查询 SysUser → 获取 userName
3. 查询 sys_org_user → 获取关联门店列表
4. 合并：orgIds = [orgId] + 关联门店列表（去重）
5. 设置 AuthContextHolder
```

可考虑 Redis 缓存 orgIds 列表，避免每次请求查库，缓存在用户门店关联变更时清除。

### JWT 和登录流程

**不变**。JWT 继续存储 userId + orgId，登录流程保持现有逻辑。

## API 改动

### 用户创建/编辑

- `UserCreateDTO` / `UserUpdateDTO` 新增 `List<Long> orgIds` 字段（额外关联门店）
- `orgId`（主门店）保留，创建时从当前用户 orgId 继承或手动指定
- 创建/更新用户时，同步维护 `sys_org_user` 记录：
  - 先删除该用户所有旧关联
  - 再批量插入新关联

### 查询用户关联门店

- 用户详情接口中返回关联门店列表
- 或新增 `GET /system/user/{userId}/orgs` 接口

### 数据查询

现有按 orgId 过滤的数据查询接口**不变**。前端获取用户 `orgIds` 列表后：
- 展示门店筛选下拉框
- 用户选择某家门店时，传 orgId 参数给后端
- 后端校验请求的 orgId 是否在该用户的 orgIds 范围内

## 新增代码

| 层级 | 文件 | 说明 |
|------|------|------|
| Entity | `SysOrgUser` | 用户门店关联实体 |
| Mapper | `SysOrgUserMapper` | 继承 BaseMapper |
| Service | `SysOrgUserService` | 关联管理接口 |
| ServiceImpl | `SysOrgUserServiceImpl` | 绑定/解绑/查询实现 |

### SysOrgUserService 核心方法

- `bindOrgs(Long userId, List<Long> orgIds)` — 批量绑定门店
- `unbindOrgs(Long userId)` — 解除所有关联
- `getOrgIdsByUserId(Long userId)` — 查询用户关联的门店ID列表
- `getUserIdsByOrgId(Long orgId)` — 查询门店下的用户ID列表

## 修改代码

| 文件 | 改动 |
|------|------|
| `AuthInfoDTO` | 新增 orgIds 字段 |
| `OrgInterceptor` | 查询并设置 orgIds |
| `UserCreateDTO` | 新增 orgIds 字段 |
| `UserUpdateDTO` | 新增 orgIds 字段 |
| `SysUserServiceImpl.addUser()` | 创建用户后绑定额外门店 |
| `SysUserController.updateUser()` | 改为调用 Service 处理，Service 中同步更新门店关联 |
| `SysUserMapper.xml` | 用户列表查询可选返回关联门店信息 |

## 不变的部分

- JWT 生成和解析逻辑
- 登录流程
- 收银系统操作（继续使用 orgId）
- 现有数据查询的 orgId 过滤逻辑
- 角色权限体系

## 后续迭代（本期不做）

- 管理角色批量下发设定到多家门店
- 门店切换机制（在请求头中切换当前操作门店）
- Redis 缓存用户门店关联
