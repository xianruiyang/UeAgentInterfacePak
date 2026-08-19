---
command: control_rig_create
category: control_rig_folder_format
title: `control_rig_create`
summary: 创建 Control Rig Blueprint
aliases: []
tags: [control_rig_folder_format]
status: active
---

# `control_rig_create`

## LLM Compact

- status: active.
- purpose: 创建 Control Rig Blueprint
- key_inputs: `asset_path`, `control_rig_type`, `import_hierarchy_from_preview`, `preview_skeletal_mesh`, `save_after_create`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `control_rig_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `import_hierarchy_from_preview`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `preview_skeletal_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
