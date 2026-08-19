# 废弃指令：Niagara（Emitter / Renderer / Event / Parameter）

> 本文件从 `../08_Niagara_Emitter.md` 抽出，保留原分册章节结构。主分册只保留 JSON / 结构化 HJSON 主流程、读取、导出/应用、编译和诊断命令。

## Emitter 属性

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_set_property` | **Deprecated for authoring**：设置 Emitter 版本属性 | `emitter_asset_path`（或 `asset_path`）、`property_name`、`value_text` | 仅用于局部修补 |
| `niagara_emitter_clear_parent` | **Deprecated for authoring**：清除 Emitter parent/merge 残留 | `emitter_asset_path`（或 `asset_path`）、`clear_merge_message` | 仅用于修复父 emitter merge error 或隐藏 parent 残留 |

`niagara_emitter_clear_parent` 默认 `compile_after_apply=true`。命令会在保存前读取 Niagara compile log；如果 owning system 编译等待后仍未完成，返回 `compile_incomplete_after_apply`；如果 `compile_log.has_error=true`，返回 `compile_failed_after_apply`，响应保留 `saved=false` 并且不执行最终保存。该命令仍只用于旧脚本兼容或故障修复，常规 authoring 应编辑 Niagara folder JSON 后调用 `niagara_emitter_apply_folder` / `niagara_apply_folder`。

## Renderer 管理

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_add_renderer` | **Deprecated for authoring**：添加渲染器 | `emitter_asset_path`、`renderer_class` 或 `renderer_type` | 仅用于 bootstrap/修补 |
| `niagara_emitter_remove_renderer` | **Deprecated for authoring**：删除渲染器 | `emitter_asset_path` + (`renderer_index`/`renderer_name`/`renderer_class`) | 仅用于修补 |
| `niagara_emitter_set_renderer_property` | **Deprecated for authoring**：设置渲染器属性 | `emitter_asset_path` + renderer 标识 + `property_name` + `value_text` | 仅用于局部修补 |

## Event Handler 管理

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_add_event_handler` | **Deprecated for authoring**：新增事件处理器 | `emitter_asset_path`、`source_emitter_id`、`source_event_name`、`execution_mode` | 仅用于修补 |
| `niagara_emitter_remove_event_handler` | **Deprecated for authoring**：删除事件处理器 | `emitter_asset_path` + (`event_index`/`script_usage_id`/`source_event_name`) | 仅用于修补 |
| `niagara_emitter_set_event_handler_property` | **Deprecated for authoring**：设置事件处理器属性 | `emitter_asset_path` + 事件标识 + `property_name` + `value_text` | 仅用于局部修补 |

## Emitter 参数 CRUD

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_parameter_add` | **Deprecated for authoring**：新增 Emitter 参数 | `emitter_asset_path`、`parameter_name`、`parameter_type`、`default_value_text`、`is_static_switch` | 仅用于修补 |
| `niagara_emitter_parameter_remove` | **Deprecated for authoring**：删除 Emitter 参数 | `emitter_asset_path`、`parameter_name` | 仅用于修补 |
| `niagara_emitter_parameter_set` | **Deprecated for authoring**：设置/重命名/改类型 | `emitter_asset_path`、`parameter_name`、`value_text` 或 `new_parameter_name` 或 `parameter_type` | 仅用于局部修补 |
