---
command: project_settings_diff_page
category: project_settings_config
title: Project Settings
summary: 只读比较 v2 properties 与当前 Settings 值
aliases: []
tags: [project_settings_config]
status: active
---

# `project_settings_diff_page`

使用与 validate 相同的严格 v2 输入，生成 proposed value 与当前 Settings 值的结构化差异，不落盘。

## Parameters

- `section_id`
- `property_schema: uai.uobject_properties.v2`
- `properties[]`，或 `json_file`
- `base_property_schema_hash`（可选）

## Returns

- `valid`、`changed`
- `property_diffs[]`
- `property_results[]`
- `errors[]`、`warnings[]`

比较由公共 codec 解码后的真实 FProperty 值完成，不比较 HJSON 文本格式。
