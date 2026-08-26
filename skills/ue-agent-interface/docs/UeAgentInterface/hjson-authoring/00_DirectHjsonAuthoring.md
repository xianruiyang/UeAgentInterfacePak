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
-> 在原生创建上下文中选择唯一候选，只保留最小 name 或 id selector
-> 编辑普通 value/connection/layout/properties
-> validate/lint/adapter/apply
-> export/readback/compile/probe 验证
```

执行规则：

1. 先导出真实资产结构，再在 `llm_authoring` 文件上改。
2. 新增候选来自当前领域唯一 candidate command；十一个当前已接入 HJSON 的入口是 `ai.behavior.candidates`、`animation.state_machine.candidates`、`animation_rig_graph.candidates`、`audio.graph.candidates`、`blueprint.component.candidates`、`blueprint.node.candidates`、`material.expression.candidates`、`niagara.module.candidates`、`pcg.node.candidates`、`umg.widget.candidates` 与 `world.actor.candidates`。
3. 候选返回不是通用 Apply payload。对已接入统一创建合同的领域，只把
   `candidate: {name: ...}` 或 `candidate: {id: ...}` 写入 HJSON；明确知道更多内容时
   可补领域公开 assertion。`candidate_id` 不是 `id` 的别名，会在写入前被拒绝；
   `query.content.search` 只搜索既有
   Asset/Actor/Component，不等价于原生创建菜单。
4. operation、owner、父级、连线、layout、placement 与属性必须来自用户意图、现有上下文或 UE readback，不能由候选显示名、分类或客户端映射猜测。
5. 不要手写完整 readback 对象；真实 id、template、slot、pin、默认属性、generated/readback/debug 字段由 apply 后的 UE/UAI 补齐。
6. apply 成功后必须重新 export/readback；后续编辑以读回的新结构为依据继续。

## Canonical Identity

身份字段由目标 ApplyInputContract 定义，不能用一套全局字段名替代所有领域：

| 类型 | 常见 canonical 字段 | 说明 |
| --- | --- | --- |
| 原生创建候选 | `candidate.name` 或 `candidate.id` | `name` 仅在当前原生上下文唯一时可用；`id` 是推荐的精确紧凑身份。完整搜索行和内部 revision 不进入 HJSON。 |
| 可选候选断言 | owning domain 明确公开的 class/path/action kind | 只校验已知更多事实，不替代 `name/id`，也不承担 graph、parent、placement 或实例身份。 |
| 资产 workspace | `target.asset_path`、`target.asset_kind` | folder/single-file profile 的目标身份。 |
| Level lifecycle | `world_path` + actor/component identity，创建时可带 `actor_class` / `component_class` | 类路径是 type assertion，不替代 owner identity。 |
| candidate-bound node/Component/Actor/expression/module | `candidate.name` 或 `candidate.id` | 服务端在同一领域 context 重枚举原生创建面并调用同一 action/spawner/factory；graph、stage、parent、level、实例名和 placement 留在外层。 |
| 其它 Blueprint/UMG 内容 | `function_owner_class + function_name`、`widget_class` 等 | exact seed 保留实际 InputContract 字段名。 |

显示 label、tooltip、category 只用于选择，不是 Apply payload 身份。是否接受 `asset_path`、`class_path`、`object_path`、`name` 或领域 class 字段，以当前 InputContract 为准，不能从字段名猜语义。

旧多文件 workspace、旧平铺 graph、旧 index/properties 布局会直接拒绝；完整边界见 `06_LegacyMigration.md`。

## 领域 Candidate Identity 与 HJSON Binding

候选命令按领域返回可执行身份。Blueprint node 与 Component 使用统一的最小
`name/id` selector：

```hjson
provider_extension: {
  components: {
    "component:PointLight": {
      operation: create
      candidate: { id: "candidate:..." }
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
          candidate: { name: Branch }
          pos: { x: 800, y: 600 }
        }
      }
    }
  }
}
```

服务端在首写前从同一 Blueprint Action Menu 或 Add Component registry 重枚举，
按 `name/id` 唯一解析并调用同一个原生 action。调用方不把 graph/pin、SCS parent、
实例名或 placement 塞进 candidate，也不自行补一套 `node_type/node_class`、
Component `name/class` 或 spawner 映射；显式提供的 `class_path/asset_path` 等丰富
字段只作为一致性 assertion。

Material 使用自己的领域形状；Graph/Pin 上下文与候选分离：

```hjson
value: {
  candidate: { id: "candidate:..." }
  candidate_context: {
    graph_name: MaterialGraph
    node_guid: "<optional-source-node-guid>"
    pin_guid: "<optional-source-pin-guid>"
    pin_name: "<optional-source-pin-name>"
  }
}
```

服务端在首写前从同一 Material Graph/Pin schema 重枚举并执行同一原生 action；
同一个 expression class 的多个 schema action 仍由不同 `id` 区分。已知 class path
时可按领域合同作为 assertion 提供，但不能代替 action。其它领域使用各自的 HJSON
形状，不能把 Material context 字段推广成全局 schema。候选 identity 不含
operation、owner、父级、默认值、layout、readback 或 completion provenance。

Control Rig 的默认 RigVM 图也使用最小 selector；节点实例名和二维位置在候选外：

```hjson
edits: [{
  intent: create
  semantic_id: "rigvm_node:AddSpaces"
  value: {
    candidate: { id: "candidate:..." }
    position: { x: 240, y: 144 }
  }
}]
```

`animation_rig_graph.candidates` 当前完整搜索 ControlRig 默认图的 blank-context
原生菜单，但只创建已验证的 RigVM Unit spawner；其它 action 仍可搜索并通过
`write_support/support_reason` 明确拒绝写入。服务端在 preflight 与 commit
分别重枚举，并调用同一 `PerformAction`。已知的 `script_struct_ref` 和
`method` 只能放在 `value` 中作 assertion，不能代替 `candidate.name/id`；
IK Rig、IK Retargeter、Skeleton 也不能套用该 RigVM candidate 形状。

Animation Blueprint 的 StateMachine 和 State 共享一个查询命令，但必须分别指定真实
原生 surface；未来 target、factory settings 与实例字段都不进入 candidate：

```hjson
provider_extension: {
  class_settings: {
    template: true
    parent_class: "/Script/Engine.AnimInstance"
  }
  state_machines: [{
    name: Locomotion
    animation_graph: AnimGraph
    candidate: { id: "candidate:<animation-graph-state-machine>" }
    pos_x: 320
    pos_y: 64
    states: [{
      name: Idle
      candidate: { id: "candidate:<state-machine-graph-state>" }
      pos_x: 240
      pos_y: 0
    }]
    entry_state: Idle
    transitions: []
  }]
}
```

先对同一 future missing target 和同一 `class_settings` 调用
`animation.state_machine.candidates`：`surface=animation_graph` 搜索 AnimGraph 的
StateMachine 原生 Blueprint action，`surface=state_machine_graph` 搜索其子图的原生
schema action。服务端查询时用同一 `UAnimBlueprintFactory` 创建 transient context，
并在 preflight 与 commit 分别重枚举、执行同一个 spawner/action。当前 parent
StateMachine 与 plain State 可写，Alias、Conduit、Comment 等其它 action 仍可搜索但
明确为 search-only。`name`、`animation_graph`、位置、entry 和 transition 都留在
candidate 外；已知 `class` 只能作 assertion。Transition 是 schema connection relation，
不是右键候选。完整边界读取 `active/t16_animation_blueprint_domain.md`。

PCG Graph Node 同样把“创建什么”和“创建到哪里”分开：

```hjson
edits: [{
  depends_on: []
  element_kind: item
  identity: "pcg_node:CreateGrid"
  intent: create
  value: {
    candidate: { id: "candidate:..." }
    position: [160, 96]
  }
}]
```

`pcg.node.candidates` 覆盖目标 Graph 的原生背景右键菜单；服务端在 preflight 与
commit 分别重枚举同一上下文，并调用选中 action 的 `PerformAction`。当前搜索覆盖完整
背景菜单，创建只开放已验证的 `NewNativeElement` action 等价类；其它 action 会保留
在搜索结果中并以 `write_support/support_reason` 明确拒绝写入。semantic identity、
`position`、连线和参数均在 candidate 外层。

BehaviorTree 的空白背景创建也使用同一分离原则：

```hjson
edits: [
  { identity: "node:root", element_kind: item, intent: create, depends_on: [],
    value: { carrier_type_ref: "/Script/BehaviorTreeEditor.BehaviorTreeGraphNode_Root" } }
  { identity: "node:aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee", element_kind: item,
    intent: create, depends_on: [],
    value: { candidate: { id: "candidate:<composite>" }, position: [384, 192] } }
  { identity: "node:11111111-2222-3333-4444-555555555555", element_kind: item,
    intent: create, depends_on: [],
    value: { candidate: { id: "candidate:<task>" }, position: [640, 192] } }
  { identity: "relation:node:root:out:0->node:aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee:in:0",
    element_kind: relation, intent: create,
    depends_on: ["node:root", "node:aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"],
    value: { from_item_ref: "node:root", from_output_index: 0,
      to_item_ref: "node:aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee", to_input_index: 0 } }
  { identity: "relation:node:aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee:out:0->node:11111111-2222-3333-4444-555555555555:in:0",
    element_kind: relation, intent: create,
    depends_on: ["node:aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee", "node:11111111-2222-3333-4444-555555555555"],
    value: { from_item_ref: "node:aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee", from_output_index: 0,
      to_item_ref: "node:11111111-2222-3333-4444-555555555555", to_input_index: 0 } }
]
```

`ai.behavior.candidates` 当前完整搜索 BehaviorTree blank-background 原生菜单，
Composite 与 Task action 可创建；搜索结果中的其它 action 以
`write_support/support_reason` 说明边界。服务端在 normalization 与 commit 重枚举并
调用同一 schema action，连线交给原生 BehaviorTree schema；root 必须先连接
Composite，不能直接连接 Task。Service/Decorator attachment、非空 pin/selection
上下文和其它 AI root 仍按各自现有合同处理，不能套用本例。

UMG WidgetTree 的候选只负责控件类型，实例 identity、父级和 slot 顺序仍在外层：

```hjson
provider_extension: {
  widget_tree: {
    widgets: {
      "widget:ActionButton": {
        operation: create
        candidate: { id: "candidate:..." }
        parent: RootCanvas
        index: 0
      }
    }
  }
}
```

`umg.widget.candidates` 绑定目标 Widget Blueprint 与 revision；服务端首写前重新解析
同一候选，并通过公开 `FWidgetTemplateClass` mechanics 创建。当前只允许返回中
`supported: true` 的已加载普通 native Widget class 写入，两个 coverage flag 都为
false；完整 Designer Palette、UserWidget/asset 和特殊 template 仍受
`DCR-UAI-UMG-PALETTE-CATALOG-OWNER` 阻断。已知 `class` 只能作为 candidate 外的
assertion，不能代替 `candidate.name/id`。

MetaSound Source 的当前可用紧凑链路同样只把候选身份放进 candidate：

```hjson
root: {
  type: "/Script/MetasoundEngine.MetaSoundSource"
  operation: {
    command_id: "metasound.graph.node.mutate"
    params: {
      nodes: [{
        intent: create
        candidate: { id: "candidate:..." }
        position: { x: 384, y: 192 }
      }]
    }
  }
}
```

`audio.graph.candidates` 对 MetaSound 返回 frontend registry 的紧凑稳定 ID；
服务端首写前重枚举并解析同一 class/version，`node_guid` 省略时由服务端生成。
这条链已覆盖保存、卸载/重载和独立 frontend 读回，但不是 UE 原生 blank-menu
等价面，因而 `coverage_complete` 与 `creation_coverage_complete` 都为 false。
SoundCue 当前仍是 loaded-class/full-binding 兼容面，不得套用上述最小 selector。

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
| `umg.widget.candidates` loaded native Widget | 是（部分覆盖） | `candidate.name` 或 `candidate.id` | 还需 Widget stable key、operation、parent/slot context 和 index；只写 `supported: true`，完整 Designer Palette 与 UserWidget/asset/special template 未覆盖。 |
| `blueprint.node.candidates` | 是 | `candidate.name` 或 `candidate.id` | 还需 Blueprint graph stable map key、node stable id、operation 与 placement；graph/pin context 在候选外层。 |
| `blueprint.component.candidates` | 是 | `candidate.name` 或 `candidate.id` | 还需 Component stable map key、operation 与 parent；stable key 是实例名，candidate 只选择原生组件项。 |
| `material.expression.candidates` | 是 | `candidate.name` 或 `candidate.id` | graph/pin context、stable element identity、连线、layout 和属性另写；服务端执行同一 Graph/Pin schema action。 |
| `animation_rig_graph.candidates` RigVM Unit | 是 | `candidate.name` 或 `candidate.id` | 当前目标只接受 ControlRigBlueprint 默认图 blank context；`semantic_id`、二维 position 与可选 struct/method assertions 在 candidate 外。非 Unit action 只搜索。 |
| `material_function_call` | 是 | exact `seed.path` | Material Function 是资产实体；已知可靠路径时可以直接按目标 contract 写。 |
| `niagara_dynamic_input` | 条件支持 | exact `seed.path` | 必须放入已有 module input 上下文；子 input/data interface 需 readback 后继续编辑。 |
| `blueprint_call_function` | 条件支持 | exact contract seed | 必须有正确 graph/owner context，pin default 和连线通常还需补。 |
| `blueprint_event` | 条件支持 | exact contract seed | 事件唯一性、绑定上下文和图类型会影响 Apply/compile。 |
| `blueprint_variable_node` | 条件支持 | exact contract seed | 变量必须存在，并明确 get/set 与 graph context。 |
| `niagara.module.candidates` asset module | 是 | `candidate.name` 或 `candidate.id` | 必须放入目标 stage；usage/usage-id/emitter、operation、顺序和输入在 candidate 外。当前 scratch-pad、assignment/set-specific 与 wizard action 只搜索、拒绝创建。 |
| `pcg.node.candidates` native element | 是 | `candidate.name` 或 `candidate.id` | 目标 PCG Graph、semantic identity、position、连线和参数另写；当前完整搜索原生背景菜单，只创建已验证的 `NewNativeElement` action。 |
| `ai.behavior.candidates` BehaviorTree composite/task | 是 | `candidate.name` 或 `candidate.id` | 当前覆盖 blank-background 原生菜单；node identity、position、关系和 root/composite 拓扑另写。Search-only action、Service/Decorator attachment 与其它 AI roots 不属于该创建等价类。 |
| `audio.graph.candidates` MetaSound frontend class | 是（部分覆盖） | `candidate.name` 或 `candidate.id` | position、可选 class/version assertion 和实例 GUID 在 candidate 外；服务端使用 frontend registry 与 Builder，覆盖字段明确为 false，不声称原生 blank-menu 等价。 |
| `audio.graph.candidates` SoundCue class | 旧兼容形状 | legacy full binding | 当前只是 loaded-class approximation；尚未接入最小 selector 与原生 palette/action owner。 |
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
  intent: create
  value: {
    candidate: { id: "candidate:..." }
    candidate_context: { graph_name: MaterialGraph }
  }
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
provider_extension: {
  stages: {
    "system|SystemUpdateScript|<usage-guid>": {
      target: {
        usage: SystemUpdateScript
        usage_id: "<usage-guid>"
      }
      modules: {
        native_asset_module: {
          candidate: { id: "candidate:..." }
        }
      }
    }
  }
}
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
- 领域 candidate 的 `name/id`、可选断言或外层原生 context 与实际目标不匹配。
- 把一个领域的候选字段形状复制到另一个领域，或绕过 stale binding 校验。
- Blueprint/Material 从 pin 拉线搜索时没有传真实 pin context。
- Niagara module candidate 没有放进精确 usage/usage-id/emitter 的目标 stage，或 selector 多实例歧义时没有写 `occurrence`。
- apply 成功但 export/readback 没有出现目标对象、目标连接或目标值。
