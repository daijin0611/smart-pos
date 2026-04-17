"""
美管家系统次卡数据导入脚本

将美管家系统导出的次卡 JSON 数据转换为 SQL INSERT 语句，用于导入 POS 系统。
采用方案三：迁移剩余权益 + 快照历史。

生成内容：
1. 通用次卡模板优惠券（vip_ticket）+ 门店关联（sys_org_relation）
2. 缺失会员自动创建（vip_info）
3. 会员券实例（vip_info_ticket）：按 leaveTimes 生成对应数量的券，amount 为老系统单次金额
4. 快照记录（vip_migrate_card_snapshot）：保存老数据完整信息
"""

import json
import os
import sys
from collections import OrderedDict
from datetime import datetime
from tkinter import Tk, filedialog

TEMPLATE_TICKET_NAME = "美管家次卡迁移模板"


def select_json_file():
    """弹窗选择 JSON 数据文件"""
    root = Tk()
    root.withdraw()
    file_path = filedialog.askopenfilename(
        title="选择美管家次卡 JSON 数据文件",
        filetypes=[("JSON 文件", "*.json"), ("所有文件", "*.*")]
    )
    root.destroy()
    if not file_path:
        print("未选择文件，退出。")
        sys.exit(0)
    return file_path


def load_json(file_path):
    """加载 JSON 数据"""
    with open(file_path, "r", encoding="utf-8") as f:
        data = json.load(f)
    content = data.get("content", [])
    if not content:
        print("JSON 数据中未找到 content 数组或数据为空，退出。")
        sys.exit(0)
    return content


def ts_to_sql_datetime(ts):
    """时间戳（毫秒）转 SQL datetime 字符串"""
    if ts is None or int(ts) <= 0:
        return None
    try:
        dt = datetime.fromtimestamp(int(ts) / 1000)
        return dt.strftime("%Y-%m-%d %H:%M:%S")
    except (ValueError, TypeError, OSError):
        return None


def ts_to_sql_date(ts):
    """时间戳（毫秒）转 SQL date 字符串"""
    if ts is None or int(ts) <= 0:
        return None
    try:
        dt = datetime.fromtimestamp(int(ts) / 1000)
        return dt.strftime("%Y-%m-%d")
    except (ValueError, TypeError, OSError):
        return None


def escape_sql(value):
    """转义 SQL 字符串中的特殊字符"""
    if value is None:
        return None
    return str(value).replace("\\", "\\\\").replace("'", "\\'")


def convert_sex(sex):
    """转换性别：女->1, 男->0"""
    if not sex:
        return None
    return "1" if "女" in sex else "0"


def generate_template_sql(org_id):
    """生成通用次卡模板优惠券 + 门店关联的 SQL"""
    return [
        "-- ============================================",
        "-- 通用次卡模板优惠券 (vip_ticket)",
        "-- ============================================",
        "",
        f"INSERT INTO vip_ticket (create_time, update_time, is_delete, ticket_status, ticket_name, ticket_type, ticket_effective_time, ticket_value)",
        f"SELECT NOW(), NOW(), 0, 1, '{TEMPLATE_TICKET_NAME}', 1, -1, 0",
        f"WHERE NOT EXISTS (SELECT 1 FROM vip_ticket WHERE ticket_name = '{TEMPLATE_TICKET_NAME}' AND is_delete = 0);",
        "",
        f"-- 门店关联 (item_type=4 优惠券)",
        f"INSERT IGNORE INTO sys_org_relation (item_type, item_id, org_id)",
        f"SELECT 4, id, {org_id} FROM vip_ticket WHERE ticket_name = '{TEMPLATE_TICKET_NAME}' AND is_delete = 0;",
        "",
        f"-- 项目券关联所有门店服务项目 (vip_ticket_detail)",
        f"INSERT IGNORE INTO vip_ticket_detail (ticket_id, server_item_id)",
        f"SELECT vt.id, sor.item_id",
        f"FROM vip_ticket vt",
        f"CROSS JOIN sys_org_relation sor",
        f"WHERE vt.ticket_name = '{TEMPLATE_TICKET_NAME}' AND vt.is_delete = 0",
        f"  AND sor.item_type = 1 AND sor.org_id = {org_id};",
        "",
    ]


def extract_unique_members(cards):
    """按 memberId 去重，取最新卡记录作为会员主信息"""
    members = OrderedDict()
    for card in cards:
        mid = card.get("memberId")
        if not mid:
            continue
        if mid not in members:
            members[mid] = card
        else:
            # 取 buyDate 更新的作为主信息
            old_ts = members[mid].get("buyDate") or 0
            new_ts = card.get("buyDate") or 0
            if new_ts > old_ts:
                members[mid] = card
    return members


def generate_vip_info_sql(members, org_id):
    """生成缺失会员的 INSERT SQL（INSERT ... SELECT，不存在才插入）"""
    sql_lines = [
        "-- ============================================",
        "-- 补创建缺失会员 (vip_info)",
        "-- ============================================",
        "",
    ]

    columns = "name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time"

    for member_id, card in members.items():
        mid_str = escape_sql(str(member_id))
        name = escape_sql(card.get("memberName", ""))
        gender = convert_sex(card.get("sex", ""))
        phone = escape_sql(str(card.get("mobile", ""))[:11])
        buy_date = ts_to_sql_datetime(card.get("buyDate"))

        sql_lines.append(
            f"INSERT INTO vip_info ({columns})\n"
            f"SELECT '{name}', {gender}, '{mid_str}', '{phone}', 0.00, {org_id}, 0, '美管家次卡迁移导入', "
            + (f"'{buy_date}'" if buy_date else "NOW()") + ", NOW()\n"
            f"WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '{mid_str}' AND is_delete = 0);"
        )

    sql_lines.append("")
    return sql_lines


def generate_numbers_cte(n):
    """生成 n 行的数字序列 SELECT UNION"""
    parts = [f"SELECT {i} AS n" for i in range(1, n + 1)]
    return "(" + " UNION ALL ".join(parts) + ") nums"


def generate_vip_info_ticket_sql(cards, org_id):
    """
    生成 vip_info_ticket INSERT ... SELECT 语句
    每条 leaveTimes > 0 的次卡记录 → 一条 INSERT ... SELECT 生成 leaveTimes 行
    会员不存在时 SELECT 返回空集，自动跳过
    """
    sql_lines = [
        "-- ============================================",
        "-- 会员券实例 (vip_info_ticket)",
        "-- ============================================",
        "",
    ]

    total_instances = 0
    skipped_zero = 0

    columns = [
        "vip_info_id", "vip_ticket_id", "ticket_name", "ticket_type",
        "vip_name", "vip_phone_number", "status", "claim_time",
        "expiry_date", "ticket_code", "org_id", "source_type", "remark",
        "is_delete", "create_time", "update_time", "amount"
    ]
    col_str = ", ".join(columns)

    for card in cards:
        leave_times = int(card.get("leaveTimes", 0) or 0)
        if leave_times <= 0:
            skipped_zero += 1
            continue

        old_card_id = card.get("id", "")
        member_id = escape_sql(str(card.get("memberId", "")))
        member_name = escape_sql(card.get("memberName", ""))
        mobile = escape_sql(str(card.get("mobile", ""))[:11])
        shop_name = escape_sql(card.get("shopName", ""))
        item_name = escape_sql(card.get("itemName", ""))
        buy_date_ts = card.get("buyDate")
        claim_time = f"'{ts_to_sql_date(buy_date_ts)}'" if ts_to_sql_date(buy_date_ts) else "NULL"
        once_money = card.get("onceMoney", 0) or 0
        leave_money = card.get("leaveMoney", 0) or 0

        remark = f"美管家系统迁移-{shop_name}-{item_name}-{once_money}"

        nums_cte = generate_numbers_cte(leave_times)

        sql_lines.append(
            f"INSERT INTO vip_info_ticket ({col_str})\n"
            f"SELECT vi.id, vt.id, '{item_name}', 0, "
            f"'{member_name}', '{mobile}', 0, "
            f"{claim_time}, NULL, "
            f"CONCAT('MG{old_card_id}_', nums.n), "
            f"{org_id}, 3, '{escape_sql(remark)}', 0, NOW(), NOW(), {once_money:.2f}\n"
            f"FROM vip_info vi\n"
            f"CROSS JOIN vip_ticket vt\n"
            f"CROSS JOIN {nums_cte}\n"
            f"WHERE vi.card_number = '{member_id}' AND vi.is_delete = 0\n"
            f"  AND vt.ticket_name = '{TEMPLATE_TICKET_NAME}' AND vt.is_delete = 0;"
        )

        total_instances += leave_times

    sql_lines.append("")
    return sql_lines, total_instances, skipped_zero


def generate_snapshot_sql(cards, org_id):
    """生成 vip_migrate_card_snapshot INSERT 语句"""
    columns = [
        "old_card_id", "old_member_id", "item_id", "item_name",
        "sum_times", "leave_times", "sum_money", "leave_money", "once_money",
        "buy_date", "last_consume_time", "emp_saler_names", "emp_saler_ids",
        "shop_name", "sex", "mobile", "org_id"
    ]

    values = []
    for card in cards:
        old_card_id = card.get("id", "")
        member_id = card.get("memberId", "")
        item_id = escape_sql(str(card.get("itemId", "")))
        item_name = escape_sql(card.get("itemName", ""))
        sum_times = int(card.get("sumTimes", 0) or 0)
        leave_times = int(card.get("leaveTimes", 0) or 0)
        sum_money = float(card.get("sumMoney", 0) or 0)
        leave_money = float(card.get("leaveMoney", 0) or 0)
        once_money = float(card.get("onceMoney", 0) or 0)
        buy_date = ts_to_sql_datetime(card.get("buyDate"))
        last_consume = ts_to_sql_datetime(card.get("lastConsumeTime"))
        emp_saler_names = escape_sql(card.get("empSalerNames", ""))
        emp_saler_ids = escape_sql(card.get("empSalerIds", ""))
        shop_name = escape_sql(card.get("shopName", ""))
        sex = escape_sql(card.get("sex", ""))
        mobile = escape_sql(str(card.get("mobile", ""))[:20])

        vals = [
            str(old_card_id),
            str(member_id) if member_id else "NULL",
            f"'{item_id}'",
            f"'{item_name}'",
            str(sum_times),
            str(leave_times),
            f"{sum_money:.2f}",
            f"{leave_money:.2f}",
            f"{once_money:.2f}",
            f"'{buy_date}'" if buy_date else "NULL",
            f"'{last_consume}'" if last_consume else "NULL",
            f"'{emp_saler_names}'",
            f"'{emp_saler_ids}'",
            f"'{shop_name}'",
            f"'{sex}'",
            f"'{mobile}'",
            str(org_id)
        ]
        values.append(f"({', '.join(vals)})")

    return columns, values


def main():
    print("=" * 60)
    print("美管家系统次卡数据导入工具")
    print("=" * 60)

    # 1. 选择文件
    json_file = select_json_file()
    print(f"已选择文件: {json_file}")

    # 2. 输入门店 ID
    org_id = input("请输入门店 org_id: ").strip()
    if not org_id:
        print("org_id 不能为空，退出。")
        sys.exit(1)

    # 3. 输出文件路径
    output_file = input("请输入输出 SQL 文件路径 (默认: ./import_cure_ticket.sql): ").strip()
    if not output_file:
        output_file = "./import_cure_ticket.sql"

    # 4. 加载数据
    print("\n正在加载数据...")
    cards = load_json(json_file)
    print(f"读取到 {len(cards)} 条次卡记录")

    # 5. 提取唯一会员
    members = extract_unique_members(cards)
    print(f"涉及 {len(members)} 个唯一会员")

    # 6. 生成各部分 SQL
    template_sql = generate_template_sql(org_id)
    vip_info_sql = generate_vip_info_sql(members, org_id)
    ticket_sql, total_instances, skipped_zero = generate_vip_info_ticket_sql(cards, org_id)
    snapshot_columns, snapshot_values = generate_snapshot_sql(cards, org_id)

    # 7. 组装 SQL 文件
    now_str = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    sql_lines = [
        f"-- 美管家系统次卡数据导入 SQL",
        f"-- 生成时间: {now_str}",
        f"-- 源文件: {os.path.basename(json_file)}",
        f"-- 门店 org_id: {org_id}",
        f"-- 原始次卡数: {len(cards)}",
        f"-- 唯一会员数: {len(members)}",
        f"-- 生成券实例数: {total_instances}",
        f"-- 跳过(剩余次数=0): {skipped_zero}",
        f"-- 快照记录数: {len(snapshot_values)}",
        "",
        "START TRANSACTION;",
        "",
    ]

    sql_lines.extend(template_sql)
    sql_lines.extend(vip_info_sql)
    sql_lines.extend(ticket_sql)

    sql_lines.extend([
        "-- ============================================",
        "-- 迁移快照 (vip_migrate_card_snapshot)",
        "-- ============================================",
        "",
    ])

    if snapshot_values:
        col_str = ", ".join(snapshot_columns)
        for i in range(0, len(snapshot_values), 500):
            batch = snapshot_values[i:i + 500]
            sql_lines.append(
                f"INSERT INTO vip_migrate_card_snapshot ({col_str}) VALUES\n"
                + ",\n".join(batch) + ";\n"
            )

    sql_lines.extend(["", "COMMIT;", ""])

    # 8. 写入文件
    with open(output_file, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_lines))

    # 9. 输出统计
    print("\n" + "=" * 60)
    print("导入统计")
    print("=" * 60)
    print(f"原始次卡数:           {len(cards)}")
    print(f"唯一会员数:           {len(members)}")
    print(f"跳过(剩余次数=0):     {skipped_zero}")
    print(f"生成券实例数:         {total_instances}")
    print(f"快照记录数:           {len(snapshot_values)}")
    print(f"\nSQL 文件已生成: {os.path.abspath(output_file)}")
    print("=" * 60)


if __name__ == "__main__":
    main()
