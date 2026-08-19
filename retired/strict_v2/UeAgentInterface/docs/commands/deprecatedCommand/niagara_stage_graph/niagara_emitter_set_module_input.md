---
command: niagara_emitter_set_module_input
category: niagara_stage_graph
title: `niagara_emitter_set_module_input`
summary: **Deprecated for authoring**：设置模块输入值或绑定参数
aliases: []
tags: [niagara_stage_graph, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：设置模块输入值或绑定参数
deprecated_replacement: []
---

# `niagara_emitter_set_module_input`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：设置模块输入值或绑定参数
- key_inputs: `emitter_asset_path`, `input_name`, `link_parameter_name`, `module_node_guid`, `value_text`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 如果输入是模块 FunctionCall 上的可见 pin（例如 Niagara 模块里的 `Velocity Mode`、`Cone Angle Mode` 这类枚举/静态开关输入），会直接写入该可见 pin。
- note: 如果输入是隐藏 stack input，会创建或复用 aliased stack override pin。
- note: 返回值里的 `write_target` 表示实际写入目标：`visible_pin` 或 `stack_override_pin`。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 如果输入是模块 FunctionCall 上的可见 pin（例如 Niagara 模块里的 `Velocity Mode`、`Cone Angle Mode` 这类枚举/静态开关输入），会直接写入该可见 pin。
- 如果输入是隐藏 stack input，会创建或复用 aliased stack override pin。
- 返回值里的 `write_target` 表示实际写入目标：`visible_pin` 或 `stack_override_pin`。
- 返回值包含 `requested_value_text`、`applied_value_text`、`value_text_normalized`，用于区分调用方传入值和真正写入 UE pin 的结构化文本。
- 设置默认值后会做写后校验。成功返回包含 `default_value_apply_verified=true` 和 `default_value_apply_status`；如果 UE 接受了字符串但 `OverridePin.DefaultValue` 没有落成预期文本，命令会失败并返回 `pin_default_apply_verification_failed:<input>:<detail>`。这类失败通常表示 Niagara pin default 的文本解析/导入格式不匹配。
- 设置后应使用 `niagara_emitter_list_module_inputs` 回读同一 `module_node_guid`，确认 `override_default_value` 和 `has_override`。
- 返回值会包含 `is_dynamic_input`、`dynamic_input_node_guid`、`dynamic_input_script_asset_path`、`dynamic_input_inputs_initialized`、`dynamic_input_initialization_source`、`curve_json_applied`、`curve_input_node_guid`、`curve_data_interface_object_path` 和 `json_issues[]`。
- 曲线动态输入必须把 `dynamic_input_inputs_initialized=true`、`curve_json_applied=true`、`json_issues[]` 为空作为成功条件。`curve_data_interface_object_path` 应指向本次新建动态输入下的 Data Interface；如果落到旧的同名 `FloatCurve` 节点，视为错误。
- 返回值包含 `dynamic_input_extension_deprecated=true` 和 `dynamic_input_extension_replacement`，用于提示调用方迁移到 folder JSON。

## Parameters

- `emitter_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `input_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `link_parameter_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `module_node_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `value_text`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
