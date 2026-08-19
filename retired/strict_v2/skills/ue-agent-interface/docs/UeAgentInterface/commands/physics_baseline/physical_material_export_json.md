---
command: physical_material_export_json
category: physics_baseline
title: 指令总览
summary: 导出 `UPhysicalMaterial` 单文件 JSON
aliases: []
tags: [physics_baseline]
status: active
---

# `physical_material_export_json`

## LLM Compact

- status: active.
- purpose: 导出 `UPhysicalMaterial` 单文件 JSON
- key_inputs: `asset_path`, `output_file`
- key_returns: `schema`, `asset_path`, `output_file`, `properties`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。

## Returns

- `schema`：返回 payload schema。
- `asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `output_file`：文件路径字段；长 JSON/结果优先走文件。
- `properties`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
