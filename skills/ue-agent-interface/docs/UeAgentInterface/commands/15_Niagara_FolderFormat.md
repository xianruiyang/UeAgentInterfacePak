# 指令详解：Niagara 文件夹式结构化 JSON

本页对应 Niagara 文件夹式结构化 JSON 工作流，固定根目录如下：

```text
Saved/UeAssetFolders/NiagaraSystem
Saved/UeAssetFolders/NiagaraEmitter
Saved/UeAssetFolders/NiagaraScript
```

## 完成度结论

当前 Niagara 文件夹 profile 已完整落地到 `System / Emitter / Script` 三个根类型：

- `niagara_export_folder / niagara_apply_folder`
- `niagara_emitter_export_folder / niagara_emitter_apply_folder`
- `niagara_script_export_folder / niagara_script_apply_folder`

实现口径：

- 使用真实 UE 关系建模：`UNiagaraSystem -> FNiagaraEmitterHandle -> FVersionedNiagaraEmitter -> UNiagaraEmitter`。
- `NiagaraSystem` 导出/回写覆盖 System 属性、User 参数、Emitter Handle、Emitter 文件夹内容、脚本引用、System/Emitter stage 摘要、验证报告。
- `NiagaraEmitter` 导出/回写覆盖 version data、graph 参数、rapid iteration 参数、renderer、event generator、event handler、simulation stage、module stack、module input default、module input dynamic input、data interface 引用与 raw reflected fields。
- `NiagaraScript` 导出/回写覆盖脚本元数据、raw reflected fields、graph nodes、graph links、Custom HLSL 节点文本。
- 不把外部资产内容复制进 Niagara 文件夹；Material、Mesh、Parameter Collection、Effect Type、Data Channel 等仍以引用和依赖记录保存。
- `validation/coverage_report.json` 现在以 `implementation_status=complete_folder_profile`、`is_complete_target_schema=true`、空 `pending_profiles`、空 `blocking_gaps` 作为完成口径。实际资产缺失、坏引用、UE `ImportText` 无法导入的字段仍会进入 `warnings`；`strict=true` 会把这些运行时 warning 转为失败。
- `niagara_apply_folder` 和 `niagara_emitter_apply_folder` 默认在 apply 后读取 Niagara Stack issue，并把红色感叹号/黄色警告信息随 apply 返回；`strict=true` 默认遇到 Stack error 也会失败。

## 标准工作流

Niagara authoring 必须优先走文件夹式结构化 JSON，不再用零散原子命令直接手搓完整效果：

1. 创建最小 Niagara System / Emitter / Script 骨架。
2. 立即导出文件夹式 JSON，拿 UE 实际生成的结构作为模板。
3. 在导出 JSON 中写入基础 module / renderer / event / script 结构。
4. Apply 回 UE，让 UE 生成合法 Stack 节点、隐藏字段、GUID 和默认参数。
5. 再导出一次，拿到已补全的完整 module 属性面。
6. 在第二次导出的完整 JSON 上修改参数。
7. 再次 apply。
8. 读取 apply 返回中的 `warnings`、`stack_issue_report`、`stack_issues`、`stack_scopes`、`stack_error_count`；必要时再用 `niagara_get_compile_log` 和 runtime probe 验证。

保留原子命令只用于 bootstrap、诊断、探针、迁移脚本和紧急修补；完整 Niagara 效果制作不应以原子命令作为主流程。

## 指令列表

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_export_folder` | 将 `UNiagaraSystem` 导出为文件夹式 JSON | `asset_path`、`folder_path`、`clean_output_dir` | 导出可读、可 diff、带覆盖报告的 Niagara System |
| `niagara_apply_folder` | 从文件夹式 JSON 回写 `UNiagaraSystem` | `asset_path`、`folder_path`、`create_if_missing`、`apply_referenced_emitters`、`strict` | 重建/合并 System、User 参数、Emitter Handle、Emitter 内容 |
| `niagara_emitter_export_folder` | 将 standalone `UNiagaraEmitter` 导出为文件夹式 JSON | `emitter_asset_path`、`folder_path`、`clean_output_dir` | 导出独立 Emitter 资产的可 diff 文件夹 |
| `niagara_emitter_apply_folder` | 从文件夹式 JSON 回写 standalone `UNiagaraEmitter` | `emitter_asset_path`、`folder_path`、`create_if_missing`、`strict` | 重建/合并 Emitter version data、Renderer、Stage、Module、Event |
| `niagara_script_export_folder` | 将 standalone `UNiagaraScript` 导出为文件夹式 JSON | `script_asset_path`、`folder_path`、`clean_output_dir` | 导出 Module / Function / Dynamic Input 脚本图 |
| `niagara_script_apply_folder` | 从文件夹式 JSON 回写 standalone `UNiagaraScript` | `script_asset_path`、`folder_path`、`create_if_missing`、`strict` | 创建或更新脚本资产、节点属性、Custom HLSL |

## System 输出结构

```text
NS_Fireball/
  asset.json
  settings/
    system.json
    asset_options.json
    effect_type.json
    scalability.json
    fixed_bounds.json
    performance.json
    baker.json
  parameters/
    user_parameters.json
    system_parameters.json
    parameter_definitions.json
    parameter_collections.json
    parameter_collection_overrides.json
  system_stages/
    SystemSpawn.json
    SystemUpdate.json
  emitters/
    index.json
    00_Emitter_xxxxxxxx/
      emitter.json
      properties.json
      parameters.json
      rapid_iteration_parameters.json
      renderers.json
      event_generators.json
      event_handlers.json
      data_interfaces.json
      stages/
        index.json
        00_ParticleSpawnScript_default.json
      scripts/
        index.json
      validation/
        coverage_report.json
  scripts/
    index.json
  validation/
    checks.json
    compile_summary.json
    dependency_report.json
    runtime_preview.json
    coverage_report.json
```

## Emitter 输出结构

```text
NE_Spark/
  asset.json
  emitter.json
  properties.json
  parameters.json
  rapid_iteration_parameters.json
  renderers.json
  event_generators.json
  event_handlers.json
  data_interfaces.json
  stages/
    index.json
    00_ParticleSpawnScript_default.json
  scripts/
    index.json
  validation/
    checks.json
    dependency_report.json
    coverage_report.json
```

## Script 输出结构

```text
NMS_FillArray/
  asset.json
  script.json
  properties.json
  graph/
    nodes.json
    links.json
    custom_hlsl_nodes.json
  validation/
    coverage_report.json
```

## 覆盖原则

- `emitters/index.json` 的 `source.ownership` 区分 `standalone_asset` 与 `system_instance`：
  - `standalone_asset` 表示 `source.emitter_asset_path` 可作为外部模板资产加载；
  - `system_instance` 表示 Emitter 已是 System 内的 handle instance，`source_system_asset_path` 只记录所属 System。
- 常用结构以结构化字段导出，例如 User 参数、System Stage、Emitter Handle、Renderer、Event Handler、Event Generator、Stage、Module、Module Input、Graph Node、Graph Link。
- UObject / UStruct 字段同时进入 `raw_properties`，保留 `property_name`、`cpp_type`、`value_text`、`property_flags`、`can_apply_generic`。
- `raw_properties` 回写解析 `property_name` 时先做精确字段名 / authored name 匹配，再把 `bFoo` 与 `Foo` 作为布尔别名兜底，避免 `FixedBounds` 这类字段误写到 `bFixedBounds`。
- `raw_properties` 和 `custom_hlsl` 回写会记录解析/读回异常：缺少 `property_name`、缺少 `value_text`、属性不存在、`ImportText` 失败、写后读回不同都会进入 `warnings`。warning 消息会包含请求值、读回值、`cpp_type` 和底层错误；`strict=true` 时会使 apply 失败。
- 曲线类 `raw_properties` 会导出 `curve_json` / `value_json`，使用统一的 `ue_agent_interface.curve.v1`。回写时 `curve_json` 优先，`value_json` 仅作为兼容别名；未知字段、拼写相近字段、缺 key 值、重复时间或非法插值/外推模式都会进入 `warnings[]`，`strict=true` 时失败。
- Data Interface 曲线属性在 System folder apply 中会等 System overview / emitter graph 总刷新后再回写，避免写入旧 `UNiagaraNodeInput.DataInterface` 后被刷新覆盖。返回字段 `post_refresh_data_interfaces_applied` 表示这一步实际应用的 Data Interface 属性数量。
- Module Input 若连接到 Dynamic Input，导出时会在该 input 下写入 `dynamic_input` 子对象，包含 `script_asset_path`、`node_name`、嵌套 `inputs[]` 和 `data_interfaces[]`。回写时 apply 会先重建 Dynamic Input，再按 `dynamic_input.data_interfaces[].raw_properties[].curve_json` 写入曲线 Data Interface。因此 `FloatFromCurve`、`VectorFromCurve`、`ColorFromCurve` 等动态输入曲线必须在 folder JSON 中编辑，不再通过旧原子扩展参数制作。
- Stage / Module / Module Input JSON 现在接入统一字段诊断：未知字段会返回 `json_unknown_field`，类型不匹配会返回 `json_field_type_mismatch`，必填字段缺失会返回 `json_missing_required_field`，数组元素不是 object 会返回 `json_array_item_type_mismatch`。这些 warning 会带完整 JSON path，例如 `stages/00_ParticleSpawnScript_default.json.modules[0].inputs[3].override_default_value`；`strict=true` 时会使 apply 失败。
- User 参数回写按 `parameter_type -> type_path -> type_internal -> type` 解析，并支持 `NiagaraFloat` / `/Script/Niagara.NiagaraFloat` 等 UE 内部类型别名。
- System Stage 与 Emitter Stage apply 都会重建 stage 基础图、按导出顺序恢复 module stack、恢复 module enabled 状态和 input default 值；新建 System 时必须通过 `system_stages/SystemUpdate.json` 恢复 `SystemState`，否则 Stack 会报缺少必需模块。
- Stage module 顺序以 `module_index` 为准；apply 会按目标索引插入，export 会按 ParameterMap 链路回读执行顺序，避免节点坐标排序导致 `Collision` / `GenerateCollisionEvent` 等更新模块顺序漂移。
- Module input default 回写会区分 FunctionCall 可见输入 pin 与隐藏 stack override input：可见枚举/静态输入直接写入 FunctionCall pin，隐藏输入才创建 aliased override pin。
- Module input default 回写会按 Niagara 类型规范化 `override_default_value`：`Vector/Position` 写为 `(X=...,Y=...,Z=...)`，`LinearColor` 写为 `(R=...,G=...,B=...,A=...)`，`Vector2/Vector4/Quat` 写为对应结构字段；`NaN/Inf` 会作为 warning 记录并跳过该输入，避免 folder apply 后 UI 落成黑色或零向量。
- Module input default 回写后会校验 `OverridePin.DefaultValue`。若 UE 接受了写入但存储文本没有落成预期 import text，会产生 `module_input_default_apply_verification_failed` warning；`strict=true` 时该 warning 会让 apply 失败。
- Module input 若 `has_override=true` 但缺少或写错 `override_default_value`，会返回 `module_input_missing_override_default_value`；若 input 当前不在 Niagara Stack 的可见有效分支，会返回 `module_input_hidden_or_inactive_branch`，提示先设置控制该分支的 mode/static switch 后重新导出再写分支值。
- 枚举型 Module Input 导出会附带 `enum_type`、`enum_value_name`、`enum_value_display_name`、`enum_value_int`、`enum_options[]`，避免只看到 `NewEnumerator3` 这类内部名而误判 UI 当前显示值。
- Event Handler apply 会按 `script_usage_id` / `source_event_name` 匹配或创建 handler，并初始化可编译的基础 output stage。
- Stage apply 会把 `SetVariables` / `UNiagaraNodeAssignment` 模块重建为目标 Emitter 本地 assignment 节点；不要把 System 内嵌 emitter 导出的私有 inline NiagaraScript 路径直接复用到 standalone Emitter，否则会形成跨 package 私有对象引用并导致保存失败。
- Custom HLSL 会从 `UNiagaraNodeCustomHlsl` 的 reflected `CustomHlsl` 字段导出/回写。
- 外部资产只记录引用，不复制 Material、Mesh、Data Channel、Parameter Collection 等外部内容。

## Dynamic Input 曲线 JSON

Dynamic Input 是 Module Input 的子结构。导出后应在 stage 文件的 `modules[].inputs[]` 里编辑，不再使用原子命令补写。

最小结构如下：

```json
{
  "input_name": "Module.Scale Alpha",
  "has_override": true,
  "has_links": true,
  "link_kind": "dynamic_input",
  "dynamic_input": {
    "node_name": "FloatFromCurve001",
    "script_asset_path": "/Niagara/DynamicInputs/FloatFromCurve.FloatFromCurve",
    "data_interfaces": [
      {
        "input_name": "FloatFromCurve001.FloatCurve",
        "data_interface_class": "/Script/Niagara.NiagaraDataInterfaceCurve",
        "raw_properties": [
          {
            "property_name": "Curve",
            "curve_json": {
              "schema": "ue_agent_interface.curve.v1",
              "curve_kind": "float",
              "storage": "rich_curve_property",
              "channels": {
                "value": {
                  "keys": [
                    { "time": 0.0, "value": 1.0, "interp_mode": "Linear" },
                    { "time": 1.0, "value": 0.0, "interp_mode": "Linear" }
                  ]
                }
              }
            }
          }
        ]
      }
    ]
  }
}
```

验收要求：

- apply 返回不得有 `dynamic_input_*`、`curve_json_*`、`json_unknown_field`、`json_field_type_mismatch` 相关 warning；`strict=true` 时这些 warning 会导致失败。
- apply 后必须再 `niagara_export_folder`，确认同一 input 仍有 `link_kind=dynamic_input`，且 `dynamic_input.data_interfaces[].raw_properties[].curve_json` 读回了目标曲线。
- 不要只看顶层 `data_interfaces.json`；Dynamic Input 的曲线归属应优先从该 input 的 `dynamic_input.data_interfaces[]` 检查。

## 覆盖矩阵

| 领域 | Export | Apply | 当前状态 |
|---|---|---|---|
| `UNiagaraSystem` asset metadata | structured | structured | 已实现 |
| `UNiagaraSystem` UObject properties | `raw_properties` | generic property import | 已实现，受 UE `ImportText` 支持范围约束 |
| System Spawn / System Update | `system_stages/*.json` 的 stage/module/module input 结构化导出与回写 | structured/raw | 已实现 |
| User parameters | structured | structured | 已实现 |
| Emitter handles | structured | structured | 已实现 handle 合并/新增、启用、顺序；GUID 由 UE 重新分配 |
| System 内嵌 Emitter instance | structured | template handle fallback + folder data | 已实现 |
| `UNiagaraEmitter` version data | `raw_properties` | generic struct import | 已实现 |
| standalone `UNiagaraEmitter` root profile | structured folder | structured folder | 已实现 |
| Emitter graph parameters | structured | structured | 已实现 |
| Rapid iteration parameters | structured/raw | structured/raw | 已实现 |
| Renderers | structured + raw properties | structured + raw properties | 已实现，缺失 renderer 可按 class 尝试创建 |
| Event handlers | structured + raw properties | structured + raw properties | 已实现，缺失 handler 可创建 |
| Event generators | structured + raw properties | structured + raw properties | 已实现 |
| Stages / Simulation Stages | structured graph snapshot | structured graph rebuild | 已实现 |
| Modules / Module Inputs | structured | structured | 已实现 module stack、enabled、input default、dynamic input 与 dynamic input DataInterface 曲线回写 |
| Data interfaces | structured + raw properties + `curve_json` | post-refresh structured/raw apply | 已实现引用、reflected 字段和曲线 DataInterface 保真 |
| standalone `UNiagaraScript` root profile | structured folder | structured folder | 已实现 |
| Custom Niagara Script / Scratch Pad / Custom HLSL | reference + raw properties + node snapshot | structured/raw | 已实现 |
| External assets | reference | reference | 引用保留，不复制外部资产 |

## `niagara_export_folder`

参数：

| 参数 | 类型 | 默认值 | 说明 |
|---|---:|---:|---|
| `asset_path` | string | 必填 | Niagara System 资产路径，例如 `/Game/FX/NS_Fireball` |
| `folder_path` | string | 自动推导 | 自定义导出目录；未提供时使用 `Saved/UeAssetFolders/NiagaraSystem/Game/...` |
| `clean_output_dir` | bool | `true` | 导出前清理目标目录 |

示例：

```json
{
  "request_id": "niagara-folder-export-001",
  "command": "niagara_export_folder",
  "params": {
    "asset_path": "/Game/FX/NS_Fireball",
    "clean_output_dir": true
  }
}
```

## `niagara_apply_folder`

参数：

| 参数 | 类型 | 默认值 | 说明 |
|---|---:|---:|---|
| `asset_path` | string | `asset.json` 中的路径 | 回写目标 System；可覆盖导出文件里的原始路径 |
| `folder_path` | string | 自动推导 | 文件夹路径；未提供时按 `asset_path` 推导 |
| `create_if_missing` | bool | `true` | 目标 System 不存在时创建 |
| `apply_referenced_emitters` | bool | `true` | 同步回写导出目录中引用的 Emitter 文件夹 |
| `compile_after_apply` | bool | `false` | 回写后触发 Niagara 编译 |
| `wait_for_complete` | bool | `true` | 编译时等待完成 |
| `save_after_apply` | bool | `false` | 回写后保存资产 |
| `collect_stack_issues_after_apply` | bool | `true` | apply 后自动读取 Stack 红/黄/信息提示并随返回附带 |
| `stack_issue_severity_filter` | string | `warning_or_error` | Stack issue 返回过滤：`all/error/warning/warning_or_error/info/none` |
| `prefer_existing_stack_view_model` | bool | `true` | 优先复用已打开 Niagara 编辑器的 live ViewModel |
| `open_editor_for_stack_issues` | bool | `true` | apply 后默认打开/复用 Niagara 编辑器 ViewModel 读取，确保与 UI 红色感叹号 tooltip 同源；自动化场景可显式传 `false` |
| `compile_before_stack_issue_read` | bool | `true` | 读取 Stack issue 前先编译，避免返回旧状态；需要只读当前缓存时可显式传 `false` |
| `fail_on_stack_errors` | bool | 跟随 `strict` | Stack error 非空时让 apply 失败 |
| `strict` | bool | `false` | 如果运行时 warnings 非空则失败；默认也会因 Stack error 失败 |

返回：

- 常规 apply 字段：`system_properties_applied`、`user_parameters_applied`、`system_stages_applied`、`emitter_handles_applied`、`emitter_properties_applied`、`post_refresh_data_interfaces_applied`、`system_refresh`、`warnings`、`warning_count`。
- Stack 诊断字段：`stack_issue_report`、`stack_issues`、`stack_scopes`、`stack_total_issue_count`、`stack_error_count`、`stack_warning_count`、`stack_info_count`、`has_stack_errors`、`stack_issue_view_model_source`。
- 当 `strict=true` 且 Stack error 非空时，命令失败返回 `strict_apply_has_stack_errors`，同时返回具体 `stack_issues[] / stack_scopes[]`。

示例：

```json
{
  "request_id": "niagara-folder-apply-001",
  "command": "niagara_apply_folder",
  "params": {
    "folder_path": "D:/program/UE/GptProjectTest/Saved/UeAssetFolders/NiagaraSystem/Game/FX/NS_Fireball",
    "asset_path": "/Game/FX/NS_Fireball_Rebuilt",
    "create_if_missing": true,
    "compile_after_apply": true,
    "save_after_apply": false
  }
}
```

## `niagara_emitter_export_folder`

参数：

| 参数 | 类型 | 默认值 | 说明 |
|---|---:|---:|---|
| `emitter_asset_path` | string | 必填 | Niagara Emitter 资产路径，例如 `/Game/FX/NE_Spark`；也兼容 `asset_path` |
| `folder_path` | string | 自动推导 | 自定义导出目录；未提供时使用 `Saved/UeAssetFolders/NiagaraEmitter/Game/...` |
| `clean_output_dir` | bool | `true` | 导出前清理目标目录 |

返回：

- `asset_path`
- `emitter_asset_path`
- `folder_path`
- `file_count`
- `script_reference_count`
- `warning_count`
- `warnings`

## `niagara_emitter_apply_folder`

参数：

| 参数 | 类型 | 默认值 | 说明 |
|---|---:|---:|---|
| `emitter_asset_path` | string | `asset.json` 中的路径 | 回写目标 Emitter；也兼容 `asset_path` |
| `folder_path` | string | 自动推导 | 文件夹路径；未提供时按 `emitter_asset_path` 推导 |
| `create_if_missing` | bool | `true` | 目标 Emitter 不存在时创建 |
| `add_default_modules_and_renderers` | bool | `true` | 创建缺失 Emitter 时是否初始化默认模块/Renderer |
| `save_after_apply` | bool | `false` | 回写后保存资产 |
| `collect_stack_issues_after_apply` | bool | `true` | apply 后自动读取 standalone Emitter Stack issue |
| `stack_issue_severity_filter` | string | `warning_or_error` | Stack issue 返回过滤 |
| `prefer_existing_stack_view_model` | bool | `true` | 优先复用 live ViewModel |
| `open_editor_for_stack_issues` | bool | `true` | apply 后默认打开/复用 Niagara 编辑器 ViewModel 读取；自动化场景可显式传 `false` |
| `compile_before_stack_issue_read` | bool | `true` | 读取 Stack issue 前先编译，避免返回旧状态 |
| `fail_on_stack_errors` | bool | 跟随 `strict` | Stack error 非空时让 apply 失败 |
| `strict` | bool | `false` | 如果运行时 warnings 非空则失败；默认也会因 Stack error 失败 |

说明：

- `asset.json` 是 standalone emitter 导出目录的标准入口文件。
- 当 `folder_path` 指向 `niagara_export_folder` 导出的 System 内嵌 emitter 子目录时，该子目录可能没有 `asset.json`；此时只要请求显式提供 `emitter_asset_path`，`niagara_emitter_apply_folder` 会把该子目录内容回写到指定 standalone Emitter。
- 若既没有 `asset.json`，也没有显式 `emitter_asset_path` / `asset_path`，命令会失败并返回 `missing_emitter_asset_path_and_asset_json`。
- 从 System 内嵌 emitter 子目录回写到 standalone Emitter 时，assignment 模块会被重建为目标资产自己的本地节点，并保留模块启用状态和 input default；这能避免 standalone Emitter 保存时引用 `/Game/...NS_System:EmbeddedEmitter...` 私有对象。
- 当来源文件夹包含完整 `stages/index.json` 时，apply 会把目标 Emitter 的动态 stage 集合同步到来源：来源不存在的 Event Handler / Simulation Stage 会被裁掉，防止旧 event stage、旧 module stack 或旧速度模块残留。
- 当来源文件夹包含 `event_generators.json` 时，apply 会先清空目标 Emitter 四类脚本上的 Event Generator 数组，再按 JSON 重建；空数组会清除旧 DeathEvent/CollisionEvent generator，避免同一数据集被旧 generator 和新 module 重复写入。
- 对 UE 内置 `CollisionEvent` / `DeathEvent` generator，apply 只会在同一 owner stage 里存在对应 `GenerateCollisionEvent` / `GenerateDeathEvent` module 时重建；若导出文件夹残留 orphan generator，会返回 `event_generator_skipped_missing_stage_module` warning，提示先修正 stage/module 结构。
- 返回值包含 `stack_issue_report`、`stack_issues`、`stack_scopes`、`stack_error_count` 等字段；这与单独调用 `niagara_get_stack_issues` 的数据结构一致。

示例：

```json
{
  "request_id": "niagara-emitter-folder-apply-001",
  "command": "niagara_emitter_apply_folder",
  "params": {
    "folder_path": "D:/program/UE/GptProjectTest/Saved/UeAssetFolders/NiagaraEmitter/Game/FX/NE_Spark",
    "emitter_asset_path": "/Game/FX/NE_Spark_Rebuilt",
    "create_if_missing": true,
    "save_after_apply": false
  }
}
```

## `niagara_script_export_folder`

参数：

| 参数 | 类型 | 默认值 | 说明 |
|---|---:|---:|---|
| `script_asset_path` | string | 必填 | Niagara Script 资产路径；也兼容 `asset_path` |
| `folder_path` | string | 自动推导 | 自定义导出目录；未提供时使用 `Saved/UeAssetFolders/NiagaraScript/Game/...` |
| `clean_output_dir` | bool | `true` | 导出前清理目标目录 |

返回：

- `asset_path`
- `script_asset_path`
- `folder_path`
- `file_count`
- `node_count`
- `link_count`
- `warning_count`
- `warnings`

## `niagara_script_apply_folder`

参数：

| 参数 | 类型 | 默认值 | 说明 |
|---|---:|---:|---|
| `script_asset_path` | string | `asset.json` 中的路径 | 回写目标 Script；也兼容 `asset_path` |
| `folder_path` | string | 自动推导 | 文件夹路径；未提供时按 `script_asset_path` 推导 |
| `create_if_missing` | bool | `true` | 目标 Script 不存在时创建 |
| `compile_after_apply` | bool | `false` | 回写后请求脚本编译 |
| `save_after_apply` | bool | `false` | 回写后保存资产 |
| `strict` | bool | `false` | 如果运行时 warnings 非空则失败 |

示例：

```json
{
  "request_id": "niagara-script-folder-apply-001",
  "command": "niagara_script_apply_folder",
  "params": {
    "folder_path": "D:/program/UE/GptProjectTest/Saved/UeAssetFolders/NiagaraScript/Game/FX/NMS_FillFloatArray",
    "script_asset_path": "/Game/FX/NMS_FillFloatArray_Rebuilt",
    "create_if_missing": true,
    "compile_after_apply": true,
    "save_after_apply": false
  }
}
```

## `validation/coverage_report.json`

所有 folder export/apply 都会写入覆盖报告。关键字段：

| 字段 | 含义 |
|---|---|
| `schema` | 当前文件夹 schema 名称 |
| `implementation_status` | 当前实现状态；完成 profile 为 `complete_folder_profile` |
| `is_complete_target_schema` | 是否覆盖当前目标 schema；完成 profile 为 `true` |
| `is_lossless_roundtrip` | 本次操作是否无运行时 warning；`warnings` 为空时为 `true` |
| `implemented_profiles` | 已实现根 profile：`niagara_system`、`niagara_emitter`、`niagara_script` |
| `pending_profiles` | 完成 profile 下为空数组 |
| `blocking_gaps` | 完成 profile 下为空数组 |
| `coverage_areas` | 各 Niagara 子领域的 export/apply 支持状态 |
| `warnings` | 本次导出或回写遇到的实际资产/字段/引用警告 |

严格验收时设置 `strict=true`。只要存在运行时 warning，命令会失败并返回 `strict_apply_has_warnings`；System / Emitter apply 若读取到 Stack error，会失败返回 `strict_apply_has_stack_errors`，并在返回体中保留具体 `stack_issues[] / stack_scopes[]`。

## 验证建议

1. 创建最小骨架。
2. `niagara_export_folder` / `niagara_emitter_export_folder` / `niagara_script_export_folder`
3. 写入基础 module / renderer / event 结构。
4. 调用对应 `*_apply_folder`。
5. 再导出一次，使用 UE 补全后的完整 JSON 修改参数。
6. 再次 apply，并检查 apply 返回中的 `warnings` 和 `stack_issues`。
7. 对 System 调用 `niagara_get_compile_log`，使用 `severity_filter="warning_or_error"`。

验收口径：

- `implementation_status=complete_folder_profile`
- `is_complete_target_schema=true`
- `pending_profiles=[]`
- `blocking_gaps=[]`
- `is_lossless_roundtrip=true`
- 自动化 smoke `GptProjectTest.UeAgentInterface.Smoke.NiagaraFolderWorkflow` 通过
