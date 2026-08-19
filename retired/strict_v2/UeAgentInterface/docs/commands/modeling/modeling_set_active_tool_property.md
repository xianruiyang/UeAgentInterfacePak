---
command: modeling_set_active_tool_property
category: modeling
title: 设置当前 Modeling Tool 属性
summary: 使用公共 UObject v2 codec 原子设置一个活动工具 PropertySet 属性。
aliases: []
tags: [modeling, property, uobject]
status: active
---

# `modeling_set_active_tool_property`

## LLM Compact

- **用途**：对当前活动 Modeling Tool 的一个 PropertySet 原子写入一个属性。
- **关键输入**：`tool_properties[]`，且数组必须恰好包含一项。
- **属性契约**：`property_set + property_path + value_kind + value`；后三项使用 `uai.uobject_properties.v2`。
- **关键返回**：`property_results[]` 与活动工具 readback。

## Parameters

`tool_properties[]` 每项包含：

- `property_set`：可选。PropertySet 类名或公开名称；省略时只允许唯一匹配。
- `property_path`：必填。canonical authored property name，不接受 `property_name`。
- `value_kind`：必填。必须与实际 `FProperty` 一致。
- `value`：必填。公共 codec 的 canonical value，不接受 `value_text`。

```hjson
{
  tool_properties: [
    {
      property_set: MeshEditingViewProperties
      property_path: bShowWireframe
      value_kind: bool
      value: {literal: true}
    }
  ]
}
```

## Validation

检查 `property_results[0].status=applied`，并从同一响应的活动工具 PropertySet readback 确认 canonical 值。失败时整个单属性写入不提交。
