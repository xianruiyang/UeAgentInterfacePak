---
command: modeling_start_tool
category: modeling
title: 按公开 Registry 启动 Modeling Tool
summary: 仅按公开 Modeling registry 启动受支持的工具，并通过 tool_properties[] 导入工具属性。
aliases: []
tags: [modeling, tool, lifecycle]
status: active
---

# `modeling_start_tool`

## LLM Compact

- **用途**：对当前 Editor 选择启动公开 registry 中的 Modeling Tool。
- **关键输入**：`tool_identifier`、`tool_properties[]`、`accept`。
- **关键返回**：`requested_tool_identifier`、`accepted`、活动工具快照和属性导入结果。
- **限制**：未知、未公开或内部工具标识会被拒绝；不能借此命令调用任意 Interactive Tool。
- **属性入口**：只接受 `tool_properties[]`。顶层 `property_set`、`property_name`、`value_text` 已删除。
- **Primitive 边界**：`bounds`、`collision`、`label`、`folder_path` 等 Primitive 参数只允许 7 条 `modeling_create_*` wrapper，不能传给本命令。

## Authoring Notes

- 工具作用于当前 Editor 选择；本命令不接受资产路径或目标 Actor 参数来替代选择。
- 优先调用语义明确的公开 wrapper。只有已知 canonical `tool_identifier` 且没有专用 wrapper 语义时，才直接调用本命令。
- registry 在执行前完成解析。未知标识、内部标识或没有公开注册的引擎工具不会进入 Editor Tool 启动流程。
- `accept: false` 默认只启动工具并保留活动状态；后续使用 `modeling_accept_tool` 或 `modeling_cancel_tool`。
- `accept: true` 会在属性导入后尝试接受工具。对破坏性或需要人工确认的操作，应先读回活动工具状态。

## Parameters

- `tool_identifier`：必填。必须解析为下列公开 registry 中的 canonical identifier。
- `tool_properties`：可选数组。每项包含：
  - `property_set`：可选；目标 PropertySet 类名或公开名称。
  - `property_path`：必填；目标 PropertySet 内的 canonical authored 属性名。
  - `value_kind`：必填；必须与目标 `FProperty` 的公共 codec 类型一致。
  - `value`：必填；使用 `uai.uobject_properties.v2` canonical value shape。
- `accept`：可选布尔值，默认 `false`。

以下顶层字段无效并会明确失败：

- `property_set`
- `property_name`
- `value_text`
- `__uai_wrapper_command`
- `post_action`

## Registry Allowlist

公开 canonical identifiers：

- Primitive：`BeginAddBoxPrimitiveTool`、`BeginAddCylinderPrimitiveTool`、`BeginAddSpherePrimitiveTool`、`BeginAddRectanglePrimitiveTool`、`BeginAddStairsPrimitiveTool`、`BeginAddRampPrimitiveTool`、`BeginAddRampCornerPrimitiveTool`
- Mesh 管理：`BeginConvertMeshesTool`、`BeginDuplicateMeshesTool`
- Poly/Selection：`BeginSelectionExtrudeTool`、`BeginPolyEditTool`、`BeginSelectionOffsetTool`、`BeginWeldEdgesTool`、`BeginHoleFillTool`
- Boolean/Cut：`BeginMeshBooleanTool`、`BeginMeshTrimTool`、`BeginPlaneCutTool`、`BeginCutMeshWithMeshTool`、`BeginVoxelBooleanTool`
- Remesh：`BeginRemeshMeshTool`、`BeginSimplifyMeshTool`、`BeginSubdividePolyTool`
- Transform/Normals：`BeginMirrorTool`、`BeginEditNormalsTool`、`BeginBakeTransformTool`、`BeginAlignObjectsTool`
- UV：`BeginGlobalUVGenerateTool`、`BeginUVProjectionTool`
- Material/Collision：`BeginEditMeshMaterialsTool`、`BeginSimpleCollisionEditorTool`、`BeginSetCollisionGeometryTool`

allowlist 只定义允许启动的公开工具边界，不表示所有工具都适合直接调用。专用 wrapper 仍负责额外动作、安全门禁和返回语义。

## Returns

- `requested_tool_identifier`：registry 解析后的 canonical identifier。
- `accepted`：本次是否已经接受工具。
- 活动工具快照：当前活动工具、属性集和可用生命周期动作。
- 属性导入结果：已应用或失败的 `tool_properties[]` 项。

## Errors

- `tool_identifier_not_allowed`：标识不在公开 registry、属于内部工具或无法解析。
- `tool_properties_array_required`：使用了已删除的顶层 singleton 属性字段，或 `tool_properties` 不是数组。
- `internal_tool_wrapper_parameters_forbidden`：调用方传入 wrapper 内部控制字段。
- `primitive_parameters_require_create_wrapper`：向本命令传入 Primitive 专用字段。

## Minimal Example

```hjson
{
  tool_identifier: BeginEditNormalsTool
  tool_properties: [
    {
      property_path: FixInconsistentNormals
      value_kind: bool
      value: {literal: true}
    }
  ]
  accept: false
}
```

## Validation

1. 调用 `modeling_get_active_tool`，确认活动工具的 canonical identifier。
2. 检查属性读回与 `tool_properties[]` 导入结果。
3. 根据任务调用 `modeling_accept_tool` 或 `modeling_cancel_tool`，再确认工具已退出。
