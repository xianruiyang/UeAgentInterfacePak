---
command: level_actor_validate_json
category: level_content
title: 指令
summary: Actor-only validate 兼容别名
aliases: []
tags: [level_content]
status: active
---

# `level_actor_validate_json`

## LLM Compact

- status: active.
- purpose: Actor-only validate 兼容别名
- key_inputs: `level_content_validate_json`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: 这是只读校验入口；不得把 validate 结果当成已写入状态。
- note: Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- validation: 写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。

## Authoring Notes

- 这是只读校验入口；不得把 validate 结果当成已写入状态。
- Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。

## Parameters

- `level_content_validate_json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。
