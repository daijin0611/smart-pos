"""
webhook_listener.py - Gitee Webhook 监听服务
根据分支自动路由到对应环境的部署脚本

使用方式:
    python3 webhook_listener.py
    或通过 systemd 管理: systemctl start pos-webhook
"""

from http.server import HTTPServer, BaseHTTPRequestHandler
import subprocess
import json
import logging
import os

# ============ 配置区（按实际情况修改） ============
SECRET = "your_webhook_secret"    # Gitee Webhook 密码
DEPLOY_DIR = "/opt/pos"           # 项目部署目录
LOG_FILE = "/opt/pos/logs/webhook.log"
LISTEN_PORT = 9000

# 分支 → 环境部署脚本映射
BRANCH_MAP = {
    "master": "prod/deploy.sh",
    "dev": "test/deploy.sh",
}
# ================================================

os.makedirs(os.path.dirname(LOG_FILE), exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.FileHandler(LOG_FILE, encoding="utf-8"),
        logging.StreamHandler(),
    ],
)
log = logging.getLogger("webhook")


class WebhookHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        if self.path != "/webhook/deploy":
            self.send_response(404)
            self.end_headers()
            return

        content_length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(content_length)

        # 验证签名
        token = self.headers.get("X-Gitee-Token", "")
        if token != SECRET:
            log.warning("签名验证失败，来源 IP: %s", self.client_address[0])
            self.send_response(403)
            self.end_headers()
            self.wfile.write(b"Forbidden")
            return

        try:
            data = json.loads(body)
        except json.JSONDecodeError:
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Invalid JSON")
            return

        ref = data.get("ref", "")

        # 匹配分支 → 环境部署脚本
        deploy_script = None
        for branch, script in BRANCH_MAP.items():
            if ref.endswith(branch):
                deploy_script = script
                break

        if not deploy_script:
            self.send_response(200)
            self.end_headers()
            self.wfile.write(f"Ignored: branch {ref}".encode())
            return

        script_path = os.path.join(DEPLOY_DIR, "deploy", deploy_script)
        if not os.path.exists(script_path):
            self.send_response(500)
            self.end_headers()
            self.wfile.write(f"Script not found: {deploy_script}".encode())
            return

        log.info(
            "触发部署: 分支=%s, 环境=%s, 触发者=%s",
            ref,
            deploy_script.split("/")[0],
            data.get("user_name", "unknown"),
        )

        # 异步执行部署脚本
        deploy_log = os.path.join(DEPLOY_DIR, "logs", f"deploy_{deploy_script.split('/')[0]}.log")
        subprocess.Popen(
            f"nohup bash {script_path} >> {deploy_log} 2>&1 &",
            shell=True,
        )

        self.send_response(200)
        self.end_headers()
        self.wfile.write(f"Deploy triggered: {deploy_script}".encode())

    def log_message(self, format, *args):
        log.info("HTTP %s - %s", self.client_address[0], format % args)


if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", LISTEN_PORT), WebhookHandler)
    log.info("Webhook 监听已启动，端口: %d", LISTEN_PORT)
    log.info("分支映射: %s", BRANCH_MAP)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        log.info("服务已停止")
        server.server_close()
