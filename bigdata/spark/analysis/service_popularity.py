"""
Smart POS 大数据平台 - 服务/产品热度分析
Spark 分析任务：统计各门店的服务/产品销售排行，帮助了解热门项目

输出表：pos_ads.ads_service_popularity

使用方式：
  spark-submit \
    --master yarn \
    --deploy-mode cluster \
    service_popularity.py \
    --dt 2026-04-18 \
    --days 30
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
        .appName("SmartPOS_Service_Popularity")
        .config("spark.sql.hive.convertMetastoreOrc", "true")
        .enableHiveSupport()
        .getOrCreate()
    )


def build_service_popularity(spark: SparkSession, dt: str, days: int = 30) -> None:
    """
    统计近 N 天的服务/产品销售热度。
    :param dt:   统计截止日期（包含当天）
    :param days: 统计天数窗口（默认 30 天）
    """
    start_dt = (
        datetime.strptime(dt, "%Y-%m-%d") - timedelta(days=days - 1)
    ).strftime("%Y-%m-%d")

    logger.info("开始服务热度分析，统计区间: %s ~ %s", start_dt, dt)

    detail = (
        spark.table("pos_dwd.dwd_order_detail")
        .filter(F.col("dt") >= start_dt)
        .filter(F.col("dt") <= dt)
        .filter(F.col("order_status") == 1)  # 仅已结算
    )

    # 聚合：按服务id + 门店
    agg_per_org = (
        detail
        .groupBy("server_id", "detail_type", "detail_type_name", "org_id", "org_name")
        .agg(
            F.count("detail_id").alias("sale_count"),
            F.sum("quantity").alias("sale_quantity"),
            F.sum("line_total").alias("total_revenue"),
            F.round(F.avg("true_price"), 2).alias("avg_price"),
        )
    )

    # 门店内排名
    org_w = Window.partitionBy("org_id").orderBy(F.col("sale_count").desc())
    # 全局排名（不分门店）
    global_w = Window.orderBy(F.col("sale_count").desc())

    result = (
        agg_per_org
        .withColumn("rank_in_org", F.row_number().over(org_w))
        .withColumn("rank_overall", F.row_number().over(global_w))
    )

    (
        result
        .withColumn("dt", F.lit(dt))
        .write
        .format("orc")
        .mode("overwrite")
        .partitionBy("dt")
        .saveAsTable("pos_ads.ads_service_popularity")
    )
    logger.info("ads_service_popularity 写入完成，截止日期: %s，统计天数: %d", dt, days)


def run(dt: str, days: int) -> None:
    spark = create_spark_session()
    try:
        build_service_popularity(spark, dt, days)
    except Exception as e:
        logger.error("服务热度分析失败: %s", e, exc_info=True)
        raise
    finally:
        spark.stop()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Smart POS 服务/产品热度分析")
    parser.add_argument("--dt", default=None, help="统计截止日期 YYYY-MM-DD（默认昨天）")
    parser.add_argument("--days", type=int, default=30, help="统计天数窗口（默认 30）")
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    dt = args.dt or (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")
    run(dt=dt, days=args.days)
