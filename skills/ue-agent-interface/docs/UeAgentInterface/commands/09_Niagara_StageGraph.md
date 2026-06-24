# 指令详解：Niagara Stage / Graph / Node / ModuleInput

> 废弃写入命令已迁移到 `deprecatedCommand/09_Niagara_StageGraph.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

## 模块与节点发现路径（禁止猜测）

Niagara authoring 前必须先用当前 UE 会话查询真实模块、节点和 input，不得凭记忆、UI 显示名、旧教程或猜测拼 `script_asset_path` / `module_name`。Niagara UI 菜单里看到的名称只是显示层；结构化 JSON 和 Stack 写入需要真实资产路径、stage 标识、节点 GUID 和当前分支下的 input。

### 1. 查询可用 Module / Dynamic Input / Graph Function 候选

新 authoring 主入口使用 `node_catalog_search`。它返回 UE Niagara 菜单同源候选，并提供 `kind/name/full_name/json_authoring/write_support/support_reason`；直接 JSON 编辑时优先复制 `json_authoring` 或 `json_authoring.seed`。

```json
{
  "catalog_type": "niagara_module",
  "query": { "text": "Velocity" },
  "filters": { "library_only": true, "source": ["niagara", "game", "plugins"] },
  "page": { "limit": 100 }
}
```

常用 `catalog_type`：

| `catalog_type` | 用途 | JSON authoring 关系 |
| --- | --- | --- |
| `niagara_module` | Stack module 候选 | seed 当前用于匹配已有导出 module；目标 stage 缺 module 时返回 `selector_not_found`。 |
| `niagara_dynamic_input` | Module input 右侧下拉中的 Dynamic Input / Make / Function 候选 | seed 可直接放到某个 module input 的 `value`。 |
| `niagara_graph_node` | Niagara Script graph function call 候选 | 返回 `kind=niagara_graph_function`，写入以 `niagara_script_export_folder/apply_folder` 的 graph JSON 为准。 |

关键返回字段：

| 字段 | 用法 |
| --- | --- |
| `kind/name/full_name` | 新 JSON 主身份；`name` 供阅读，稳定写入和来源解析依赖 `full_name`。 |
| `json_authoring` | 可放入 `profile_path` 的最小 authoring seed；也可只复制 `seed`。 |
| `write_support/support_reason` | 判断当前候选能否用于目标写入。 |
| `category_path/source_origin/source_label` | 菜单分类和来源，用于筛选和理解。 |

### 1.1 查询 Dynamic Input / Function 候选

Niagara input 右侧下拉里的 `Dynamic Inputs`、`Make`、函数类候选不是 Stack module。使用 `catalog_type=niagara_dynamic_input`：

```json
{
  "catalog_type": "niagara_dynamic_input",
  "query": { "text": "Random Range" },
  "filters": { "library_only": true },
  "page": { "limit": 100 }
}
```

写 `value.source="dynamic_input"` 或 `value.source="make"` 时，使用返回的 `json_authoring` 或 `seed.dynamic_input.kind/name/full_name`，不能只写 UI 名称。adapter 会把 `full_name` 映射到当前 folder apply 需要的 legacy script path。

需要理解某个 script 的资产或源码位置时，先用同一组 `kind/name/full_name` 调 `node_origin_resolve`。需要查看 graph 结构时，再使用 `niagara_script_export_folder` 把该 `UNiagaraScript` 导出到临时 folder，只读查看 `script.json`、`graph/nodes.json`、`graph/links.json` 和 `graph/custom_hlsl_nodes.json`。不要编辑或保存引擎插件内置 script 资产本身。

### 2. 查询当前 Stack 的 Stage 与 Module

Standalone Emitter：

```json
{
  "command": "niagara_emitter_list_stages",
  "params": {
    "emitter_asset_path": "/Game/FX/NE_Example",
    "include_modules": true,
    "include_module_inputs": true
  }
}
```

返回的 `stage_key`、`script_usage`、`script_usage_id` 是后续查 module、node、input 的依据。对指定 stage 继续查询：

```json
{
  "command": "niagara_emitter_list_stage_modules",
  "params": {
    "emitter_asset_path": "/Game/FX/NE_Example",
    "stage_key": "ParticleUpdateScript",
    "include_inputs": true
  }
}
```

System stage 使用：

```json
{
  "command": "niagara_system_list_stage_modules",
  "params": {
    "asset_path": "/Game/FX/NS_Example",
    "stage_key": "SystemUpdateScript",
    "include_inputs": true
  }
}
```

对 System 内嵌 emitter 的完整 authoring，优先走 `niagara_export_folder` 导出 `emitters/*/stages/*.json`，不要把 standalone emitter 的 stage/node 结果直接套到 system instance。

### 3. 查询节点、节点属性和 Module Input

需要确认节点 GUID、节点类型或节点属性时：

```json
{
  "command": "niagara_emitter_list_stage_nodes",
  "params": {
    "emitter_asset_path": "/Game/FX/NE_Example",
    "stage_key": "ParticleUpdateScript",
    "include_properties": true
  }
}
```

需要检查某个节点属性时：

```json
{
  "command": "niagara_emitter_get_stage_node_property",
  "params": {
    "emitter_asset_path": "/Game/FX/NE_Example",
    "stage_key": "ParticleUpdateScript",
    "node_guid": "<node_guid_from_list_stage_nodes>",
    "property_name": "FunctionScript"
  }
}
```

需要列出某个 module 当前有效 input，包括隐藏 input 时：

```json
{
  "command": "niagara_emitter_list_module_inputs",
  "params": {
    "emitter_asset_path": "/Game/FX/NE_Example",
    "module_node_guid": "<module_node_guid>"
  }
}
```

System stage module input 使用 `niagara_system_list_module_inputs`，参数同样以 system `asset_path` 和 `module_node_guid` 为核心。

### 4. 理解模块含义的证据链

LLM 需要理解模块含义时按以下顺序取证：

1. `node_catalog_search`：确认真实 `kind/name/full_name/json_authoring/write_support/support_reason`。
2. `node_origin_resolve`：用同一组 `kind/name/full_name` 解析资产/package/source 路径。
3. 对 Dynamic Input / Function，必要时用 `niagara_script_export_folder` 只读查看 script 图结构。
4. 目标资产 `*_export_folder`：查看 UE 已生成的 stage/module/input 结构、当前分支和 renderer 绑定。
5. `niagara_emitter_list_module_inputs` 或 `niagara_system_list_module_inputs`：读取当前 module 的真实 input 名、类型、默认值、隐藏状态和链接状态。
6. apply 后重新 export：确认 UE 是否补全、重命名、规范化或切换了 active branch。
7. `stack_issue_report` / `compile_log` / runtime probe / screenshot：验证语义效果，而不是只看 JSON 字段存在。

禁止流程：

- 不得把 UI 显示名当作 `script_asset_path`。
- 不得只凭 `name` 写 module 或 dynamic input；必须保留 `full_name`。
- 不得在不知道 `supported_usages[]` 的情况下把模块塞入任意 stage。
- 不得把旧资产导出的私有 inline script path 复用到新 standalone emitter。
- 不得只靠模块名推断 input 字段；必须通过导出或 list input 读取。

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
| `niagara_emitter_move_stage_module` | **原子/兼容**：移动 standalone Emitter 的 stage module；新 authoring 优先用 folder JSON | `emitter_asset_path`、`stage_key` / `script_usage`、`module_node_guid`、`target_index` | `stage_key`、`module_node_guid`、`saved` |
| `niagara_list_module_library` | **兼容/底层只读**：查询当前 UE 会话可用 Niagara script 库；新 JSON authoring 优先使用 `node_catalog_search` | `root_path`、`search` / `name_contains`、`category`、`include_non_module_scripts`、`limit` | `items[].asset_path`、`items[].supported_usages`、`items[].is_module_script` |
| `niagara_system_list_module_inputs` | 读取 System stage module 的真实 input | `asset_path`、`module_node_guid` | `inputs`、`module_node_guid` |
| `niagara_system_list_stage_modules` | 读取 System stage 的 module 列表 | `asset_path`、`stage_key` / `script_usage`、`include_inputs` | `modules`、`stage_key`、`script_usage_id` |
| `niagara_system_set_module_input` | **原子/兼容**：设置 System stage module input；新 authoring 优先用 folder JSON | `asset_path`、`module_node_guid` 或 module selector、`input_name`、`value_text` | `requested_value_text`、`applied_value_text`、`property_import_status` |

<!-- UAI_FORMAL_COMMAND_INDEX_END -->

## 废弃命令

本分册不再列出已废弃写入命令；这些命令仅保留在 `deprecatedCommand/09_Niagara_StageGraph.md`，供旧脚本兼容、bootstrap、迁移和故障补修查阅。
