"""
Smart POS 大数据平台 - 技师月度绩效排行分析
Spark 分析任务：统计指定月份各门店技师的业绩和提成排行，写入 ADS 层

输出表：pos_ads.ads_top_technician_monthly

使用方式：
  spark-submit \
    --master yarn \
    --deploy-mode cluster \
    kpi_monthly_ranking.py \
    --month 2026-04
"""

import argparse
import logging
from datetime import datetime, timedelta

from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.window import Window

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)
logger = logging.getLogger(__name__)


def create_spark_session() -> SparkSession:
    return (
        SparkSession.builder
        .appName("SmartPOS_KPI_Monthly_Ranking")
        .config("spark.sql.hive.convertMetastoreOrc", "true")
        .enableHiveSupport()
        .getOrCreate()
    )


def build_kpi_monthly_ranking(spark: SparkSession, month: str) -> None:
    """
    生成月度技师业绩排行榜。
    :param month: 月份，格式 YYYY-MM
    """
    logger.info("开始生成月度技师绩效排行，月份: %s", month)

    # 读取 DWD 层绩效明细（过滤指定月份所有分区）
    kpi = (
        spark.table("pos_dwd.dwd_kpi_detail")
        .filter(F.col("dt").startswith(month))
        .groupBy("user_id", "user_name", "user_position", "org_id", "org_name")
        .agg(
            F.count("id").alias("service_count"),
            F.sum("performance").alias("total_performance"),
            F.sum("commission").alias("total_commission"),
        )
        .withColumn(
            "avg_per_service",
            F.round(F.col("total_performance") / F.col("service_count"), 2)
        )
    )

    # 在每个门店内按业绩降序排名
    rank_w = Window.partitionBy("org_id").orderBy(F.col("total_performance").desc())

    result = (
        kpi
        .withColumn("rank_no", F.row_number().over(rank_w))
        .select(
            "rank_no", "user_id", "user_name",
            "org_id", "org_name",
            "service_count", "total_performance",
            "total_commission", "avg_per_service",
        )
    )

    (
        result
        .withColumn("month", F.lit(month))
        .write
        .format("orc")
        .mode("overwrite")
        .partitionBy("month")
        .saveAsTable("pos_ads.ads_top_technician_monthly")
    )
    logger.info("ads_top_technician_monthly 写入完成，月份: %s", month)


def run(month: str) -> None:
    spark = create_spark_session()
    try:
        build_kpi_monthly_ranking(spark, month)
    except Exception as e:
        logger.error("月度技师绩效排行生成失败: %s", e, exc_info=True)
        raise
    finally:
        spark.stop()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Smart POS 技师月度绩效排行")
    parser.add_argument(
        "--month",
        default=None,
        help="统计月份，格式 YYYY-MM（默认上月）"
    )
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    if args.month:
        month = args.month
    else:
        now = datetime.now()
        # 默认取上月
        first_of_month = now.replace(day=1)
        last_month = (first_of_month - timedelta(days=1)).replace(day=1)
        month = last_month.strftime("%Y-%m")
    run(month=month)
