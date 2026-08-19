---
command: data_asset_apply_json
category: data_driven_data_asset_data_table
title: DataAsset / PrimaryDataAsset
summary: 预检通过后创建或回写 DataAsset
aliases: []
tags: [data_driven_data_asset_data_table]
status: active
---

# `data_asset_apply_json`

## LLM Compact

- status: active.
- purpose: 预检通过后创建或回写 DataAsset
- key_inputs: `asset_path`, `json_file`, `backup`, `create_if_missing`, `json`, `save_after_apply`, `validate_references`
- key_returns: `applied_field_count`, `backup_asset_path`, `field_results[]`, `read_back_hash`
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- `json.fields[]` 使用 `property_path`、精确 `value_kind` 和 canonical `value`；不接受 `value_text`、`name` 或未知字段跳过。
- apply 严格校验 descriptor 字段、`value_kind` 和递归类型元数据；未知字段或与实际 `FProperty` 不一致时，整个 owner apply 在提交前失败。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `backup`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `create_if_missing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_apply`：布尔/开关字段；默认值以本命令契约为准。
- `validate_references`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `applied_field_count`：数量摘要。
- `backup_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `field_results[]`：field_results 列表摘要；大列表应写入 output/artifact 或 debug。
- `read_back_hash`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
