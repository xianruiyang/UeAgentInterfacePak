# UAI JSON Authoring Guide

本指南定义 UeAgentInterface 结构化 JSON 的 LLM authoring 规则。它不替代各命令分册；字段、参数和支持面仍以 `docs/commands/*.md` 与当前插件源码为准。结构化 JSON schema 判断必须依据实际导出、apply/validate 源码、命令文档和 readback/smoke，不使用 KB 推断项目私有字段。

## Documentation Route

通用 input/value 规则和节点/module/component/widget 查询写入链路只维护一套，不在每个模块分册重复展开。LLM 默认直接编辑 `authoring` / `minimal_authoring` JSON；Python 只用于批量生成、参数化脚本、adapter 调试或重复变量过多的辅助工作。

| 文档 | 内容 |
| --- | --- |
| `json-authoring/00_DirectJsonAuthoring.md` | LLM 直接编辑 JSON、`node_catalog_search -> json_authoring seed -> apply/readback -> node_origin_resolve` 的统一主链路。 |
| `json-authoring/01_Workflow.md` | 通用 export -> authoring -> lint -> adapter -> apply -> readback 流程。 |
| `json-authoring/02_CommonInputValue.md` | 所有模块共享的 `type_info`、`value`、`allowed_values[]`、source 层和只读字段规则。 |
| `json-authoring/03_OperationsAndSelectors.md` | selector、operation、新增/删除/替换结构、最小创建种子。 |
| `json-authoring/04_SpaceContract.md` | transform、layout、socket、IK、graph/node/widget 坐标合同。 |
| `json-authoring/05_Validation.md` | lint、adapter、validate/dry-run、apply、readback、warning 处理。 |
| `json-authoring/recipes/*.md` | 模块特有规则，只讲通用教程之外的差异。 |
| `commands/*.md` | UAI 命令参数、返回字段、folder JSON 支持范围和模块实现边界。 |

## Direct JSON Authoring First

结构化 JSON 编辑默认按以下顺序执行：

```text
export/readback
-> 直接编辑 authoring/minimal_authoring JSON
-> 需要新增候选时 node_catalog_search
-> 可选 node_origin_resolve 查来源
-> validate/lint/adapter
-> apply
-> export/readback/compile/probe 验证
```

不要用一长串原子命令替代已有 JSON / folder workflow。不要先写 Python 再让 Python 隐式拼业务语义；业务意图必须落在 JSON 中，Python 只负责批量生成、复用参数、执行 UAI 调用和收集 report。

新增内容默认走“最小结果 -> apply 补全 -> readback 继续编辑”：不要从 readback 复制完整对象，也不要手写 UE/UAI 会生成的 id、template、slot、pin、默认属性、diagnostics 或 derived 字段。只写能表达目标的最小 authoring：`kind/name/full_name`、必要 selector/parent/context、必要 `operation`，以及用户实际要改的 `value`、connection、layout 或 properties。

节点、模块、组件、控件、Material expression、Niagara dynamic input 的新增和来源切换统一看 `json-authoring/00_DirectJsonAuthoring.md`。主身份字段固定为 `kind/name/full_name`：`name` 用于阅读和默认本地 id，稳定写入和来源解析必须依赖 `full_name`。

## Profiles

| Profile | 内容 | 编辑策略 |
| --- | --- | --- |
| `minimal_authoring` | 最小可写意图和必要 selector。 | LLM 可编辑；适合新增结构、改少量值。 |
| `authoring` | 紧凑可写意图和必要候选。 | LLM 可编辑；默认主入口。 |
| `readback` | UE 当前状态、对象路径、默认值、能力状态、raw enum options。 | 只读；用于确认和消歧。 |
| `diagnostics` | validation、coverage、compile、runtime、warning、diff。 | 只读；不回写。 |
| `legacy_full` | 当前 UAI 原始导出兼容层。 | 仅 adapter/migration 使用。 |

## Common Input Contract

所有类似 input 的可写值都走通用 `value` 对象。模块分册不应重新定义 bool、number、enum、vector、curve 的基础写法。

| 类型 | 写法 |
| --- | --- |
| bool | `value.literal` |
| int / float | `value.literal` |
| string / name / text | `value.literal` |
| enum / choice | `value.selected` + input 级 `allowed_values[]` |
| vector / color / rotator / quat | `value.components` |
| transform / layout | typed object + `space_contract` |
| object/class/folder path | 明确语义 path 字段 |
| curve | `value.curve` |

普通值编辑只改 `value` 内部字段。`operation` 只用于 add/remove/replace/clear/rename/set_binding 等非普通值意图。

Enum authoring 必须包含 concrete candidates。LLM 只能把 `value.selected` 写成 `allowed_values[].value`；不要在可写 `value` 对象里放 `display_label`。候选项里的 `allowed_values[].display_label` 是只读辅助；数字值和 raw `enum_options` 留在 readback/diagnostics。

Authoring JSON 使用自动紧凑规则：对象暴露出的属性数量低于 formatter 阈值，且自身或嵌套对象不暴露 list/array 字段时，才允许单行；嵌套短对象的叶子属性会计入暴露属性数量。这样短 `value`、vector/color `components` 和 `allowed_values[]` 里的候选对象通常可单行，但包含 `allowed_values`、curve keys、graph links 等数组字段的对象不会整体压成一行。

## Catalog / Node Authoring Chain

新增节点、模块、组件、控件、Material expression、Niagara dynamic input 或需要从 JSON 反查含义时，统一走 `json-authoring/00_DirectJsonAuthoring.md` 和 `commands/28_NodeGraph.md`：

1. 用 `node_catalog_search` 查当前 UE 真实候选；分类不明确时先 `node_catalog_categories`。
2. 只使用候选返回的 `kind/name/full_name/json_authoring/write_support/support_reason` 作为写入证据。
3. 把 `json_authoring` 或 `json_authoring.seed` 直接放入对应 authoring JSON 位置；只补必要上下文和用户要改的字段。
4. 需要理解候选或 JSON 中已有节点时，用同一组 `kind/name/full_name` 调 `node_origin_resolve`。
5. apply 后重新 export/readback，并检查编译、Stack issue、graph/node/pin、slot、template 或 domain-specific probe。

当前最完整的直接补全路径是 `actor_component`、`umg_widget`、`material_expression`、`material_function_call` 和作为 input value 的 `niagara_dynamic_input`。Blueprint 节点类候选需要正确图/Pin 上下文并以 compile/readback 为准；Niagara module seed 当前只匹配已有导出 module，不等于新增 stack module 已闭环。

## Allowed Authoring Surface

| 域 | LLM 可以表达的内容 | 主要命令 |
| --- | --- | --- |
| Blueprint / UMG / AnimBlueprint | components/widgets/members/defaults；graph nodes、connections、comments、layout；UMG slot/binding/animation。 | `*_export_folder` / `*_apply_folder` |
| Material | material expressions、connections、root inputs、function graph、instance parameter overrides。 | `material*_export_folder` / `material*_apply_folder` |
| Niagara | system/emitter stages、modules、renderers、event handlers、module inputs、dynamic inputs、data interface curves、parameters。 | `niagara*_export_folder` / `niagara*_apply_folder` |
| Sequence | bindings、tracks、sections、keys、ControlRig control keys、outliner folders。 | `sequence_export_folder` / `sequence_apply_folder` |
| Control Rig | hierarchy、controls、variables、RigVM nodes/links/pin defaults、structured IK、Shape Library references。 | `control_rig_export_folder` / `control_rig_apply_folder` |
| Mesh / Skeleton / IK | sockets、materials、collision、preview、virtual bones、retargeting、IK goals/chains/solvers、retargeter mappings/poses。 | mesh/skeleton/IK folder commands |
| PCG / Project Settings / Data | PCG nodes/connections/layout；settings field patches；DataAsset fields；DataTable rows。 | `pcg_graph_*`、`project_settings_*`、`data_*` |
| Long-tail assets | Audio, Texture/Media, AI, Localization/Packaging, LevelContent, Topology, Physics, Deformer, EnhancedInput safe subsets。 | corresponding `*_json` / `*_folder` commands |

## Field Rules

1. Use `target_asset_path` for target identity. Treat `object_path`, generated class names, engine versions and export timestamps as readback.
2. Use structured `value` objects for editable current values. Legacy compact values and typed value objects remain accepted for compatibility, but generators should prefer the structured value object.
3. Use `operation` only for explicit non-value intent. Do not encode intent through readback booleans.
4. Do not author derived counts, output files, validation reports, compile reports, runtime probe results, roundtrip status or coverage notes.
5. Do not write Niagara `has_override`, `has_links` or `autogenerated_default_value`. Use structured `value`; keep defaults, visibility, raw enum metadata, links and override state in `readback`.
6. Generated authoring must not carry readonly `context`. Legacy hand-authored `context.allowed_values` may be lint-compatible, but generators should emit input-level `allowed_values`.
7. Do not place `enum_options` on writable authoring enum value objects. `enum_options` remains raw readback metadata.
8. Do not treat `raw_properties` as generally writable. Only explicit property patches with `apply=true` and a supported command path may be written.
9. Unknown or unsupported operations must fail before writing an apply folder. Do not silently drop user intent.
10. Generated authoring JSON should compact objects by structure, not by a hard-coded type list: no exposed array fields and fewer than the configured exposed-property threshold. Keep arrays, nested curves, graph nodes and domain records expanded so selectors and boundaries remain readable.

## Space Contract

Any 2D/3D layout, transform, socket, control, IK goal, graph node, widget slot or LevelContent transform must include:

```json
{
  "space_contract": {
    "subject": "the exact edited object",
    "dimension": "2d or 3d",
    "Fsemantic": "user-intent frame and basis evidence",
    "Fwrite": "UAI/UE write frame",
    "Fread": "readback frame",
    "Fverify": "verification frame",
    "conversion_chain": "how authoring converts to write/read/verify"
  }
}
```

If the contract is incomplete, reject the authoring profile before adapter output. Do not compare or combine transforms from different frames.

## Standard Loop

1. Export or load a fixed fixture.
2. Generate `authoring`, `minimal_authoring`, `readback`, `diagnostics`, `legacy_full`.
3. Edit only authoring profiles.
4. Run authoring hygiene lint.
5. Convert with the domain adapter to current UAI legacy JSON/folder.
6. Validate or dry-run.
7. Apply with explicit safety flags.
8. Export/readback and compare the semantic result.
9. Record warnings, dirty resources and process state.

对支持编译的 folder apply 命令，`compile_after_apply=true` 是 apply 合同的一部分，不是事后补充步骤。Apply 必须在最终保存前读取编译结果；编译错误返回 `compile_failed_after_apply`，响应中保留 `saved=false`。Niagara folder apply 还默认 `force_compile=true`、`wait_for_complete=true`；`compile_incomplete_after_apply` 表示 System 编译队列未清空，`compile_log_read_failed_after_apply` 表示诊断读取失败，两者都不会执行最终保存。

普通导出、apply、readback、smoke 复用当前 UE Editor，不因为普通验证完成而关闭用户已有 UE。只有需要重新编译插件/UE C++ 且 DLL 被占用时，才先处理 dirty resource，然后安全关闭 UE 构建。

## Verification Requirements

| Case | Required check |
| --- | --- |
| Value edit | command response plus readback exact or normalized value check. |
| Graph edit | node/link count, supported node type, compile/validation report, readback graph. |
| Niagara edit | stack issues, compile log, active branch/mode, runtime or preview probe when visual behavior matters. |
| Space edit | same subject, same frame, same state readback; visual check when layout or rendering matters. |
| Destructive edit | explicit destructive gate, dry-run or plan first, readback after apply. |
| Long-tail config | validate/diff/dry-run first; do not treat packaging/config output as persistent asset state unless command reports it. |
