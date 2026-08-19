---
command: modeling_add_material_slot
category: modeling
title: 新增材质槽
summary: 独立的 AddMaterialSlot 语义入口；UE 5.6 Modeling 工具不支持该动作，因此命令明确失败。
aliases: []
tags: [modeling, material, unsupported]
status: active
---

# `modeling_add_material_slot`

## LLM Compact

- **用途**：表达“新增材质槽”的独立动作，不复用设置材质或删除材质槽的语义。
- **UE 5.6 状态**：`UEditMeshMaterialsTool` 不提供受支持的 `AddMaterialSlot` 动作；命令明确返回 unsupported。
- **不得假定**：失败时不会新增槽、不会分配活动材质，也不会返回同义成功。

## Authoring Notes

- 此命令保留独立接口和错误语义，避免把 `set`、`add`、`remove` 三种操作合并为同一成功路径。
- 在 UE 5.6 中，unsupported 检查发生在工具启动和资产修改之前。
- 不要把 `modeling_set_material_slot` 当作新增材质槽的替代命令；它只执行 `AssignActiveMaterial`。

## Parameters

UE 5.6 不接受可导致该动作成功的参数。调用方不得通过 `tool_identifier`、`post_action` 或其他内部字段绕过动作支持检查。

## Returns

UE 5.6 无成功返回；命令返回明确错误：

- `modeling_add_material_slot_action_unsupported`

## Validation

确认返回 `modeling_add_material_slot_action_unsupported`，并确认没有启动活动 Modeling Tool、没有修改材质槽或资产。
