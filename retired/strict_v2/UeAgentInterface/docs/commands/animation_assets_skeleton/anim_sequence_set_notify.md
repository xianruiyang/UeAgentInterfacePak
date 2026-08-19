---
command: anim_sequence_set_notify
category: animation_assets_skeleton
title: `anim_sequence_set_notify`
summary: 新增 / 更新 / 删除单条 notify
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `anim_sequence_set_notify`

## LLM Compact

- status: active.
- purpose: 新增 / 更新 / 删除单条 notify
- key_inputs: `asset_path`, `can_be_filtered_via_request`, `duration_seconds`, `notify_class`, `notify_color`, `notify_filter_lod`, `notify_filter_type`, `notify_index` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 这是 AnimSequence notify 本体的统一入口，避免继续拆 `add_notify / update_notify / remove_notify / add_notify_state` 多条命令。
- note: 不传 `notify_class / notify_state_class` 时，会创建一条普通命名 notify。
- note: 传 `notify_state_class` 时，必须同时提供 `duration_seconds`。
- note: 新增时如 `track_name` 不存在，命令会先补齐 notify track。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 这是 AnimSequence notify 本体的统一入口，避免继续拆 `add_notify / update_notify / remove_notify / add_notify_state` 多条命令。
- 不传 `notify_class / notify_state_class` 时，会创建一条普通命名 notify。
- 传 `notify_state_class` 时，必须同时提供 `duration_seconds`。
- 新增时如 `track_name` 不存在，命令会先补齐 notify track。
- 当前优先支持 notify 结构、时间、轨道、颜色和常见触发/过滤字段；不继续扩到自定义 notify 对象 payload 属性编辑。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `can_be_filtered_via_request`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `duration_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_color`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_filter_lod`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_filter_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `notify_state_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_trigger_chance`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `remove`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。
- `tick_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `time_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `track_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `trigger_on_dedicated_server`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `trigger_on_follower`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `trigger_weight_threshold`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
