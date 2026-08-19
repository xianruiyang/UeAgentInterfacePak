# 指令详解：Niagara Stage / Graph / Node / ModuleInput

> 本分册是历史聚合索引，不进入 skill 日常路由。当前 Niagara folder 能力与 Catalog 契约以 `../../../hjson-authoring/recipes/Niagara.md`、`../../node_graph/node_catalog_search.md` 和对应 CommandSpec 为准。

## 紧凑返回契约

- 默认 `llm_compact` 的 `data` 只保留 LLM 决策需要的目标标识、关键状态、计数、摘要、warnings/errors 摘要和 artifact / 文件路径。
- 完整读回、大对象、长列表、编译日志、像素/帧/点数据、raw property metadata、诊断栈和内部中间状态默认不进入 `data`；需要时通过 `response_options` 的 debug/raw 视图、显式请求字段或外置 artifact 获取。
- 本分册中的旧局部参数、历史别名或原子入口只作为 alias / 兼容路径；新 authoring 应优先使用本分册推荐的 JSON、folder、统一 viewport、probe 或 domain 专用入口。


> 废弃写入命令已迁移到 `deprecatedCommand/09_Niagara_StageGraph.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 HJSON 覆盖的命令。

## 返回契约

- Python `uai_core` wrapper 统一返回 `CommandResult`：业务字段读取 `CommandResult.data`，调试字段读取 `CommandResult.debug`，完整原始 envelope 仅在排查时读取 `CommandResult.envelope`。
- 默认 compact data 只保留 stage/module/node/input 的稳定身份、关键定位字段、计数、摘要列表、结构化写入/readback 状态和 warnings 摘要。
- Stage / module / node / input 列表默认必须压缩：保留 `stage_key`、`script_usage`、`script_usage_id`、`module_node_guid`、`node_guid`、`input_name`、`type`、`full_name`、`supported_usages` 等 LLM 决策必需字段；完整 graph、节点属性、隐藏 input、raw property metadata 和长 readback 进入 debug/raw 或显式请求字段。
- `niagara_list_module_library` 是兼容查询；新流程使用 `node_catalog_search` 的 `items_tsv` 和 unique exact `candidate/seed/placement`。
- `niagara_emitter_get_stage_node_property` 等读取命令可在 debug/readback 返回文本证据；System/Emitter module input 的新 authoring 统一使用 `niagara_apply_folder` / `niagara_emitter_apply_folder` 的结构化 HJSON。旧细粒度文本 setter 只在 deprecated 分册保留。
- `niagara_emitter_move_stage_module` 是原子 / 兼容写入入口；默认 data 只保留移动目标、实际 `stage_key` / `module_node_guid`、`saved`、编译 / warning 摘要，完整图差异和诊断进入 debug/raw。
- `niagara_script_export_folder` 当前只确认 Script 资产 identity，不覆盖 Script graph topology；需要图编辑时必须使用已有正式 graph 命令或补齐统一领域语义。

## 模块与节点发现路径（禁止猜测）

Niagara authoring 前必须先用当前 UE 会话查询真实模块、节点和 input，不得凭记忆、UI 显示名、旧教程或猜测拼 `script_asset_path` / `module_name`。Niagara UI 菜单里看到的名称只是显示层；结构化 HJSON 和 Stack 写入需要真实资产路径、stage 标识、节点 GUID 和当前分支下的 input。

### 1. 查询可用 Module / Dynamic Input / Graph Function 候选

新 authoring 主入口使用 `node_catalog_search`。broad 查询只读取压缩 `items_tsv`；选定候选后做唯一 exact 查询，并在该 kind 有正式投影时读取独立的 `seed/placement`。不要复制历史 catalog envelope。

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
| `niagara_module` | Stack module 候选 | exact `seed` 只提供 script identity；stage、operation、module GUID/顺序和 inputs 另写。 |
| `niagara_dynamic_input` | Module input 右侧下拉中的 Dynamic Input / Make / Function 候选 | 必须放入已有 module input context，不能作为独立对象 Apply。 |
| `niagara_graph_node` | Niagara Script graph function call 候选 | 无 standalone projection；当前 folder Script profile 不覆盖 graph topology。 |

关键返回字段：

| 字段 | 用法 |
| --- | --- |
| `items_tsv` | broad 查询的紧凑候选列表，只用于选择候选。 |
| `candidate_resolution/candidate` | unique exact 的 canonical identity 和消歧结果。 |
| `seed` | 目标 ApplyInputContract 允许的最小片段。 |
| `placement` | 独立 workspace contract/unit/target 位置。 |

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

写 Dynamic Input 时，先用 exact 查询取得 script `seed`，再把它与目标 module input identity 合并；不能只写 UI 名称，也不能把 seed 当作可独立 Apply 的对象。

需要理解某个 script 的资产或源码位置时，用 exact `candidate` 或稳定 script path 调 `node_origin_resolve`。当前 `niagara_script_export_folder` 只确认资产 identity，不提供 graph topology；不要从历史多文件 graph 结构推断当前 folder 能力，也不要编辑或保存引擎插件内置 script 资产本身。

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

1. `node_catalog_search`：broad 选候选，unique exact 读取 `candidate`，并按能力读取 `seed/placement`。
2. `node_origin_resolve`：用同一组 `kind/name/full_name` 解析资产/package/source 路径。
3. 对 Dynamic Input / Function，用 exact catalog 查询选中候选的 `candidate`，并在存在正式投影时读取 `seed/placement`；`niagara_script_export_folder` 当前只能确认 Script 资产身份，不能查看 script 图结构。
4. 目标资产 `*_export_folder`：查看统一 workspace 中的 stage identity、module GUID/顺序和 Dynamic Input script。
5. `niagara_emitter_list_module_inputs` 或 `niagara_system_list_module_inputs`：读取当前 module 的真实 input 名、类型、默认值、隐藏状态和链接状态。
6. apply 后重新 export：确认 UE 是否补全或规范化 stage identity、module GUID/顺序和 script path。
7. `stack_issue_report` / `compile_log` / runtime probe / screenshot：验证语义效果，而不是只看 JSON 字段存在。

禁止流程：

- 不得把 UI 显示名当作 `script_asset_path`。
- 不得只凭 UI 显示名写 module 或 Dynamic Input；必须使用 catalog/readback 给出的 mounted script path 或唯一 exact seed。
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

> Stage、Stage node 和 Module Input 的写入通过 folder HJSON 表达。UObject/UStruct 属性使用 `property_path/value_kind/value` 并原子读回；Niagara module input 保留领域 source/link/dynamic-input 结构，其 literal/vector/color/curve 叶子使用公共 canonical value。

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_list_stage_nodes` | 列出 Stage 全部节点 | `emitter_asset_path` + Stage 标识 + `include_properties` | 查节点 GUID 与类型 |
| `niagara_emitter_get_stage_node_property` | 读取节点属性 | `emitter_asset_path` + Stage 标识 + `node_guid` + `property_name` | 检查节点参数 |

## 模块输入管理

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_emitter_list_module_inputs` | 列出模块输入（含隐藏输入） | `emitter_asset_path`、`module_node_guid` | 查询可写输入名 |

> 统一 folder 主流程覆盖 stage、module 和 Dynamic Input script。Data Interface 详细属性与 `curve_json` 尚未进入 folder contract；需要时使用当前专用 typed 命令，后续应迁入统一 Niagara Data Interface semantic，不能把旧多文件 reader/writer 恢复为主路径。
## 防崩与限制（必须了解）

- Stage module 删除默认应表现为软删除（禁用模块），避免直接破坏 Stack 图。
- 模块节点删除走软删除，非模块节点才物理删除。
- 对 `ParticleEventScript` 的危险加模块场景有保护拦截。
- Static Switch 输入不支持参数链接时需改默认值方式。Dynamic Input curve 不能写入当前统一 folder HJSON；应先查询专用命令的当前 CommandSpec，并以专用读回验证。

## 推荐执行顺序

1. `niagara_emitter_export_folder`
2. 只编辑统一 `index.hjson` 中的 stage/module/Dynamic Input script 字段
3. `niagara_emitter_apply_folder`
4. 再导出一次，比较稳定 identity、module order 与 script path
5. 普通 module input 或 Data Interface 属性改用对应专用 typed 命令，并单独读回
6. 对包含该 emitter 的 System 做 compile log 和 runtime probe

## 最小请求示例

```hjson
{
  request_id: nsg-001
  command: niagara_emitter_apply_folder
  params: {
    emitter_asset_path: /Game/AutoTests/Niagara/NE_Leader
    folder_path: Saved/UeAssetFolders/NiagaraEmitter/Game/AutoTests/Niagara/NE_Leader
    strict: true
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

<!-- UAI_FORMAL_COMMAND_INDEX_END -->

## 废弃命令

本分册不再列出已废弃写入命令；这些命令仅保留在 `deprecatedCommand/09_Niagara_StageGraph.md`，供旧脚本兼容、bootstrap、迁移和故障补修查阅。
