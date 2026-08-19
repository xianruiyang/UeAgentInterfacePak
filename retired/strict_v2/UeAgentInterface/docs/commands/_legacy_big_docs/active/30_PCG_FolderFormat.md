# PCG Folder Format

本分册记录 PCG 文件夹式 JSON 的稳定结构。命令参数和完整清单见 `29_PCG.md`；本分册只描述 schema、文件职责、验证顺序和当前边界，不重复登记命令清单。

## 紧凑返回契约

- `pcg_graph_export_folder`、`pcg_graph_validate_folder`、`pcg_graph_plan_folder`、`pcg_graph_diff_folder`、`pcg_graph_apply_folder` 默认按 `llm_compact` 返回 folder 路径、schema、目标资产、节点/边/参数计数、plan/diff/apply 结果摘要、issues/warnings 摘要和产物路径。
- 默认 `data` 不返回完整 `graph.json`、`nodes/*.json`、`coverage_report.json`、默认 graph dump 或大段 validation 明细；这些内容必须写入文件并通过 artifact/path 字段引用。
- 只有显式请求 debug/raw 视图时，才允许返回详细 coverage、节点属性明细、完整 diff 条目、preflight 细节或回滚诊断；默认返回仍应优先保证 LLM 可扫描。
- Graph 参数包和 GraphInstance 相关命令默认只返回参数 schema/value 摘要、写入计数和验证问题；完整参数包或实例快照应作为 artifact 输出。

## 适用范围

`ue_agent_interface.pcg.graph_folder.v1` 当前用于 `UPCGGraph` authoring。GraphInstance 参数 override 使用单 JSON 参数包；PCGDataAsset 管理使用 DataAsset JSON 入口。这样可以把复杂连线图、轻量参数实例和数据资产元信息分开，避免在同一个 folder schema 里混入不同生命周期。

典型流程：

```text
export folder -> edit graph.json / nodes/*.json -> validate -> plan -> diff -> apply -> compile -> snapshot
```

## 目录结构

| 文件 | 必需 | 职责 |
| --- | --- | --- |
| `asset.json` | 是 | 记录 schema、目标资产路径、对象路径和资产类型。 |
| `graph.json` | 是 | 记录 Graph 参数包、节点、边、graph settings 和计数。 |
| `nodes/index.json` | 导出时生成 | 记录节点 id 到 `nodes/*.json` 的映射，便于人工审查。 |
| `nodes/<node_id>.json` | 导出时生成 | 单节点完整导出副本；apply 以 `graph.json` 为准。 |
| `validation/coverage_report.json` | 导出时生成 | 记录导出覆盖范围、节点数、边数和文件清单。 |

最小 `asset.json`：

```json
{
  "schema": "ue_agent_interface.pcg.graph_folder.v1",
  "asset_path": "/Game/PCG/MyGraph",
  "asset_class": "/Script/PCG.PCGGraph"
}
```

最小 `graph.json`：

```json
{
  "schema": "ue_agent_interface.pcg.graph_folder.v1",
  "parameters": {
    "parameters": []
  },
  "nodes": [
    { "id": "__input__", "role": "input" },
    { "id": "__output__", "role": "output" }
  ],
  "edges": [],
  "node_count": 2,
  "edge_count": 0
}
```

## 节点结构

`id` 必须在同一个 Graph 内唯一。输入和输出节点使用保留 id `__input__`、`__output__`，普通节点必须提供 `settings_class`。`settings_class` 应来自运行时节点目录导出结果，不应手写猜测。

新增 PCG 节点前先运行 `pcg_node_catalog_export`，从 catalog 里选择真实 `settings_class`、pin 能力和 GPU/弃用状态；对已有图再用 `pcg_graph_export_folder` 和 `pcg_node_inspect` 读回当前节点结构。不要从 UI 菜单显示名或网络教程反推 `settings_class`。

输入/输出节点也是可回放节点。当前 authoring 使用 `settings_details` 指向的 grouped Details 字段描述 settings；旧 `settings_properties[]` 仅用于显式迁移或 debug/readback 识别，不作为编辑入口。普通节点导出的 `output_pins[]` 可作为动态 pin 提示；对 `UPCGUserParameterGetSettings`，apply 会用当前 settings Details 字段回放 `PropertyName`，确保 `Get Graph Parameter` 节点重新创建后仍输出 `Grammar`、`ModuleInfo`、`MeshInfo` 等参数 pin。

普通节点常用字段：

```hjson
{
  id: density_filter_1
  settings_class: /Script/PCG.PCGDensityFilterSettings
  authored_title: "Density Filter"
  pos_x: 480
  pos_y: 0
  enabled: true
  debug: false
  inspect: false
  settings_details: {path: details/density_filter_1/index.hjson}
}
```

当前写入使用 `settings_details` 指向的 `details/<owner>/index.hjson` 和 group HJSON。字段统一使用 `property_path/value_kind/value`，应从导出的 grouped Details 模板编辑 canonical `value`；旧 `settings_properties[]` 不属于当前 apply/edit 输入。

## Graph 参数包

Graph 参数包放在 `graph.hjson.parameters`，格式与 `pcg_graph_parameters_query` / `pcg_graph_parameters_apply_json` 相同。它由 `schema[]` 明确每个参数及递归容器类型，由 `fields{}` 保存 canonical value；apply 会在创建节点前后同一事务中解码完整参数包，并调用 UE 的 `UpdateUserParametersStruct` 触发 Graph 参数刷新。

```hjson
{
  parameters: {
    schema: [
      {name: Grammar, value_kind: string}
      {name: Density, value_kind: float}
    ]
    fields: {
      Grammar: {literal: "[Small1]{Large3,Large1}*[Large2]"}
      Density: {literal: 0.25}
    }
  }
}
```

数组和 set 参数必须在 schema 中通过递归 `element_type` 表达；struct 参数必须携带 `struct_path`。复杂参数应从 UE 实际资产导出后编辑，不能手写 ImportText。

## 边结构

边通过节点 id 和 pin 名称连接。空 pin 名按 UE / PCG 默认 pin 处理；只有目标节点对应方向仅有一个 pin 时才允许空 pin 自动落到该 pin，无法唯一解析时会在 validation / preflight 阶段报错。apply 后会再次读回验证连接确实存在，不能只相信 `AddLabeledEdge` 的返回路径。

```json
{
  "from": "__input__",
  "from_pin": "",
  "to": "density_filter_1",
  "to_pin": ""
}
```

folder validation 会检查节点 id、重复 id、节点类和边引用。apply 前还会在 transient graph 上预演节点创建、属性导入和连线，预演失败不会修改真实资产。导出结果会包含保留的 `__input__` / `__output__` 节点和所有可读边，便于把一次导出作为后续 authoring 模板。

## Graph Settings

Graph 级属性放在 `graph_settings.properties[]`：

```hjson
{
  graph_settings: {
    properties: [
      {property_path: bExposeToLibrary, value_kind: bool, value: {literal: false}}
    ]
  }
}
```

同样建议先导出已有 Graph，再在导出结果中修改字段。属性导入失败会在 preflight 阶段报错并阻断 apply。

## Apply 语义

默认 apply 会替换非输入/输出节点。需要增量追加时可以关闭 replace，但这种模式要求调用方明确已有目标 Graph 结构，通常只用于局部维护。

写入顺序：

```text
load asset.json / graph.json
validate folder
transient graph preflight
create or load target graph
transaction + apply nodes / edges / graph settings / graph parameters
optional save
return applied counts / issues / preflight report
```

失败规则：

- validation 失败：返回 folder validation issues，不触碰真实 Graph。
- preflight 失败：返回 preflight issues，不触碰真实 Graph。
- 真实 apply 异常失败：优先用写入前 snapshot 回滚已有 Graph，并返回 rollback 结果。
- 保存失败：返回保存错误；此时结构 apply 已成功但 package 持久化失败，需要调用方按保存错误处理。

同类写入保护也适用于 PCG 参数包和组件属性：`pcg_graph_parameters_apply_json`、`pcg_graph_instance_json` 和 `pcg_component_apply_json` 会先在参数包副本或 transient component 上验证输入。非法参数、未知父 GraphInstance 参数、坏属性名、坏属性 import text 或非法 `generation_trigger` 会在创建/修改真实对象前失败。

## 当前边界

- folder v1 会保存 Graph 自身 user parameters；GraphInstance override 仍用参数包入口。
- folder v1 不直接写入 PCGDataAsset data collection；DataAsset 当前只支持元信息和摘要读回。
- GPU/HLSL 节点默认只做 feature gate、静态识别和结构诊断，不默认启动高成本 profile 或 Insights trace。
- node inspection 当前以节点结构和 execution inspection 标记为主；完整点数据抽样走组件数据导出入口。
