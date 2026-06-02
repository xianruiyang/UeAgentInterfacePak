# 指令详解：Niagara（Emitter / Renderer / Event / Parameter）

> 废弃写入命令已迁移到 `deprecatedCommand/08_Niagara_Emitter.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

## Emitter 属性

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_export_folder` | 导出 standalone Emitter 文件夹式 JSON | `emitter_asset_path`、`folder_path`、`clean_output_dir` | 生成可 diff 的 Emitter 结构化文件夹 |
| `niagara_emitter_apply_folder` | 从文件夹式 JSON 回写 standalone Emitter | `emitter_asset_path`、`folder_path`、`create_if_missing`、`strict` | 同步 Emitter version data、Renderer、Event Handler、Simulation Stage、Module Stack |
| `niagara_emitter_get_property` | 读取 Emitter 版本属性 | `emitter_asset_path`（或 `asset_path`）、`property_name`、`emitter_version` | 查询 `bRequiresPersistentIDs` 等开关 |
| `niagara_get_stack_issues` | 读取 standalone Emitter Stack 红/黄/信息提示 | `asset_path`、`severity_filter`、`open_editor_if_needed` | 定位 Emitter 栈面板感叹号内容 |

> `niagara_emitter_apply_folder` 可直接应用 `niagara_export_folder` 导出的 System 内嵌 emitter 子目录；这类子目录没有 `asset.json` 时，必须显式传入目标 `emitter_asset_path`。

> 从 System 内嵌 emitter 子目录回写到 standalone Emitter 时，`SetVariables` / assignment 模块会重建为目标 Emitter 本地节点，不会复用内嵌 emitter 的私有 inline script 路径。

> 当来源文件夹包含完整 `stages/index.json` 时，apply 会同步动态 stage 集合：目标里来源不存在的 Event Handler / Simulation Stage 会被移除，避免旧 event stage 和旧 module stack 残留。

> 当来源文件夹包含 `event_generators.json` 时，apply 会同步 Event Generator 数组；空数组会清空目标上的旧 generator，避免残留 DeathEvent/CollisionEvent 写入导致 Niagara 编译报错。UE 内置 `CollisionEvent` / `DeathEvent` generator 只有在同一 owner stage 仍存在对应 `GenerateCollisionEvent` / `GenerateDeathEvent` module 时才会重建；否则会返回 `event_generator_skipped_missing_stage_module` warning。

> 文件夹式 Emitter 已纳入完整 Niagara folder profile：支持 version data、graph 参数、rapid iteration 参数、Renderer、Event Generator、Event Handler、Simulation Stage、Module Stack、Module Input default、Data Interface 引用与 `raw_properties` 回写。完整说明见 `15_Niagara_FolderFormat.md`。

> `niagara_emitter_apply_folder` 默认返回 `stack_issue_report`、`stack_issues`、`stack_scopes`、`stack_error_count`、`stack_warning_count` 和 `stack_issue_view_model_source`。apply 后默认会先编译并打开/复用 Niagara 编辑器 ViewModel 读取感叹号内容；自动化场景可显式传 `open_editor_for_stack_issues=false` 或 `compile_before_stack_issue_read=false`。`strict=true` 时如 Stack error 非空，会失败返回 `strict_apply_has_stack_errors`，但仍带具体感叹号内容。

> Emitter 版本属性应通过 folder JSON 回写；针对会触发 UE 联动逻辑的属性，apply 会同步相关派生字段并返回 `side_effect_handled` 等诊断，避免属性回读和编译脚本状态错位。

> `niagara_get_stack_issues` 同时支持 System 与 standalone Emitter。读取 Emitter 时传 `asset_path` 为 Emitter 资产路径；如需尽量匹配 Niagara UI 中红色感叹号悬停文本，传 `prefer_existing_view_model=true` 和 `open_editor_if_needed=true`。返回的 `scopes[]` 会给出 `stack_issue_icon_kind`、`stack_issue_tooltip_summary`，并在 Emitter scope 上补充 `emitter_latest_compile_status`、`emitter_handle_error_text`、`emitter_handle_error_visibility`，用于区分 Stack issue 图标与 emitter 编译/状态提示。命令也会合并 Niagara `FNiagaraMessageStore` 中显示到 Stack 的资产消息；这类 issue 会在 `issues[]` 里标记 `issue_origin=message_store`，并包含 `message_key`、`message_topic`、`message_source_path`。

> 清除 parent / merge 残留的兼容入口已移入废弃分册；正式 authoring 中应通过 Emitter folder JSON 和 System refresh 读回验证 owning System 的 overview、execution order、cached traversal data 和 ViewModel。

> Emitter、Renderer 和 Event Handler 属性回写都会返回通用属性观测字段：`requested_value_text`、`applied_value_text`、`property_value_read_back`、`property_import_status`、`property_import_error`、`value_text_changed_after_import`、`cpp_type`。属性不存在会返回 `property_not_found`，UE `ImportText` 解析失败会返回 `property_import_failed:<property>:<value>`。
> Renderer 创建或重建阶段如果初始属性导入失败，apply 必须回滚半成品 renderer，并返回对应清理诊断。
## Renderer 管理

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_list_renderers` | 列出渲染器 | `emitter_asset_path`、`include_properties` | 查 renderer_index/name |
| `niagara_emitter_get_renderer_property` | 读取渲染器属性 | `emitter_asset_path` + renderer 标识 + `property_name` | 查看材质、宽度、排序设置 |

## Event Handler 管理

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_list_event_handlers` | 列出事件处理器 | `emitter_asset_path` | 查看当前事件绑定 |
| `niagara_emitter_get_event_handler_property` | 读取事件处理器属性 | `emitter_asset_path` + 事件标识 + `property_name` | 查看 SpawnNumber/SourceEmitterID |

> `SourceEmitterID` 支持纯 GUID 字符串和 UE Struct ImportText 两种写法。

## Emitter 参数 CRUD

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_parameter_list` | 列出 Emitter 参数 | `emitter_asset_path`、`namespace`、`include_default_values` | 查参数命名空间与默认值 |
| `niagara_emitter_parameter_get` | 读取单个 Emitter 参数 | `emitter_asset_path`、`parameter_name` | 回读验证 |

## 组合流程建议

1. `niagara_emitter_export_folder` 导出真实模板。
2. 在 JSON 中补基础 renderer / event / parameter / module 结构。
3. `niagara_emitter_apply_folder` 应用。
4. 再次导出，使用 UE 补全后的完整属性面改参数。
5. 再次 apply，并检查返回的 `warnings` 和 `stack_issues`。
6. 对包含该 emitter 的 System 读取 compile log / runtime probe。

## 最小请求示例

```json
{
  "request_id": "ne-001",
  "command": "niagara_emitter_apply_folder",
  "params": {
    "emitter_asset_path": "/Game/AutoTests/Niagara/NE_Follower",
    "folder_path": "Saved/UeAssetFolders/NiagaraEmitter/Game/AutoTests/Niagara/NE_Follower",
    "strict": true
  }
}
```

<!-- UAI_FORMAL_COMMAND_INDEX_BEGIN -->

## 补充命令正式索引
>
> 以下命令仍属于本正式分册；已废弃写入命令不在正式分册列出，仅保留在 `deprecatedCommand/08_Niagara_Emitter.md`。

| Command | 作用 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `niagara_emitter_move_renderer` | **原子/兼容**：编辑 Niagara System/Emitter 的 emitter、renderer、event handler、parameter 或属性 | `asset_path`、`emitter_name`、`module_name`、`input_name`、`value_text` | `success`、`warnings`、`errors` |

<!-- UAI_FORMAL_COMMAND_INDEX_END -->
