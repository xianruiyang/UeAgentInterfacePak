---
command: anim_sequence_set_curve
category: animation_assets_skeleton
title: `anim_sequence_set_curve`
summary: 统一管理 AnimSequence 曲线与 key
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `anim_sequence_set_curve`

## LLM Compact

- status: active.
- purpose: 统一管理 AnimSequence 曲线与 key
- key_inputs: `asset_path`, `clear_existing_keys`, `curve_json`, `curve_name`, `curve_type=float`, `keys[]`, `meta_data_curve`, `remove` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 这是当前曲线管理的统一入口，避免继续拆 `add_float_curve / remove_curve / add_curve_key` 多条命令。
- note: 当前稳定开放 `curve_type=float`。
- note: 推荐优先使用 `curve_json`，格式为 `ue_agent_interface.curve.v1` 的 float 曲线结构；写入前会校验未知字段、缺 key 值、重复时间、非法插值/切线/外推模式，并在 `json_issues[]` 返回。
- note: 单 key 写入可直接传顶层 `time_seconds` + `value`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 这是当前曲线管理的统一入口，避免继续拆 `add_float_curve / remove_curve / add_curve_key` 多条命令。
- 当前稳定开放 `curve_type=float`。
- 推荐优先使用 `curve_json`，格式为 `ue_agent_interface.curve.v1` 的 float 曲线结构；写入前会校验未知字段、缺 key 值、重复时间、非法插值/切线/外推模式，并在 `json_issues[]` 返回。
- 单 key 写入可直接传顶层 `time_seconds` + `value`。
- 多 key 写入走 `keys[]`。
- 曲线用于 IK 权重、脚锁定、手部贴合或步态阶段时，apply 后必须用 `anim_sequence_get_info(include_curve_keys=true)` 或重新导出曲线确认 key 数、时间、最大值和插值。只看到曲线名存在，不代表运行时权重有效。
- 移动动画的 IK 曲线通常需要支撑期高、摆动期低的过渡；全程 1.0 容易锁脚卡顿，全程 0.0 会让 Control Rig 看起来无效。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `clear_existing_keys`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `curve_json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `curve_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `curve_type=float`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `keys[]`：keys 列表。
- `meta_data_curve`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `remove`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `remove_name_from_skeleton`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。
- `time_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `value`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
