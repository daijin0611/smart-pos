# 项目分析文档

## 1. 项目技术栈

| 技术栈 | 版本 | 用途 |
|-------|------|------|
| Java | 17 | 开发语言 |
| Spring Boot | 3.2.0 | 项目框架 |
| MyBatis-Plus | 3.5.11 | ORM框架 |
| MySQL | 8.2.0 | 数据库 |
| Druid | 1.2.20 | 数据库连接池 |
| Redis | - | 缓存 |
| JWT | 4.3.0 | 认证授权 |
| Knife4j | 4.3.0 | API文档 |
| Lombok | 1.18.34 | 代码简化 |
| Hutool | 5.8.18 | 工具类库 |
| MapStruct | 1.6.3 | 对象转换 |
| Maven | 3.11.0 | 构建工具 |

## 2. 项目模块与功能划分

### 2.1 项目结构

```
pos-java/
├── pos-common/          # 公共模块
├── pos-server/          # 业务逻辑模块
├── pos-web/             # 接口层模块
├── Dockerfile
├── docker-compose.yml
└── pom.xml
```

### 2.2 核心模块

#### pos-common 公共模块
- **路径**: `/pos-common/src/main/java/org/haut/common/`
- **功能**: 提供项目通用的工具类、常量、注解、异常、DTO/VO等
- **子包**:
  - `annotation`: 自定义注解
  - `component`: 通用组件
  - `constant`: 常量定义
  - `domain`: DTO/VO/Query等数据传输对象
  - `enums`: 枚举类
  - `exception`: 异常定义
  - `utils`: 工具类

#### pos-server 业务逻辑模块
- **路径**: `/pos-server/src/main/java/org/haut/server/`
- **功能**: 核心业务逻辑实现，包括各种业务模块的Service和Mapper
- **子模块**:
  - `kpi`: KPI指标模块
  - `order`: 订单管理模块
  - `payment`: 支付模块
  - `room`: 房间管理模块
  - `server`: 服务项目模块
  - `statistics`: 统计模块
  - `stock`: 库存管理模块
  - `system`: 系统管理模块（用户、角色、权限等）
  - `task`: 任务调度模块
  - `vip`: VIP会员模块

#### pos-web 接口层模块
- **路径**: `/pos-web/src/main/java/org/haut/`
- **功能**: 提供RESTful API接口，处理HTTP请求
- **核心组件**:
  - `PosApplication.java`: 项目入口
  - `controller/`: 各种业务模块的控制器
  - `config/`: 配置类
  - `filter/`: 过滤器
  - `interceptor/`: 拦截器

### 2.3 系统管理模块示例

以 `system` 模块为例，展示典型的三层架构：

**Entity层** (`pos-server/src/main/java/org/haut/server/system/entity/`):
```java
@TableName(value = "sys_user")
@Data
@Schema(description = "系统用户表（员工表）")
public class SysUser {
    @TableId(type = IdType.AUTO)
    private Long id;
    // ... 其他字段
}
```

**Mapper层** (`pos-server/src/main/java/org/haut/server/system/mapper/`):
```java
@Mapper
public interface SysUserMapper extends BaseMapper<SysUser> {
    // ... 自定义查询方法
}
```

**Service层** (`pos-server/src/main/java/org/haut/server/system/service/`):
```java
public interface SysUserService extends IService<SysUser>, UserDetailsService {
    // ... 业务方法
}
```

**Controller层** (`pos-web/src/main/java/org/haut/controller/system/`):
```java
@RestController
@RequestMapping("/system/user")
@Tag(name = "人事管理", description = "系统人事管理")
public class SysUserController {
    @GetMapping("/query-list")
    @Operation(description = "获取用户列表", summary = "获取用户列表")
    public JsonVO<PageDTO<UserInfoVO>> getList(UserListQuery query) {
        // ... 接口实现
    }
}
```

## 3. 项目代码开发风格

### 3.1 命名规范
- **类名**: 采用大驼峰式命名，如 `SysUserController`
- **方法名**: 采用小驼峰式命名，如 `getUserById`
- **变量名**: 采用小驼峰式命名，如 `userId`
- **包名**: 全小写，如 `org.haut.server.system`
- **数据库表名**: 采用下划线分隔，如 `sys_user`
- **数据库字段**: 采用下划线分隔，如 `user_code`

### 3.2 代码结构
- 严格遵循分层架构：Controller → Service → Mapper → Entity
- 使用 DTO/VO/Query 进行数据传输，避免直接使用 Entity
- 接口定义与实现分离，Service接口位于 `pos-server/src/main/java/org/haut/server/[module]/service/`，实现类位于 `impl/` 子包

### 3.3 技术选型实践
- 使用 MyBatis-Plus 的 BaseMapper 和 IService 减少重复代码
- 使用 Lombok 的 `@Data`、`@Slf4j` 等注解简化代码
- 使用 MapStruct 进行对象转换
- 使用 Knife4j 生成API文档，注解包括 `@Tag`、`@Operation`、`@Parameter` 等
- 使用 JWT 进行认证授权
- 使用 Druid 作为数据库连接池，并配置监控

### 3.4 异常处理
- 自定义业务异常 `BusinessException`
- 使用统一的返回结果类 `JsonVO` 封装响应
- 配置全局异常处理器

### 3.5 日志
- 使用 SLF4J 进行日志记录，通过 `@Slf4j` 注解注入
- 接口方法入口记录参数日志

### 3.6 配置
- 使用 Spring Boot 的多环境配置（application-dev.yml, application-prod.yml 等）
- 配置文件中统一管理数据库、Redis、JWT等参数

## 4. 项目亮点
- 模块化设计，职责清晰
- 代码风格统一，结构规范
- 充分利用 Spring Boot、MyBatis-Plus 等框架的特性提高开发效率
- 完善的API文档和监控
- 支持 Docker 部署

## 5. 运行与构建

### 5.1 构建命令
```bash
mvn clean package -DskipTests
```

### 5.2 运行命令
```bash
java -jar pos-web/target/pos-web-1.0-SNAPSHOT.jar
```

### 5.3 访问地址
- API接口: `http://localhost:8080/api/`
- Swagger文档: `http://localhost:8080/doc.html`
- Druid监控: `http://localhost:8080/druid/`

## 6. 总结

该项目是一个基于 Spring Boot 3.2.0 的 Java 17 后端项目，采用模块化设计，分层架构清晰，代码风格统一。项目涵盖了系统管理、订单管理、库存管理等多个业务模块，使用了多种主流技术和框架，具备良好的可扩展性和维护性。
