---
command: physical_material_apply_json
category: physics_baseline
title: 指令总览
summary: 创建或更新 PhysicalMaterial 并读回
aliases: []
tags: [physics_baseline]
status: active
---

# `physical_material_apply_json`

## LLM Compact

- status: active.
- purpose: 创建或更新 PhysicalMaterial 并读回
- key_inputs: `json_file`, `backup`, `create_if_missing`, `json`, `save_after_apply`
- key_returns: `asset_created`, `backup_created`, `property_results[]`, `readback`, `readback_hash`
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。

## Parameters

- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `backup`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `create_if_missing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_apply`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `asset_created`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `backup_created`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `property_results[]`：property_results 列表摘要；大列表应写入 output/artifact 或 debug。
- `readback`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `readback_hash`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
