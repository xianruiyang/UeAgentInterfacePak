---
command: ik_retargeter_duplicate_and_retarget
category: ikrig_ikretargeter
title: IK Retargeter
summary: 批量复制并重定向动画资产
aliases: []
tags: [ikrig_ikretargeter]
status: active
---

# `ik_retargeter_duplicate_and_retarget`

## LLM Compact

- status: active.
- purpose: 批量复制并重定向动画资产
- key_inputs: `asset_path`, `asset_paths[]`, `include_referenced_assets`, `output_folder`, `prefix`, `replace`, `search`, `source_mesh_path` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `asset_paths[]`：asset_paths 列表。
- `include_referenced_assets`：布尔/开关字段；默认值以本命令契约为准。
- `output_folder`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `prefix`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `replace`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `search`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `source_mesh_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `suffix`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_mesh_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
