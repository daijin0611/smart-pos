# POS系统 Docker部署指南

## 概述

本项目提供了简化的Docker Compose配置，用于快速启动POS收银系统的Spring Boot应用。数据库和缓存服务需要单独部署或使用外部服务。

## 服务组件

- **pos-app**: POS应用主服务 (端口: 8080)

## 快速启动

### 1. 构建应用JAR包

```bash
# 在项目根目录执行
mvn clean package -DskipTests

# 将构建好的JAR包复制到根目录并重命名
cp pos-web/target/pos-web-1.0-SNAPSHOT.jar ./pos-web-1.0-SNAPSHOT.jar
```

### 2. 启动所有服务

```bash
# 启动所有服务（后台运行）
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看应用日志
docker-compose logs -f pos-app
```

### 3. 停止服务

```bash
# 停止所有服务
docker-compose down

# 停止服务并删除数据卷（谨慎使用）
docker-compose down -v
```

## 访问地址

- **应用主页**: http://localhost:8080/api
- **API文档**: http://localhost:8080/api/swagger-ui.html
- **Druid监控**: http://localhost:8080/api/druid/
  - 用户名: druid
  - 密码: druid

## 注意事项

- 应用使用dev配置文件启动，请确保配置文件中的数据库和Redis连接信息正确
- 需要提前准备好MySQL数据库和Redis服务

## 环境变量配置

应用支持以下环境变量配置：

- `JAVA_OPTS`: JVM参数（默认: -Xms256m -Xmx512m）
- `SPRING_PROFILES_ACTIVE`: Spring配置文件（默认: dev）

## 数据持久化

项目配置了以下数据卷：

- `app_logs`: 应用日志持久化

## 故障排除

### 1. 应用启动失败

```bash
# 查看应用日志
docker-compose logs pos-app

# 检查应用容器状态
docker-compose ps pos-app
```

### 2. 数据库连接问题

- 确保外部MySQL服务正在运行
- 检查application-dev.yml中的数据库连接配置
- 验证数据库用户权限和网络连通性

### 3. Redis连接问题

- 确保外部Redis服务正在运行
- 检查application-dev.yml中的Redis连接配置
- 验证Redis密码和网络连通性

## 注意事项

1. 确保8080端口未被占用
2. 应用启动前需要确保外部数据库和Redis服务可用
3. 生产环境建议使用prod配置文件
4. 建议定期备份应用日志