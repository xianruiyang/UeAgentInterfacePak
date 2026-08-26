# Niagara Apply Domain

## 1. Scope

Niagara authoring registers one mutation owner, `niagara.apply`, for the following semantic targets:

- Niagara System、standalone Niagara Emitter 和 standalone Niagara Script 资产生命周期。
- External script modules and Assignment Modules in System, embedded Emitter, standalone Emitter, and standalone Module Script stages.
- Dynamic inputs attached to module inputs.
- Niagara module and dynamic-input script references.
- System emitter handle completion from a standalone Emitter source, followed by recursive renderer, Event Handler and stage/module Apply in the same transaction.

The provider uses the shared Workspace Apply coordinator for preflight, rollback capture, mutation, optional compile, shared state readback and semantic verification, optional save, then commit. Verification always precedes save so a failed semantic readback cannot persist an unverified mutation. Export remains independent and does not consume Apply input contracts or provider extensions.

## 2. Registered contracts

| Target | Apply input contract | Workspace contract | Supported operations |
| --- | --- | --- | --- |
| System / Emitter / Script asset | `uai.apply_input.niagara.asset` | `uai.apply_workspace.niagara.asset` | `create`, `update`, `upsert`, `remove`, `clone` |
| Stack module | `uai.apply_input.niagara.module` | `uai.apply_workspace.niagara.module` | `create`, `update`, `upsert`, `remove`, `clone` |
| Dynamic input | `uai.apply_input.niagara.dynamic_input` | `uai.apply_workspace.niagara.dynamic_input` | `create`, `update`, `upsert`, `remove` |

Dynamic input does not advertise `clone`. A correct clone must preserve the complete nested input graph and Data Interface state; replacing a link with the same script is an update, not a clone.

Module and dynamic-input contracts are separate so unsupported operations and selector fields are not advertised through a union contract. Both contracts still dispatch to the single `niagara.apply` provider.

## 3. Identity and state

The Niagara domain owns canonical identity models for the shared read-only asset projection, System, Emitter, script, stack entry, module, and dynamic input. All of them use `niagara.state` for readback.

Asset identity is based on canonical asset path and asset kind. Stack identity includes the owning asset, stage usage and usage ID, optional emitter selector, and entry selector. Module GUID is the preferred stable selector. Dynamic input identity adds module GUID, resolved input name, and dynamic-input node GUID when available.

Mutation verification reads the real UE object or Niagara graph after execution. A successful command result is not sufficient by itself.

## 4. Native defaults

The domain registers distinct default providers rather than one provider with changing provenance:

- `niagara.factory`: System、Emitter 和 Script creation through UE factories；Script 复制 `UNiagaraEditorSettings` 配置的对应 UE 原生 Default Script，保留 native Source/Graph，缺失时明确失败而不伪造默认图。
- `niagara.schema`: deferred stack defaults created by Niagara stack APIs.
- `niagara.domain_native`: script, module, Assignment target, and dynamic-input defaults supplied by Niagara domain APIs and `FNiagaraConstants`.

Apply completion may accept more information than Export displays. Missing generated content is obtained from UE factory, schema, or domain-native behavior; Export fields remain controlled only by Export profiles.

## 5. Script resolution

`ResolveScript` remains the resolver for existing module assertions, dynamic
inputs, and non-candidate internal references. New external Stack modules use
the contextual candidate chain instead: `niagara.module.candidates` resolves
the exact System/usage/usage-id/emitter Stack group and enumerates that group's
native Add Module actions.

Aliases that describe the same script must resolve to the same value. Conflicting aliases fail in preflight with `niagara_script_reference_conflict:*`. Unknown scripts fail with `niagara_script_not_found`. Missing dynamic-input references fail with `niagara_script_reference_missing`. These failures never become warning-and-skip mutations.

For native module creation, HJSON contains only `candidate: {name: ...}` or
`candidate: {id: ...}` inside the target stage module entry. Stage identity,
ordering, inputs, and operation remain outside `candidate`; the caller does not
copy a script path or binding revision from search. The server re-enumerates the
same native Stack action set in preflight and immediately before executing the
selected `INiagaraStackItemGroupAddUtilities::ExecuteAddAction`. Both selectors
are conjunctive when supplied together. Current creation support is explicitly
limited to `asset_module`; scratch-pad, assignment/set-specific, and wizard
actions remain visible in search but fail before mutation. Dynamic-input search
and creation are a separate surface.

Module selectors for existing entries use dedicated fields such as
`module_selector_script_asset_path`; they are not merged into dynamic-input
script references or candidate identity.

## 6. Mutation and rollback

Asset create and clone use UE factory or asset duplication paths. Asset update mutates the existing object and never copies an entire unrelated UObject over it. Whole-object property copying is unsafe for Niagara because internal scripts and script sources have ownership relationships that must remain intact.

For a System update, an emitter entry may provide Apply-only `source_asset_path`. If `target.emitter_name` does not resolve to an existing handle, Apply asks Niagara to create the handle from that standalone Emitter and its exposed version, captures the generated handle ID, then resolves all nested renderer, Event Handler and stage/module targets against the new handle. If the handle already exists and its UE parent matches `source_asset_path`, `source_sync_mode` selects the UE-native baseline operation before explicit nested patches: `merge` is the default and calls `UNiagaraEmitter::MergeChangesFromParent()` while preserving local overrides; `replace` creates a fresh parent-backed instance from the current source while preserving the existing handle ID, name and enabled state. Use `replace` only when the source is intentionally authoritative and stale local overrides must not survive. A conflicting parent path or version fails preflight instead of silently reusing unrelated content. An explicit handle ID is rejected for a missing target because UE owns generated handle identity. Optional `emitter_version` overrides the exposed source version.

Target and source paths must remain valid long package names under registered UE mount points. Resolution checks an already-loaded object inside its package, then a complete object path, then disk loading. This supports unsaved in-memory UObjects without admitting unregistered paths such as `/Temp`.

The same input is idempotent. If the named handle already exists, Apply reuses the handle, performs the requested matching-parent source synchronization, and repairs System integration instead of adding a duplicate. `replace` changes only the handle's parent-backed emitter instance; explicit owner properties, renderer patches, Event Handlers and stage patches in the same request are applied afterward and therefore have higher priority. Integration rebuilds System spawn/update emitter nodes, synchronizes the overview graph, recomputes emitter execution order, invalidates cached data and broadcasts the structural post-edit change before compilation. This step is required: `enabled=true` on the asset is insufficient when a runtime instance still reports the emitter as `Disabled` and never ticks.

Native asset-module creation replays the exact contextual Add Module action.
Existing module move/remove, Assignment creation/replacement, and dynamic-input
replacement continue through the shared Niagara stage/module helper. Assignment
creation uses Niagara's native `AddParameterModuleToStack`; target defaults come
from `FNiagaraConstants::GetAttributeDefaultValue`, not values invented by the
authoring provider. Replacing a dynamic input removes its owned nested value
nodes before changing the link, preventing orphaned graph nodes. Clearing a
dynamic input follows Niagara's native Reset semantics: it removes the
module-input override pin after deleting owned value nodes, so the module
script's UE-native default becomes active again instead of leaving an empty
synthetic literal override.

Asset operations capture an asset-level rollback object. Stack operations capture the owned Niagara graph and restore that graph on mutation, compile, verification, or save failure. The shared operation coordinator also captures the incoming dirty state of every package reported by a prepared state and restores it after the editor transaction is cancelled; a failed command therefore preserves both semantic content and the caller's original dirty state. Renderer rollback preserves the original UObject names and ordering so repeated failed transactions remain addressable by stable renderer identity. Existing-handle source refresh participates in the same graph, emitter-property, renderer and Event Handler rollback capture. A `replace` refresh also retains the previous instance until commit and restores it before graph and structure rollback if a later nested mutation, compile, verification or save phase fails. Emitter completion additionally records every handle created by the transaction and removes those handles in reverse order during rollback.

Preflight performs no mutation. Emitter Owner and renderer property groups are projected through the shared ObjectApply descriptor contract during preflight, including schema, property path, type/value conversion and renderer binding payload validation. This validation uses the current owner, the authoritative source baseline for add/replace completion, or a transient renderer probe as appropriate. Invalid nested fields fail in workspace preflight before source synchronization, renderer replacement, graph mutation, compile, save, or rollback is entered.

## 7. Export 与 folder command adapters

System、Emitter 和 Script 的六个 folder 命令已经迁移到统一纵切：

- Export 使用 `uai.export.niagara.asset`，执行 `niagara.state snapshot -> shared projector -> shared HJSON writer`。
- Apply 使用 `uai.apply_workspace.niagara.asset` 和 `uai.apply_input.niagara.asset`，Directory、single-file、inline 输入共用 loader、preflight、atomic transaction 与 snapshot verification。
- `niagara_export_folder` / `niagara_apply_folder` 约束 `asset_kind=system`。
- `niagara_emitter_export_folder` / `niagara_emitter_apply_folder` 约束 `asset_kind=emitter`。
- `niagara_script_export_folder` / `niagara_script_apply_folder` 约束 `asset_kind=script`。

standalone Script 的 `provider_extension.script_usage` 支持 `Module`、`Function`、`DynamicInput`，省略时为 `Module`。当前结构化 Stage authoring 只用于 `Module` usage；它复用相同的 stage/module/Assignment/recursive dynamic-input provider，而不是维护第二套 Script 图实现。Function/DynamicInput 可完成原生生命周期创建，但向它们提交 `stages` 会返回明确的 usage unsupported 错误。

默认 workspace 只有一个 `index.hjson`。旧 `asset.hjson`、`settings/`、`emitters/`、`graphs/`、`validation/coverage_report.hjson` 多文件 Niagara reader/writer 已不再是主路径，也不作为兼容输入。

`llm_authoring` 的核心形状如下；stage 和 module 的对象 key 是稳定 identity，不能按遍历序号重新生成：

```hjson
operation: update
target: { asset_path: "/Game/VFX/NE_Example", asset_kind: emitter }
provider_extension: {
  stages: {
    "standalone|ParticleUpdateScript|<usage-guid>": {
      target: { usage: ParticleUpdateScript, usage_id: "<usage-guid>" }
      modules: {
        "<module-guid>": {
          script_asset_path: "/Niagara/Modules/Update/Position/JitterPosition.JitterPosition"
          module_index: 0
          dynamic_inputs: {
            "Module.Jitter Amount": {
              script_asset_path: "/Niagara/DynamicInputs/Multiply/Multiply_Float.Multiply_Float"
              input_name: "Module.Jitter Amount"
            }
          }
        }
      }
    }
  }
}
```

新建原生资产模块时使用最小候选；查询需要的 usage/usage-id/emitter context 与
创建位置都在候选外层：

```hjson
operation: update
target: { asset_path: "/Game/VFX/NS_Example", asset_kind: system }
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

Export 的 stage key 保留 owner 身份：System 自身 stage 使用 `system|...`，standalone Emitter 使用 `standalone|...`，System 内 Emitter 使用 `<EmitterName>@<HandleGuid>|...`。Apply 仍以 stage 对象内的结构化 `target` 解析真实目标；对象 key 是稳定集合身份，不得用错误 owner 或遍历序号代替。

### 7.1 Standalone Module Script

standalone Module Script 使用同一 `provider_extension.stages` 结构。`script_usage` 只决定 UE 创建的 Script 类型；真正可编辑的 Parameter Map 链仍通过 stage/module/dynamic-input 公共结构表达：

```hjson
operation: create
target: { asset_path: "/Game/VFX/NM_Example", asset_kind: script }
provider_extension: {
  script_usage: Module
  compile: true
  stages: {
    module: {
      target: { usage: Module }
      modules: {
        "<module-guid>": {
          module_kind: assignment
          module_index: 0
          assignment_targets: { "Particles.ExampleValue": float }
          inputs: { "Module.Particles.ExampleValue": { value_kind: float, value: 1 } }
        }
      }
    }
  }
}
```

Export 会读回 stack-shaped Module Script 图。UE 图中的任意低层节点、自由连线和布局不属于此纵切，不得把缺失的低层节点误判成完整任意图往返能力。

### 7.2 Assignment Module

Assignment Module 复用普通 `provider_extension.stages.<stage>.modules` 容器，通过 `module_kind: assignment` 区分，不新增独立命令：

```hjson
"<module-guid-or-create-key>": {
  module_kind: assignment
  module_index: 1
  assignment_targets: {
    "Particles.Position": null
    "Particles.RibbonWidth": null
    "Particles.DynamicMaterialParameter": null
    "Particles.ProjectSpecificValue": float
  }
  inputs: {
    "Module.Particles.Position": { value: { source: linked_input, linked_parameter: "Particles.Position" } }
    "Module.Particles.RibbonWidth": { value_kind: float, value: 12 }
    "Module.Particles.DynamicMaterialParameter": { value_kind: vector4, value: [1, 1, 1, 1] }
  }
}
```

- `assignment_targets` 存在时是该 Assignment 的完整目标集合；增删或改类型会通过原生 Niagara Stack API 重建模块，并保留稳定 module GUID 和目标顺序位置。
- `modules` 的键优先接受 Export 返回的合法 GUID；手写稳定语义键时，Apply 会按资产与 stage 上下文生成确定性 module GUID。相同 workspace 重复 Apply 必须命中同一模块，不得追加重复节点；Export 始终读回实际 GUID。
- 对 `FNiagaraConstants` 中的已知原生属性，值可写 `null`，Apply 自动使用 UE 声明的真实类型；显式类型与原生类型冲突时以 `niagara_assignment_target_type_conflict:*` 失败。
- 对未知项目变量必须显式提供类型；缺失时以 `niagara_assignment_target_type_missing:*` 失败。支持公共 Niagara 基础类型 token，也接受可加载的 struct、enum 或 class object path。
- Assignment 不接受 `script_asset_path`；普通 Script Module 不接受把 Assignment 当作无脚本外部模块静默保留。冲突在 preflight 阶段失败，不进入 mutation。
- Export 对 Assignment 输出结构化 `module_kind`、`assignment_targets` 和必要 input overrides，不暴露 Niagara 为 Assignment 生成的内部瞬态脚本路径。
- Apply 在 mutation 前递归比较现有 literal、`linked_input`、Data Interface 和 dynamic-input 子树；语义相同的 Export->Apply 不重写 pin、不标脏图，也不触发无意义的结构编译。模块脚本或 Assignment 目标集合确实替换时，才把其输入树标记为需要重建。

当前 Export 可编辑投影覆盖 stage、外部 script module、Assignment Module、dynamic-input script、System User Parameter，以及已偏离 UE 默认值的 Emitter Owner 和 renderer authoring 属性。Emitter Owner 的 `target` 与 `properties` 是同一 snapshot 的两个独立投影槽：身份只进入 `target`，属性组只进入同级 `properties`；Emitter 默认比较由 UE Niagara Factory seed 提供。Renderer 与 Emitter Owner 共用结构化 property-group builder，array/set/map 会携带 `element_type`、`key_type`、`value_type` 等容器类型信息。Renderer property group 还总是包含按 `property_path` 排序的 `{property_path:bIsEnabled,value_kind:bool,value:{literal:...}}` descriptor；该字段由 Niagara renderer API 拥有，Apply 通过 `SetIsEnabled` 写入，而不是把它误当作普通反射 FProperty。重复 descriptor 或非 bool literal 在 preflight 拒绝。Event Handler 仅覆盖当前受控结构，Data Interface 详细属性和任意 Script graph topology 不在本纵切的完整 Export 范围内；不得从旧多文件文档推断这些内容仍由 folder 命令覆盖。Assignment 是 UE 原生参数写入节点的受控 authoring 形态，不代表任意 Script graph topology 已开放。Apply 可以接受契约允许但 Export profile 未展示的输入，两者字段集合互不推导。

### 7.3 System User Parameter completion

- `provider_extension.user_parameters` 是以规范参数名为 key 的对象映射；Export 使用 `User.*` 全名，Apply 同时接受短名并规范化为 `User.*`。
- 参数对象支持 `type`、结构化 `value`、可选断言 `value_kind` 和 `remove`。`null` 与 `remove: true` 等价，删除不存在的参数是幂等 no-op。
- `llm_authoring` Export 不输出可由结构化 `value` 是否存在推导的 `has_value`；`readback` / `debug` 可保留 `value_text`。Apply 接受历史 Export 中的布尔 `has_value` 和 readback `value_text` 作为只读元数据，结构化 `value` 始终是唯一写入真源；`has_value=false` 与同时提供 `value` 会在 mutation 前失败。
- 新参数必须提供 `type`；缺少 `value` 时由 UE 参数存储创建原生默认值。更新已有参数可省略 `type`，缺少 `value` 时保留当前值；显式类型与现有类型冲突会在 mutation 前失败。
- `value` 使用统一类型结构：标量 `{ literal }`，Vector/Position/Quat/Color `{ components: [] }`，Enum `{ selected }`，UObject/Data Interface `{ path }`，其它 struct 使用递归 `{ fields }`。
- User Parameter 具有独立 semantic identity、统一 snapshot readback 和事务回滚；Apply 接受范围不会改变 Export 的字段筛选规则，`value_text` 只在 readback/debug profile 保留。

### 7.4 System emitter handle completion

```hjson
provider_extension: {
  emitters: {
    MainArc: {
      source_asset_path: "/Game/VFX/Emitters/NE_Arc"
      source_sync_mode: replace
      emitter_version: "<optional-guid>"
      target: { emitter_name: MainArc }
    }
  }
}
```

This is not a separate seed command. It is the Niagara specialization of shared recursive completion: use caller evidence to resolve an existing UObject first, ask UE to create missing native content second, hide generated identity from the caller, then continue ordinary Apply. Replaying the same entry is also a synchronization request. Omitted `source_sync_mode` or `merge` keeps UE local overrides; `replace` uses the current source as the complete baseline and then applies explicit request fields. A different parent, incompatible version, unknown mode, or a mode without `source_asset_path` is rejected in preflight. Export remains profile-driven and does not add either Apply-only field solely because Apply accepted it.

### 7.5 Renderer attribute binding

`FNiagaraVariableAttributeBinding` 不是普通递归 struct。它的 `ParamMapVariable`、`DataSetName`、缓存名称和可访问性标记是 UE 根据绑定根变量、Emitter 版本和 renderer source mode 推导的内部状态，不能逐字段手工维护。

Renderer binding 的 authoring 输入只需要结构化提供 `RootVariable.Name`：

```hjson
{
  property_path: PositionBinding
  value_kind: struct
  value: { fields: { RootVariable: { fields: { Name: { literal: Module.Position } } } } }
}
```

Apply 会识别所有类型为 `FNiagaraVariableAttributeBinding` 的 renderer 属性，并调用 UE 的 `FNiagaraVariableAttributeBinding::SetValue` 自动补全命名空间、数据集名称、类型和缓存字段。该规则同样适用于 `PositionBinding`、`SpriteSizeBinding`、`SpriteAlignmentBinding`、`ColorBinding` 及其他 renderer attribute binding；不得通过手写派生字段或逐字段绕过来模拟绑定。其他 renderer 属性仍走共享 UObject property Apply。

## 8. Verification

`UeAgentInterface.Authoring.Niagara` covers:

- registration, semantic ownership, exact native-default source kinds, and contract operation matrices;
- conflicting, missing, and unknown script references;
- System and Emitter create, update, clone, and remove;
- external module and Assignment Module create, replace, move, clone-compatible readback, and remove;
- dynamic-input create, update, and remove;
- preflight failures that leave the stack unchanged.
- invalid Emitter Owner or renderer property descriptors rejected in preflight with unchanged semantic state and package dirty state;
- renderer enabled-state Export/Apply round trip through the domain-owned `bIsEnabled` descriptor;
- transaction rollback restoring the package dirty state that existed before capture;
- emitter handle completion before recursive stage Apply, matching-parent `merge` and source-authoritative `replace` refresh with stable handle identity, local-override priority, source-conflict protection, System execution-graph integration, idempotent replay and rollback ownership.

Additional command-level smoke gates cover:

- `NiagaraStageModulePatch`: Emitter Export、module/dynamic-input Apply、幂等重放、删除和读回；
- `AssignmentWorkspace`: UE 原生属性类型补全、类型冲突保护、Particle Update Assignment 写入、结构化 Export 和幂等往返；
- `NiagaraFolderWorkflow`: System、Emitter、Script 六个 folder 命令的 `Export -> Apply -> Export` HJSON golden；
- Export 前后 package dirty 状态与 semantic snapshot 不变；
- published create/clone assets carry `RF_Public | RF_Standalone` and remain resolvable across commands.
- contextual System Update module search leaves the package clean, accepts an
  id-only candidate, replays the same native asset-module action, and survives
  save/unload/reload with independent script and selected-version readback.
