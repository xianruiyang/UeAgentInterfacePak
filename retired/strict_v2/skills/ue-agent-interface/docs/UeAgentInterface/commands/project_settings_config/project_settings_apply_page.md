---
command: project_settings_apply_page
category: project_settings_config
title: Project Settings
summary: 原子回写 Settings UObject、保存配置并读回
aliases: []
tags: [project_settings_config]
status: active
---

# `project_settings_apply_page`

输入只接受标准 v2 `properties[]` 或包含该数组的导出 HJSON 文件。旧 `values/fields/patch`、未知属性保留和按字段 schema 兼容应用均不支持。

## Parameters

- `section_id`：Settings 页 id。
- `property_schema: uai.uobject_properties.v2`：inline 输入建议显式提供；导出文件中必填。
- `properties[]`：标准 v2 descriptor；`property_path` 必须唯一。
- `json_file`：`project_settings_export_page` 产生并经编辑的 `.hjson` 文件。
- `base_property_schema_hash`：可选；提供时必须等于当前 `property_schema_hash`。
- `dry_run`：apply 命令默认 true；真实写入必须显式 false。
- `backup`：保存前备份 config 文件；默认 true。
- `read_back`：成功后返回重新导出的页；默认 true。
- `allow_high_risk`：高风险设置真实写入门禁；默认 false。
- `fail_on_requires_restart`：遇到需要重启的变更时阻断。

## Semantics

全部 descriptor 先完成严格 shape、真实 FProperty、`value_kind`、canonical value、风险和 schema 校验。任一项失败时不写入任何属性。提交后逐项读回；读回或 config 保存失败时恢复整组旧值。

## Returns

- `success`、`valid`、`changed`
- `properties_applied`
- `property_results[]`
- `changes[]`、`errors[]`、`warnings[]`
- `read_back`
- `requires_restart`、`requires_config_reload` 等影响摘要
- `backup_file`（实际创建备份时）

不能只依据 HTTP 或 wrapper success 验收；必须检查 `success/valid` 并读取 `read_back.properties[]`。
