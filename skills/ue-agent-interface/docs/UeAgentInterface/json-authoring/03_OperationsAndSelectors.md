# Operations And Selectors

本页定义 authoring JSON 中 selector 和 `operation` 的通用规则。`value` 负责普通值编辑，selector 负责定位对象，`operation` 负责非普通值意图。

## Selector 是定位，不是编辑

selector 必须足够稳定，让 adapter 找到当前 UE JSON 中的同一个对象。

常见 selector：

| 域 | 典型 selector |
| --- | --- |
| Niagara | stage/module/input：stage name、script usage、module name、input name |
| Material | node id、node name、node class、pin name |
| Blueprint/UMG | component/widget id、graph name、node id、pin name |
| Sequence | binding id/name、track type、section id、control name、frame |
| ControlRig | hierarchy key、control name、graph name、pin path |
| Skeleton/IK | socket name、virtual bone name、goal name、chain name |
| ProjectSettings | settings container/category/section/page、field path |

selector 不应包含导出路径、行号、派生 count 或 runtime report。

## Operation 何时需要

需要 `operation` 的情况：

- 新增结构：component、widget、node、module、socket、track、section、row。
- 删除结构：remove node、remove link、remove socket、remove virtual bone。
- 替换结构：replace graph nodes、replace binding、replace full list。
- 清空状态：clear override、clear binding、clear key。
- 重命名：rename graph/member/module。
- 一次性 action：retarget batch、packaging plan、dry-run config patch。

不需要 `operation` 的情况：

- 改 bool/number/string/enum。
- 改 vector/color/transform 的已有值。
- 改 object path/class path。
- 改 Niagara module input 的 `value.source`，除非域 recipe 明确要求。

## 新增结构的最小种子

LLM 可以用最小种子创建结构，让 adapter/UAI 补齐默认值。最小种子是“能唯一表达新增目标的最小 authoring”，不是完整 readback：只写身份、必要定位上下文、必要 `operation` 和用户要改的初始字段。涉及节点、模块、组件、控件、Material expression 或 Niagara dynamic input 时，优先直接使用 `node_catalog_search.items[].json_authoring` 或 `json_authoring.seed`；完整链路见 `00_DirectJsonAuthoring.md`。

| 结构 | 最小种子 |
| --- | --- |
| Blueprint component | `node_catalog_search(catalog_type=actor_component)` 返回的 `json_authoring` 或 `seed.kind/name/full_name`；`component_id/component_class/relative_transform` 可由 adapter 默认补齐。 |
| UMG widget | `node_catalog_search(catalog_type=umg_widget)` 返回的 `json_authoring` 或 `seed.kind/name/full_name`；需要挂载时额外写 `parent_widget_id`，slot 按父容器类型补。 |
| Material node | `node_catalog_search(catalog_type=material_expression/material_function_call/material_node)` 返回的 `json_authoring` 或 `seed.kind/name/full_name`；`node_id` 可由 adapter 从 `name` 默认生成。 |
| Blueprint graph node | `node_catalog_search(catalog_type=blueprint_node/blueprint_call_function/blueprint_event/blueprint_variable_node)` 返回的 `json_authoring` 或 `seed.kind/name/full_name`；必须有正确 graph/pin 上下文，并通过 compile/readback 验证。 |
| Niagara dynamic input | `node_catalog_search(catalog_type=niagara_dynamic_input)` 返回的 `json_authoring` 或 `seed.kind/name/full_name`；只放在某个 module input 的 `value` 位置。 |
| Niagara module | `node_catalog_search(catalog_type=niagara_module)` 返回的 `kind/name/full_name`；当前 adapter 只匹配已有导出 module，新增 stack module 必须等 folder apply 明确支持后再写。 |
| Socket | `socket_name` + parent bone/component |
| ControlRig control | `name` + control type/settings |
| ProjectSettings field | field path + typed value |

如果最小种子不足，adapter 应报错，而不是猜。apply 成功后必须重新 export/readback，由读回的新结构补齐后续可编辑字段。

## Operation 示例

新增节点：

```json
{
  "operation": "add",
  "node_id": "NoiseA",
  "node_class": "/Script/Engine.MaterialExpressionNoise",
  "layout": {
    "position": { "x": 100, "y": 220 },
    "space_contract": { "...": "..." }
  }
}
```

删除连线：

```json
{
  "operation": "remove",
  "from": { "node_id": "NoiseA", "pin": "Result" },
  "to": { "node_id": "MultiplyA", "pin": "A" }
}
```

普通改值：

```json
{
  "input_name": "Roughness",
  "type_info": "float",
  "value": { "literal": 0.35 }
}
```

## 失败策略

以下情况必须失败或产生明确 warning：

- selector 找不到目标。
- selector 匹配多个目标。
- `operation` 未实现。
- 删除/替换会影响未声明对象。
- 最小种子不足。
- LLM 提供的是 readback 字段而不是 authoring 字段。
