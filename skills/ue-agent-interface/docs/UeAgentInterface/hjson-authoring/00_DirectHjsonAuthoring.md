# Direct HJSON Authoring And Structured Apply Chain

本页是 LLM 执行结构化 HJSON 编辑的主入口。默认策略是直接编辑 `llm_authoring` folder HJSON，只在批量生成、参数化调用、adapter 调试或重复变量过多时写 Python 辅助。Python 不能替代 HJSON 意图本身。

本页只描述 UAI 结构化 HJSON 内部链路；字段语义以本地 UAI 源码、adapter/profile、正式命令文档和实测 readback 为准。

## 主链路

```text
确认资产和 profile
-> export/readback 当前 folder
-> 按 ExportProfile included_files/tutorial read_order 读取必需入口
-> 按需打开 authoring HJSON
-> 如需新增节点/模块/组件/控件/输入来源，先 node_catalog_search
-> 从 items_tsv 选候选
-> 对选中候选做唯一 exact 查询，按需读取 seed 和 placement
-> 编辑普通 value/connection/layout/properties
-> validate/lint/adapter/apply
-> export/readback/compile/probe 验证
```

执行规则：

1. 先导出真实资产结构，再在 `llm_authoring` 文件上改。
2. 新增候选优先来自 `node_catalog_search`，分类不明确时先 `node_catalog_categories`。
3. `node_catalog_search.items_tsv` 是候选选择的压缩主返回，不是通用 Apply payload。只对选中行发起唯一 `exact` 查询；若该 kind 有正式 Apply 投影，读取独立的 `seed` 与 `placement`。
4. `seed` 只表达 ApplyInputContract 允许的最小目标片段；`placement` 只表达 workspace contract、unit、文件 pattern 和目标位置。operation、owner、父级、连线、layout 与属性必须来自用户意图、现有上下文或 UE readback，不能由 Catalog 猜测。
5. 不要手写完整 readback 对象；真实 id、template、slot、pin、默认属性、generated/readback/debug 字段由 apply 后的 UE/UAI 补齐。
6. apply 成功后必须重新 export/readback；后续编辑以读回的新结构为依据继续。

## Canonical Identity

身份字段由目标 ApplyInputContract 定义，不能用一套全局字段名替代所有领域：

| 类型 | 常见 canonical 字段 | 说明 |
| --- | --- | --- |
| 资产/脚本候选 | `path` | Catalog 可直接投影为目标 seed 时使用。 |
| 无路径 action | `name` + discriminator | 只有 owner/context 内可唯一解析时合法。 |
| 资产 workspace | `target.asset_path`、`target.asset_kind` | folder/single-file profile 的目标身份。 |
| Level lifecycle | `world_path` + actor/component identity，创建时可带 `actor_class` / `component_class` | 类路径是 type assertion，不替代 owner identity。 |
| Blueprint/UMG | `node_class`、`function_owner_class + function_name`、`widget_class` 等 | exact seed 保留实际 InputContract 字段名。 |

`candidate_id` 是 Catalog detail selector，不是 Apply payload 字段。`full_name` 只用于 display/legacy 消歧；是否接受 `asset_path`、`class_path`、`object_path` 或领域 class 字段，以当前 InputContract 为准，不能把它们全局判定为 legacy，也不能从字段名猜语义。

旧多文件 workspace、旧平铺 graph、旧 index/properties 布局会直接拒绝；完整边界见 `06_LegacyMigration.md`。

## Catalog Seed 与 Placement

`node_catalog_search.items_tsv` 首行是 header；`path` / `name` 用于选择候选和构造 exact 查询：

```text
name	full_name	category	tooltip	path
Multiply	Multiply	Math	Multiplies inputs	Multiply
```

唯一 exact 命中后，返回形状为：

```hjson
seed: { path: "/Script/Engine.MaterialExpressionMultiply" }
placement: {
  schema: uai.catalog_placement.v1
  workspace_contract_id: uai.apply_workspace.material.graph_mutation
  input_contract_id: uai.apply_input.material.graph_mutation
  unit_id: primary
  path_pattern: index.hjson
  target_path: "$"
}
```

`seed` 的字段名以实际 InputContract 为准，可能是 `path`，也可能是 `actor_class`、`component_class`、`widget_class`、`node_class` 或领域 selector。不要把 TSV 的列名强行写入目标 HJSON。`seed` 不含 operation、默认值、layout、readback 或 completion provenance。

## Apply 输入源

三种 source 最终都进入同一个 Workspace Loader、Router、全局 preflight、transaction 和 verification：

| source | 公开入口示例 | 语义 |
| --- | --- | --- |
| 目录 | `material_instance_apply_folder(..., folder_path="D:/work/M_Test")` | 一次加载目录内完整 workspace，保留 unit/source provenance。 |
| 单文件 | `material_instance_apply_folder(..., input_file="D:/work/M_Test/index.hjson")` | 包装为单 unit 虚拟 workspace。 |
| 内联 | `asset_apply_property_json(..., properties=[...])` 或领域 adapter 的 inline object | 包装为 inline 虚拟 workspace；不新增独立 seed 应用模式。 |

具体命令只接受其 CommandSpec 声明的参数；共享核心支持三种 source，不表示每个 HTTP adapter 都公开同一组参数。目录/单文件/inline 的路由、identity、类型、UE native default 和 mutation 仍由服务端权威决定。

### 递归 UObject/UStruct Inline Apply

属性描述符最小形状是 `property_path + value`。`value_kind`、`struct_path`、`element_type` 等是可选 assertion；只有调用方需要额外断言时才提供。

```hjson
asset_path: "/Game/Data/DA_Example"
properties: [
  { property_path: Tint, value: { components: [0.2, 0.5, 1, 1] } }
  {
    property_path: Bounds
    value: {
      fields: {
        Min: { components: [-100, -100, 0] }
        Max: { components: [100, 100, 300] }
      }
    }
  }
  {
    property_path: OwnedSettings
    value: {
      owned_object: {
        class_path: "/Script/MyModule.MySettings"
        properties: [{ property_path: Strength, value: { literal: 2 } }]
      }
    }
  }
]
```

known struct 继续使用 canonical codec，generic/Blueprint struct 使用 `fields` 递归；array/set/fixed array 使用 `items`，map 使用 `entries[{key,value}]`，optional 使用 `is_set/value`。普通外部 object reference 只能替换引用，不能经父对象递归修改；Instanced/EditInlineNew/default subobject 才允许以真实 outer 创建或定位后递归。

## 直接写入支持面

| catalog / kind | 可直接用于 HJSON 补全 | 推荐 seed | 补全与限制 |
| --- | --- | --- | --- |
| `actor_component` | 是 | exact `seed.component_class` | 还需 owner actor identity、component name 和 operation。 |
| `umg_widget` | 是 | exact `seed.widget_class` | 还需 widget identity、parent/slot context 和 operation。 |
| `material_expression` | 是 | exact `seed.path` | graph mutation context、identity、连线、root input 和属性另写。 |
| `material_function_call` | 是 | exact `seed.path` | Material Function 是资产实体；已知可靠路径时可以直接按目标 contract 写。 |
| `niagara_dynamic_input` | 条件支持 | exact `seed.path` | 必须放入已有 module input 上下文；子 input/data interface 需 readback 后继续编辑。 |
| `blueprint_call_function` | 条件支持 | exact contract seed | 必须有正确 graph/owner context，pin default 和连线通常还需补。 |
| `blueprint_event` | 条件支持 | exact contract seed | 事件唯一性、绑定上下文和图类型会影响 Apply/compile。 |
| `blueprint_variable_node` | 条件支持 | exact contract seed | 变量必须存在，并明确 get/set 与 graph context。 |
| `niagara_module` | 是 | exact `seed.path` | 必须放入目标 stage；operation、顺序、输入和 stage identity 不在 seed 中。 |
| `niagara_graph_function` | 无 standalone projection | 无 | 需要 Script graph contract；当前 folder Script profile不覆盖 graph topology。 |

判断可写时，以当前 CommandSpec、InputContract、`seed/placement` 和 readback 验证为准。`items_tsv` 中的 `path` / `name` 只表示候选 selector，不表示目标 contract 接受同名字段。

## 写入示例

### Actor Component

```hjson
{
  "operation": "upsert",
  "component_class": "/Script/Engine.StaticMeshComponent"
}
```

### UMG Widget

```hjson
{
  "operation": "upsert",
  "widget_class": "/Script/UMG.Button",
  "parent_widget_id": "RootCanvas"
}
```

### Material Node

```hjson
{
  "operation": "add",
  "path": "/Script/Engine.MaterialExpressionMultiply",
  "properties": {}
}
```

### Blueprint Callable Function

```hjson
{
  "operation": "add",
  "function_owner_class": "/Game/Blueprints/BP_FunctionOwner.BP_FunctionOwner_C",
  "function_name": "MyCallable"
}
```

### Niagara Dynamic Input

```hjson
{
  "input_name": "Module.Offset",
  "type_info": "vector3",
  "value": {
    "source": "dynamic_input",
    "dynamic_input": {
      "path": "/Niagara/Functions/Random/RandomRangeVector.RandomRangeVector",
      "inputs": [],
      "data_interfaces": []
    }
  }
}
```

### Niagara Stage Module

```hjson
apply_mode: patch
modules: [
  {
    operation: upsert
    path: "/Niagara/Modules/Update/Position/JitterPosition.JitterPosition"
    inputs: []
  }
]
```

## 来源解析

刚搜索完候选或在 HJSON 中看到 `path`/`name` seed 后，如需理解含义，可调用 `node_origin_resolve`。已知路径实体优先传 `path`：

```hjson
{
  "target": {
    "source": "name_reference",
    "path": "/Script/Engine.KismetSystemLibrary",
    "function_name": "PrintString"
  }
}
```

从 HJSON 文件反查：

```hjson
{
  "target": {
    "source": "json_reference",
    "json_file": "<ProjectRoot>/tmp/uai_params/authoring.hjson",
    "json_pointer": "/graphs/items/main/graph.hjson/nodes/3"
  }
}
```

解析失败说明身份不足或当前环境缺源码/资产，不代表 JSON 可以靠猜继续写。

## 失败边界

以下情况必须停止或修正 JSON：

- 把 display-only `full_name` 或任意字段名当作所有领域通用身份，而没有核对目标 InputContract。
- 仅凭显示名写入本应有路径的自定义资产、类或对象。
- 从 `items_tsv` 解析出的 `path` / `name` seed 与实际放置位置不匹配。
- `write_support` 或 `support_reason` 表示当前 item 不能按目标用途写入。
- Blueprint/Material 从 pin 拉线搜索时没有传真实 pin context。
- Niagara module seed 没有放进 `apply_mode: patch` 的目标 stage，或 selector 多实例歧义时没有写 `occurrence`。
- apply 成功但 export/readback 没有出现目标对象、目标连接或目标值。
