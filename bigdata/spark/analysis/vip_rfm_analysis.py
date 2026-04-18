"""
Smart POS 大数据平台 - 会员 RFM 分析
Spark 分析任务：基于会员消费记录计算 RFM 得分，对会员进行价值分层

RFM 模型：
  R (Recency)   - 最近消费距今天数：越小越好（近期活跃）
  F (Frequency) - 近 90 天消费频次：越大越好（高频消费）
  M (Monetary)  - 近 90 天消费金额：越大越好（高价值）

会员分层标签（基于 RFM 得分）：
  重要价值客户   (R高F高M高)
  重要发展客户   (R高F低M高)
  重要保持客户   (R低F高M高)
  重要挽留客户   (R低F低M高)
  一般价值客户   (R高F高M低)
  一般发展客户   (R高F低M低)
  一般保持客户   (R低F高M低)
  流失风险客户   (R低F低M低)

输出表：pos_ads.ads_vip_rfm_analysis

使用方式：
  spark-submit \
    --master yarn \
    --deploy-mode cluster \
    vip_rfm_analysis.py \
    --dt 2026-04-18
"""

import argparse
import logging
from datetime import datetime, timedelta

from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.types import StringType
from pyspark.sql.window import Window

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)
logger = logging.getLogger(__name__)


def create_spark_session() -> SparkSession:
    return (
        SparkSession.builder
        .appName("SmartPOS_VIP_RFM_Analysis")
        .config("spark.sql.hive.convertMetastoreOrc", "true")
        .enableHiveSupport()
        .getOrCreate()
    )


def score_rfm(df, col_name: str, ascending: bool, score_col: str):
    """
    使用分位数将指标映射到 1-5 的得分。
    :param ascending: True 表示值越大得分越高（F/M），False 表示值越小得分越高（R）
    """
    quantiles = df.approxQuantile(col_name, [0.2, 0.4, 0.6, 0.8], 0.01)
    q1, q2, q3, q4 = quantiles

    if ascending:
        return df.withColumn(
            score_col,
            F.when(F.col(col_name) <= q1, 1)
             .when(F.col(col_name) <= q2, 2)
             .when(F.col(col_name) <= q3, 3)
             .when(F.col(col_name) <= q4, 4)
             .otherwise(5)
        )
    else:
        # R：越小越好，倒序打分
        return df.withColumn(
            score_col,
            F.when(F.col(col_name) <= q1, 5)
             .when(F.col(col_name) <= q2, 4)
             .when(F.col(col_name) <= q3, 3)
             .when(F.col(col_name) <= q4, 2)
             .otherwise(1)
        )


def label_vip(r_score: int, f_score: int, m_score: int) -> str:
    """根据 R/F/M 得分生成分层标签（Spark UDF 使用）"""
    r_high = r_score >= 3
    f_high = f_score >= 3
    m_high = m_score >= 3

    if r_high and f_high and m_high:
        return "重要价值客户"
    elif r_high and not f_high and m_high:
        return "重要发展客户"
    elif not r_high and f_high and m_high:
        return "重要保持客户"
    elif not r_high and not f_high and m_high:
        return "重要挽留客户"
    elif r_high and f_high and not m_high:
        return "一般价值客户"
    elif r_high and not f_high and not m_high:
        return "一般发展客户"
    elif not r_high and f_high and not m_high:
        return "一般保持客户"
    else:
        return "流失风险客户"


def build_vip_rfm(spark: SparkSession, dt: str) -> None:
    """计算 RFM 并写入 ADS 层"""
    logger.info("开始 VIP RFM 分析，计算日期: %s", dt)

    dt_90_days_ago = (
        datetime.strptime(dt, "%Y-%m-%d") - timedelta(days=90)
    ).strftime("%Y-%m-%d")

    # -------------------------------------------------------
    # 1. 读取近 90 天的会员消费数据
    # -------------------------------------------------------
    vip_orders = (
        spark.table("pos_dwd.dwd_vip_order")
        .filter(F.col("dt") >= dt_90_days_ago)
        .filter(F.col("dt") <= dt)
    )

    # -------------------------------------------------------
    # 2. 计算 R/F/M 基础指标
    # -------------------------------------------------------
    vip_metrics = (
        vip_orders
        .groupBy("vip_id", "vip_name", "vip_card_number",
                 "vip_phone_number", "org_id", "org_name")
        .agg(
            F.datediff(F.lit(dt), F.max("settle_time")).alias("recency_days"),
            F.countDistinct("order_id").alias("frequency"),
            F.sum("actual_amount").alias("monetary"),
        )
        .withColumn("monetary", F.round(F.col("monetary"), 2))
    )

    # 补充当前余额（从最新的 vip_info 快照获取）
    vip_balance = (
        spark.table("pos_ods.ods_vip_info")
        .filter(F.col("dt") == dt)
        .filter(F.col("is_delete") == 0)
        .select(F.col("id").alias("vip_id"), F.col("balance").alias("current_balance"))
    )

    vip_metrics = vip_metrics.join(vip_balance, "vip_id", "left")

    # -------------------------------------------------------
    # 3. RFM 打分（1-5 分位数分段）
    # -------------------------------------------------------
    vip_metrics = score_rfm(vip_metrics, "recency_days", ascending=False, score_col="r_score")
    vip_metrics = score_rfm(vip_metrics, "frequency",    ascending=True,  score_col="f_score")
    vip_metrics = score_rfm(vip_metrics, "monetary",     ascending=True,  score_col="m_score")

    vip_metrics = vip_metrics.withColumn(
        "rfm_score",
        F.col("r_score") + F.col("f_score") + F.col("m_score")
    )

    # -------------------------------------------------------
    # 4. 生成会员分层标签
    # -------------------------------------------------------
    label_udf = F.udf(label_vip, StringType())
    vip_metrics = vip_metrics.withColumn(
        "vip_segment",
        label_udf(F.col("r_score"), F.col("f_score"), F.col("m_score"))
    )

    # -------------------------------------------------------
    # 5. 写入 ADS 层
    # -------------------------------------------------------
    output_cols = [
        "vip_id", "vip_name", "vip_card_number", "vip_phone_number",
        "org_id", "org_name",
        "recency_days", "frequency", "monetary",
        "r_score", "f_score", "m_score", "rfm_score",
        "vip_segment", "current_balance",
        F.lit(dt).alias("calc_date"),
    ]

    (
        vip_metrics.select(*output_cols)
        .withColumn("dt", F.lit(dt))
        .write
        .format("orc")
        .mode("overwrite")
        .partitionBy("dt")
        .saveAsTable("pos_ads.ads_vip_rfm_analysis")
    )
    logger.info("ads_vip_rfm_analysis 写入完成，计算日期: %s", dt)


def run(dt: str) -> None:
    spark = create_spark_session()
    try:
        build_vip_rfm(spark, dt)
    except Exception as e:
        logger.error("VIP RFM 分析失败: %s", e, exc_info=True)
        raise
    finally:
        spark.stop()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Smart POS 会员 RFM 分析")
    parser.add_argument("--dt", default=None, help="计算日期 YYYY-MM-DD（默认昨天）")
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    dt = args.dt or (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")
    run(dt=dt)
