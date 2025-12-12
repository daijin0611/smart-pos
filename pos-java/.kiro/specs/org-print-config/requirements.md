# Requirements Document

## Introduction

为门店（机构）实体添加"打印宽度"字段，用于配置门店小票打印的纸张宽度。该字段为整型，默认值为58（毫米），并提供独立的接口用于修改打印宽度配置。

## Glossary

- **SysOrg（门店/机构）**: 系统中的组织机构实体，代表一个门店或分店
- **打印宽度（Print Width）**: 小票打印纸张的宽度，单位为毫米，常见值为58mm或80mm
- **小票打印**: 订单结算后打印的收据/小票

## Requirements

### Requirement 1

**User Story:** As a 门店管理员, I want to 为门店配置打印宽度, so that 系统可以根据门店的打印机纸张宽度正确打印小票。

#### Acceptance Criteria

1. WHEN 创建门店时未提供打印宽度 THEN THE SysOrg系统 SHALL 使用默认值58作为打印宽度
2. WHEN 查询门店信息时 THEN THE SysOrg系统 SHALL 返回包含打印宽度的完整门店信息
3. WHEN 打印宽度字段存储到数据库时 THEN THE SysOrg系统 SHALL 使用整型字段存储

### Requirement 2

**User Story:** As a 门店管理员, I want to 通过独立接口修改门店的打印宽度, so that 可以在不修改其他门店信息的情况下更新打印配置。

#### Acceptance Criteria

1. WHEN 调用修改打印宽度接口并提供有效的门店ID和打印宽度值 THEN THE SysOrg系统 SHALL 更新该门店的打印宽度
2. WHEN 调用修改打印宽度接口但门店ID不存在 THEN THE SysOrg系统 SHALL 返回错误提示
3. WHEN 修改打印宽度成功后 THEN THE SysOrg系统 SHALL 返回操作成功的响应
