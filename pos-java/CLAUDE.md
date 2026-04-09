# CLAUDE.md

本文件为 Claude Code (claude.ai/code) 在处理此代码仓库中的代码时提供指导。

## 项目概述

这是一个基于 Java 17 的销售点（POS）系统，使用 Spring Boot 3.5.0 构建。这是一个多模块 Maven 项目，专为零售/餐饮企业设计，支持门店管理、VIP 客户、订单处理、支付和库存管理。

## 构建和开发命令

### Maven 命令
```bash
# 构建整个项目
mvn clean package

# 构建并跳过测试
mvn clean package -DskipTests

# 运行应用（开发环境）
mvn install -DskipTests && mvn spring-boot:run -pl pos-web -Dspring-boot.run.profiles=dev

# 运行应用（指定环境）
mvn install -DskipTests && mvn spring-boot:run -pl pos-web -Dspring-boot.run.profiles=test

# Docker 构建
mvn docker:build

# Docker 推送
mvn docker:push
```

### 运行应用
- 默认端口：8080
- 上下文路径：`/api`
- Swagger UI：`http://localhost:8080/api/swagger-ui.html`
- API 文档：`http://localhost:8080/api/v3/api-docs`
- Druid 监控：`http://localhost:8080/api/druid/*`（用户名：druid，密码：druid）

## 架构概览

### 模块结构
- **pos-common/**：共享工具类、DTO、VO、枚举、响应包装器
- **pos-server/**：业务逻辑层（Services、Entities、MyBatis mappers）
- **pos-web/**：REST API 层（Controllers、Configuration、Application 入口）
- **sql/**：数据库架构和迁移脚本

### 技术栈
- **核心框架**：Java 17、Spring Boot 3.5.0
- **数据库**：MySQL 8.2.0 + MyBatis-Plus 3.5.11
- **连接池**：Druid 1.2.20
- **缓存**：Redis
- **安全**：Spring Security + JWT 4.3.0
- **API 文档**：Knife4j 4.3.0 (Swagger)
- **工具类**：Lombok 1.18.34、MapStruct 1.6.3、Hutool 5.8.18
- **AOP**：AspectJ（操作日志等切面功能）

### 分层架构
1. **Controller 层** (`pos-web`)：带 Swagger 文档的 REST API 端点
2. **Service 层** (`pos-server`)：继承 `IService<T>` 的业务逻辑
3. **Mapper 层** (`pos-server`)：继承 `BaseMapper<T>` 的数据库访问
4. **Entity 层** (`pos-server`)：带 `@TableName` 注解的数据库模型

## 核心业务模块
- **system**：用户、角色、权限、组织机构
- **order**：订单管理和处理
- **payment**：支付处理（支持多种支付方式）
- **vip**：VIP 客户管理
- **stock**：库存管理
- **room**：房间/区域管理（餐饮业功能）
- **server**：服务项管理
- **kpi**：关键绩效指标
- **statistics**：数据分析和报表
- **task**：定时任务
- **ai**：AI 相关功能
- **操作日志**：基于 `@OperLog` 注解 + AOP 切面的关键业务操作记录，查询接口 `GET /system/oper-log/page`

## 开发规范

### 代码结构模式
- **Controllers**：使用 `@RestController`、`@Tag`、`@Operation` 提供 Swagger 文档
- **Services**：继承 MyBatis-Plus 的 `IService<T>`
- **Mappers**：继承 MyBatis-Plus 的 `BaseMapper<T>`
- **Responses**：使用 `JsonVO<T>` 包装器和 `ResultStatus` 枚举
- **Logging**：使用 Lombok 的 `@Slf4j`

### 命名规范
- **类名**：PascalCase（如 `SysUserController`）
- **方法名**：camelCase（如 `getUserById`）
- **变量名**：camelCase（如 `userId`）
- **数据库**：snake_case（如 `sys_user`）

### Git 提交规范
- 格式：`模块名[类型] 描述`
- 类型：`feat`、`fix`、`docs`、`style`、`refactor`、`perf`、`test`、`chore`、`build`
- 优先使用中文提交信息
- 描述最多 50 个字符
- 不要添加与本次提交无关的信息

## 环境配置
- **dev**：开发环境（默认）
- **test**：测试环境
- **prod**：生产环境

## 数据库
- 数据库架构位于 `/sql/` 目录
- 包含初始数据文件 `pos_data.sql`
- 最近迁移：`V1.0.8__create_sys_oper_log.sql` 用于操作日志表
- 新建迁移脚本需递增版本号（当前最高 V1.0.8）

## 测试
- 使用 Spring Boot Test starter
- 运行测试：`mvn test`
- 运行特定模块测试：`mvn test -pl pos-server`

## Docker 支持
- 提供 Dockerfile，基于 openjdk:17 镜像
- 使用 docker-compose.yml 进行编排
- 应用运行在 8080 端口，上下文路径为 `/api`

## Superpowers 文档规范

所有 superpowers 产出的设计文档和计划文档统一放在 `docs/superpowers/<需求名称>/` 目录下，按需求分类组织，不使用 `plans/` 或 `specs/` 等平面目录。

### 目录结构
```
docs/superpowers/
├── 组织关系/                          # 需求名称（中文）
│   ├── 2026-04-01-org-relation-design.md    # 设计文档
│   ├── 2026-04-01-org-relation.md           # 实现计划
│   └── 门店关联关系重构-前端对接文档.md      # 附加文档
├── 券作为支付方式/
│   ├── 2026-04-09-ticket-as-payment-design.md
│   └── 2026-04-09-ticket-as-payment.md
└── ...
```

### 文件命名规则
- **设计文档**：`YYYY-MM-DD-<英文短名>-design.md`
- **实现计划**：`YYYY-MM-DD-<英文短名>.md`
- **附加文档**：使用中文名称（如前端对接文档）
- 日期使用文档创建日期

### 创建流程
1. 新需求启动时，先在 `docs/superpowers/` 下创建中文命名的需求文件夹
2. brainstorming/设计阶段产出的文档直接写入该文件夹
3. 实现计划也写入同一文件夹
4. 如果需求迭代产生新版本，使用新日期前缀创建新文件，保留旧文件

## 注意事项
- 连接测试环境 MySQL 需加 `--default-character-set=utf8mb4` 参数，避免中文注释乱码
- 测试环境登录账号为手机号格式（如 `N15287842664`），密码 `123456`