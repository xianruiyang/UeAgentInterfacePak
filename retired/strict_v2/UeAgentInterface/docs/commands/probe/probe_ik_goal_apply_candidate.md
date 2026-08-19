---
command: probe_ik_goal_apply_candidate
category: probe
title: `probe_ik_goal_apply_candidate`
summary: 将最近一次或指定 `probe_ik_goal_candidates` 预览中的某个编号 transform 写回同一个 sequence / binding / Control Rig control 的同一帧
aliases: []
tags: [probe]
status: active
---

# `probe_ik_goal_apply_candidate`

## LLM Compact

- status: active.
- purpose: 将最近一次或指定 `probe_ik_goal_candidates` 预览中的某个编号 transform 写回同一个 sequence / binding / Control Rig control 的同一帧
- key_inputs: `candidate_index`, `control_name`, `frame_index`, `number`, `probe_request_id`, `save_after_apply`, `sequence_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: sequence 主路径 `schema`：`uai.probe.ik_goal_apply_candidate.sequence_control_rig.v1`。
- note: sequence 主路径返回 `sequence_path`、`binding_guid`、`control_name`、`control_type`、`sequence_frame_index`、`evaluation_frame`。
- note: sequence 主路径在读回 `previous_control_transform` / `final_control_transform` 和调用 `AutoSetTangents` 前，会重置并强制触发 Control Rig section 的 `ChannelProxy` 懒重建，再校验 float channel map；这用于规避 UE `EvaluateTransformParameter` / `EvaluateVectorParameter` 对非法 channel 下标直接 assert 的问题。
- note: 若重建后 channel map 仍然缺失、越界或包含空 channel，命令返回失败，不再调用不安全的 UE 读回/切线路径。典型错误包括 `control_rig_float_channel_map_missing`、`control_rig_float_channel_range_invalid:...`、`control_rig_float_channel_null:...`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- sequence 主路径 `schema`：`uai.probe.ik_goal_apply_candidate.sequence_control_rig.v1`。
- sequence 主路径返回 `sequence_path`、`binding_guid`、`control_name`、`control_type`、`sequence_frame_index`、`evaluation_frame`。
- sequence 主路径在读回 `previous_control_transform` / `final_control_transform` 和调用 `AutoSetTangents` 前，会重置并强制触发 Control Rig section 的 `ChannelProxy` 懒重建，再校验 float channel map；这用于规避 UE `EvaluateTransformParameter` / `EvaluateVectorParameter` 对非法 channel 下标直接 assert 的问题。
- 若重建后 channel map 仍然缺失、越界或包含空 channel，命令返回失败，不再调用不安全的 UE 读回/切线路径。典型错误包括 `control_rig_float_channel_map_missing`、`control_rig_float_channel_range_invalid:...`、`control_rig_float_channel_null:...`。
- 这些错误表示当前 Level Sequence / Control Rig section 的 Sequencer channel 状态已不适合继续写入；应先重新生成 probe cache、重建或修复对应 Control Rig track/section，再继续应用候选。
- cache 仅存在于当前 Editor 进程内；重启 UE 后必须重新执行 `probe_ik_goal_candidates`。
- sequence 主路径会改变 Level Sequence key 数据；未保存时会产生 dirty resource。
- 应用候选后仍需继续做逐帧、正面 / 侧面视觉验收，必要时再以更小候选尺度继续 probe。

## Parameters

- `candidate_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `control_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `frame_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `number`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `probe_request_id`：稳定 id，用于精确定位或后续操作。
- `save_after_apply`：布尔/开关字段；默认值以本命令契约为准。
- `sequence_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
