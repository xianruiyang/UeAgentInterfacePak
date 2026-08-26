# Structured HJSON Editing

本页定义单文件和 folder HJSON 的日常编辑流程。动态领域的字段细节以运行中的
`content_graph.authoring_schema` 返回为准；静态 authoring guide、命令 detail、实际导出
和 readback 只补充该查询没有承担的领域约束，不能形成第二字段合同。

## 选择编辑面

编辑前确认：目标资产/owner、单文件或 folder、authoring profile、目标文件/ref、可写/readonly/unsupported 范围、validate/diff/apply/readback 命令，以及 compile/save/probe/screenshot 验收要求。

优先级：

1. 领域支持 `content_graph.authoring_schema` 时，先取得当前 schema、field owner、
   allowed intents、稀疏 template 和 revision，再选择 inline/single-file/directory carrier。
2. 使用正式 folder Export 时先检查返回的 `scope`。只有明确声明完整结构覆盖时才按 whole-asset
   workspace 编辑；`field_set_complete=true` 但 `asset_structure_complete=false` 只授权编辑该
   field set，省略结构必须由 Import 保留，不能从导出缺失推断删除或完整覆盖。
3. 单文件资产使用单文件 HJSON round-trip；新增内容从正式 create schema 的最小 seed 开始。
4. 原子命令只用于 bootstrap、只读 probe、迁移、schema 边界、局部修复和故障恢复。

`_json` 可以保留为稳定命令名，但文件 authoring 统一使用 HJSON。HTTP/CLI JSON envelope 和第三方协议 JSON 不属于文件格式迁移范围。

## Folder 导航

```text
folder root
-> ExportProfile included_files
-> tutorial read_order / required identity-entry files
-> target section/ref when present
-> target authoring file
-> required owner context/direct refs
```

- 默认不读 sibling、raw、readonly、debug、coverage、report 或完整 readback。
- ref 必须留在 package 根目录内，不能使用越界相对路径。
- Details group 已由 `details/index.hjson` 和 group 文件表达，不再输出 `category_path`。
- 公共路径 resolver 统一处理 owner、group、section 和 stem；不得重复拼接形成多余中间目录。
- 一个目标能在一个文件表达时，不联动修改无关文件。

## 字段规则

若响应包含 `fields` 合同，`path`、`owner`、`missing`、`nullable`、
`default_supported`、`allowed_intents` 与 `value_contract` 整体决定字段语义。未出现的
intent 一律不支持，不能从其他字段或领域类推。省略只在 `missing=preserve` 时表示保留；
`remove`、`null` 与 `default` 必须逐字段声明。

默认 authoring 字段使用：

- `property_path` 或域内 selector：定位字段；
- `selector`：定位结构对象；
- `display_name`、`value_kind`、结构化 `value`；
- 条件适用时使用 `availability`、`tooltip` 和 `candidates`。

限制：

- 有可靠 `value` 时不输出 `value_text`；它只用于 debug/readback 或契约明确的无可靠结构值 fallback。
- grouped Details 不输出 `category_path`。
- 普通属性不输出复数 `operations` 能力列表。
- 单数 `operation` 只用于 add/remove/replace/clear/rename/set_binding/upsert 等结构意图；普通值修改只改 `value`。
- `control_type` 由 `value_kind`、`candidates` 和值结构推导。
- enum/choice 写 `value.selected`，且必须来自 `candidates`。
- `full_name/class_path/asset_path/object_path` 不作为新创建的必填选择器；领域允许时
  可作为 search 结果或 HJSON assertion。新候选的最小选择器使用公开 `name` 或 `id`。

## 最小编辑

1. 新增节点、模块、组件、Actor、控件或 expression 前，若领域 candidate command
   未知，先用 `query.command.search` 和 `query.command.detail` 取得当前教程与
   参数合同；再在 graph/pin、SCS parent、world/level、stage/target 等真实原生
   上下文中搜索 3-5 条候选。
   Blueprint 节点的 `graph_id` 必须先从该资产当前
   `content_graph.structure` 中选择：匹配 `kind=blueprint_graph` 以及所需的
   `value.name`/`value.graph_kind`，再把同一 container 的 opaque `id` 原样传入
   candidate 查询；不得从节点类型推断、缓存旧 GUID 或自行重建 ID。
   同一 structure 也是既有 Blueprint 节点的紧凑语义读回：事件、组件绑定事件、
   函数调用和变量节点分别在 `value` 中给出其 event、delegate、function 或
   variable identity。应连同稳定节点 `id` 直接选择/验证，不得从位置、数量、边或
   原始 K2 class 推断，也不得只为这些已投影语义导出完整 workspace。
2. 候选最小 HJSON 形状是 `candidate: { name: ... }` 或
   `candidate: { id: ... }`。`name` 必须在同一上下文唯一；`id` 是精确选择器。
   模型明确知道并希望断言更多内容时，可补领域公开的 `class_path`、`asset_path`
   等字段，但这些字段不能替代 `name/id`。Blueprint node 查询还可返回
   function/event/variable/node 的安全语义字段；可把查询原值随 `name/id` 写回作精确
   assertion，不得从本地化显示名合成。内部 `native_action_signature` 不公开。不要写
   `candidate_id` 别名。候选分页时沿 `next_cursor` 读到 `has_more=false` 后才能声称全集
   或唯一。
3. stable map key、对象 selector 和外层 context 表达实例名、owner、父级、graph、
   level、stage、placement、连线和 layout；不得把这些字段混入 candidate。
4. 服务端在首写前必须从同一原生 owner 重枚举候选，按 `name/id` 唯一解析，并
   调用同一 action/spawner/factory；不得由 Python 或 HJSON adapter 根据显示名
   重建 class、节点类、asset factory 或资产映射。
5. 不手写内部 candidate id、template、slot、pin、默认属性、derived 字段和
   diagnostics；公开查询返回的 `id` 可以原样使用。
6. 跨文件引用使用正式 ref，不复制被引用对象全文。
7. 删除/重命名前检查 owner、ref、binding 和 index 更新要求。

当前三个基础创建面的最小形状如下；字段的精确嵌套位置仍以运行中的
`content_graph.authoring_schema` 和 command detail 为准：

```hjson
// Blueprint graph node; graph and optional pin context stay outside candidate.
"node:BranchGate": {
  operation: create
  candidate: { name: Branch }
}

// Blueprint SCS Component; stable key is the instance identity.
"component:DoorTrigger": {
  operation: create
  candidate: { id: "candidate:..." }
  parent: DefaultSceneRoot
}

// One item inside the Level document's actors array.
{
  managed_id: NativeCube
  operation: upsert
  candidate: { id: "candidate:..." }
  transform: {
    location: { x: 0, y: 0, z: 50 }
    rotation: { pitch: 0, yaw: 0, roll: 0 }
    scale: { x: 1, y: 1, z: 1 }
  }
}
```

对应查询入口是 `blueprint.node.candidates`、
`blueprint.component.candidates`、`world.actor.candidates`。只把这些 ID 当作发现
bootstrap；调用参数、结果 assertion、category/context 和 unsupported 语义从运行时
detail 与候选结果读取。

Animation Blueprint 的 parent StateMachine 与 child State 使用同一个
`animation.state_machine.candidates`，但查询时必须选择不同 surface。先为同一 future
missing target 和同一 `class_settings` 查询 `animation_graph`，再查询
`state_machine_graph`，把各自返回的精确 id 放入对应 HJSON item：

```hjson
state_machines: [{
  name: Locomotion
  animation_graph: AnimGraph
  candidate: { id: "candidate:<state-machine>" }
  pos_x: 320
  pos_y: 64
  states: [{
    name: Idle
    candidate: { id: "candidate:<state>" }
    pos_x: 240
    pos_y: 0
  }]
  entry_state: Idle
  transitions: []
}]
```

查询与写入都从同一 factory/context 重枚举 UE 原生 action。当前仅 parent StateMachine
与 plain State 可写；其它返回 action 按 `supported/write_support` 处理。实例 `name`、
graph、position、entry 和 transition 不进入 candidate；Transition 是 schema relation，
不是候选。完整合同读取
`docs/UeAgentInterface/active/t16_animation_blueprint_domain.md`。

UMG WidgetTree 使用同样的最小 selector，但 widget 实例身份、父级和 slot 顺序都在
candidate 外：

```hjson
"widget:ActionButton": {
  operation: create
  candidate: { id: "candidate:..." }
  parent: RootCanvas
  index: 0
}
```

对应查询入口是 `umg.widget.candidates`，并绑定同一目标 Widget Blueprint。只使用
`supported: true` 的候选；服务端首写前重枚举并通过公开 Widget template mechanics
创建。当前两个 coverage flag 都为 false，不能声称覆盖完整 Designer Palette、
UserWidget/asset 或特殊 template。已知 `class` 只能作为 candidate 外的 assertion。

MetaSound Source 使用 `audio.graph.candidates`，当前最小节点形状为：

```hjson
{
  intent: create
  candidate: { id: "candidate:..." }
  position: { x: 384, y: 192 }
}
```

`node_guid` 可省略并由服务端生成；已知 class/version 时只能作为 candidate 外的
assertion。该查询当前覆盖 frontend registry 并经 Builder 写入，返回的两个 coverage
flag 都为 false，不可描述成原生 blank-menu 等价。SoundCue 仍使用其 legacy full
binding 兼容合同，不能复用上述紧凑形状。完整边界读取
`docs/UeAgentInterface/active/t21_audio_domain.md`。

## 直接与程序化编辑

- 小范围修改可以直接编辑完整目标 HJSON 对象，写后必须 parse。
- 动态 schema 返回的 template 可以作为 JSON（HJSON 的合法子集）修改和序列化；调用方只
  改值并把 document 原样传给公开 Import，不补默认、路由、revision 或领域变换。
- 编辑 directory export 后必须保留 manifest 的 `target_identity`、`base_revision`、`entry_file`
  和文件集合，并用修改后文件的 UTF-8 内容重新计算对应 SHA-256 `content_hash`；旧 hash
  不匹配时 Import 在 UE 写入前失败。
- 若领域 detail 指向正式 HJSON reader/writer，文件读取与写出只用该入口；没有正式入口时
  不臆造 `load_authoring_file`、`write_authoring_file` 等 helper。
- 批量、重复数组或跨文件一致性修改使用结构化数据操作，但 Python 不复制服务端业务。
- 不使用正则、全局字符串替换、手工拼接或 `json.dumps(..., indent=2)` 修改 authoring。
- 程序化重写不得无必要改变未修改字段、文件布局和稳定顺序。

## 同行与字符串安全

公共 writer 的固定规则：

1. object 递归计算有效字段数；scalar 计 1。
2. 不含 object 的 list 在所属 object 中计 1，并整体同行。
3. 嵌套 object 的字段递归累计。
4. object 有效字段数 `<= 6` 且所有子值可同行时整体同行，否则折行。
5. 含 object 的 list 不作为普通同行列表，各 object 继续按同一规则判断。

字符串可能包含 `#`、`//`、`/*`、引号、反斜杠、冒号、逗号、边界符、换行和 Unicode。把原值交给 HJSON writer，由 writer 决定引用和转义；不得为同行截断、双重转义或改变换行。重要写入执行 parse -> write -> parse round-trip。

## Apply 与验证

```text
authoring_schema or verified scoped export
-> navigate target
-> minimal edit
-> local parse/round-trip
-> content_graph.import_workspace
-> server validate/plan/mutate/compile/save/reload
-> independent readback/probe/screenshot
-> semantic comparison
```

- 公共 Import 没有第二个 `intent` 或 `dry_run` 参数；intent 在文档中，预写验证和失败
  终态由服务端拥有。多文件变更全部 parse 通过后才提交。
- apply 后导出到独立 readback 位置，不覆盖 authoring 输入。
- diff 比较业务语义，不把空白、同行方式和字段顺序当作业务变化。
- readback 缺少目标、值不一致、分支不活跃或 compile 失败时，任务未完成。
- 大型 readback 只投影目标对象/字段，完整证据留在 artifact。
