---
command: niagara_refresh_system
category: niagara_system
title: `niagara_refresh_system`
summary: 刷新 System 结构、执行顺序和缓存
aliases: []
tags: [niagara_system]
status: active
---

# `niagara_refresh_system`

## LLM Compact

- status: active.
- purpose: 刷新 System 结构、执行顺序和缓存
- key_inputs: `asset_path`, `broadcast_post_edit_change`, `compile_after_refresh`, `save_after_refresh`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 对 `mark_dirty=false` 的刷新、默认校验编译、读前编译日志，若 UE 内部刷新/编译过程临时把原本 clean 的包置 dirty，命令会恢复原 dirty 状态并返回 `restored_dirty_state=true`。
- note: 若 UI 中出现“新增一个空 emitter 后 system 才恢复”的现象，优先对目标 System 执行 `niagara_refresh_system`，再读 compile log、Stack issue 和 runtime probe。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- 对 `mark_dirty=false` 的刷新、默认校验编译、读前编译日志，若 UE 内部刷新/编译过程临时把原本 clean 的包置 dirty，命令会恢复原 dirty 状态并返回 `restored_dirty_state=true`。
- 若 UI 中出现“新增一个空 emitter 后 system 才恢复”的现象，优先对目标 System 执行 `niagara_refresh_system`，再读 compile log、Stack issue 和 runtime probe。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `broadcast_post_edit_change`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `compile_after_refresh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_refresh`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
