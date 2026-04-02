# Redis Docker 部署说明

## 配置概述

本配置创建了一个独立的Redis服务器，具有以下特性：
- **用户名**: admin
- **密码**: aA123456@
- **持久化**: 开启AOF（Append Only File）
- **模式**: 单机模式（关闭主从复制）
- **安全**: 启用密码认证和ACL用户管理

## 文件说明

### 1. redis-docker-compose.yml
Docker Compose配置文件，定义了Redis服务的部署参数：
- 使用Redis 7 Alpine镜像
- 映射端口6379
- 挂载数据卷和配置文件
- 配置健康检查

### 2. redis.conf
Redis服务器配置文件，包含：
- 用户认证配置
- AOF持久化设置
- 安全配置
- 性能优化参数

## 部署步骤

### 1. 启动Redis服务
```bash
# 进入配置文件目录
cd documents

# 启动Redis服务
docker-compose -f redis-docker-compose.yml up -d

# 查看服务状态
docker-compose -f redis-docker-compose.yml ps

# 查看日志
docker-compose -f redis-docker-compose.yml logs -f redis
```

### 2. 连接Redis
```bash
# 使用redis-cli连接（在容器内）
docker-compose -f redis-docker-compose.yml exec redis redis-cli -a aA123456@

# 或者使用admin用户连接
docker-compose -f redis-docker-compose.yml exec redis redis-cli
# 然后执行：AUTH admin aA123456@

# 从宿主机连接（需要安装redis-cli）
redis-cli -h localhost -p 6379 -a aA123456@
```

### 3. 验证配置
```bash
# 检查AOF是否开启
CONFIG GET appendonly
# 应该返回：appendonly yes

# 检查当前用户
ACL WHOAMI
# 应该返回：admin

# 检查用户权限
ACL LIST

# 测试数据持久化
SET test_key "hello redis"
GET test_key
```

## 主要配置说明

### 用户认证
- **默认用户**: 已禁用
- **admin用户**: 拥有所有权限，密码为aA123456@
- **密码认证**: 必须提供密码才能连接

### AOF持久化
- **同步策略**: 每秒同步一次（appendfsync everysec）
- **重写条件**: 文件大小增长100%且超过64MB时触发重写
- **混合持久化**: 启用AOF+RDB混合模式

### 安全配置
- **保护模式**: 启用
- **危险命令**: FLUSHDB、FLUSHALL、KEYS等已重命名或禁用
- **网络绑定**: 绑定到所有接口（容器环境安全）

### 性能配置
- **最大客户端**: 10000
- **内存策略**: allkeys-lru（最近最少使用淘汰）
- **慢查询**: 记录超过10ms的查询

## 常用命令

```bash
# 停止服务
docker-compose -f redis-docker-compose.yml down

# 重启服务
docker-compose -f redis-docker-compose.yml restart

# 查看Redis信息
docker-compose -f redis-docker-compose.yml exec redis redis-cli -a aA123456@ INFO

# 查看内存使用
docker-compose -f redis-docker-compose.yml exec redis redis-cli -a aA123456@ INFO memory

# 查看持久化状态
docker-compose -f redis-docker-compose.yml exec redis redis-cli -a aA123456@ INFO persistence

# 手动保存数据
docker-compose -f redis-docker-compose.yml exec redis redis-cli -a aA123456@ BGSAVE

# 查看AOF重写状态
docker-compose -f redis-docker-compose.yml exec redis redis-cli -a aA123456@ INFO replication
```

## 数据备份

### 自动备份
Redis会自动进行AOF和RDB备份：
- AOF文件：`/data/appendonly.aof`
- RDB文件：`/data/dump.rdb`

### 手动备份
```bash
# 创建RDB快照
docker-compose -f redis-docker-compose.yml exec redis redis-cli -a aA123456@ BGSAVE

# 复制数据文件到宿主机
docker cp redis-server:/data/dump.rdb ./backup/
docker cp redis-server:/data/appendonly.aof ./backup/
```

## 故障排除

### 1. 连接被拒绝
- 检查端口是否正确映射
- 确认防火墙设置
- 验证密码是否正确

### 2. 认证失败
```bash
# 检查用户配置
docker-compose -f redis-docker-compose.yml exec redis redis-cli --no-auth-warning CONFIG GET requirepass

# 重置密码（如果需要）
docker-compose -f redis-docker-compose.yml exec redis redis-cli --no-auth-warning CONFIG SET requirepass "新密码"
```

### 3. 数据丢失
- 检查AOF文件是否存在
- 查看Redis日志
- 验证数据卷挂载

### 4. 性能问题
```bash
# 查看慢查询日志
docker-compose -f redis-docker-compose.yml exec redis redis-cli -a aA123456@ SLOWLOG GET 10

# 监控Redis命令
docker-compose -f redis-docker-compose.yml exec redis redis-cli -a aA123456@ MONITOR
```

## 生产环境建议

1. **修改默认密码**: 使用更复杂的密码
2. **资源限制**: 在docker-compose中添加内存和CPU限制
3. **监控**: 配置Redis监控和告警
4. **网络安全**: 限制访问IP范围
5. **定期备份**: 设置自动备份脚本
6. **日志管理**: 配置日志轮转和收集

## 配置文件位置

- **Docker Compose**: `redis-docker-compose.yml`
- **Redis配置**: `redis.conf`
- **数据目录**: Docker卷 `redis_data`
- **日志**: 容器标准输出