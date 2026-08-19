---
command: project_settings_validate_page
category: project_settings_config
title: Project Settings
summary: 只读校验 v2 properties 是否可按当前 Settings schema 写入
aliases: []
tags: [project_settings_config]
status: active
---

# `project_settings_validate_page`

执行与 apply 相同的 descriptor、类型、canonical value、风险和 schema preflight，但不修改 Settings UObject 或配置文件。

## Parameters

- `section_id`
- `property_schema: uai.uobject_properties.v2`
- `properties[]`，或 `json_file`
- `base_property_schema_hash`（可选，提供时严格匹配）
- `allow_high_risk`、`fail_on_requires_restart`

## Returns

- `valid`
- `error_count`
- `property_results[]`
- `changes[]`
- `errors[]`、`warnings[]`
- `properties_applied: 0`

校验不接受旧属性 identity、旧 value shape 或 `value_text` fallback。
