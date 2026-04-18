"""
Smart POS 大数据平台 - 门店销售日报分析
Spark 分析任务：基于 DWD/DWS 层数据生成每日门店销售报表，写入 ADS 层

输出表：pos_ads.ads_sales_daily_report

使用方式：
  spark-submit \
    --master yarn \
    --deploy-mode cluster \
    daily_sales_report.py \
    --dt 2026-04-18
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

PAYMENT_TYPE_WECHAT = 0
PAYMENT_TYPE_ALIPAY = 1
PAYMENT_TYPE_CASH   = 2
PAYMENT_TYPE_MEMBER = 3
PAYMENT_TYPE_POS    = 4


def create_spark_session() -> SparkSession:
    return (
        SparkSession.builder
        .appName("SmartPOS_Daily_Sales_Report")
        .config("spark.sql.hive.convertMetastoreOrc", "true")
        .enableHiveSupport()
        .getOrCreate()
    )


def build_daily_sales_report(spark: SparkSession, dt: str) -> None:
    """生成 ads_sales_daily_report"""
    logger.info("开始生成销售日报，日期: %s", dt)

    # -------------------------------------------------------
    # 1. 订单基础汇总（按门店）
    # -------------------------------------------------------
    order_summary = (
        spark.table("pos_dwd.dwd_order_detail")
        .filter(F.col("dt") == dt)
        .filter(F.col("order_status") == 1)  # 仅已结算订单
        .groupBy("order_id", "org_id", "org_name", "customer_type",
                 "total_amount", "actual_amount", "discount_amount")
        .agg(F.lit(1).alias("_dummy"))  # 去重到订单级别
        .drop("_dummy")
    )

    orders_per_org = (
        order_summary
        .groupBy("org_id", "org_name")
        .agg(
            F.countDistinct("order_id").alias("order_count"),
            F.sum(F.when(F.col("customer_type") == 0, 1).otherwise(0)).alias("vip_order_count"),
            F.sum(F.when(F.col("customer_type") == 1, 1).otherwise(0)).alias("guest_order_count"),
            F.sum("total_amount").alias("total_amount"),
            F.sum("actual_amount").alias("actual_amount"),
            F.sum("discount_amount").alias("discount_amount"),
        )
    )

    # -------------------------------------------------------
    # 2. 支付方式汇总
    # -------------------------------------------------------
    payment_pivot = (
        spark.table("pos_dwd.dwd_payment_detail")
        .filter(F.col("dt") == dt)
        .filter(F.col("active_type") == 1)  # 仅订单消费
        .groupBy("org_id")
        .agg(
            F.sum(F.when(F.col("payment_type") == PAYMENT_TYPE_WECHAT, F.col("total_amount")).otherwise(0))
             .alias("wechat_pay_amount"),
            F.sum(F.when(F.col("payment_type") == PAYMENT_TYPE_ALIPAY, F.col("total_amount")).otherwise(0))
             .alias("alipay_amount"),
            F.sum(F.when(F.col("payment_type") == PAYMENT_TYPE_CASH, F.col("total_amount")).otherwise(0))
             .alias("cash_amount"),
            F.sum(F.when(F.col("payment_type") == PAYMENT_TYPE_MEMBER, F.col("total_amount")).otherwise(0))
             .alias("member_card_amount"),
            F.sum(F.when(F.col("payment_type") == PAYMENT_TYPE_POS, F.col("total_amount")).otherwise(0))
             .alias("pos_pay_amount"),
        )
    )

    # -------------------------------------------------------
    # 3. 会员充值汇总
    # -------------------------------------------------------
    recharge_summary = (
        spark.table("pos_ods.ods_vip_recharge_history")
        .filter(F.col("dt") == dt)
        .filter(F.col("is_delete") == 0)
        .groupBy("org_id")
        .agg(
            F.sum("recharge_amount").alias("recharge_amount"),
            F.sum("gift_amount").alias("recharge_gift_amount"),
        )
    )

    # -------------------------------------------------------
    # 4. 新增会员数（当日注册）
    # -------------------------------------------------------
    new_vip = (
        spark.table("pos_ods.ods_vip_info")
        .filter(F.col("dt") == dt)
        .filter(F.col("is_delete") == 0)
        .filter(F.date_format(F.col("create_time"), "yyyy-MM-dd") == dt)
        .groupBy("org_id")
        .agg(F.count("id").alias("new_vip_count"))
    )

    # -------------------------------------------------------
    # 5. 当日最热服务项目
    # -------------------------------------------------------
    service_count = (
        spark.table("pos_dwd.dwd_order_detail")
        .filter(F.col("dt") == dt)
        .filter(F.col("detail_type") == 1)  # 服务类型
        .filter(F.col("order_status") == 1)
        .groupBy("org_id", "server_id")
        .agg(F.count("detail_id").alias("cnt"))
    )
    top_service_w = Window.partitionBy("org_id").orderBy(F.col("cnt").desc())
    top_service = (
        service_count
        .withColumn("rn", F.row_number().over(top_service_w))
        .filter(F.col("rn") == 1)
        .select("org_id", F.col("server_id").cast("string").alias("top_service"))
    )

    # -------------------------------------------------------
    # 6. 当日业绩最高技师
    # -------------------------------------------------------
    tech_perf = (
        spark.table("pos_dwd.dwd_kpi_detail")
        .filter(F.col("dt") == dt)
        .groupBy("org_id", "user_id", "user_name")
        .agg(F.sum("performance").alias("total_perf"))
    )
    top_tech_w = Window.partitionBy("org_id").orderBy(F.col("total_perf").desc())
    top_technician = (
        tech_perf
        .withColumn("rn", F.row_number().over(top_tech_w))
        .filter(F.col("rn") == 1)
        .select("org_id", F.col("user_name").alias("top_technician"))
    )

    # -------------------------------------------------------
    # 7. 合并所有维度
    # -------------------------------------------------------
    result = (
        orders_per_org
        .join(payment_pivot, "org_id", "left")
        .join(recharge_summary, "org_id", "left")
        .join(new_vip, "org_id", "left")
        .join(top_service, "org_id", "left")
        .join(top_technician, "org_id", "left")
        .withColumn(
            "avg_order_amount",
            F.round(F.col("actual_amount") / F.col("order_count"), 2)
        )
        .withColumn(
            "vip_order_rate",
            F.round(F.col("vip_order_count") / F.col("order_count") * 100, 2)
        )
        .fillna(0, subset=[
            "recharge_amount", "recharge_gift_amount", "new_vip_count",
            "wechat_pay_amount", "alipay_amount", "cash_amount",
            "member_card_amount", "pos_pay_amount",
        ])
    )

    output_cols = [
        "org_id", "org_name",
        "order_count", "vip_order_count", "vip_order_rate",
        "total_amount", "actual_amount", "discount_amount", "avg_order_amount",
        "recharge_amount", "new_vip_count",
        "wechat_pay_amount", "alipay_amount", "cash_amount",
        "member_card_amount", "pos_pay_amount",
        "top_service", "top_technician",
    ]

    (
        result.select(*output_cols)
        .withColumn("dt", F.lit(dt))
        .write
        .format("orc")
        .mode("overwrite")
        .partitionBy("dt")
        .saveAsTable("pos_ads.ads_sales_daily_report")
    )
    logger.info("ads_sales_daily_report 生成完成，日期: %s", dt)


def run(dt: str) -> None:
    spark = create_spark_session()
    try:
        build_daily_sales_report(spark, dt)
    except Exception as e:
        logger.error("销售日报生成失败: %s", e, exc_info=True)
        raise
    finally:
        spark.stop()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Smart POS 门店销售日报")
    parser.add_argument("--dt", default=None, help="数据日期 YYYY-MM-DD（默认昨天）")
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    dt = args.dt or (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")
    run(dt=dt)
