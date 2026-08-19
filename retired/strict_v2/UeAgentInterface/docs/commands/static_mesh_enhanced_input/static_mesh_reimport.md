---
command: static_mesh_reimport
category: static_mesh_enhanced_input
title: StaticMesh 文件夹式 HJSON 主流程
summary: 自动化重导入 StaticMesh
aliases: []
tags: [static_mesh_enhanced_input]
status: active
---

# `static_mesh_reimport`

## LLM Compact

- status: active.
- purpose: 自动化重导入 StaticMesh
- key_inputs: `asset_path`, `allow_reimport`, `save_after_reimport`, `show_notification`, `source_filename`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
- note: 重导入会替换 Static Mesh 的导入结果；`allow_reimport` 默认 false，未显式设为 true 时返回 `allow_reimport_required`。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `allow_reimport`：重导入确认；默认 `false`，执行重导入必须显式设为 `true`。
- `save_after_reimport`：布尔/开关字段；默认值以本命令契约为准。
- `show_notification`：布尔/开关字段；默认值以本命令契约为准。
- `source_filename`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
