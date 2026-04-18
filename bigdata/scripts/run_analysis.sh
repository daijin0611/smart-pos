#!/usr/bin/env bash
# =============================================================
# Smart POS 大数据平台 - 每日分析任务调度脚本
# 流程：DWD/DWS → ADS（销售日报、支付分析、服务热度）
#
# 用法：
#   ./run_analysis.sh [YYYY-MM-DD]
#   不传日期时默认使用昨天
# =============================================================

set -euo pipefail

# -------------------------------------------------------
# 配置项
# -------------------------------------------------------
SPARK_HOME="${SPARK_HOME:-/opt/spark}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIGDATA_DIR="$(dirname "$SCRIPT_DIR")"
LOG_DIR="${LOG_DIR:-/var/log/smartpos-bigdata}"
SPARK_MASTER="${SPARK_MASTER:-yarn}"
SPARK_DEPLOY_MODE="${SPARK_DEPLOY_MODE:-cluster}"

# -------------------------------------------------------
# 日期参数
# -------------------------------------------------------
if [[ $# -ge 1 ]]; then
    DT="$1"
else
    DT=$(date -d "yesterday" +"%Y-%m-%d" 2>/dev/null || date -v-1d +"%Y-%m-%d")
fi

mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/analysis_${DT}.log"

echo "======================================================" | tee -a "$LOG_FILE"
echo "Smart POS 分析任务开始，日期: $DT" | tee -a "$LOG_FILE"
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
# Step 1: 门店销售日报
# -------------------------------------------------------
run_spark "SmartPOS_Daily_Sales_Report_${DT}" \
    "$BIGDATA_DIR/spark/analysis/daily_sales_report.py" \
    --dt "$DT"

# -------------------------------------------------------
# Step 2: 支付方式分布分析
# -------------------------------------------------------
run_spark "SmartPOS_Payment_Type_Analysis_${DT}" \
    "$BIGDATA_DIR/spark/analysis/payment_type_analysis.py" \
    --dt "$DT"

# -------------------------------------------------------
# Step 3: 服务/产品热度分析（近 30 天）
# -------------------------------------------------------
run_spark "SmartPOS_Service_Popularity_${DT}" \
    "$BIGDATA_DIR/spark/analysis/service_popularity.py" \
    --dt "$DT" --days 30

# -------------------------------------------------------
# Step 4: 会员 RFM 分析（每周一执行，其他天跳过）
# -------------------------------------------------------
DAY_OF_WEEK=$(date -d "$DT" +"%u" 2>/dev/null || date -jf "%Y-%m-%d" "$DT" +"%u" 2>/dev/null || echo "0")
if [[ "$DAY_OF_WEEK" == "1" ]]; then
    echo "" | tee -a "$LOG_FILE"
    echo "[$(date '+%H:%M:%S')] 今日为周一，执行会员 RFM 分析..." | tee -a "$LOG_FILE"
    run_spark "SmartPOS_VIP_RFM_Analysis_${DT}" \
        "$BIGDATA_DIR/spark/analysis/vip_rfm_analysis.py" \
        --dt "$DT"
else
    echo "" | tee -a "$LOG_FILE"
    echo "[$(date '+%H:%M:%S')] 今日非周一，跳过会员 RFM 分析（周一执行）" | tee -a "$LOG_FILE"
fi

# -------------------------------------------------------
# Step 5: 月度技师绩效排行（每月 1 日执行，其他天跳过）
# -------------------------------------------------------
DAY_OF_MONTH=$(date -d "$DT" +"%d" 2>/dev/null || date -jf "%Y-%m-%d" "$DT" +"%d" 2>/dev/null || echo "99")
if [[ "$DAY_OF_MONTH" == "01" ]]; then
    LAST_MONTH=$(date -d "$DT -1 month" +"%Y-%m" 2>/dev/null || date -jf "%Y-%m-%d" "$DT" -v-1m +"%Y-%m" 2>/dev/null || echo "")
    if [[ -n "$LAST_MONTH" ]]; then
        echo "" | tee -a "$LOG_FILE"
        echo "[$(date '+%H:%M:%S')] 今日为每月1日，执行月度技师绩效排行，月份: $LAST_MONTH" | tee -a "$LOG_FILE"
        run_spark "SmartPOS_KPI_Monthly_Ranking_${LAST_MONTH}" \
            "$BIGDATA_DIR/spark/analysis/kpi_monthly_ranking.py" \
            --month "$LAST_MONTH"
    fi
else
    echo "" | tee -a "$LOG_FILE"
    echo "[$(date '+%H:%M:%S')] 今日非月初，跳过月度技师绩效排行（每月1日执行）" | tee -a "$LOG_FILE"
fi

echo "" | tee -a "$LOG_FILE"
echo "======================================================" | tee -a "$LOG_FILE"
echo "Smart POS 分析任务完成，日期: $DT" | tee -a "$LOG_FILE"
echo "时间: $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$LOG_FILE"
echo "======================================================" | tee -a "$LOG_FILE"
