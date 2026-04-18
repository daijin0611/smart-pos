#!/usr/bin/env bash
# =============================================================
# Smart POS 大数据平台 - 每日 ETL 调度脚本
# 流程：MySQL → ODS → DWD
#
# 用法：
#   ./run_etl.sh [YYYY-MM-DD]
#   不传日期时默认使用昨天
# =============================================================

set -euo pipefail

# -------------------------------------------------------
# 配置项
# -------------------------------------------------------
SPARK_HOME="${SPARK_HOME:-/opt/spark}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIGDATA_DIR="$(dirname "$SCRIPT_DIR")"
MYSQL_CONNECTOR_JAR="${MYSQL_CONNECTOR_JAR:-/opt/jars/mysql-connector-j-8.0.33.jar}"
LOG_DIR="${LOG_DIR:-/var/log/smartpos-bigdata}"
SPARK_MASTER="${SPARK_MASTER:-yarn}"
SPARK_DEPLOY_MODE="${SPARK_DEPLOY_MODE:-cluster}"

# MySQL 连接信息（必须通过环境变量提供）
: "${POS_MYSQL_HOST:?请设置环境变量 POS_MYSQL_HOST}"
: "${POS_MYSQL_PORT:?请设置环境变量 POS_MYSQL_PORT}"
: "${POS_MYSQL_DB:?请设置环境变量 POS_MYSQL_DB}"
: "${POS_MYSQL_USER:?请设置环境变量 POS_MYSQL_USER}"
: "${POS_MYSQL_PASS:?请设置环境变量 POS_MYSQL_PASS}"

# -------------------------------------------------------
# 日期参数
# -------------------------------------------------------
if [[ $# -ge 1 ]]; then
    DT="$1"
else
    DT=$(date -d "yesterday" +"%Y-%m-%d" 2>/dev/null || date -v-1d +"%Y-%m-%d")
fi

mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/etl_${DT}.log"

echo "======================================================" | tee -a "$LOG_FILE"
echo "Smart POS ETL 开始，日期: $DT" | tee -a "$LOG_FILE"
echo "时间: $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$LOG_FILE"
echo "======================================================" | tee -a "$LOG_FILE"

# -------------------------------------------------------
# 公共 spark-submit 函数
# -------------------------------------------------------
run_spark() {
    local app_name="$1"
    local script="$2"
    shift 2
    local extra_args=("$@")

    echo "" | tee -a "$LOG_FILE"
    echo "[$(date '+%H:%M:%S')] 启动: $app_name" | tee -a "$LOG_FILE"

    "$SPARK_HOME/bin/spark-submit" \
        --master "$SPARK_MASTER" \
        --deploy-mode "$SPARK_DEPLOY_MODE" \
        --name "$app_name" \
        --jars "$MYSQL_CONNECTOR_JAR" \
        --conf "spark.yarn.appMasterEnv.POS_MYSQL_HOST=$POS_MYSQL_HOST" \
        --conf "spark.yarn.appMasterEnv.POS_MYSQL_PORT=$POS_MYSQL_PORT" \
        --conf "spark.yarn.appMasterEnv.POS_MYSQL_DB=$POS_MYSQL_DB" \
        --conf "spark.yarn.appMasterEnv.POS_MYSQL_USER=$POS_MYSQL_USER" \
        --conf "spark.yarn.appMasterEnv.POS_MYSQL_PASS=$POS_MYSQL_PASS" \
        --conf "spark.executorEnv.POS_MYSQL_HOST=$POS_MYSQL_HOST" \
        --conf "spark.executorEnv.POS_MYSQL_PORT=$POS_MYSQL_PORT" \
        --conf "spark.executorEnv.POS_MYSQL_DB=$POS_MYSQL_DB" \
        --conf "spark.executorEnv.POS_MYSQL_USER=$POS_MYSQL_USER" \
        --conf "spark.executorEnv.POS_MYSQL_PASS=$POS_MYSQL_PASS" \
        "$script" \
        "${extra_args[@]}" \
        2>&1 | tee -a "$LOG_FILE"

    local exit_code=${PIPESTATUS[0]}
    if [[ $exit_code -ne 0 ]]; then
        echo "[ERROR] $app_name 执行失败，退出码: $exit_code" | tee -a "$LOG_FILE"
        return $exit_code
    fi
    echo "[$(date '+%H:%M:%S')] 完成: $app_name" | tee -a "$LOG_FILE"
}

# -------------------------------------------------------
# Step 1: MySQL → ODS（增量同步）
# -------------------------------------------------------
run_spark "SmartPOS_MySQL_to_ODS_${DT}" \
    "$BIGDATA_DIR/spark/etl/mysql_to_ods.py" \
    --mode incremental --dt "$DT"

# -------------------------------------------------------
# Step 2: ODS → DWD（数据清洗）
# -------------------------------------------------------
run_spark "SmartPOS_ODS_to_DWD_${DT}" \
    "$BIGDATA_DIR/spark/etl/ods_to_dwd.py" \
    --dt "$DT"

echo "" | tee -a "$LOG_FILE"
echo "======================================================" | tee -a "$LOG_FILE"
echo "Smart POS ETL 完成，日期: $DT" | tee -a "$LOG_FILE"
echo "时间: $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$LOG_FILE"
echo "======================================================" | tee -a "$LOG_FILE"
