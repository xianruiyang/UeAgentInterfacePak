---
command: project_settings_export_page
category: project_settings_config
title: Project Settings
summary: 导出 Settings 页的 v2 UObject 属性 authoring 文件
aliases: []
tags: [project_settings_config]
status: active
---

# `project_settings_export_page`

导出指定 Settings 页的全部可编辑属性。属性面固定使用 `uai.uobject_properties.v2`，不输出 `fields/values/fields_array`。

## Parameters

- `section_id`：由 `project_settings_export_index` 返回的稳定页 id。
- `container`、`category`、`section`：没有 `section_id` 时用于精确定位页。
- `write_file`：是否写出 HJSON；默认 true。
- `output_file`：目标 `.hjson` 文件。
- `output_directory`：未指定 `output_file` 时的输出根目录。
- `include_raw_config`：显式加入 raw config 诊断；默认 false，不属于属性 authoring 面。

## Returns

- `schema: ue_agent.project_settings.page.v2`
- `property_schema: uai.uobject_properties.v2`
- `properties[]`：标准 v2 descriptor。
- `property_schema_hash`：当前可编辑属性 schema hash。
- `page_value_hash`：当前属性值 hash。
- `section_info`、`capabilities`、`settings_object`：页身份和领域能力。

Project Settings 的 `constraints` 可附带 `requires_restart`、`requires_config_reload` 和 `high_risk`。这些是领域写入约束，不改变通用 value schema。

## Validation

写文件时确认返回路径存在并可重新解析；持续编辑后使用 `project_settings_validate_page`，apply 后读取 `read_back.properties[]`。
