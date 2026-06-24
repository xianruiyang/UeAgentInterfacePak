# 指令详解：Node Graph

本分册描述跨资产的通用节点图排布入口。这里的“节点图”特指横向的 **节点 + 接口/Pin + 连线** 图；竖向层级图、栈式编辑器和 UI 设计器布局不纳入本算法。

## 节点发现边界

`node_graph_list` / `node_graph_layout` 是跨资产图枚举与排布入口，不是通用“节点 palette 生成器”。它们能可靠告诉调用方：当前资产里有哪些图、已有节点、pin、连线、真实几何和 adapter 类型；它们不能证明某个从未出现过的业务节点、组件、控件或模块可以被安全新增。新增业务节点、Blueprint component、UMG widget、Niagara 模块、Niagara 动态输入或 Material expression 前，优先使用 `node_catalog_search` 查真实 palette/candidate；分类不明确时先用 `node_catalog_categories`。

新增或替换业务节点前，必须回到对应域的发现入口：

| 域 | 业务节点候选来源 |
| --- | --- |
| Blueprint / UMG K2 | `node_catalog_search(catalog_type=blueprint_node)`；有真实上下文时传 `asset_path`、`graph_name`、可选 `node_guid/pin_guid/pin_name`。若从某个 pin 拉线查节点，必须传对应 pin 上下文，让 search 结果反映上下文候选。再结合 `blueprint_list_graphs`、`blueprint_inspect_nodes`、`blueprint_export_folder` / `umg_export_folder` 读回现有图。 |
| Actor Blueprint Components | `node_catalog_search(catalog_type=actor_component)` 查 Add Component 菜单同源候选；把返回的 `json_authoring` 或 `json_authoring.seed` 放入 `components[]`，adapter 从 `full_name` 补 `component_class/class`。 |
| UMG WidgetTree Widgets | `node_catalog_search(catalog_type=umg_widget)` 查 UMG Palette 同源控件候选；把返回的 `json_authoring` 或 `json_authoring.seed` 放入 `widget_tree.widgets[]`，adapter 从 `full_name` 补 `widget_class`。 |
| AnimBlueprint | `anim_blueprint_list_graphs`、`anim_blueprint_inspect_nodes`、`anim_blueprint_export_folder`；复杂 AnimGraph node 需要导出模板或已实现 profile。 |
| Material / Material Function | `node_catalog_search(catalog_type=material_expression/material_function_call/material_node)` 查 expression class / function call；有真实图上下文时传 `asset_path`、`graph_name`、可选 `node_guid/pin_guid/pin_name`。若从某个 Material pin 拉线查表达式或函数，必须传对应 pin 上下文，让 search 结果走 `UMaterialGraphSchema` 的 context menu 并按 pin 类型过滤。再用 `material_export_folder`、`material_function_export_folder` 读回现有图。 |
| Niagara | `node_catalog_search(catalog_type=niagara_module/niagara_dynamic_input/niagara_graph_node)` 查 Stack 模块、模块输入动态来源和 script graph function call；再用 `niagara*_export_folder`、`niagara_emitter_list_*`、`niagara_system_list_*`、`niagara_script_export_folder` 读回当前 stack/input/graph。 |
| PCG | `pcg_node_catalog_export`、`pcg_graph_export_folder`、`pcg_node_inspect`。 |
| Control Rig / RigVM | `control_rig_export_folder`、`validation/rigvm_unit_registry.json`、`control_rig_validate_folder`、`control_rig_get_info`。 |

如果节点候选、pin 或属性只能靠猜测得到，不能进入 `node_graph_layout` 或 folder apply 的写入流程；应先补对应域的查询命令或用现有资产导出模板取证。

## 指令列表

| 指令 | 作用 | 关键参数 | 返回 |
|---|---|---|---|
| `node_catalog_search` | 查询 UE palette/action menu 风格的可新增节点、模块或输入来源候选，供 LLM 写 JSON 前取证 | `catalog_type`、`query.text`、`filters`、`page`、可选 `context.asset_path/graph_name/node_guid/pin_guid/pin_name`、`candidate_id`、`view.include_legacy_authoring/include_debug_fields` | `counts`、`groups`、`category_tree`、`items[]`、`items[].kind/name/full_name/json_authoring`、`warnings` |
| `node_catalog_categories` | 查询同一候选源的分类/分组统计；当 LLM 不确定 UE 菜单分类时先用它缩小范围 | `catalog_type`、可选 `query.text`、`filters`、`context` | `counts`、`groups`、`category_tree`、`warnings` |
| `node_origin_resolve` | 根据 catalog 候选、`kind/name/full_name`、JSON 指针或 UE 对象身份返回资产/源码路径 | `target.source`、`target.kind/name/full_name`、`target.json_file/json_pointer`、`target.candidate_id` | `resolved`、`status`、`target`、`origin.asset_paths/package_paths/package_files/code_paths[]`、`warnings` |
| `node_graph_list` | 枚举一个资产内可由通用节点图排布入口识别的图 | `asset_path`、可选 `adapter`、`include_nested_graphs`、`graph_selector` | `asset_path`、`object_path`、`asset_class`、`adapter`、`graphs[]`、`graph_count` |
| `node_graph_layout` | 对一个资产内指定或批量选中的节点连线图执行自动排布 | `asset_path`、可选 `adapter`、`graph_selector`、`layout_options`、`compile_after_layout`、`save_after_layout` | `asset_path`、`adapter`、`graphs[]` 或 `nodes[]`、`changed`、`saved`、`node_count`、`edge_count`、`moved_node_count` |

## 节点候选查询：node_catalog_search / categories

`node_catalog_search` 是 LLM authoring 前的统一 palette/candidate 查询入口。它复用 UE 编辑器侧的真实候选来源：Blueprint 使用 `FBlueprintActionMenuUtils`，Actor Component 使用 `FComponentTypeRegistry`，UMG Widget 使用 UMG Palette 分类和 WidgetBlueprint asset registry，Material 使用 `UMaterialGraphSchema` / Material Editor action，Niagara 使用 Niagara Editor filtered script asset library。不要用旧教程或记忆直接拼 `node_class`、`function_name`、`module_script_path`、`component_class` 或 `widget_class`。新结构化 JSON 的主身份字段固定为 `kind/name/full_name`：

- `name`：来自 UE 右键/Palette 菜单同源英文名称，供 LLM 阅读和搜索。
- `full_name`：能稳定解析到当前 UE 对象的类、函数、属性或资产路径，供 JSON authoring 和 `node_origin_resolve` 使用。
- `kind`：节点/模块/组件/控件类型，例如 `niagara_module`、`niagara_dynamic_input`、`niagara_graph_function`、`material_expression`、`material_function_call`、`blueprint_call_function`、`blueprint_event`、`blueprint_variable_node`、`blueprint_node`、`actor_component`、`umg_widget`。

旧字段如 `display_name`、`stable_id`、`canonical_key`、`package_path`、`object_path`、`recommended_authoring` 只在 `view.include_debug_fields=true` 或 `view.include_legacy_authoring=true` 时作为迁移/调试兼容输出；新教程和新 authoring 不以这些字段为主路径。

结构化 JSON 直接编辑主链路见 `../json-authoring/00_DirectJsonAuthoring.md`。`node_catalog_search` 的职责是提供当前 UE 会话真实可用的候选和最小 `json_authoring` seed；它不替代目标资产导出、连线、layout、属性补写、compile 或 readback 验证。

同一套请求参数也用于：

- `node_catalog_categories`：只看 `groups` 和 `category_tree`，适合先了解 UE 菜单分类。

### 请求参数

```json
{
  "catalog_type": "niagara_module",
  "query": { "text": "location", "search_mode": "fuzzy" },
  "filters": {
    "library_only": true,
    "source": ["niagara", "game", "plugins"],
    "target_usage": "particle_update",
    "suggested_filter": "all"
  },
  "page": { "offset": 0, "limit": 20, "sort": "ui_order" },
  "context": {
    "asset_path": "/Game/Blueprints/BP_Door",
    "graph_name": "EventGraph",
    "node_guid": "",
    "pin_guid": "",
    "pin_name": ""
  },
  "view": {
    "include_legacy_authoring": false,
    "include_debug_fields": false
  }
}
```

`catalog_type` 当前支持：

| `catalog_type` | 候选来源 | 推荐写入 |
| --- | --- | --- |
| `niagara_module` | Niagara module script library | 写入 `kind/name/full_name`，adapter 兼容旧 `module_script_path` |
| `niagara_dynamic_input` | Niagara dynamic input script library | module input `value.source=dynamic_input` + `dynamic_input.kind/name/full_name` |
| `niagara_graph_node` | Niagara function script library；返回 `kind=niagara_graph_function` | `UNiagaraNodeFunctionCall` in `niagara_script_export_folder/apply_folder` graph JSON |
| `material_expression` | Material expression palette | `kind=material_expression` + expression class `full_name` |
| `material_function_call` | Material Function library | `kind=material_function_call` + material function asset `full_name` |
| `material_node` | Material expression + function call | 按候选 `kind` 决定 |
| `blueprint_node` | Blueprint action menu | `kind/name/full_name`；adapter 兼容 function/event/variable/node_class 旧字段 |
| `blueprint_call_function` | Blueprint action menu 中的函数调用候选 | `kind=blueprint_call_function` + UFunction `full_name` |
| `blueprint_event` | Blueprint action menu 中的事件候选 | `kind=blueprint_event` + UFunction `full_name` |
| `blueprint_variable_node` | Blueprint action menu 中的变量 get/set 候选 | `kind=blueprint_variable_node` + FProperty `full_name` |
| `actor_component` | Actor Blueprint Add Component 菜单候选 | `json_authoring.seed` 可直接放入 `components[]`；adapter 从 `full_name` 补 `component_class` |
| `umg_widget` | UMG Palette 控件候选，包括可用原生控件和 WidgetBlueprint 资产 | `json_authoring.seed` 可直接放入 `widget_tree.widgets[]`；adapter 从 `full_name` 补 `widget_class` |

直接用于结构化 JSON 的状态：

| catalog / kind | 状态 |
| --- | --- |
| `actor_component`、`umg_widget` | 最完整；可直接把 `json_authoring` 或 `seed` 放入对应 authoring 数组，apply/readback 补齐 template、slot、properties 等真实信息。 |
| `material_expression`、`material_function_call` | 可直接创建节点；连线、root input、layout 和属性仍需在 JSON 中另写。 |
| `niagara_dynamic_input` | 可直接作为某个 module input 的 `value`；不是独立节点或 stack module。 |
| `blueprint_call_function`、`blueprint_event`、`blueprint_variable_node`、`blueprint_node` | 条件支持；需要正确 Blueprint/Graph/Pin 上下文，apply 后以 compile/readback 为准。 |
| `niagara_module` | 只保证匹配已有导出 module 并编辑 input；目标 stage 中不存在该 module 时返回 `selector_not_found`，当前不能当成“只写名称新增 stack module”。 |
| `niagara_graph_function` | seed 可用于 Niagara Script graph authoring，但必须按 `niagara_script_export_folder/apply_folder` 的图 JSON 和 compile/readback 验证。 |

`filters.source` 支持 `niagara`/`engine`、`game`/`project`、`plugins`、`developer`。Niagara 默认包含 Niagara、Game、Plugins，不包含 Developer。Blueprint 没有 `asset_path` 时会用 transient Actor Blueprint 作为基础上下文，并在 `warnings` 中说明缺少项目变量、组件、选中 Actor 和 pin context。Actor component 和 UMG widget 候选会按真实 class/asset 路径标记 `source_origin`，可用同一 `filters.source` 缩小到 project/engine/plugins/developer。Material 带 `pin_guid` 或 `pin_name` 时必须同时提供 `asset_path`；已有图不会被 search 重建，避免 readback 取得的 pin identity 在查询时失效。

### 返回字段

每个 `items[]` 默认包含：

| 字段 | 含义 |
| --- | --- |
| `candidate_id` | 本次 search 结果的精确展开键；不写入结构化 JSON。 |
| `kind` / `name` / `full_name` | LLM-facing 主身份字段；`name` 用于阅读，`full_name` 用于稳定写入和来源解析。 |
| `category_path` / `section` / `type` | UE 菜单分类、分组和兼容类型。`type` 与 `kind` 同步。 |
| `source_origin` / `source_label` | 候选来源。 |
| `write_support` / `support_reason` | 当前推荐写入通道和原因。 |
| `json_authoring` | 基于 `kind/name/full_name` 的最小 authoring seed。可把整个对象粘进对应 authoring 列表/值位置，adapter 会解包 `seed`；也可只复制 `seed`。 |

需要迁移旧脚本或排查底层路径时，显式打开：

```json
{
  "catalog_type": "niagara_module",
  "candidate_id": "niagara_module:/Niagara/Modules/Spawn/Location/SystemLocation.SystemLocation",
  "view": {
    "include_legacy_authoring": true,
    "include_debug_fields": true
  }
}
```

此时可额外返回 `legacy_authoring` / `recommended_authoring`、`stable_id`、`canonical_key`、`display_name`、`package_path`、`object_path`。这些字段只用于兼容、readback 或调试，不作为新 authoring 主路径。

### json_authoring seed

`json_authoring` 的结构固定为：

```json
{
  "schema": "uai.catalog_authoring_seed.v1",
  "route": "blueprint_umg_authoring_profile",
  "target": "blueprint.components[]",
  "profile_path": "components[]",
  "readback_after_apply": true,
  "seed": {
    "operation": "upsert",
    "kind": "actor_component",
    "name": "Static Mesh",
    "full_name": "/Script/Engine.StaticMeshComponent"
  }
}
```

- `seed.kind/name/full_name` 是写入和来源解析的统一身份；`name` 只用于阅读和生成默认本地 id，稳定解析必须靠 `full_name`。
- 调用方可以把整个 `json_authoring` 对象放入 `profile_path` 指定的位置；当前 Blueprint/UMG、Material、Niagara input adapter 会自动解包 `seed`。
- Actor Component seed 可省略 `component_id/component_class/relative_transform`：adapter 会由 `name` 生成默认 `component_id`，由 `full_name` 补 `component_class`，并写入零位移/零旋转/一缩放的 `component_parent_relative` 默认 transform。
- UMG Widget seed 可省略 `widget_id/widget_class`：adapter 会由 `name` 生成默认 `widget_id`，由 `full_name` 补 `widget_class`。若写了 `parent_widget_id`，adapter 会把该控件补进父控件的 `children`。
- Material seed 可省略 `node_id`：adapter 会由 `name` 生成默认节点 id。函数调用节点用 `kind=material_function_call` 和函数资产 `full_name`。
- Niagara dynamic input seed 可直接作为某个 input 的 `value`，adapter 会把 `dynamic_input.full_name` 转为 legacy `script_asset_path`。Niagara module seed 当前用于匹配已有导出 module 并修改其 input；如果目标 stage 中没有该 module，adapter 会明确报 `selector_not_found`，不会伪造新增 module。
- 只写显示 `name` 而没有 `full_name` 不是稳定 authoring；这种输入应视为信息不足，先重新用 `node_catalog_search` 查询候选。

### 示例

查 Niagara Location 模块：

```json
{
  "catalog_type": "niagara_module",
  "query": { "text": "location" },
  "filters": { "library_only": true, "source": ["niagara", "game", "plugins"] },
  "page": { "limit": 5 }
}
```

查 Niagara 输入下拉里的 Random 动态输入：

```json
{
  "catalog_type": "niagara_dynamic_input",
  "query": { "text": "random" },
  "filters": { "library_only": true },
  "page": { "limit": 5 }
}
```

查 Niagara script graph 里的 function call 候选：

```json
{
  "catalog_type": "niagara_graph_node",
  "query": { "text": "vector" },
  "filters": { "library_only": true },
  "page": { "limit": 5 }
}
```

查 Material Add expression：

```json
{
  "catalog_type": "material_expression",
  "query": { "text": "add" },
  "page": { "limit": 5 }
}
```

查 Blueprint 函数节点，最好传真实 Blueprint/Graph；没有上下文时只用于粗搜：

```json
{
  "catalog_type": "blueprint_node",
  "query": { "text": "print string" },
  "context": {
    "asset_path": "/Game/Blueprints/BP_Door",
    "graph_name": "EventGraph"
  },
  "page": { "limit": 10 }
}
```

查 Actor Blueprint 可添加组件：

```json
{
  "catalog_type": "actor_component",
  "query": { "text": "Static Mesh" },
  "page": { "limit": 5 }
}
```

返回候选的 `json_authoring.seed` 可放入 Blueprint/UMG authoring profile 的 `components[]`。adapter 会把 `full_name` 转为 folder JSON 所需的 `class/component_class`，apply 后重新 export/readback 会补齐真实 template、properties 和 generated 字段。

查 UMG WidgetTree 可添加控件：

```json
{
  "catalog_type": "umg_widget",
  "query": { "text": "Button" },
  "page": { "limit": 5 }
}
```

返回候选的 `json_authoring.seed` 可放入 Widget Blueprint authoring profile 的 `widget_tree.widgets[]`。需要挂到某个容器下时，在 seed 中写 `parent_widget_id`；adapter 会生成 folder JSON 的 `id/widget_class/children` 关系，apply 后重新 export/readback 会补齐 slot、properties 和变量状态。

分类不明确时先查分类：

```json
{
  "catalog_type": "niagara_module",
  "query": { "text": "location" },
  "filters": { "library_only": true }
}
```

候选选定后如需查看资产或源码来源，用同一组 `kind/name/full_name` 调 `node_origin_resolve`：

```json
{
  "target": {
    "source": "name_reference",
    "kind": "niagara_module",
    "name": "System Location",
    "full_name": "/Niagara/Modules/Spawn/Location/SystemLocation.SystemLocation"
  }
}
```

从 Blueprint pin 拉线搜索时，带 pin 上下文搜索，让 UE action menu 返回真实可连候选：

```json
{
  "catalog_type": "blueprint_node",
  "query": { "text": "print string" },
  "context": {
    "asset_path": "/Game/Blueprints/BP_Door",
    "graph_name": "EventGraph",
    "node_guid": "源节点GUID",
    "pin_guid": "源PinGUID"
  }
}
```

## 来源解析：node_origin_resolve

`node_origin_resolve` 只返回路径和解析状态，不打开 IDE、不聚焦内容浏览器、不做 UI 操作。它用于两种真实场景：

1. 刚用 `node_catalog_search` 找到候选后，需要查看模块/节点真实含义。
2. 正在编辑结构化 JSON 时，需要从 JSON 中的 `kind/name/full_name` 或 legacy 字段反查来源。兼容字段包括 `component_class` 和 `widget_class`，但新 authoring 主路径仍是 `kind/name/full_name`。

直接解析搜索候选或结构化 JSON identity：

```json
{
  "target": {
    "source": "name_reference",
    "kind": "blueprint_call_function",
    "name": "Print String",
    "full_name": "/Script/Engine.KismetSystemLibrary.PrintString"
  }
}
```

从 JSON 文件中解析：

```json
{
  "target": {
    "source": "json_reference",
    "json_file": "D:/program/UE/GptProjectTest/tmp/uai_params/origin_resolve_v3_identity.json",
    "json_pointer": "/node"
  }
}
```

返回示例：

```json
{
  "schema": "uai.node_origin.resolve.v3",
  "resolved": true,
  "status": "resolved_native_function",
  "target": {
    "source": "name_reference",
    "kind": "blueprint_call_function",
    "name": "Print String",
    "full_name": "/Script/Engine.KismetSystemLibrary.PrintString"
  },
  "origin": {
    "asset_paths": [],
    "package_paths": [],
    "package_files": [],
    "code_paths": [
      {
        "path": "D:/Epic Games/UE_5.6/Engine/Source/Runtime/Engine/Private/KismetSystemLibrary.cpp",
        "line": 425,
        "column": 0,
        "symbol": "UKismetSystemLibrary::PrintString",
        "module": "UnrealEditor-Engine",
        "status": "symbol_definition"
      }
    ]
  },
  "warnings": []
}
```

资产候选返回 `origin.asset_paths/package_paths/package_files`；native function 尽量返回真实 `path + line`，缺符号时回退到 owner class 的 header/source 路径并给 warning。

## 支持范围

`adapter=auto` 是默认模式。命令会根据资产类型选择 adapter：

- `k2_blueprint`：普通 Blueprint、Level Blueprint、Blueprint Function Library、Macro Library、Interface 中实际存在节点和连线的 K2 图。
- `umg_k2`：Widget Blueprint / UMG 内的 K2 逻辑图，包括 EventGraph、FunctionGraph、属性绑定函数图和回调逻辑图；不处理 Designer 控件布局和 Widget Animation 时间轴。
- `anim_blueprint`：AnimBlueprint 中的 EventGraph、AnimGraph、Transition Rule、State 内部 pose/data 节点图；State Machine 顶层状态图属于状态/转移图，默认标为 unsupported，不直接套横向 pin 图算法。
- `material_graph`：`UMaterial` 的 Material Expression 图，例如 `/Game/Materials/M_WaterSurface`。
- `material_function_graph`：`UMaterialFunctionInterface` 的表达式节点图。
- `generic_edgraph`：能从资产对象中枚举到 `UEdGraph` 子对象、且不是已知竖向/非 pin 图的其它节点连线资产。`ControlRigBlueprint` 的 `ControlRigGraph / RigVM` 编辑图虽然资产类继承自 `UBlueprint`，但图语义不是 K2，因此 `adapter=auto` 必须归入 `generic_edgraph`，再转换为同一套 Blueprint layout kernel 输入。该 adapter 仍必须提供真实节点尺寸和真实 pin 连接点；如果无法从 UE 图编辑器取得真实几何，则本次排布失败而不是回退估算。

明确不纳入：

- Behavior Tree、StateTree、EQS 这类竖向/层级/专用语义图。
- Niagara Stack、Emitter Stack、Renderer Stack 等栈式编辑结构。
- UMG Designer 控件布局、Widget Animation 时间轴、Curve、DataTable、Material Instance 参数面板。
- State Machine 顶层状态图，除非以后单独设计状态图算法。

## 图选择器

`graph_selector` 用来处理“一个资产内有多个图”的情况。支持精确指定单图、指定列表、按类型批量、或排布全部支持图。

### 精确指定单图

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "graph_selector": {
    "mode": "single",
    "graph_path": "/Game/Blueprints/BP_AutoDoor.BP_AutoDoor:MyMacro"
  }
}
```

如果图名不重名，也可以使用：

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "graph_selector": {
    "mode": "single",
    "graph_kind": "macro_graph",
    "graph_name": "MyMacro"
  }
}
```

稳定性优先级：`graph_path` 高于 `graph_name`。宏图、函数图或嵌套图可能重名时，应该先用 `node_graph_list` 读取返回的 `graph_path`，再调用 `node_graph_layout`。

### 指定多图

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "graph_selector": {
    "mode": "list",
    "graph_names": ["EventGraph", "OpenDoor"],
    "graph_paths": []
  }
}
```

### 按图类型批量

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "graph_selector": {
    "mode": "by_kind",
    "graph_kinds": ["event_graph", "function_graph", "macro_graph"],
    "skip_empty_graphs": true
  }
}
```

K2 家族支持的 `graph_kinds`：

- `event_graph`
- `function_graph`
- `macro_graph`
- `delegate_graph`
- `nested_graph`

### 全部支持图

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "graph_selector": {
    "mode": "all_supported",
    "include_nested_graphs": false,
    "skip_empty_graphs": true
  }
}
```

`include_nested_graphs=false` 是更安全的默认倾向：普通函数、宏、事件图会被纳入；AnimBlueprint State Machine 顶层状态图、折叠图内部图等嵌套图只有显式请求时才枚举。

## 排布参数

`layout_options` 是通用排布参数容器：

```json
{
  "layout_options": {
    "horizontal_spacing": 360,
    "vertical_spacing": 96,
    "node_padding": 16,
    "origin_x": 0,
    "origin_y": 0,
    "insert_reroute_nodes": true,
    "replace_existing_reroute_nodes": true,
    "allow_remove_all_reroute_nodes": false
  }
}
```

所有支持的横向节点连线图都必须进入同一套 Blueprint layout kernel。adapter 的职责只允许是：

- 读取对应资产的节点、输入 pin、输出 pin 和连线，转换成 Blueprint layout kernel 的 `FNode/FEdge`。
- 计算并提供真实节点结构数据：节点实际宽高、每个输入 pin 相对节点左上角的真实连接点、每个输出 pin 相对节点左上角的真实连接点。该数据来自同一张 `UEdGraph` 构造出的临时离屏 `SGraphEditor` / `SGraphPanel` / `SGraphNode` / `SGraphPin` 和连接绘制策略等真实 Slate 值，不允许用标题长度、固定行高、固定 pin 间距或其它估算值替代，也不得为了测量去移动用户正在看的 live GraphEditor。
- Material / MaterialFunction 的真实几何必须来自 UE 自己的 `UMaterialGraph` / `UMaterialGraphNode`。特别是 Material Function，UE 会在编辑器中创建 transient preview material 和 duplicated function graph，adapter 不得自行创建另一张复制 graph；但可以把这张真实 `UEdGraph` 放入临时离屏 `SGraphEditor` 进行 Slate 测量，避免截图/几何采样污染真实编辑器窗口。
- MaterialFunction 打开 editor 前必须先快照原始 `UMaterialFunction` 的 expression collection 和 expression 数量；打开后用这个快照校验 preview graph 是否完整。若 transient preview graph 尚未同步完整表达式，adapter 必须先把快照 collection 同步到 editor preview material/function 并 rebuild；仍不完整时命令失败，不允许对只含输出节点等残缺 graph 执行布局。
- MaterialFunction 写回时不得把 transient preview material/function 的 `ExpressionCollection` 整体赋回原资产。preview graph 只用于读取真实节点尺寸、真实 pin 和临时可视 graph node；实际保存只允许按 `MaterialExpressionGuid` 将每个 preview `UMaterialGraphNode` 的新坐标同步回原始 `UMaterialFunction` 中对应 `UMaterialExpression::MaterialExpressionEditorX/Y`，避免把预览材质的临时表达式对象序列化进资产或把资产污染成空图。
- pin anchor 的 Y 坐标必须按 UE 图编辑器自身对齐语义读取：优先使用当前 `SGraphPin::GetNodeOffset().Y`，这和 UE `SGraphPanel::StraightenConnections()` 中的 `NodePosY + Pins.SrcPin->GetNodeOffset().Y` 保持一致。最小化或自动化测量路径下，pin widget 可能尚未 tick，导致 `GetNodeOffset().Y` 保持为 0；这种 0 缓存视为不可用，才允许用同一轮 Slate arranged node geometry 与 arranged pin geometry 计算相对节点的 pin 行中心作为 fallback。不得把旧 report 的 anchor 和当前节点位置混算。
- `node_graph_layout` 的报告会输出 `nodes[].input_pins/output_pins[].anchor_x/anchor_y/new_graph_x/new_graph_y` 和 `edges[].new_pin_y_residual`。验收 pin 对齐时必须看真实 pin graph 坐标 residual，而不是比较节点左上角坐标；材质函数输出节点带 preview 区域时，输出节点左上角通常会高于上游节点。
- `node_graph_layout` 的真实几何测量必须使用离屏 `SGraphEditor`，报告必须返回 `geometry_used_offscreen_graph_editor=true`。对 `generic_edgraph` / ControlRig 这类需要资产编辑器先完成节点类初始化的图，命令可以打开资产编辑器并返回 `opened_editor_for_geometry=true`，但测量仍只能在离屏 GraphEditor 上完成，不能用截图，也不能移动用户当前真实图面的 view。
- `node_graph_layout` 使用 shared Blueprint layout core 时，会同步输出 core 诊断字段。岛内跨多列显式连接命中 `island_internal_multi_column_bus_count`；同列岛内连接若直连曲线会碰撞本列其它节点，则命中 `island_internal_same_column_collision_bus_count`，并通过列右边界中途点引导。
- 在真实几何不完整时直接报错，返回 `geometry_source=incomplete_slate_real_pin_geometry`、`missing_pin_anchor_count` 等诊断字段；不得继续调用 layout kernel 生成看似成功的结果。
- 写回阶段必须由 adapter 把 core 输出转换回对应图类型。K2 家族按 kernel 输出写回 reroute 节点；Material / MaterialFunction 写回 `UEdGraphNode::NodePosX/Y` 与对应 `UMaterialExpression::MaterialExpressionEditorX/Y`，Material 图会在写回后调用 `UMaterialGraph::LinkMaterialExpressionsFromGraph()` 同步表达式位置，不重建表达式、不删除表达式、不实现第二套排布算法；ControlRig / RigVM 这类 `generic_edgraph` 必须通过 `URigVMController` 写回模型节点位置、折叠已有 reroute 并按 core reroute plan 重建 RigVM reroute 节点。若某 adapter 尚不支持 reroute 写回，而本次 core 产生了需要写回的中途点，命令必须失败并返回不支持原因，不能生成看似成功但实际残留旧中途点的结果。

Material / MaterialFunction adapter 不再用 `UMaterialExpression` 自行拼虚拟图，也不再创建虚拟 Material Output 节点。它们先解析到 UE 自己的 `UMaterialGraph` / `UMaterialGraphNode`，使用图中真实 root node、表达式节点、pin 和连线，再交给同一套 Blueprint layout kernel。

禁止在本入口为 Material、UMG、AnimBlueprint 或其它 EdGraph 另写 rank layout、树状 layout、随机/迭代修补 layout。需要支持新资产类型时，应只新增 adapter，把该资产转换为同一套 `FNode/FEdge` 后调用 Blueprint layout kernel。

## 示例

枚举 `M_WaterSurface`：

```json
{
  "asset_path": "/Game/Materials/M_WaterSurface"
}
```

排布 `M_WaterSurface`：

```json
{
  "asset_path": "/Game/Materials/M_WaterSurface",
  "adapter": "auto",
  "graph_selector": {
    "mode": "all_supported"
  },
  "layout_options": {
    "horizontal_spacing": 360,
    "vertical_spacing": 128
  },
  "compile_after_layout": true,
  "save_after_layout": true
}
```

只排布 Blueprint 内某个宏图：

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "adapter": "auto",
  "graph_selector": {
    "mode": "single",
    "graph_kind": "macro_graph",
    "graph_name": "MyMacro"
  },
  "compile_after_layout": true,
  "save_after_layout": true
}
```

批量排布 Blueprint 中所有常规 K2 图：

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "adapter": "auto",
  "graph_selector": {
    "mode": "all_supported",
    "include_nested_graphs": false,
    "skip_empty_graphs": true
  },
  "compile_after_layout": true,
  "save_after_layout": true
}
```

## 兼容关系

`blueprint_layout_graph`、`blueprint_layout_all_graphs`、`anim_blueprint_layout_graph` 继续保留。`node_graph_layout` 对 K2 / UMG / AnimBlueprint 图会委托到现有 Blueprint layout kernel，不实现第二套 K2 排布算法。新脚本应优先使用 `node_graph_list` + `node_graph_layout`，旧脚本无需立刻迁移。
