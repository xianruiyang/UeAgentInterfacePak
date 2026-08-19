---
command: ik_rig_set_retarget_root
category: ikrig_ikretargeter
title: 设置 retarget root
summary: 设置 retarget root
aliases: []
tags: [ikrig_ikretargeter]
status: active
---

# `ik_rig_set_retarget_root`

## LLM Compact

- status: active.
- purpose: 设置 retarget root
- key_inputs: `ik_rig_apply_folder`, `retarget_definition.hjson`
- key_returns: `errors`, `success`, `warnings`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `ik_rig_apply_folder`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `retarget_definition.hjson`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `errors`：错误摘要。
- `success`：命令业务是否成功；仍需按返回字段读回验收。
- `warnings`：警告摘要。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
