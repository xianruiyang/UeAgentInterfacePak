---
command: control_rig_graph_set_view
category: control_rig_folder_format
title: Control Rig 命令
summary: 设置图视图
aliases: []
tags: [control_rig_folder_format]
status: active
---

# `control_rig_graph_set_view`

## LLM Compact

- status: active.
- purpose: 设置图视图
- key_inputs: `asset_path`, `graph_name_or_path`, `save_after_set`, `snap_to_pixel_grid`, `update_document_view_state`, `view_x`, `view_y`, `zoom`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `graph_name_or_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。
- `snap_to_pixel_grid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `update_document_view_state`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `view_x`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `view_y`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `zoom`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
