# Direct HJSON Authoring And Structured Apply Chain

本页是 LLM 执行结构化 HJSON 编辑的主入口。默认策略是直接编辑 `llm_authoring` folder HJSON，只在批量生成、参数化调用、adapter 调试或重复变量过多时写 Python 辅助。Python 不能替代 HJSON 意图本身。

本页只描述 UAI 结构化 HJSON 内部链路；字段语义以本地 UAI 源码、adapter/profile、正式命令文档和实测 readback 为准。

## 主链路

```text
确认资产和 profile
-> export/readback 当前 folder
-> 按 ExportProfile included_files/tutorial read_order 读取必需入口
-> 按需打开 authoring HJSON
-> 如需新增节点/模块/组件/控件/输入来源，调用对应领域 exact candidate command
-> 选择唯一候选并保留 executable identity、binding_revision 与领域 context
-> 编辑普通 value/connection/layout/properties
-> validate/lint/adapter/apply
-> export/readback/compile/probe 验证
```

执行规则：

1. 先导出真实资产结构，再在 `llm_authoring` 文件上改。
2. 新增候选来自当前领域唯一 candidate command；八个当前入口是 `ai.behavior.candidates`、`animation_rig_graph.candidates`、`audio.graph.candidates`、`blueprint.component.candidates`、`blueprint.node.candidates`、`material.expression.candidates`、`niagara.module.candidates` 与 `pcg.node.candidates`。
3. 候选返回不是通用 Apply payload。只把该领域合同声明的 executable `name`/path、`binding_revision` 与适用 context 原样写入对应 HJSON；`query.content.search` 只搜索现有 Asset/Actor/Component，不复制创建候选 mechanics。
4. operation、owner、父级、连线、layout、placement 与属性必须来自用户意图、现有上下文或 UE readback，不能由候选显示名、分类或客户端映射猜测。
5. 不要手写完整 readback 对象；真实 id、template、slot、pin、默认属性、generated/readback/debug 字段由 apply 后的 UE/UAI 补齐。
6. apply 成功后必须重新 export/readback；后续编辑以读回的新结构为依据继续。

## Canonical Identity

身份字段由目标 ApplyInputContract 定义，不能用一套全局字段名替代所有领域：

| 类型 | 常见 canonical 字段 | 说明 |
| --- | --- | --- |
| 资产/脚本候选 | 领域合同返回的 executable `name`/path + `binding_revision` | 只在 owning domain 的目标 HJSON 合同中使用。 |
| 无路径 action | `name` + discriminator | 只有 owner/context 内可唯一解析时合法。 |
| 资产 workspace | `target.asset_path`、`target.asset_kind` | folder/single-file profile 的目标身份。 |
| Level lifecycle | `world_path` + actor/component identity，创建时可带 `actor_class` / `component_class` | 类路径是 type assertion，不替代 owner identity。 |
| Blueprint candidate-bound node/Component | 领域返回的完整 `candidate` object | 当前 Blueprint root authoring 由服务端校验 binding 并展开 native class/name 字段；调用方不维护第二份映射。 |
| 其它 Blueprint/UMG 内容 | `function_owner_class + function_name`、`widget_class` 等 | exact seed 保留实际 InputContract 字段名。 |

显示 label、tooltip、category 只用于选择，不是 Apply payload 身份。是否接受 `asset_path`、`class_path`、`object_path`、`name` 或领域 class 字段，以当前 InputContract 为准，不能从字段名猜语义。

旧多文件 workspace、旧平铺 graph、旧 index/properties 布局会直接拒绝；完整边界见 `06_LegacyMigration.md`。

## 领域 Candidate Identity 与 HJSON Binding

候选命令按领域返回可执行身份与 binding revision。Blueprint node 与 Component 是当前明确允许“候选对象原样进入 HJSON”的领域：

```hjson
provider_extension: {
  components: {
    "component:PointLight": {
      operation: create
      candidate: {
        name: PointLight
        component_class: "/Script/Engine.PointLightComponent"
        binding_revision: "sha256:..."
      }
      parent: DefaultSceneRoot
    }
  }
  graphs: {
    "event_graph:EventGraph": {
      operation: update
      graph: { graph_kind: event_graph }
      nodes: {
        "11111111-1111-1111-1111-111111111111": {
          operation: create
          candidate: {
            name: "/Script/BlueprintGraph.K2Node_IfThenElse"
            binding_revision: "sha256:..."
            display_name: Branch
            graph_id: "graph:..."
          }
          pos: { x: 800, y: 600 }
        }
      }
    }
  }
}
```

服务端在首写前以同一 candidate mechanics 校验 target、graph/SCS context、executable identity 与 `binding_revision`，再展开 Blueprint native mutation 字段。调用方不把 `candidate.graph_id` 改写成 graph map key，也不自行补一套 `node_type/node_class` 或 Component `name/class`；如果显式提供这些字段，它们必须与 candidate 完全一致。

Material 使用自己的领域形状：

```hjson
value: {
  class_ref: "/Script/Engine.MaterialExpressionScalarParameter"
  candidate: {
    name: "/Script/Engine.MaterialExpressionScalarParameter"
    binding_revision: "sha256:..."
  }
  position: { x: -300, y: 0 }
}
```

`candidate.name` 必须与本次实际创建使用的 `class_ref` 一致，`binding_revision` 必须原样复制；服务端在写前重新解析并拒绝 stale binding。其它领域使用各自的 HJSON 形状，不能把 Material 字段推广成全局 schema。候选 identity 不含 operation、owner、父级、默认值、layout、readback 或 completion provenance。

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

| domain candidate / kind | 可直接用于 HJSON 补全 | 推荐 identity | 补全与限制 |
| --- | --- | --- | --- |
| `actor_component` | 是 | exact `seed.component_class` | 还需 owner actor identity、component name 和 operation。 |
| `umg_widget` | 是 | exact `seed.widget_class` | 还需 widget identity、parent/slot context 和 operation。 |
| `blueprint.node.candidates` | 是 | 完整 exact `candidate` object | 还需 Blueprint graph stable map key、node stable id、operation 与 placement；服务端校验 graph binding 并展开 native node fields。 |
| `blueprint.component.candidates` | 是 | 完整 exact `candidate` object | 还需 Component stable map key、operation 与 parent；服务端校验 SCS binding 并展开 native Component fields。 |
| `material_expression` | 是 | exact `seed.path` | graph mutation context、identity、连线、root input 和属性另写。 |
| `material_function_call` | 是 | exact `seed.path` | Material Function 是资产实体；已知可靠路径时可以直接按目标 contract 写。 |
| `niagara_dynamic_input` | 条件支持 | exact `seed.path` | 必须放入已有 module input 上下文；子 input/data interface 需 readback 后继续编辑。 |
| `blueprint_call_function` | 条件支持 | exact contract seed | 必须有正确 graph/owner context，pin default 和连线通常还需补。 |
| `blueprint_event` | 条件支持 | exact contract seed | 事件唯一性、绑定上下文和图类型会影响 Apply/compile。 |
| `blueprint_variable_node` | 条件支持 | exact contract seed | 变量必须存在，并明确 get/set 与 graph context。 |
| `niagara_module` | 是 | exact `seed.path` | 必须放入目标 stage；operation、顺序、输入和 stage identity 不在 seed 中。 |
| `niagara_graph_function` | 无 standalone projection | 无 | 需要 Script graph contract；当前 folder Script profile不覆盖 graph topology。 |

判断可写时，以当前 CommandSpec、InputContract、领域 candidate contract 和 readback 验证为准。候选返回中的字段只在 owning domain 明确声明时可写入目标 HJSON。

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

刚搜索完候选或在 HJSON 中看到 `path`/`name` 后，如需理解来源，可调用 `reference.origin.resolve`。已知路径实体优先传 `path`：

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
- 领域 candidate 的 executable identity、binding revision 或 context 与实际目标不匹配。
- 把一个领域的候选字段形状复制到另一个领域，或绕过 stale binding 校验。
- Blueprint/Material 从 pin 拉线搜索时没有传真实 pin context。
- Niagara module seed 没有放进 `apply_mode: patch` 的目标 stage，或 selector 多实例歧义时没有写 `occurrence`。
- apply 成功但 export/readback 没有出现目标对象、目标连接或目标值。
