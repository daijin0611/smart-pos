## 项目结构分析总结

### 1. 技术栈

**后端框架：**
- **Spring Boot 3.2.0** - 主要应用框架
- **Spring Security** - 安全认证框架
- **Spring Web** - Web开发框架

**数据层：**
- **MyBatis Plus 3.5.11** - ORM框架，简化数据库操作
- **MySQL 8.0.20** - 关系型数据库
- **Druid 1.2.20** - 数据库连接池
- **Redis** - 缓存数据库

**工具库：**
- **Lombok 1.18.34** - 简化Java代码
- **Hutool 5.8.18** - Java工具类库
- **JWT 4.3.0** - 身份认证令牌
- **Knife4j 4.3.0** - API文档生成工具

**构建工具：**
- **Maven** - 项目管理和构建工具
- **Java 17** - 开发语言版本

### 2. 模块划分

项目采用**多模块Maven架构**，分为三个核心模块：

**<mcfile name="pos-common" path="pos-common"></mcfile>** - 公共模块
- 包含通用的常量、枚举、DTO、VO、工具类
- 提供JWT工具、登录上下文等公共功能
- 集成Knife4j、MyBatis Plus、Redis、Spring Security等基础依赖

**<mcfile name="pos-server" path="pos-server"></mcfile>** - 业务服务模块
- 依赖pos-common模块
- 包含业务实体(Entity)、数据访问层(Mapper)、业务逻辑层(Service)
- 按业务领域划分：system(系统管理)、room(房间管理)、server(服务管理)、vip(会员管理)
- 集成Druid连接池和MySQL驱动

**<mcfile name="pos-web" path="pos-web"></mcfile>** - Web控制层模块
- 依赖pos-server模块
- 包含控制器(Controller)、配置类(Config)、过滤器(Filter)、全局异常处理等
- 作为应用启动入口，包含<mcsymbol name="PosApplication" filename="PosApplication.java" path="pos-web/src/main/java/org/haut/PosApplication.java" startline="9" type="class"></mcsymbol>主类

### 3. 代码风格

**架构模式：**
- 采用经典的**三层架构**：Controller → Service → Mapper
- 遵循**领域驱动设计(DDD)**思想，按业务领域组织代码
- 使用**依赖注入**和**面向接口编程**

**代码规范：**
- 统一使用**@Lombok**注解简化代码，如@Data、@RequiredArgsConstructor
- 控制器使用**@RestController**和**@RequestMapping**进行RESTful API设计
- 服务层继承**MyBatis Plus的ServiceImpl**，简化CRUD操作
- 实体类使用**@TableName**、**@TableId**等MyBatis Plus注解
- 广泛使用**Swagger注解**(@Tag、@Operation)进行API文档化

**包命名规范：**
- 统一使用**org.haut**作为根包名
- 按模块和功能层次清晰划分包结构
- 每个业务领域独立成包：system、room、server、vip

**配置管理：**
- 使用**YAML格式**的配置文件
- 配置了详细的数据源、Redis、Jackson等组件参数
- 支持Druid监控和多环境配置

### 4. 命名规范

**各层方法命名规范**
  - 获取单个对象方法用`query`做前缀
  - 获取多个对象方法用`query`做前缀
  - 获取统计值的方法用`count`做前缀
  - 插入的方法用`add`做前缀
  - 删除的方法用`remove`做前缀
  - 修改的方法用`update`做前缀
  - API请求路径命名，前缀（功能模块） + 功能名称（多个单词连接）示例：
    - `/user/query-by-name`、`/user/add-user`

**领域模型命名规范**
  - VO：接口响应参数使用`xxxVO`命名，位置在`@root\pos-common\src\main\java\org\haut\common\domain\vo\**(对应模块)`，外层使用`JsonVO`进行包裹
  - DTO：接口请求参数使用`xxxDTO`命名，位置`@root\pos-common\src\main\java\org\haut\common\domain\dto\**(对应模块)`
  - Query：查询类型请求使用`xxxQuery`命名，位置`@root\pos-common\src\main\java\org\haut\common\domain\query\**(对应模块)`

这是一个结构清晰、技术栈现代化的**POS收银系统**项目，采用了主流的Spring Boot生态技术栈，具有良好的模块化设计和代码规范。
        