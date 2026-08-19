---
command: save_current_level
category: core_level
title: Save Current Level
summary: 保存当前打开关卡，并保护 Python 控制台执行后可能触发 UE Python GC 崩溃的自动保存风险。
aliases: []
tags: [level, save]
status: active
---

# `save_current_level`

## LLM Compact

- status: active.
- purpose: 保存当前打开关卡，并保护 Python 控制台执行后可能触发 UE Python GC 崩溃的自动保存风险。
- key_inputs: `only_if_dirty`, `allow_python_gc_risk`
- key_returns: `saved`, `reason`, `block_reason`, `level_path`
- note: 用途：保存当前打开关卡。
- note: 调用方应优先在批量写入结束后显式保存；不要把 `save_level=true` 当成无条件安全的自动落盘。确需在 Python 控制台执行后保存时，必须由调用方显式确认并传 `allow_python_gc_risk=true`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 用途：保存当前打开关卡。
- 调用方应优先在批量写入结束后显式保存；不要把 `save_level=true` 当成无条件安全的自动落盘。确需在 Python 控制台执行后保存时，必须由调用方显式确认并传 `allow_python_gc_risk=true`。

## Parameters

- `only_if_dirty`：默认 `true`。
- `allow_python_gc_risk`：默认 `false`，解除 Python 控制台保存风险阻断。

## Returns

- `saved`：是否实际保存。
- `reason` / `block_reason`：未保存或阻断原因。
- `level_path`：当前关卡路径。

## Minimal Example

```json
{
  "command": "save_current_level",
  "params": { "only_if_dirty": true }
}
```

## Validation

批量写入结束后显式保存；不要把 `save_level=true` 当作无条件安全落盘。编译前关闭 UE 时先保存 dirty 资源。
