---
command: enhanced_input_clear_mappings
category: static_mesh_enhanced_input
title: EnhancedInput
summary: **Deprecated for authoring**：清空全部映射
aliases: []
tags: [static_mesh_enhanced_input, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：清空全部映射
deprecated_replacement: []
---

# `enhanced_input_clear_mappings`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：清空全部映射
- key_inputs: `mapping_context_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `mapping_context_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
