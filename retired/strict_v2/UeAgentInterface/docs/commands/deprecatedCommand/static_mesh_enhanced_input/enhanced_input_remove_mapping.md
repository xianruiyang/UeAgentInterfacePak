---
command: enhanced_input_remove_mapping
category: static_mesh_enhanced_input
title: EnhancedInput
summary: **Deprecated for authoring**：删除某条映射
aliases: []
tags: [static_mesh_enhanced_input, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：删除某条映射
deprecated_replacement: []
---

# `enhanced_input_remove_mapping`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：删除某条映射
- key_inputs: `action_path`, `key`, `mapping_context_path`
- key_returns: `mappings[]`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `action_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `key`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `mapping_context_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- `mappings[]`：mappings 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
