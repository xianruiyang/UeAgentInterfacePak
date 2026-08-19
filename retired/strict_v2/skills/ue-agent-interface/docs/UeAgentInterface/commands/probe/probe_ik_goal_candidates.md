---
command: probe_ik_goal_candidates
category: probe
title: `probe_ik_goal_candidates`
summary: 浏览当前 Level Sequence 中 Control Rig 控制点的候选 transform：F0 来自目标帧未做候选变换的真实 sequence 评估；每个候选只设置同一 Control Rig 当前 control transform、解算、截图并恢复，不复制 sequence、不写 key
aliases: []
tags: [probe]
status: active
---

# `probe_ik_goal_candidates`

## LLM Compact

- status: active.
- purpose: 浏览当前 Level Sequence 中 Control Rig 控制点的候选 transform：F0 来自目标帧未做候选变换的真实 sequence 评估；每个候选只设置同一 Control Rig 当前 control transform、解算、截图并恢复，不复制 sequence、不写 key
- key_inputs: `format`, `preview_state`, `visual_options`, `quality`, `baseline_control_bone_map`, `binding_guid`, `binding_name`, `candidates[]` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 支持统一 `visual_options` / `preview_state` 嵌套对象：`visual_options` 可填充 `format`、`quality`、`frame_width`、`frame_height`、`mesh_capture_bounds_padding` / `bounds_padding` 和 frame sheet 输出设置；`preview_state` 可填充 `frame_index` / `frame` / `target_frame` / `pause_at_frame`、`time_seconds`、`sequence_frame_index`、`evaluation_frame`。嵌套对象只填充缺失的顶层字段；冲突时顶层字段胜出，并返回 `unified_sequence_frame_options.conflicts`。
- note: 当传入统一对象时，返回会包含 `unified_sequence_frame_options`、`visual_options_applied`、`visual_options_ignored`、`preview_state_applied`、`preview_state_ignored`。IK probe 使用固定 bounds SceneCapture，不支持编辑器 overlay；`grid`、`bounds`、`pivot`、`selection`、`view_mode` 等无等价键会记录为 ignored。
- note: F0 必须来自实际 sequence 在目标帧的未修改状态；如果 F0 不对，应先修复 sequence、Control Rig、AnimSequence、Backward Solve 或 bake 流程，而不是在 probe 指令里伪造 baseline。
- note: 候选预览只改变当前 Control Rig transient state，不写 key。只有 `probe_ik_goal_apply_candidate` 会把选中候选写回原 sequence。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 支持统一 `visual_options` / `preview_state` 嵌套对象：`visual_options` 可填充 `format`、`quality`、`frame_width`、`frame_height`、`mesh_capture_bounds_padding` / `bounds_padding` 和 frame sheet 输出设置；`preview_state` 可填充 `frame_index` / `frame` / `target_frame` / `pause_at_frame`、`time_seconds`、`sequence_frame_index`、`evaluation_frame`。嵌套对象只填充缺失的顶层字段；冲突时顶层字段胜出，并返回 `unified_sequence_frame_options.conflicts`。
- 当传入统一对象时，返回会包含 `unified_sequence_frame_options`、`visual_options_applied`、`visual_options_ignored`、`preview_state_applied`、`preview_state_ignored`。IK probe 使用固定 bounds SceneCapture，不支持编辑器 overlay；`grid`、`bounds`、`pivot`、`selection`、`view_mode` 等无等价键会记录为 ignored。
- F0 必须来自实际 sequence 在目标帧的未修改状态；如果 F0 不对，应先修复 sequence、Control Rig、AnimSequence、Backward Solve 或 bake 流程，而不是在 probe 指令里伪造 baseline。
- 候选预览只改变当前 Control Rig transient state，不写 key。只有 `probe_ik_goal_apply_candidate` 会把选中候选写回原 sequence。
- 如果 `readback_matches_request=true` 但 `visual_validation_passed=false` 或 `pose_sample_validation_passed=false`，说明 control 值已被设置但当前 Control Rig / Sequencer 求值没有让 watched bones 或截图发生可见变化；应检查 control 是否参与求解、Control Rig 正反向流程、solver effector、binding 和 watched bones。
- 截图由 UE 内部 SceneCapture 对真实绑定对象生成，单帧内包含正面 / 侧面两个视角；不是外部图片模拟。捕获时会关闭眼适应，并使用临时无阴影补光提高姿态轮廓可读性。
- cache 仅存在于当前 Editor 进程内；重启 UE 后必须重新执行预览。

## Parameters

- `format`：输出格式，例如 png/json/csv，取决于命令支持。
- `preview_state`：adapter 专属预览状态；序列帧/截图应继承统一 preview_state 语义。
- `visual_options`：视图模式/overlay/show flags；截图和序列帧也应消费该对象。
- `quality`：有损图片输出质量；通常用于 jpg/webp。
- `baseline_control_bone_map`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `binding_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `binding_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `candidates[]`：candidates 列表。
- `control_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `create_frame_sheet`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_height`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_width`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `mesh_capture_bounds_padding`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sequence_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `time_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `track_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `watched_bones`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `write_individual_frames`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
