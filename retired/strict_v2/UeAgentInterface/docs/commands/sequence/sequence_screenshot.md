---
command: sequence_screenshot
category: sequence
title: Level Sequence
summary: 按帧/时间截取 Level Sequence 画面，也可批量输出连续序列帧总览图
aliases: []
tags: [sequence]
status: active
---

# `sequence_screenshot`

## LLM Compact

- status: active.
- purpose: 按帧/时间截取 Level Sequence 画面，也可批量输出连续序列帧总览图
- key_inputs: `asset_path`, `format`, `max_size`, `preview_state`, `target`, `visual_options`, `quality`, `count` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 序列帧、预览截图和资产预览应沿用统一 `visual_options` 与 `preview_state` 语义。
- note: 用于 Level Sequence 选帧审查，按 `frame_index` 或 `time_seconds` 把指定序列求值到目标帧并输出图片。
- note: 批量审查镜头阶段时，使用 `start_time_seconds + count + interval_seconds`，或 `start_frame_index + count + frame_interval` 一次输出连续序列帧。`frame_index` 使用序列 display rate，且相对 playback start 计算。
- note: 命令会在编辑器世界中创建临时 `LevelSequencePlayer` 与临时 `SceneCapture2D`，不保存关卡，不启动 PIE。结束时停止 player、销毁临时 actor，并在原关卡干净时恢复 dirty flag。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 序列帧、预览截图和资产预览应沿用统一 `visual_options` 与 `preview_state` 语义。
- 用于 Level Sequence 选帧审查，按 `frame_index` 或 `time_seconds` 把指定序列求值到目标帧并输出图片。
- 批量审查镜头阶段时，使用 `start_time_seconds + count + interval_seconds`，或 `start_frame_index + count + frame_interval` 一次输出连续序列帧。`frame_index` 使用序列 display rate，且相对 playback start 计算。
- 命令会在编辑器世界中创建临时 `LevelSequencePlayer` 与临时 `SceneCapture2D`，不保存关卡，不启动 PIE。结束时停止 player、销毁临时 actor，并在原关卡干净时恢复 dirty flag。
- 有 Camera Cut 时优先使用序列当前激活 camera；没有 Camera Cut 时默认回退到当前 Level Viewport 相机。可传 `fallback_to_viewport_camera=false` 强制要求序列相机。
- 单帧模式返回单张帧图。多帧模式默认只写一张序列帧总览图，`file_path`、`frame_sheet_file_path` 与 `sequence_frame_image_path` 都指向该图；每个格子左上角标注 `F<frame_index>`。
- 可传 `create_frame_sheet=false` 关闭总览图；若同时没有 `write_individual_frames=true`，命令会返回 `multi_frame_output_disabled`。总览图统一按最小正方形网格排布，即 `ceil(sqrt(frame_count)) x ceil(sqrt(frame_count))`，不足格子留空；`frame_sheet_padding` 控制间距；`frame_sheet_max_size` 控制总览图最长边；`frame_sheet_label_scale` 控制帧号字号。
- 序列帧模式支持统一 `visual_options` / `preview_state` 嵌套对象：`visual_options` 可填充 `format`、`quality`、`max_size`、`width`、`height`、`target`、frame sheet 输出设置和 `fallback_to_viewport_camera`；`preview_state` 可填充 `frame_index` / `frame` / `target_frame` / `pause_at_frame`、`time_seconds`、`start_frame_index`、`count`、`frame_interval`、`start_time_seconds`、`interval_seconds`、`frames[]`。嵌套对象只填充缺失的顶层字段；若顶层字段已存在则顶层字段胜出，并在返回 `unified_sequence_frame_options.conflicts` 中记录。
- 当传入统一对象时，返回会包含 `unified_sequence_frame_options`、`visual_options_applied`、`visual_options_ignored`、`preview_state_applied`、`preview_state_ignored`。`grid` / `bounds` / `view_mode` 这类真实编辑器视口 overlay 只在当前命令的离屏 SceneCapture 后端有等价能力时才会标记为 applied；否则记录为 ignored，不静默伪装成功。
- 批量模式上限为 120 张；若请求帧超出 playback range，会失败并返回 `preview_frame_range_exceeds_sequence`，避免尾帧重复误导判断。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `format`：输出格式，例如 png/json/csv，取决于命令支持。
- `max_size`：截图或导出尺寸上限。
- `preview_state`：adapter 专属预览状态；序列帧/截图应继承统一 preview_state 语义。
- `target`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。
- `visual_options`：视图模式/overlay/show flags；截图和序列帧也应消费该对象。
- `quality`：有损图片输出质量；通常用于 jpg/webp。
- `count`：数量摘要。
- `create_frame_sheet`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_interval`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_sheet_label_scale`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_sheet_max_size`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_sheet_padding`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `interval_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `start_frame_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `start_time_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `time_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `write_individual_frames`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
