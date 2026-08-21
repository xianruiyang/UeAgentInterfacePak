# Operations And Selectors

本页定义 authoring HJSON 中 selector 和 `operation` 的通用规则。`value` 负责普通值编辑，selector 负责定位对象，`operation` 负责非普通值意图。

## Selector 是定位，不是编辑

selector 必须足够稳定，让 adapter 找到当前 UE HJSON 中的同一个对象。

常见 selector：

| 域 | 典型 selector |
| --- | --- |
| Niagara | stage：script usage/usage id；module：node guid、script `path`、module name、`occurrence`；input：input name |
| Material | node id、node name、node class、pin name |
| Blueprint/UMG | component/widget id、graph name、node id、pin name |
| Sequence | binding id/name、track type、section id、control name、frame |
| ControlRig | hierarchy key、control name、graph name、pin path |
| Skeleton/IK | socket name、virtual bone name、goal name、chain name |
| ProjectSettings | settings container/category/section/page、field path |

selector 不应包含导出路径、行号、派生 count、runtime report 或旧 legacy path 字段。

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
- 改 object/class/asset `path`。
- 改 Niagara module input 的 `value.source`，除非域 recipe 明确要求。

## 新增结构的最小种子

LLM 可以用最小 seed 创建结构，让 adapter/UAI 补齐默认值。最小 seed 是“能唯一表达新增目标的最小 authoring”，不是完整 readback：只写身份、必要定位上下文、必要 `operation` 和用户要改的初始字段。

涉及节点、模块、组件、控件、Material expression 或 Niagara dynamic input 时，先调用对应领域的 exact candidate command，并按该领域合同原样使用 executable `name`/path、`binding_revision` 与必要 context；完整链路见 `00_DirectHjsonAuthoring.md`。

| 结构 | 最小 seed |
| --- | --- |
| Blueprint component | 当前 `blueprint.component.candidates` 返回的完整 `candidate` object 原样写入 Blueprint root entry；另写 stable map key、`operation` 与 parent，native `name/class` 由服务端校验后展开。 |
| UMG widget | path-backed Widget 写 `path`；无路径候选写 `name`；需要挂载时额外写 `parent_widget_id`，slot 按父容器类型补。 |
| Material node | 内置 expression 通常写 `name`；Material Function Call 或明确 class/asset 时写 `path`；`node_id` 可由 adapter 从 `name` 默认生成。 |
| Blueprint graph node | 当前 Branch 创建使用 `blueprint.node.candidates` 返回的完整 `candidate` object；graph stable map key、node stable id、`operation` 与 placement 另写。函数、事件和变量仍按各自明确合同，不能套用 Branch 字段。 |
| Niagara dynamic input | path-backed script 写 `path`；无路径候选写 `name`；只放在某个 module input 的 `value` 位置。 |
| Niagara module | stage 写 `apply_mode: patch`；module 写 `operation: upsert` + `path` 或 `name` + `inputs: []`。需要定位多个同脚本实例时补 `occurrence`。 |
| Socket | `socket_name` + parent bone/component |
| ControlRig control | `name` + control type/settings |
| ProjectSettings field | field path + typed value |

如果最小 seed 不足，adapter 应报错，而不是猜。apply 成功后必须重新 export/readback，由读回的新结构补齐后续可编辑字段。

## Operation 示例

新增节点：

```json
{
  "operation": "add",
  "name": "Noise",
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

## Graph 文件边界

- `graphs/items/<graph_id>/graph.hjson` 保存逻辑整体：nodes、pins、links、entry/local graph metadata。
- `graphs/items/<graph_id>/layout.hjson` 保存视觉布局：节点位置、注释框、折叠状态和视图辅助信息。
- 默认 authoring 不使用旧平铺 `graphs/<name>.hjson`；旧文件不是兼容输入，必须先显式转换成当前 contract。

## 失败策略

以下情况必须失败或产生明确 warning：

- selector 找不到目标。
- selector 匹配多个目标。
- `operation` 未实现。
- 删除/替换会影响未声明对象。
- 最小 seed 不足。
- LLM 提供的是 readback/debug/legacy 字段而不是 authoring 字段。
- path-backed 实体用旧 `full_name`、`asset_path`、`class_path` 等字段作为主输入。
