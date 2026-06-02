# 指令详解：Niagara Stage / Graph / Node / ModuleInput

> 废弃写入命令已迁移到 `deprecatedCommand/09_Niagara_StageGraph.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

## Stage 管理

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_list_stages` | 列出 Emitter 所有 Stage | `emitter_asset_path`、`include_modules`、`include_module_inputs` | 先拿 `stage_key` 和 `script_usage_id` |

## Stage 模块管理

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_list_stage_modules` | 列出 Stage 模块 | `emitter_asset_path` + Stage 标识 + `include_inputs` | 读取 `module_node_guid` |

## Stage 节点管理

> Stage、Stage node 和 Module Input 的属性回写应通过 folder JSON 表达，并返回通用属性观测字段：`requested_value_text`、`applied_value_text`、`property_value_read_back`、`property_import_status`、`property_import_error`、`value_text_changed_after_import`、`cpp_type`。属性不存在会返回 `property_not_found`，UE `ImportText` 解析失败会返回 `property_import_failed:<property>:<value>`。

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_list_stage_nodes` | 列出 Stage 全部节点 | `emitter_asset_path` + Stage 标识 + `include_properties` | 查节点 GUID 与类型 |
| `niagara_emitter_get_stage_node_property` | 读取节点属性 | `emitter_asset_path` + Stage 标识 + `node_guid` + `property_name` | 检查节点参数 |

## 模块输入管理

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_list_module_inputs` | 列出模块输入（含隐藏输入） | `emitter_asset_path`、`module_node_guid` | 查询可写输入名 |

> 废弃写入命令已迁移到 `deprecatedCommand/09_Niagara_StageGraph.md` 的对应章节。Dynamic Input 与曲线写入已并入 `15_Niagara_FolderFormat.md` 的 folder JSON 主流程。
## 防崩与限制（必须了解）

- Stage module 删除默认应表现为软删除（禁用模块），避免直接破坏 Stack 图。
- 模块节点删除走软删除，非模块节点才物理删除。
- 对 `ParticleEventScript` 的危险加模块场景有保护拦截。
- Static Switch 输入不支持参数链接，需改默认值方式。Dynamic Input / `curve_json` 应改用 folder JSON 的 `inputs[].dynamic_input.data_interfaces[].raw_properties[].curve_json`。

## 推荐执行顺序

1. `niagara_emitter_export_folder`
2. 写基础 Stage / Module / Node / ModuleInput JSON
3. `niagara_emitter_apply_folder`
4. 再导出一次，基于 UE 补全后的完整属性面修改参数
5. 再次 apply，并检查返回的 `stack_issues` / `stack_error_count`
6. 对包含该 emitter 的 System 做 compile log 和 runtime probe

## 最小请求示例

```json
{
  "request_id": "nsg-001",
  "command": "niagara_emitter_apply_folder",
  "params": {
    "emitter_asset_path": "/Game/AutoTests/Niagara/NE_Leader",
    "folder_path": "Saved/UeAssetFolders/NiagaraEmitter/Game/AutoTests/Niagara/NE_Leader",
    "strict": true
  }
}
```

<!-- UAI_FORMAL_COMMAND_INDEX_BEGIN -->

## 补充命令正式索引
>
> 以下命令仍属于本正式分册；已废弃写入命令不在正式分册列出，仅保留在 `deprecatedCommand/09_Niagara_StageGraph.md`。

| Command | 作用 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `niagara_emitter_move_stage_module` | **原子/兼容**：编辑 Niagara Stage Graph/Module Input 的节点、连线、排序或输入 | `asset_path`、`emitter_name`、`module_name`、`input_name`、`value_text` | `success`、`warnings`、`errors` |
| `niagara_list_module_library` | **原子/兼容**：编辑 Niagara Stage Graph/Module Input 的节点、连线、排序或输入 | `asset_path`、`emitter_name`、`module_name`、`input_name`、`value_text` | `success`、`warnings`、`errors` |
| `niagara_system_list_module_inputs` | **原子/兼容**：编辑 Niagara Stage Graph/Module Input 的节点、连线、排序或输入 | `asset_path`、`emitter_name`、`module_name`、`input_name`、`value_text` | `success`、`warnings`、`errors` |
| `niagara_system_list_stage_modules` | **原子/兼容**：编辑 Niagara Stage Graph/Module Input 的节点、连线、排序或输入 | `asset_path`、`emitter_name`、`module_name`、`input_name`、`value_text` | `success`、`warnings`、`errors` |
| `niagara_system_set_module_input` | **原子/兼容**：编辑 Niagara Stage Graph/Module Input 的节点、连线、排序或输入 | `asset_path`、`emitter_name`、`module_name`、`input_name`、`value_text` | `success`、`warnings`、`errors` |

<!-- UAI_FORMAL_COMMAND_INDEX_END -->

## 废弃命令

本分册不再列出已废弃写入命令；这些命令仅保留在 `deprecatedCommand/09_Niagara_StageGraph.md`，供旧脚本兼容、bootstrap、迁移和故障补修查阅。
