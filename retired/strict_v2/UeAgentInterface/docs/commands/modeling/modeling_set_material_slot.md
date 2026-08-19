---
command: modeling_set_material_slot
category: modeling
title: 将活动材质分配给选中面
summary: 启动 Edit Mesh Materials 工具并执行 AssignActiveMaterial，语义独立于新增或删除材质槽。
aliases: []
tags: [modeling, material, tool-wrapper]
status: active
---

# `modeling_set_material_slot`

## LLM Compact

- **用途**：对当前 Editor 选择启动 `BeginEditMeshMaterialsTool`，执行受支持动作 `AssignActiveMaterial`。
- **关键输入**：`tool_properties[]`、`accept`。
- **关键返回**：`invoked_action: AssignActiveMaterial`、`accepted` 和活动工具快照。
- **语义边界**：设置选中面的材质分配，不新增或删除材质槽。

## Authoring Notes

- 当前 Editor 选择必须能启动 Edit Mesh Materials 工具；面选择和活动材质由工具状态决定。
- wrapper 固定使用公开 registry 项 `BeginEditMeshMaterialsTool`，调用方不得传入 `tool_identifier`、`post_action` 或 `__uai_wrapper_command`。
- 只通过 `tool_properties[]` 导入属性。顶层 singleton `property_set`、`property_name`、`value_text` 已删除。
- 默认 `accept: false`，执行分配动作后保留工具活动状态，便于读回并决定接受或取消。

## Parameters

- `tool_properties`：可选数组。每项包含可选 `property_set`，以及必填的 `property_path`、`value_kind` 和 canonical `value`。
- `accept`：可选布尔值，默认 `false`。

## Returns

- `requested_tool_identifier: BeginEditMeshMaterialsTool`
- `invoked_action: AssignActiveMaterial`
- `accepted`：是否已经接受工具。
- 活动工具快照和属性导入结果。

## Errors

- `internal_tool_wrapper_parameters_forbidden`：调用方传入 wrapper 内部控制字段。
- `tool_properties_array_required`：使用顶层 singleton 属性字段，或 `tool_properties` 不是数组。
- 工具无法启动、动作无法执行或属性导入失败时，命令明确失败，不返回同义成功。

## Minimal Example

```hjson
{
  tool_properties: [
    {
      property_set: UEditMeshMaterialsToolProperties
      property_path: ActiveMaterial
      value_kind: object_ref
      value: { path: "/Game/Materials/M_Surface.M_Surface" }
    }
  ]
  accept: false
}
```

## Validation

1. 调用 `modeling_get_active_tool`，确认工具为 `BeginEditMeshMaterialsTool`。
2. 读回活动材质和面材质分配状态。
3. 调用 `modeling_accept_tool` 提交，或调用 `modeling_cancel_tool` 放弃。
