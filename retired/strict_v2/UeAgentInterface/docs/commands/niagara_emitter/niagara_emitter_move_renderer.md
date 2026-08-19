---
command: niagara_emitter_move_renderer
category: niagara_emitter
title: niagara_emitter_move_renderer
summary: 调整 Niagara Emitter 中 renderer 的顺序
aliases: []
tags: [niagara_emitter]
status: active
---

# `niagara_emitter_move_renderer`

## LLM Compact

- status: active.
- purpose: 按 renderer index、name 或 class 定位 renderer，并移动到 `target_index`。
- key_inputs: `emitter_asset_path`, `renderer_index|renderer_name|renderer_class`, `target_index`
- key_returns: `old_index`, `new_index`, `target_index`, `moved`, `renderer`, `saved`
- note: `target_index` 必须落在当前 renderer 列表范围内；写入后用 `niagara_emitter_list_renderers` 读回顺序。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按 CommandSpec 中的 renderer selector 定位目标；未提供 selector 时默认使用 `renderer_index: 0`。
- `compile_after_set` 默认开启，`save_after_set` 由调用方决定。
- standalone Emitter 必须在 UE 原生临时 System 上下文中编译，因此启用 `compile_after_set` 时总会同步等待该临时上下文完成；不会逐个孤立编译 Emitter Script。

## Parameters

- `emitter_asset_path`：Emitter 资产路径。
- `renderer_index` / `renderer_name` / `renderer_class`：renderer selector，按实现优先级解析。
- `target_index`：目标列表索引，必填。
- `compile_after_set`、`force_compile`、`wait_for_complete`：编译策略。
- `save_after_set`：是否保存资产。

## Returns

- `old_index`、`new_index`、`target_index`：移动前后及请求索引。
- `moved`：索引是否实际发生变化。
- `renderer`：移动后的 renderer 结构化读回。
- `compile_after_set`、`compilation_requested`、`compilation_complete`、`compile_has_error`：上下文编译状态；启用编译时返回的 `wait_for_complete` 是实际生效值 true。
- `saved`：本次是否保存资产。

## Validation

调用 `niagara_emitter_list_renderers`，确认目标 renderer 的最终索引等于 `new_index`。
