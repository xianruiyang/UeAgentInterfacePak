---
command: node_catalog_search
category: node_graph
title: Node Catalog Search
summary: 查询 UE palette/action menu 风格的可新增节点、模块、输入来源或可放置 Actor 候选，供 LLM 写 HJSON 前取证
aliases: [placeable_actor, level_actor, actor_placeable, place_actors, actor_catalog]
tags: [node_graph, placeable_actor, level_actor, actor_placeable, place_actors, actor_catalog]
status: active
---

# `node_catalog_search`

## LLM Compact

- status: active.
- purpose: 查询 UE palette/action menu 风格的可新增节点、模块、输入来源或可放置 Actor 候选，供 LLM 写 HJSON 前取证
- key_inputs: `candidate_id`, `catalog_type`, `context.asset_path`, `graph_name`, `node_guid`, `pin_guid`, `pin_name`, `filters` ...
- key_returns: `counts`, `page`, `items_tsv`, `candidate_resolution`, `candidate`, `seed`, `placement`, `warnings`；普通搜索只返回紧凑候选，唯一 `exact` / `candidate_id` 查询才可能返回正式 Apply 投影。
- note: 新增节点、模块、expression 或 Actor 前先查询 3-5 条 catalog TSV；选定候选后只对该候选发起唯一查询。`seed` 是 ApplyInputContract 允许的最小目标片段，`placement` 是独立的 workspace 位置，两者都不包含 operation、默认值、layout 或 readback 状态。
- placeable_actor: `catalog_type=placeable_actor`，别名 `level_actor`、`actor_placeable`；broad TSV 只用于选候选，写入字段必须取自 unique exact 的 `seed/placement`。
- placeable_actor_verified: 当前基础候选已通过搜索、最小创建和读回验证，包括 `PointLight`、`DirectionalLight`、`CameraActor`、`PlayerStart`、`TextRenderActor`、`StaticMeshActor`、`TriggerBox`、`Cube`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog TSV；写入后必须编译或读回关键 pin/input 状态。
- 创建关卡 Actor 前使用 `catalog_type=placeable_actor` 查询可放置 Actor 候选，随后用 TSV 的 opaque `candidate_id` 发起 unique exact 查询。
- `placeable_actor` 的别名 `level_actor`、`actor_placeable` 会归一化为主类型；正式文档和示例使用 `placeable_actor`。
- `items_tsv` 只用于低 token 候选选择，不是通用 Apply payload。使用 TSV 的 opaque `candidate_id` 发起 exact/detail 查询；实际写入字段名只取自 exact 返回的 `seed` 和目标 InputContract。
- 普通 fuzzy/contains/prefix 搜索不会返回 `candidate`、`seed` 或 `placement`。选定 TSV 行后，用该行的稳定 selector 发起 `search_mode=exact` 查询；只有唯一命中且该 catalog kind 注册了正式 Apply 投影时才返回 `seed` 和 `placement`。
- 同一个逻辑节点可能由 UE Palette 的多个分类入口重复提供；Catalog 按 canonical identity 去重。exact 或 `candidate_id` 查询中 canonical identity 完全相同的重复来源按一个目标解析，只有身份不同的候选才返回 `target_ambiguous`。
- `seed` 与 Export 无关，也不是完整对象。调用方仍须按目标 operation 补充 owner、stage、graph、identity、连接或属性等上下文；这些内容不能由 Catalog 猜测。
- Niagara input value source 和 Script graph function 没有可脱离 owner 的 standalone placement；需要既有 module input 或 Script graph 上下文时，必须走对应领域 contract 和 readback，不能把候选本身直接 Apply。
- 已验证基础候选：`PointLight`、`DirectionalLight`、`CameraActor`、`PlayerStart`、`TextRenderActor`、`StaticMeshActor`、`TriggerBox`、`Cube`。

## Parameters

- Niagara `filters.target_usage` accepts the canonical `ENiagaraScriptUsage` names such as `ParticleSpawnScript`, `ParticleUpdateScript`, `EmitterUpdateScript`, and `ParticleSimulationStageScript`, plus documented compact aliases such as `particle_spawn` and `update`. Matching is case-insensitive and ignores spaces, `_`, and `-`; an unknown value returns an ignored-filter warning rather than silently claiming the filter was applied.

- `candidate_id`：由 Shared canonical identity 生成的稳定、可解析但应视为 opaque 的 id；只能取自唯一 exact/detail 返回，不能手工拼接。
- `catalog_type`：catalog 主类型。常用值包括 `niagara_module`、`niagara_dynamic_input`、`niagara_graph_node`、`material_node`、`material_expression`、`material_function_call`、`blueprint_node`、`actor_component`、`umg_widget`、`placeable_actor`。`placeable_actor` 别名：`level_actor`、`actor_placeable`。
- `context`：可选上下文对象；支持 `asset_path`、`graph_name`、`node_guid`、`pin_guid` / `pin_id`、`pin_name` 和 `candidate_id`。需要 pin/graph 上下文的 catalog 必须传真实值。
- `filters`：catalog 类型定义的过滤条件。
- `page`：`limit` 默认 5、范围 1-20；超过 20 返回 `catalog_page_limit_exceeded`；`offset` 默认 0；`sort` 为 `ui_order`、`name` 或 `category`。
- `query`：`text` 默认空字符串；`search_mode` 为 `fuzzy`、`exact`、`prefix` 或 `contains`。
- `view`：控制 `include_items`、`include_groups`、`include_category_tree` 和 `include_debug_fields`；不包含 legacy authoring 开关。
- `include_debug_fields`：顶层 debug 开关；日常候选搜索保持关闭。

## Returns

- `warnings`：警告摘要。
- `category_tree`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `counts`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `groups`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `items_tsv`：仅 broad 查询返回的候选列表 TSV；首行为 `candidate_id	name	kind	category	summary`，最多 20 行、16384 UTF-8 bytes，单元格最多 2048 bytes。
- `items_tsv.candidate_id`：opaque canonical identity；只用于 exact/detail 查询，不得手工解析或拼接。
- `items_tsv.name`：候选短名；无稳定路径候选可作为 `name` seed。
- `items_tsv.kind`：候选对应的 generated CatalogBinding kind。
- `items_tsv.category`：候选分类，如 `Basic`、`Lights`、`Shapes`、`Volumes`、`Cinematic`。
- `items_tsv.summary`：受限 UE tooltip 摘要，最多 512 Unicode code points，并服从单元格/总字节门禁。
- `table_budget`：返回 `max_rows=20`、`max_bytes=16384`、`max_cell_bytes=2048`、`tooltip_max_codepoints=512`、实际 rows/bytes 与 `truncated`。
- `candidate_resolution`：exact/candidate-id 定位状态。`error_code=target_resolved` 才能使用结果；`target_ambiguous` 需要按 `required_discriminators` 增加 selector，`target_identity_conflict` 表示冗余身份字段指向不同实体，`target_not_found`/`target_query_invalid` 均不得回退选择首项。失败时 `candidates` 提供有序的可操作身份。
- `candidate`：唯一定位时返回 `candidate_id/kind/name/full_name`；`candidate_id` 可直接传给 `node_catalog_search` detail 或 `node_origin_resolve`，两者使用同一 identity。
- `seed`：仅在唯一候选具备正式 Apply 投影时返回。字段来自目标 ApplyInputContract 的 canonical identity/type assertion，不包含 operation、默认值、owner patch、layout 或对象内容。
- `placement`：与 `seed` 独立，active schema 为 `uai.catalog_placement.v2`；包含当前 `contract_hash`、workspace/input/unit/path、`pointer_template`、`merge_mode`、`seed_bindings` 和 `required_context`。它不猜 owner/context，也不包含 operation。

## Minimal Example

```python
result = node_catalog_search(
    ue,
    catalog_type="placeable_actor",
    query={"text": "Point Light"},
    page={"limit": 5},
)
header, row = result.data["items_tsv"].splitlines()[:2]
columns = dict(zip(header.split("\t"), row.split("\t")))
candidate_id = columns["candidate_id"]
```

选中候选后只取一条 exact detail：

```python
detail = node_catalog_search(
    ue,
    catalog_type="placeable_actor",
    candidate_id=candidate_id,
    query={"text": "", "search_mode": "exact"},
    page={"limit": 1},
    view={"include_items": False, "include_groups": False, "include_category_tree": False},
)
actor_seed = detail.data["seed"]
placement = detail.data["placement"]
candidate_id = detail.data["candidate"]["candidate_id"]
```

`seed` 仍需与目标 operation 和 owner identity 合并。以下示例只展示 Level actor create 的组合关系，实际文件位置由 `placement.path_pattern` 决定：

```hjson
operation: create
target: {
  world_path: "/Game/Maps/L_Example"
  managed_id: Light_01
  actor_class: "/Script/Engine.PointLight" // 来自 exact seed
}
provider_extension: {
  label: Light_01
  folder_path: Lighting
  transform: { translation: [0, 0, 300], rotation: [0, 0, 0], scale: [1, 1, 1] }
}
```

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

对 `placeable_actor`，验证链路为：broad search -> 选择 TSV 行 -> unique exact -> 读取 `seed/placement` -> 与 Level owner/operation 合并 -> `level_apply_folder` -> `level_export_folder` 读回 class、label、folder 和 transform。不得跳过 exact 投影并把 TSV 当作完整 actor 文件。
