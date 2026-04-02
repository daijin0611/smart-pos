-- V1.0.9__alter_sys_org_user_pk.sql
-- 调整 sys_org_user 表主键顺序为 (usr_id, org_id)，优化用户维度的查询性能

ALTER TABLE sys_org_user
    DROP PRIMARY KEY,
    DROP FOREIGN KEY fk_sys_org_user_sys_org_1,
    DROP FOREIGN KEY fk_sys_org_user_sys_user_1;

ALTER TABLE sys_org_user
    ADD PRIMARY KEY (usr_id, org_id),
    ADD CONSTRAINT fk_sys_org_user_sys_org FOREIGN KEY (org_id) REFERENCES sys_org(id),
    ADD CONSTRAINT fk_sys_org_user_sys_user FOREIGN KEY (usr_id) REFERENCES sys_user(id);

-- 已在测试环境执行：2026-04-02
-- 生产环境已更新：2026/4/2