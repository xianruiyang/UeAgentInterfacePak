---
command: niagara_preview_advance
category: niagara_system
title: `niagara_preview_advance`
summary: 连续推进 Niagara 编辑器预览并暂停
aliases: []
tags: [niagara_system]
status: active
---

# `niagara_preview_advance`

## LLM Compact

- status: active.
- purpose: 连续推进 Niagara 编辑器预览并暂停
- key_inputs: `asset_path`, `open_editor_if_needed`, `target_frame`, `tick_delta_seconds`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 序列帧、预览截图和资产预览应沿用统一 `visual_options` 与 `preview_state` 语义。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 记录返回的 `preview_state_token` 后，再调用只读 probe 和截图。
- note: `open_editor_if_needed` 默认 false；没有已打开的兼容编辑器时不会隐式打开窗口。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 序列帧、预览截图和资产预览应沿用统一 `visual_options` 与 `preview_state` 语义。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- 记录返回的 `preview_state_token` 后，再调用只读 probe 和截图。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `open_editor_if_needed`：默认 false；设为 true 才允许打开 Niagara 编辑器。
- `target_frame`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `tick_delta_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
