# PCG Folder Format

本分册记录 PCG 文件夹式 JSON 的稳定结构。命令参数和完整清单见 `29_PCG.md`；本分册只描述 schema、文件职责、验证顺序和当前边界，不重复登记命令清单。

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

输入/输出节点也是可回放节点。`settings_properties[]` 中的 `Pins` 会应用到 `__input__` / `__output__` 对应的 `UPCGGraphInputOutputSettings`，用于恢复 Spline、Point、Param 等自定义 pin。普通节点导出的 `output_pins[]` 可作为动态 pin 提示；对 `UPCGUserParameterGetSettings`，apply 会用第一个导出输出 pin label 回放 `PropertyName`，确保 `Get Graph Parameter` 节点重新创建后仍输出 `Grammar`、`ModuleInfo`、`MeshInfo` 等参数 pin。

普通节点常用字段：

```json
{
  "id": "density_filter_1",
  "settings_class": "/Script/PCG.PCGDensityFilterSettings",
  "authored_title": "Density Filter",
  "pos_x": 480,
  "pos_y": 0,
  "enabled": true,
  "debug": false,
  "inspect": false,
  "settings_properties": [
    {
      "name": "LowerBound",
      "value_text": "0.25"
    }
  ]
}
```

`settings_properties[]` 使用 UE property import text 写入。优先从导出的模板改 `value_text`，不要凭记忆拼复杂结构。对节点 settings 上的一级 instanced UObject 子对象支持点路径写入与导出，例如 `MeshSelectorParameters.MeshEntries`、`MeshSelectorParameters.AttributeName`、`MeshSelectorParameters.bUseAttributeMaterialOverrides`。`UPCGStaticMeshSpawnerSettings.MeshSelectorType` 会在导入 class 文本后实例化对应 selector 子对象，因此官方 Shape Grammar 栅栏示例里的 `PCGMeshSelectorByAttribute` 可以通过 folder JSON 复原。更深层或数组元素内部字段仍建议整体用 ImportText 写回。

## Graph 参数包

Graph 参数包放在 `graph.json.parameters.parameters[]`，格式与 `pcg_graph_parameters_query` / `pcg_graph_parameters_apply_json` 相同。导出时会保留 `type`、`type_object`、`container_type`、`container_types` 和 `value_text`；apply 会在创建节点前后同一事务中回放参数包，并调用 UE 的 `UpdateUserParametersStruct` 触发 Graph 参数刷新。

```json
{
  "parameters": {
    "parameters": [
      {
        "name": "Grammar",
        "type": "String",
        "container_type": "None",
        "container_types": [],
        "type_object": "",
        "value_text": "[Small1]{Large3,Large1}*[Large2]"
      },
      {
        "name": "ModuleInfo",
        "type": "Struct",
        "container_type": "Array",
        "container_types": ["Array"],
        "type_object": "/Script/PCG.PCGSubdivisionSubmodule",
        "value_text": "((Symbol=\"Large1\",bScalable=True))"
      }
    ]
  }
}
```

数组和 set 参数必须通过 `container_types` 或兼容字段 `container_type` 表达；否则只会创建标量参数。复杂参数仍应从 UE 实际资产导出后编辑，不应手写完整 import text。

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

```json
{
  "graph_settings": {
    "properties": [
      {
        "name": "bExposeToLibrary",
        "value_text": "False"
      }
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
