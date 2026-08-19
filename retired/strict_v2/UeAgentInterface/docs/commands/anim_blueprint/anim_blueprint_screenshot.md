---
command: anim_blueprint_screenshot
category: anim_blueprint
title: 图视图 / 预览视口 / 截图
summary: 对图面板 / 预览视口 / 窗口截图
aliases: []
tags: [anim_blueprint]
status: active
---

# `anim_blueprint_screenshot`

## LLM Compact

- status: active.
- purpose: 对图面板 / 预览视口 / 窗口截图
- key_inputs: `asset_path`, `format`, `max_size`, `open_editor_if_needed`, `target`, `quality`, `allow_ui_mutation`, `allow_window_mutation` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 序列帧、预览截图和资产预览应沿用统一 `visual_options` 与 `preview_state` 语义。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 序列帧、预览截图和资产预览应沿用统一 `visual_options` 与 `preview_state` 语义。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `format`：输出格式，例如 png/json/csv，取决于命令支持。
- `max_size`：截图或导出尺寸上限。
- `open_editor_if_needed`：默认 `false`；传 `true` 时还必须显式传 `allow_ui_mutation=true`。
- `target`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。
- `quality`：有损图片输出质量；通常用于 jpg/webp。
- `allow_ui_mutation`：默认 `false`；是否允许激活编辑器、切换图页等 UI 状态。
- `allow_window_mutation`：默认 `false`；是否允许临时恢复、显示或调整承载窗口。
- `graph_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `restore_graph_view_after_capture`：默认 `true`；截图后恢复原图视图状态。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
