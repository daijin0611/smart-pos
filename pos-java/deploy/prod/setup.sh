#!/bin/bash
# deploy/prod/setup.sh - 生产服务器初始化（仅需执行一次）
set -e

echo "========== POS 生产环境初始化 =========="

# ============ 配置区 ============
DEPLOY_DIR="/opt/pos"
GIT_REMOTE="https://gitee.com/your_name/pos-java.git"
# ================================

# 1. 安装依赖
echo ">>> 安装 Docker..."
if ! command -v docker &> /dev/null; then
    if command -v apt-get &> /dev/null; then
        apt-get update && apt-get install -y python3 docker.io docker-buildx-plugin curl
    elif command -v yum &> /dev/null; then
        yum install -y python3 docker curl
    fi
    systemctl enable --now docker
fi

# 2. 创建目录
mkdir -p "${DEPLOY_DIR}/logs"

# 3. 克隆代码
if [ ! -d "${DEPLOY_DIR}/.git" ]; then
    git clone "$GIT_REMOTE" "$DEPLOY_DIR"
fi

# 4. 创建环境配置
if [ ! -f "${DEPLOY_DIR}/deploy/prod/.env" ]; then
    cp "${DEPLOY_DIR}/deploy/prod/env.example" "${DEPLOY_DIR}/deploy/prod/.env"
    echo ">>> 已创建 .env 模板，请编辑: vi ${DEPLOY_DIR}/deploy/prod/.env"
fi

# 5. 配置 systemd 服务
cp "${DEPLOY_DIR}/deploy/shared/pos-webhook.service" /etc/systemd/system/
systemctl daemon-reload
systemctl enable pos-webhook

echo ""
echo "========== 初始化完成 =========="
echo ""
echo "后续步骤:"
echo "  1. 编辑 deploy/prod/.env 填入实际配置"
echo "  2. 修改 deploy/shared/webhook_listener.py 中的 SECRET"
echo "  3. 启动 webhook:  systemctl start pos-webhook"
echo "  4. 配置 Gitee Webhook (master 分支 Push 事件):"
echo "     URL: http://本机IP:9000/webhook/deploy"
echo "  5. 手动测试:      bash ${DEPLOY_DIR}/deploy/prod/deploy.sh"
