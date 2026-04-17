"""
杨波采耳老系统会员数据导入脚本

读取 export_vip_data.py 导出的 JSON 文件，生成 SQL 导入语句。
导入顺序: 会员(vip_info) → 会员卡(vip_asset) → 次卡模板(vip_ticket) → 优惠券(vip_info_ticket)

字段映射:
  - 老系统会员ID → 新系统会员编号(cardNumber)
  - awardedFin → assetType (0充值, 1赠送)
  - 优惠券全部映射为项目券(ticketType=6)，面额取 useLimitRule.value
"""

import json
import os
import sys
import time
from collections import defaultdict

BATCH_SIZE = 500
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SQL_DIR = os.path.join(SCRIPT_DIR, "..", "..", "sql")


def load_json(path):
    """加载JSON"""
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def sql_str(val):
    """SQL字符串转义，None或空字符串返回NULL"""
    if val is None or val == "":
        return "NULL"
    return "'" + str(val).replace("'", "''").replace("\\", "\\\\") + "'"


def to_date(val):
    """提取日期部分 (yyyy-MM-dd)"""
    if not val:
        return None
    return val[:10] if len(val) > 10 else val


def parse_amount(use_limit_rule):
    """从 useLimitRule JSON 解析面额 value"""
    if not use_limit_rule:
        return 0
    try:
        rule = json.loads(use_limit_rule) if isinstance(use_limit_rule, str) else use_limit_rule
        return float(rule.get("value", 0))
    except (json.JSONDecodeError, TypeError, ValueError):
        return 0


def main():
    print("=" * 60)
    print("杨波采耳老系统 - 会员数据导入工具")
    print("=" * 60)

    # ---- 参数输入 ----
    org_id = input("\n请输入新系统门店 orgId: ").strip()
    store_name = input("请输入店名: ").strip()
    template_name = f"{store_name}杨波导入次卡模板"

    # ---- 加载JSON ----
    members = load_json(os.path.join(SCRIPT_DIR, "vip_info.json"))
    cards = load_json(os.path.join(SCRIPT_DIR, "vip_asset.json"))
    coupons = load_json(os.path.join(SCRIPT_DIR, "vip_info_ticket.json"))

    # ---- 加载排除名单 ----
    filter_path = os.path.join(SCRIPT_DIR, "jiudian_vip_filter.json")
    exclude_phones = set()
    if os.path.exists(filter_path):
        filter_list = load_json(filter_path)
        exclude_phones = {(m.get("cellPhoneNo") or "").strip() for m in filter_list}
        print(f"  排除名单: {len(exclude_phones)} 个手机号")
    else:
        print(f"  未找到排除名单文件，跳过过滤")

    # ---- 排除会员 ----
    before = len(members)
    members = [m for m in members if (m.get("cellPhoneNo") or "").strip() not in exclude_phones]
    print(f"  会员: {before} → {len(members)} 条 (排除 {before - len(members)})")
    print(f"  会员卡: {len(cards)} 条")
    print(f"  优惠券: {len(coupons)} 条")

    # ==========================================================
    # 处理会员: 按 cellPhoneNo 去重，保留 updateTime 最新的记录
    # ==========================================================
    phone_member = {}   # phone -> member (保留的那条)
    id_to_phone = {}    # old_member_id -> phone
    for m in members:
        phone = (m.get("cellPhoneNo") or "").strip()
        mid = m.get("id")
        if not phone or not mid:
            continue
        id_to_phone[mid] = phone
        existing = phone_member.get(phone)
        if not existing or (m.get("updateTime") or "") > (existing.get("updateTime") or ""):
            phone_member[phone] = m

    # phone -> cardNumber (老系统 memberId)
    phone_to_card = {phone: str(m["id"]) for phone, m in phone_member.items()}
    # 所有老 memberId -> 保留的 cardNumber
    old_id_to_card = {mid: phone_to_card[phone] for mid, phone in id_to_phone.items()}

    # 计算每个手机的余额 (汇总所有卡的 totalBalance)
    phone_balance = defaultdict(float)
    for c in cards:
        phone = id_to_phone.get(c.get("memberId"))
        if phone is not None:
            phone_balance[phone] += float(c.get("totalBalance") or 0)

    # ==========================================================
    # 生成 SQL
    # ==========================================================
    sql = []
    sql.append(f"-- 杨波采耳会员数据导入\n")
    sql.append(f"-- 门店: {store_name} (orgId={org_id})\n")
    sql.append(f"-- 生成时间: {time.strftime('%Y-%m-%d %H:%M:%S')}\n")
    sql.append(f"-- 模板名称: {template_name}\n\n")
    sql.append("START TRANSACTION;\n\n")

    # ---- 1. vip_info (会员信息) ----
    print("\n[1/4] 生成会员信息 SQL...")
    vip_cols = [
        "card_number", "name", "gender", "phone_number", "balance",
        "birthday", "pwd", "org_id",
        "last_consumption_time", "last_recharge_time",
        "create_time", "update_time", "is_delete", "remark",
    ]
    vip_vals = []
    for phone, m in phone_member.items():
        card = phone_to_card[phone]
        balance = round(phone_balance.get(phone, 0), 2)
        gender = 1 if m.get("sexuality") == 95 else 0  # 95女→1, 97男→0, 其他→0
        name = (m.get("memName") or "").strip()
        birthday = to_date(m.get("birthDate"))
        ct = m.get("createTime") or m.get("updateTime")
        ut = m.get("updateTime") or ct
        last_cons = to_date(m.get("lastConsumptionTime"))
        last_rech = to_date(m.get("lastRechargeTime"))

        # 构建会员remark: 保留老系统的业务备注
        old_remark = (m.get("remark") or "").strip()
        remark_parts = [f"{store_name}老系统导入"]
        if old_remark and old_remark != "系统导入创建会员":
            remark_parts.append(old_remark)
        vip_remark = "; ".join(remark_parts)

        vip_vals.append(
            f"({sql_str(card)}, {sql_str(name)}, {gender}, {sql_str(phone)}, "
            f"{balance}, {sql_str(birthday)}, {sql_str('123456')}, {org_id}, "
            f"{sql_str(last_cons)}, {sql_str(last_rech)}, "
            f"{sql_str(ct)}, {sql_str(ut)}, 0, {sql_str(vip_remark)})"
        )

    for i in range(0, len(vip_vals), BATCH_SIZE):
        batch = vip_vals[i:i + BATCH_SIZE]
        sql.append(f"-- 会员 ({i + 1}-{min(i + BATCH_SIZE, len(vip_vals))})\n")
        sql.append(f"INSERT IGNORE INTO vip_info ({', '.join(vip_cols)}) VALUES\n")
        sql.append(",\n".join(batch) + ";\n\n")
    print(f"  {len(vip_vals)} 条会员 INSERT")

    # ---- 2. vip_asset (会员卡) ----
    print("\n[2/4] 生成会员卡 SQL...")
    asset_cols = [
        "vip_id", "vip_card_number", "asset_num", "asset_name",
        "asset_balance", "asset_type", "asset_discount_base", "asset_discount_rate",
        "asset_is_cross_store", "asset_card_number", "org_id",
        "create_time", "update_time", "is_delete", "remark", "version",
    ]
    asset_vals = []
    skip_asset = 0
    for c in cards:
        mid = c.get("memberId")
        card = old_id_to_card.get(mid)
        if not card:
            skip_asset += 1
            continue

        balance = round(float(c.get("totalBalance") or 0), 2)
        awarded = int(c.get("awardedFin") or 0)
        asset_name = "赠送金" if awarded == 1 else "充值金"
        fin_no = c.get("finNo") or str(c.get("finId") or mid)
        asset_num = str(c.get("finId") or mid)
        disc_base = int(c.get("discountBaseType") or 0)
        disc_rate = c.get("discountRate") if c.get("discountRate") else 100
        cross = int(c.get("allowCrossStore") or 0)
        entity = c.get("entityCardNo") or ""
        ct = c.get("createTime")

        # 构建会员卡remark: 保留老系统门店和卡号信息
        asset_remark_parts = [f"{store_name}老系统导入"]
        old_org_name = (c.get("orgName") or "").strip()
        if old_org_name:
            asset_remark_parts.append(f"原门店: {old_org_name}")
        if fin_no:
            asset_remark_parts.append(f"原卡号: {fin_no}")
        asset_remark = "; ".join(asset_remark_parts)

        # vip_id 通过 cardNumber 子查询获取
        sub_vip = f"(SELECT vi.id FROM vip_info vi WHERE vi.card_number = {sql_str(card)} AND vi.org_id = {org_id} LIMIT 1)"

        asset_vals.append(
            f"({sub_vip}, {sql_str(card)}, {sql_str(asset_num)}, {sql_str(asset_name)}, "
            f"{balance}, {awarded}, {disc_base}, {disc_rate}, "
            f"{cross}, {sql_str(entity)}, {org_id}, "
            f"{sql_str(ct)}, {sql_str(ct)}, 0, {sql_str(asset_remark)}, 0)"
        )

    for i in range(0, len(asset_vals), BATCH_SIZE):
        batch = asset_vals[i:i + BATCH_SIZE]
        sql.append(f"-- 会员卡 ({i + 1}-{min(i + BATCH_SIZE, len(asset_vals))})\n")
        sql.append(f"INSERT INTO vip_asset ({', '.join(asset_cols)}) VALUES\n")
        sql.append(",\n".join(batch) + ";\n\n")
    print(f"  {len(asset_vals)} 条会员卡 INSERT (跳过 {skip_asset})")

    # ---- 3. vip_ticket (次卡模板) ----
    print("\n[3/4] 生成次卡模板 SQL...")
    sql.append("-- 次卡模板\n")
    sql.append(
        f"INSERT INTO vip_ticket (create_time, update_time, is_delete, "
        f"ticket_status, ticket_name, ticket_type, ticket_effective_time, "
        f"ticket_full_payment, ticket_value, remark)\n"
        f"SELECT NOW(), NOW(), 0, 0, {sql_str(template_name)}, 1, -1, 0, 0, "
        f"{sql_str('杨波老系统导入模板')}\n"
        f"WHERE NOT EXISTS (\n"
        f"  SELECT 1 FROM vip_ticket WHERE ticket_name = {sql_str(template_name)} AND is_delete = 0\n"
        f");\n\n"
    )
    # 模板-门店关联
    sql.append("-- 模板-门店关联\n")
    sql.append(
        f"INSERT IGNORE INTO sys_org_relation (item_type, item_id, org_id)\n"
        f"SELECT 4, vt.id, {org_id} FROM vip_ticket vt "
        f"WHERE vt.ticket_name = {sql_str(template_name)} AND vt.is_delete = 0;\n\n"
    )
    # 模板-服务项目关联
    sql.append("-- 模板-服务项目关联\n")
    sql.append(
        f"INSERT IGNORE INTO vip_ticket_detail (ticket_id, server_item_id)\n"
        f"SELECT vt.id, sor.item_id FROM vip_ticket vt\n"
        f"CROSS JOIN sys_org_relation sor ON sor.item_type = 1 AND sor.org_id = {org_id}\n"
        f"WHERE vt.ticket_name = {sql_str(template_name)} AND vt.is_delete = 0;\n\n"
    )
    print(f"  模板: {template_name}")

    # ---- 4. vip_info_ticket (优惠券 → 项目券实例) ----
    print("\n[4/4] 生成优惠券 SQL...")
    ticket_cols = [
        "vip_info_id", "vip_ticket_id", "ticket_type", "ticket_name",
        "amount", "ticket_code",
        "vip_name", "vip_phone_number", "vip_card_number",
        "status", "claim_time", "expiry_date",
        "org_id", "source_type", "source_code",
        "create_time", "update_time", "is_delete", "remark",
    ]
    ticket_vals = []
    skip_ticket = 0
    for cp in coupons:
        mid = cp.get("memberId")
        card = old_id_to_card.get(mid)
        if not card:
            skip_ticket += 1
            continue

        # 解析面额
        def_info = cp.get("couponDefInfo") or {}
        amount = parse_amount(def_info.get("useLimitRule"))

        coupon_no = cp.get("couponNo") or ""
        old_status = cp.get("status")
        new_status = 0 if old_status == 0 else 1  # 0未使用 → 0, 其他 → 1已使用
        get_time = to_date(cp.get("getTime"))
        limit_time = to_date(cp.get("limitTime"))
        ct = cp.get("updateTime") or cp.get("getTime")

        # 会员信息
        phone = id_to_phone.get(mid, "")
        member_data = phone_member.get(phone, {})
        vip_name = (member_data.get("memName") or "").strip()

        # 构建优惠券remark: 保留老系统完整信息
        old_coupon_name = (def_info.get("couponName") or "").strip()
        remark_parts = [f"{store_name}老系统导入"]
        if old_coupon_name:
            remark_parts.append(f"原券名: {old_coupon_name}")
        if coupon_no:
            remark_parts.append(f"原券号: {coupon_no}")
        remark = "; ".join(remark_parts)

        # 子查询
        sub_vip = f"(SELECT vi.id FROM vip_info vi WHERE vi.card_number = {sql_str(card)} AND vi.org_id = {org_id} LIMIT 1)"
        sub_ticket = f"(SELECT vt.id FROM vip_ticket vt WHERE vt.ticket_name = {sql_str(template_name)} AND vt.is_delete = 0 LIMIT 1)"

        ticket_vals.append(
            f"({sub_vip}, {sub_ticket}, 1, {sql_str(template_name)}, "
            f"{round(amount, 2)}, {sql_str(coupon_no)}, "
            f"{sql_str(vip_name)}, {sql_str(phone)}, {sql_str(card)}, "
            f"{new_status}, {sql_str(get_time)}, {sql_str(limit_time)}, "
            f"{org_id}, 3, {sql_str(str(cp.get('id') or ''))}, "
            f"{sql_str(ct)}, {sql_str(ct)}, 0, {sql_str(remark)})"
        )

    for i in range(0, len(ticket_vals), BATCH_SIZE):
        batch = ticket_vals[i:i + BATCH_SIZE]
        sql.append(f"-- 优惠券 ({i + 1}-{min(i + BATCH_SIZE, len(ticket_vals))})\n")
        sql.append(f"INSERT INTO vip_info_ticket ({', '.join(ticket_cols)}) VALUES\n")
        sql.append(",\n".join(batch) + ";\n\n")
    print(f"  {len(ticket_vals)} 条优惠券 INSERT (跳过 {skip_ticket})")

    # ---- 完成 ----
    sql.append("COMMIT;\n")

    os.makedirs(SQL_DIR, exist_ok=True)
    output_path = os.path.join(SQL_DIR, "import_yb_vip.sql")
    with open(output_path, "w", encoding="utf-8") as f:
        f.write("".join(sql))

    print(f"\n{'=' * 60}")
    print("SQL文件已保存")
    print(f"{'=' * 60}")
    print(f"  文件: {output_path}")
    print(f"  会员:  {len(vip_vals)} 条")
    print(f"  会员卡: {len(asset_vals)} 条")
    print(f"  优惠券: {len(ticket_vals)} 条")
    print(f"{'=' * 60}")


if __name__ == "__main__":
    main()
