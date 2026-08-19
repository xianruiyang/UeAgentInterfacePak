---
command: probe_actor_transform_candidates
category: probe
title: `probe_actor_transform_candidates`
summary: 对同一个 Actor 依次套用候选移动 / 旋转 / 缩放，截图后恢复原 transform，并输出原始帧 + 候选帧拼接图
aliases: []
tags: [probe]
status: active
---

# `probe_actor_transform_candidates`

## LLM Compact

- status: active.
- purpose: 对同一个 Actor 依次套用候选移动 / 旋转 / 缩放，截图后恢复原 transform，并输出原始帧 + 候选帧拼接图
- key_inputs: `format`, `max_size`, `preview_state`, `visual_options`, `quality`, `warmup_frames`, `candidates[]`, `create_frame_sheet` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 相对模式别名：`location_offset` / `location_delta` / `delta_location`，`rotation_offset` / `rotation_delta` / `delta_rotation`，`scale_multiplier` / `scale_factor`。
- note: 支持统一 `visual_options` / `preview_state` 嵌套对象：`visual_options` 可填充 `format`、`quality`、`max_size`、`warmup_frames`、`render_warmup_frames`、`tick_editor_world`、`editor_world_tick_frames`、`editor_world_tick_delta_seconds` 和 frame sheet 输出设置；`preview_state` 只作为统一入口诊断读取，不改变候选 transform 顺序。嵌套对象只填充缺失的顶层字段；冲突时顶层字段胜出，并返回 `unified_sequence_frame_options.conflicts`。
- note: 当传入统一对象时，返回会包含 `unified_sequence_frame_options`、`visual_options_applied`、`visual_options_ignored`、`preview_state_applied`、`preview_state_ignored`。Actor probe 截图来自当前 active Level Viewport；若需要 `grid` / `bounds` / `view_mode` 等 overlay，应先用 `editor_viewport_set_visual_options` 设置当前场景窗口，命令内嵌对象里的无等价键会记录为 ignored。
- note: 该命令是探测指令，不负责提交最终 authoring 状态。选定候选后，应使用对应资产 / Level Content / 动画写入流程生成真实结果。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 相对模式别名：`location_offset` / `location_delta` / `delta_location`，`rotation_offset` / `rotation_delta` / `delta_rotation`，`scale_multiplier` / `scale_factor`。
- 支持统一 `visual_options` / `preview_state` 嵌套对象：`visual_options` 可填充 `format`、`quality`、`max_size`、`warmup_frames`、`render_warmup_frames`、`tick_editor_world`、`editor_world_tick_frames`、`editor_world_tick_delta_seconds` 和 frame sheet 输出设置；`preview_state` 只作为统一入口诊断读取，不改变候选 transform 顺序。嵌套对象只填充缺失的顶层字段；冲突时顶层字段胜出，并返回 `unified_sequence_frame_options.conflicts`。
- 当传入统一对象时，返回会包含 `unified_sequence_frame_options`、`visual_options_applied`、`visual_options_ignored`、`preview_state_applied`、`preview_state_ignored`。Actor probe 截图来自当前 active Level Viewport；若需要 `grid` / `bounds` / `view_mode` 等 overlay，应先用 `editor_viewport_set_visual_options` 设置当前场景窗口，命令内嵌对象里的无等价键会记录为 ignored。
- 该命令是探测指令，不负责提交最终 authoring 状态。选定候选后，应使用对应资产 / Level Content / 动画写入流程生成真实结果。
- 命令不使用 UE transaction，不调用 `Modify()`，并在命令结束前恢复 Actor transform；但如果外部同时修改同一 Actor，调用者需要自行避免并发。
- sheet 只负责比较候选视觉效果，不替代后续 readback、compile、dirty resource 和任务级验收。

## Parameters

- `format`：输出格式，例如 png/json/csv，取决于命令支持。
- `max_size`：截图或导出尺寸上限。
- `preview_state`：adapter 专属预览状态；序列帧/截图应继承统一 preview_state 语义。
- `visual_options`：视图模式/overlay/show flags；截图和序列帧也应消费该对象。
- `quality`：有损图片输出质量；通常用于 jpg/webp。
- `warmup_frames`：截图前刷新帧数，用于等待 viewport 更新。
- `candidates[]`：candidates 列表。
- `create_frame_sheet`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_sheet_max_size`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `id`：稳定 id，用于精确定位或后续操作。
- `relative_to_original`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `write_individual_frames`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
