---
command: editor_viewport_set_preview_state
category: editor_viewport
title: 命令表
summary: 设置 adapter 专属预览状态
aliases: []
tags: [editor_viewport]
status: active
---

# `editor_viewport_set_preview_state`

## LLM Compact

- status: active.
- purpose: 设置 adapter 专属预览状态
- key_inputs: `preview_state`
- key_returns: `preview_state`, `preview_state_applied`
- note: 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- note: 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- note: 设置结果也应被 `editor_viewport_screenshot` 以及 Niagara/Animation/Sequence 等序列帧输出消费。
- note: 用途：设置 adapter 专属预览状态。它与 camera/show flags 分离，避免把 Niagara 定帧、动画时间、材质预览体等状态混进 `visual_options`。
- note: Level viewport 可通过 `actor_id` + `component_id` 选择场景中的 NiagaraComponent，并以 `absolute_time_seconds` + `tick_delta_seconds` 使用引擎 DesiredAge 机制确定性求值；`component_name` 是 `component_id` 的兼容别名。
- validation: 读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。

## Authoring Notes

- 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- 设置结果也应被 `editor_viewport_screenshot` 以及 Niagara/Animation/Sequence 等序列帧输出消费。
- 用途：设置 adapter 专属预览状态。它与 camera/show flags 分离，避免把 Niagara 定帧、动画时间、材质预览体等状态混进 `visual_options`。
- Level NiagaraComponent 定帧使用 `actor_id` + `component_id`，以及 `absolute_time_seconds`、`tick_delta_seconds`、`reset`、`pause_after_advance`；实现调用 Niagara 原生 `DesiredAge/SeekToDesiredAge`，这些运行时状态不是 UObject Details 属性，不应写入 Level folder `properties[]`。
- `actor_id` 接受当前 Editor World 中的 Actor 名称或标签；`component_id` 接受该 Actor 的组件名称或路径，`component_name` 是兼容别名。目标缺失、组件类型错误或未提供动作时会明确失败，不猜测唯一组件。
- Level NiagaraComponent 也接受 `simulation` 和 `paused/pause` 控制；绝对时间与 `simulation=false` 同时出现会作为冲突拒绝。
- 绝对时间求值会建立 solo system instance、初始化组件并进行有界 DesiredAge 求值；只有 `actual_age_seconds` 达到请求时间才返回成功，否则恢复现场并返回 `level_preview_seek_incomplete`。
- `editor_viewport_screenshot` 中携带相同 `preview_state` 且 `restore_after_capture=true` 时，会恢复组件的原年龄模式、模拟年龄、DesiredAge、seek delta、lock、active 与 paused 状态。
- 只读 `preview_state` 会报告 asset path、LOD 和选择摘要。
- 只读 `preview_state` 会报告 asset、skeleton、preview mesh、animation / anim blueprint 路径、context、reference pose 和选择摘要。
- 只读 `preview_state.context="ControlRigBlueprint"`。
- 只读 `preview_state.preview_mesh_path`。
- ControlRig 专属运行、求解、控制器选择或 RigVM 调试状态不在当前 `editor_viewport_set_preview_state` 范围内。

## Parameters

- `preview_state`：adapter 专属预览状态；Level NiagaraComponent 的规范字段为 `actor_id`、`component_id`、`absolute_time_seconds`、`tick_delta_seconds`、`reset`、`pause_after_advance`。

## Returns

- `preview_state`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `preview_state_applied`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- Level Niagara 定帧的 `preview_state_applied.actual_age_seconds` 是真实 system instance age，不是请求值回显。

## Validation

读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。
