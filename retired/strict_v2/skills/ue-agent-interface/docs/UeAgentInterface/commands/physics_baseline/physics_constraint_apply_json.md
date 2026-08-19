---
command: physics_constraint_apply_json
category: physics_baseline
title: 指令总览
summary: 创建或更新场景 PhysicsConstraintActor/Component 并绑定两个 PrimitiveComponent
aliases: []
tags: [physics_baseline]
status: active
---

# `physics_constraint_apply_json`

## LLM Compact

- status: active.
- purpose: 创建或更新场景 PhysicsConstraintActor/Component 并绑定两个 PrimitiveComponent
- key_inputs: `json_file`, `transaction`, `create_if_missing`, `json`
- key_returns: `actor_created`, `readback`, `set_constrained_components_applied`
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。

## Parameters

- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `transaction`：是否使用 UE transaction 包裹写入。
- `create_if_missing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `actor_created`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `readback`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `set_constrained_components_applied`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
