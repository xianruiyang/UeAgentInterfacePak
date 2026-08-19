---
command: editor_console_exec
category: core_level
title: `editor_console_exec`
summary: 执行 UE 底部状态栏 `Cmd` 控制台命令的等价路径
aliases: []
tags: [core_level]
status: active
---

# `editor_console_exec`

## LLM Compact

- status: active.
- purpose: 执行 UE 底部状态栏 `Cmd` 控制台命令的等价路径
- key_inputs: `add_to_history`, `allow_high_risk`, `command`, `commands[]`, `fail_on_unhandled`, `max_output_chars`, `max_output_lines`, `stop_on_error` ...
- key_returns: `DumpConsoleCommands`, `r.*`, `stat`, `viewmode`
- note: 阻断高风险命令时返回失败 `editor_console_command_blocked_high_risk`；未处理且 `fail_on_unhandled=true` 时返回失败 `editor_console_command_unhandled` 或更具体的失败原因。
- note: 一旦本 Editor 会话执行过 Python 控制台命令，`save_current_level` 以及 `level_content_apply_json` / `level_content_delete_scope` 的 `save_level` 自动保存会默认阻断，避免保存触发 UE Python 插件 GC 崩溃。
- note: 确认当前环境确实可承受该风险时，可显式传 `allow_python_gc_risk=true` 解除阻断；普通 authoring 流程不应默认开启。
- note: 注意：`editor_console_exec` 是兜底/调试入口，不应替代已有结构化 UAI 指令。凡是 UAI 已有明确读写命令的资产、关卡、视口、编译、截图、配置和生命周期操作，仍优先使用结构化指令，以获得更稳定的读回和错误语义。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 阻断高风险命令时返回失败 `editor_console_command_blocked_high_risk`；未处理且 `fail_on_unhandled=true` 时返回失败 `editor_console_command_unhandled` 或更具体的失败原因。
- 一旦本 Editor 会话执行过 Python 控制台命令，`save_current_level` 以及 `level_content_apply_json` / `level_content_delete_scope` 的 `save_level` 自动保存会默认阻断，避免保存触发 UE Python 插件 GC 崩溃。
- 确认当前环境确实可承受该风险时，可显式传 `allow_python_gc_risk=true` 解除阻断；普通 authoring 流程不应默认开启。
- 注意：`editor_console_exec` 是兜底/调试入口，不应替代已有结构化 UAI 指令。凡是 UAI 已有明确读写命令的资产、关卡、视口、编译、截图、配置和生命周期操作，仍优先使用结构化指令，以获得更稳定的读回和错误语义。

## Parameters

- `add_to_history`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `allow_high_risk`：布尔/开关字段；默认 `false`。退出/崩溃、任意 Python、地图与会话切换、对象或包破坏性操作，以及 `Module` 加载/卸载/重编译、`HotReload`、`LiveCoding`、`Recompile` 等运行时代码生命周期变更均会被默认阻断。`Module List` 保持只读可用。
- `command`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `commands[]`：commands 列表。
- `fail_on_unhandled`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `max_output_chars`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `max_output_lines`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stop_on_error`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `world_context`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `DumpConsoleCommands`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `r.*`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stat`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `viewmode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
