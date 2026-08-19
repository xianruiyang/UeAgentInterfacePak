---
command: ik_retargeter_auto_map_chains
category: ikrig_ikretargeter
title: IK Retargeter
summary: 对 retargeter op stack 自动做链映射
aliases: []
tags: [ikrig_ikretargeter]
status: active
---

# `ik_retargeter_auto_map_chains`

## LLM Compact

- status: active.
- purpose: 对 retargeter op stack 自动做链映射
- key_inputs: `asset_path`, `auto_map_type=exact/fuzzy/clear`, `force_remap`, `op_name`, `save_after_set`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `auto_map_type=exact/fuzzy/clear`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `force_remap`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `op_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
