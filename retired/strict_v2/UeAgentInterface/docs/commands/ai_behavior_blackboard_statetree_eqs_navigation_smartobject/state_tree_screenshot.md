---
command: state_tree_screenshot
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: StateTree
summary: 截取 StateTree 编辑器
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `state_tree_screenshot`

## LLM Compact

- status: active.
- purpose: 截取 StateTree 编辑器
- key_inputs: `asset_path`, `format`, `max_size`, `open_editor_if_needed`, `require_non_black`
- key_returns: `file_path`, `height`, `width`, `appears_non_black`, `capture_mode=offscreen_widget_renderer`, `legacy_backbuffer_capture=disabled`, `non_black_pixel_count`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `format`：输出格式，例如 png/json/csv，取决于命令支持。
- `max_size`：截图或导出尺寸上限。
- `open_editor_if_needed`：资产预览命令是否允许打开编辑器；高风险 adapter 可能拒绝自动打开。
- `require_non_black`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `file_path`：生成的 artifact 文件路径。
- `height`：输出图片高度。
- `width`：输出图片宽度。
- `appears_non_black`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `capture_mode=offscreen_widget_renderer`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `legacy_backbuffer_capture=disabled`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `non_black_pixel_count`：数量摘要。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
