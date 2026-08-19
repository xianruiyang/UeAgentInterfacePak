---
command: probe_ik_goal_review_frames
category: probe
title: `probe_ik_goal_review_frames`
summary: 从最近一次或指定 `probe_ik_goal_candidates` 缓存中按 `F0..Fn` 编号筛选帧，默认重新高分辨率捕获选中帧并生成只包含这些帧的序列帧图
aliases: []
tags: [probe]
status: active
---

# `probe_ik_goal_review_frames`

## LLM Compact

- status: active.
- purpose: 从最近一次或指定 `probe_ik_goal_candidates` 缓存中按 `F0..Fn` 编号筛选帧，默认重新高分辨率捕获选中帧并生成只包含这些帧的序列帧图
- key_inputs: `format`, `preview_state`, `visual_options`, `quality`, `frame_height`, `frame_indices[]`, `frame_sheet_max_size`, `frame_width` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 支持统一 `visual_options` / `preview_state` 嵌套对象：`visual_options` 可填充 `format`、`quality`、`frame_width`、`frame_height`、`mesh_capture_bounds_padding` / `bounds_padding`、`rerender` / `recapture` / `rerender_selected_frames`、`use_cached_pixels` 和 frame sheet 输出设置；`preview_state` 可填充 `frames[]`、`frame_indices[]`、`frame_index` / `target_frame` / `pause_at_frame`。嵌套对象只填充缺失的顶层字段；冲突时顶层字段胜出，并返回 `unified_sequence_frame_options.conflicts`。
- note: cache 仅存在于当前 Editor 进程内；重启 UE 后必须重新执行 `probe_ik_goal_candidates`。
- note: 该命令只复看 `probe_ik_goal_candidates` 缓存的帧编号和 transform；它不是新的候选搜索，也不会应用 transform。
- note: sequence/control-rig 主路径默认重新捕获，因此不会因为源 sheet 或源缓存像素低清而继续低清。只有 `use_cached_pixels=true` 时才要求旧帧像素仍在缓存中；若旧帧像素因内存上限被释放，会返回 `probe_frame_pixels_not_available:F<n>`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 支持统一 `visual_options` / `preview_state` 嵌套对象：`visual_options` 可填充 `format`、`quality`、`frame_width`、`frame_height`、`mesh_capture_bounds_padding` / `bounds_padding`、`rerender` / `recapture` / `rerender_selected_frames`、`use_cached_pixels` 和 frame sheet 输出设置；`preview_state` 可填充 `frames[]`、`frame_indices[]`、`frame_index` / `target_frame` / `pause_at_frame`。嵌套对象只填充缺失的顶层字段；冲突时顶层字段胜出，并返回 `unified_sequence_frame_options.conflicts`。
- cache 仅存在于当前 Editor 进程内；重启 UE 后必须重新执行 `probe_ik_goal_candidates`。
- 该命令只复看 `probe_ik_goal_candidates` 缓存的帧编号和 transform；它不是新的候选搜索，也不会应用 transform。
- sequence/control-rig 主路径默认重新捕获，因此不会因为源 sheet 或源缓存像素低清而继续低清。只有 `use_cached_pixels=true` 时才要求旧帧像素仍在缓存中；若旧帧像素因内存上限被释放，会返回 `probe_frame_pixels_not_available:F<n>`。

## Parameters

- `format`：输出格式，例如 png/json/csv，取决于命令支持。
- `preview_state`：adapter 专属预览状态；序列帧/截图应继承统一 preview_state 语义。
- `visual_options`：视图模式/overlay/show flags；截图和序列帧也应消费该对象。
- `quality`：有损图片输出质量；通常用于 jpg/webp。
- `frame_height`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_indices[]`：frame_indices 列表。
- `frame_sheet_max_size`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_width`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frames[]`：frames 列表。
- `probe_request_id`：稳定 id，用于精确定位或后续操作。
- `recapture`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `rerender`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `use_cached_pixels`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
