#!/bin/bash
# deploy/test/deploy.sh - 测试环境自动部署脚本
# 触发方式: 由 webhook_listener.py 自动调用（dev 分支推送时），或手动执行
set -e

# ============ 配置区（按实际情况修改） ============
DEPLOY_DIR="/opt/pos"
GIT_REMOTE="https://gitee.com/your_name/pos-java.git"
BRANCH="dev"
ENV="test"
# ================================================

cd "$DEPLOY_DIR"

echo "========== [$(date '+%Y-%m-%d %H:%M:%S')] 测试环境部署开始 =========="

# 1. 拉取最新代码
echo ">>> 拉取 ${BRANCH} 分支..."
if [ ! -d ".git" ]; then
    git clone -b "$BRANCH" "$GIT_REMOTE" .
else
    git fetch origin
    git reset --hard "origin/${BRANCH}"
fi

# 2. 构建镜像并重启
echo ">>> 构建 Docker 镜像..."
cd deploy/${ENV}
docker compose build --no-cache

echo ">>> 重启容器..."
docker compose up -d

# 3. 健康检查
echo ">>> 等待服务启动..."
for i in $(seq 1 12); do
    sleep 5
    if curl -sf http://localhost:8081/api/actuator/health > /dev/null 2>&1; then
        echo ">>> 测试环境启动成功！(耗时约 $((i * 5)) 秒)"
        break
    fi
    if [ "$i" -eq 12 ]; then
        echo ">>> 警告：健康检查超时，请查看日志"
        docker logs pos-app-test --tail 50
    fi
done

# 4. 清理旧镜像
docker image prune -f --filter "until=72h" 2>/dev/null || true

echo "========== [$(date '+%Y-%m-%d %H:%M:%S')] 测试环境部署完成 =========="
