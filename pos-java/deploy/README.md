# POS 自动部署

基于 Gitee Webhook 的 CI/CD 自动部署方案。推送代码到指定分支后自动触发服务器构建和部署。

## 目录结构

```
deploy/
├── README.md                     # 本文档
├── shared/                       # 共享文件（多环境共用）
│   ├── Dockerfile.multistage     # 多阶段构建 Dockerfile
│   ├── webhook_listener.py       # Webhook 监听服务
│   └── pos-webhook.service       # systemd 服务配置
├── prod/                         # 生产环境
│   ├── docker-compose.yml
│   ├── deploy.sh
│   ├── setup.sh
│   └── env.example
└── test/                         # 测试环境
    ├── docker-compose.yml
    ├── deploy.sh
    ├── setup.sh
    └── env.example
```

## 环境对比

| | 测试环境 | 生产环境 |
|---|---|---|
| 触发分支 | `dev` | `master` |
| Spring Profile | `test` | `prod` |
| 容器名 | `pos-app-test` | `pos-app-prod` |
| 宿主机端口 | `8081` | `8080` |
| JVM 内存 | 256m ~ 512m | 512m ~ 1024m |
| 日志保留 | 3 个文件 x 50MB | 5 个文件 x 100MB |

## 部署流程

```
推送代码 → Gitee Webhook → webhook_listener.py (端口 9000)
                                  │
                    ┌─────────────┴──────────────┐
                    │ 分支判断                     │
                    ├─ dev    → test/deploy.sh    │
                    └─ master → prod/deploy.sh    │
                                │
                    git pull → docker build → docker up
                                │
                         健康检查 → 部署完成
```

## 快速开始

### 一、服务器初始化

登录目标服务器，执行对应环境的初始化脚本：

```bash
# 克隆项目
git clone https://gitee.com/your_name/pos-java.git /opt/pos
cd /opt/pos

# 初始化（选一个）
bash deploy/prod/setup.sh    # 生产服务器
bash deploy/test/setup.sh    # 测试服务器
```

初始化脚本会：
- 安装 Docker、Python3
- 克隆代码到 `/opt/pos`
- 创建 `.env` 配置模板
- 注册 webhook 自启服务

### 二、修改配置

**必须修改的配置项：**

1. **环境配置** — 编辑对应环境的 `.env` 文件：
   ```bash
   vi /opt/pos/deploy/prod/.env    # 生产环境
   vi /opt/pos/deploy/test/.env    # 测试环境
   ```

2. **Webhook 密码** — 编辑 `shared/webhook_listener.py`：
   ```python
   SECRET = "修改为你的密码"
   ```

3. **Git 仓库地址** — 编辑各环境 `deploy.sh` 中的 `GIT_REMOTE`。

### 三、启动 Webhook 服务

```bash
systemctl start pos-webhook    # 启动
systemctl status pos-webhook   # 查看状态
journalctl -u pos-webhook -f   # 查看日志
```

### 四、配置 Gitee Webhook

进入 Gitee 仓库 → **管理** → **WebHooks** → **添加 WebHook**：

| 配置项 | 值 |
|---|---|
| URL | `http://服务器IP:9000/webhook/deploy` |
| 密码 | 与 `webhook_listener.py` 中 SECRET 一致 |
| 事件 | 勾选 **Push** |

> 如果测试和生产在同一台服务器，只需添加一个 Webhook，`webhook_listener.py` 会根据分支自动路由。
> 如果在不同服务器，各自添加指向各自服务器的 Webhook。

### 五、验证

```bash
# 手动触发部署测试
bash /opt/pos/deploy/test/deploy.sh     # 测试环境
bash /opt/pos/deploy/prod/deploy.sh     # 生产环境

# 推送代码触发自动部署
git push origin dev      # → 自动部署测试环境
git push origin master   # → 自动部署生产环境
```

## 日常运维

```bash
# 查看容器状态
docker ps | grep pos-app

# 查看应用日志
docker logs pos-app-test --tail 100 -f    # 测试环境
docker logs pos-app-prod --tail 100 -f    # 生产环境

# 查看部署日志
tail -f /opt/pos/logs/deploy_test.log
tail -f /opt/pos/logs/deploy_prod.log

# 手动重启
cd /opt/pos/deploy/test  && docker compose restart
cd /opt/pos/deploy/prod  && docker compose restart

# 回滚（切换到上一个 commit）
cd /opt/pos
git log --oneline -5                      # 找到目标版本
git reset --hard <commit-hash>            # 回退代码
bash deploy/prod/deploy.sh                # 重新构建部署
```

## 注意事项

- `.env` 文件已在 `.gitignore` 中排除，不会被提交到仓库
- 测试和生产可部署在同一台服务器（不同端口），也可分别部署在不同服务器
- 部署期间会有短暂服务不可用（非滚动更新），建议在低峰期推送生产环境
- 服务器防火墙需开放 9000 端口给 Gitee Webhook 回调
