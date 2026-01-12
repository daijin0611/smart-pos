

# 智慧收银管理系统 (POS System)

## 介绍

智慧收银管理系统是一个基于 **Spring Boot** 和 **Vue.js** 构建的现代化收银解决方案。系统采用前后端分离架构，设计用于服务行业（如美容美发、洗浴按摩等）的日常运营管理，支持多门店、多角色协同工作。

## 核心功能

- **收银管理**：支持开单、挂单、加单、结算（支持现金、银行卡、微信、支付宝、会员卡）、订单冲正与对单。
- **会员中心**：会员信息管理、储值充值（支持充值活动与赠送）、资产（储值卡/疗程卡）管理、优惠券发放与核销。
- **库存管理**：产品入库、出库管理，库存流水日志追踪。
- **排钟与房态**：房间与床位状态管理，可视化展示房间使用情况。
- **绩效管理**：员工业绩（KPI）统计与汇总，支持按技师查询业绩明细。
- **系统配置**：机构（门店）管理、角色权限分配（RBAC）、系统参数配置。

## 技术栈

- **后端框架**：Spring Boot 3.x
- **持久层框架**：MyBatis-Plus
- **安全框架**：Spring Security + JWT
- **缓存中间件**：Redis
- **前端框架**：Vue 3.x + Element Plus
- **数据库**：MySQL 8.0
- **构建工具**：Maven / npm

## 项目结构

项目采用模块化设计，主要分为后端和前端两大部分：

```text
pos
├── pos-java/                 # 后端项目主目录
│   ├── pos-common/           # 公共模块：存放工具类、常量定义、通用DTO/VO对象
│   ├── pos-server/           # 业务模块：包含实体类(Entity)、数据访问层(Mapper)、业务逻辑层(Service)
│   ├── pos-web/              # 接口层：Controller接口、配置类(Config)、启动类
│   └── sql/                  # 数据库初始化脚本
├── pos-vue/                  # 前端项目目录
└── documents/                # 项目开发文档与规范
```

## 快速开始

### 环境准备

在开始之前，请确保开发环境已安装以下软件：
- JDK 17 或更高版本
- Node.js 18 或更高版本
- MySQL 8.0
- Redis 6.0 或更高版本

### 1. 后端部署

1.  **初始化数据库**：
    在 MySQL 中创建数据库（例如 `pos_db`），并执行 `pos-java/sql/` 目录下的 SQL 文件初始化表结构和基础数据。

2.  **修改配置**：
    编辑 `pos-java/pos-web/src/main/resources/application-dev.yml`，配置数据库连接 URL、用户名、密码以及 Redis 连接信息。

3.  **启动服务**：
    在 `pos-java` 目录下执行以下命令：
    ```bash
    # 打包构建
    mvn clean install

    # 运行项目 (指定 dev 环境)
    mvn spring-boot:run -Dspring-boot.run.profiles=dev
    ```
    服务启动后，默认监听端口为 8080。

### 2. 前端部署

1.  **安装依赖**：
    进入 `pos-vue` 目录，执行：
    ```bash
    npm install
    ```

2.  **启动开发服务器**：
    ```bash
    npm run dev
    ```
    打开浏览器访问显示的本地地址（通常是 `http://localhost:3000`）。

3.  **构建生产版本**：
    ```bash
    npm run build
    ```
    构建后的文件位于 `dist` 目录，可直接部署至 Nginx 或静态文件服务器。

### 3. Docker 部署 (可选)

项目根目录及后端目录均提供了 `Dockerfile` 和 `docker-compose.yml` 文件。
如果已安装 Docker，可以使用以下命令一键启动后端服务、Redis 和 MySQL（如需）：
```bash
docker-compose up -d
```

## API 文档

后端集成了 Swagger (OpenAPI) 自动生成文档。
在服务启动后，可通过以下地址查看和测试接口文档：
`http://localhost:8080/swagger-ui.html`

## 开发规范

### 分支管理策略

为了保证代码质量和多人协作效率，项目采用以下分支管理策略：

1.  **拉取主开发分支**：
    在开始开发前，请确保本地拥有最新的 `dev` 分支代码。
    ```bash
    git checkout dev
    git pull origin dev
    ```

2.  **创建个人分支**：
    从 `dev` 分支切出新的功能分支，命名规范为 `dev_您的姓名_功能名`。
    ```bash
    git checkout -b dev_zhangsan_new_feature
    ```

3.  **提交与推送**：
    功能开发完成后，提交代码并推送至远端仓库。
    ```bash
    git add .
    git commit -m "feat: 新增xxx功能"
    git push origin dev_zhangsan_new_feature
    ```
    *注意：请在仓库中查看是否成功出现您的分支，并在提交 PR 前确保代码无误。*

4.  **合并与清理**：
    代码合并（Merge Request）经审核后，请及时删除本地开发分支。

### 代码风格

- **命名规范**：类名使用大驼峰（PascalCase），方法名和变量名使用小驼峰（camelCase）。
- **异常处理**：业务逻辑中请抛出自定义业务异常（BusinessException），由全局异常处理器统一处理。
- **日志规范**：关键操作（如登录、下单、结算）需记录操作日志。
- **注释规范**：复杂的业务逻辑和接口必须添加必要的注释说明。

## 许可证

本项目基于 [MIT License](LICENSE) 开源。