---
command: anim_sequence_analyze_root_motion
category: animation_assets_skeleton
title: `anim_sequence_analyze_root_motion`
summary: 采样 AnimSequence 的 root motion / root bone / 朝向骨骼轨道，输出转身角度、水平距离和建议曲线/marker
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `anim_sequence_analyze_root_motion`

## LLM Compact

- status: active.
- purpose: 采样 AnimSequence 的 root motion / root bone / 朝向骨骼轨道，输出转身角度、水平距离和建议曲线/marker
- key_inputs: `asset_path`, `include_samples`, `include_suggested_keys`, `meaningful_translation_threshold_cm`, `meaningful_yaw_threshold_degrees`, `orientation_bone_name`, `sample_count`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 只读采样命令，用于判断动画是否真的包含 root 轨道运动，而不是只看 `root_motion_enabled` 开关。
- note: 命令会同时读取 `ExtractRootMotionFromRange(0,time)` 的 root motion 结果、root bone 在采样点相对首帧的 raw delta，以及可选朝向骨骼相对首帧的 yaw delta，便于识别“资产有 root 轨道但 root 只位移，身体朝向转在 hips/pelvis 上”的情况。
- note: 未传 `orientation_bone_name` 时会按 `hips -> pelvis -> spine -> root` 自动选择第一个存在的骨骼。
- note: 适合给 Turn-In-Place、root-motion turn montage、pivot/turn 动作补 `TurnYaw`、`Distance`、`TurnStart`、`PivotCommit`、`TurnEnd` 等基础信号；`FootPlant` / `FootLock` 仍建议结合脚骨/视觉审核单独确认，不能只从 root 或 hips/pelvis 轨道推断。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 只读采样命令，用于判断动画是否真的包含 root 轨道运动，而不是只看 `root_motion_enabled` 开关。
- 命令会同时读取 `ExtractRootMotionFromRange(0,time)` 的 root motion 结果、root bone 在采样点相对首帧的 raw delta，以及可选朝向骨骼相对首帧的 yaw delta，便于识别“资产有 root 轨道但 root 只位移，身体朝向转在 hips/pelvis 上”的情况。
- 未传 `orientation_bone_name` 时会按 `hips -> pelvis -> spine -> root` 自动选择第一个存在的骨骼。
- 适合给 Turn-In-Place、root-motion turn montage、pivot/turn 动作补 `TurnYaw`、`Distance`、`TurnStart`、`PivotCommit`、`TurnEnd` 等基础信号；`FootPlant` / `FootLock` 仍建议结合脚骨/视觉审核单独确认，不能只从 root 或 hips/pelvis 轨道推断。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `include_samples`：布尔/开关字段；默认值以本命令契约为准。
- `include_suggested_keys`：布尔/开关字段；默认值以本命令契约为准。
- `meaningful_translation_threshold_cm`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `meaningful_yaw_threshold_degrees`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `orientation_bone_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `sample_count`：数量摘要。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
