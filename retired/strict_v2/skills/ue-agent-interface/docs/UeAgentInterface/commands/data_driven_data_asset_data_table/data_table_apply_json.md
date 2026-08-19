---
command: data_table_apply_json
category: data_driven_data_asset_data_table
title: DataTable
summary: 创建或回写 DataTable
aliases: []
tags: [data_driven_data_asset_data_table]
status: active
---

# `data_table_apply_json`

## LLM Compact

- status: active.
- purpose: 创建或回写 DataTable
- key_inputs: `asset_path`, `backup`, `create_if_missing`, `row_policy`, `row_struct`, `save_after_apply`
- key_returns: `applied_row_count`, `backup_asset_path`, `destructive`, `read_back_hash`, `removed_row_count`, `row_results[]`
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- `rows[].fields[]` 使用 `property_path`、精确 `value_kind` 和 canonical `value`；每个 row 在写入前完整预检。
- apply 忽略公共 metadata，只消费字段身份和值。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `backup`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `create_if_missing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `row_policy`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `row_struct`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_apply`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `applied_row_count`：数量摘要。
- `backup_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `destructive`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `read_back_hash`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `removed_row_count`：数量摘要。
- `row_results[]`：row_results 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
