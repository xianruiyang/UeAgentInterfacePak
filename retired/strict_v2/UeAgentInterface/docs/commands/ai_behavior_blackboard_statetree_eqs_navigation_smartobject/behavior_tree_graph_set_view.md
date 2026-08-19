---
command: behavior_tree_graph_set_view
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Behavior Tree
summary: 请求图视图位置
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `behavior_tree_graph_set_view`

## LLM Compact

- status: active.
- purpose: 请求图视图位置
- key_inputs: `asset_path`, `open_editor_if_needed`, `snap_to_pixel_grid`, `view_x`, `view_y`, `zoom`
- key_returns: `snap_to_pixel_grid`, `view_requested`, `view_x`, `y`, `zoom`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `open_editor_if_needed`：资产预览命令是否允许打开编辑器；高风险 adapter 可能拒绝自动打开。
- `snap_to_pixel_grid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `view_x`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `view_y`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `zoom`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `snap_to_pixel_grid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `view_requested`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `view_x`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `y`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `zoom`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
