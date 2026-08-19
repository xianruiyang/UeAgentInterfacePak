# Level Content JSON 指令

## 紧凑返回契约

- 默认 `llm_compact` 的 `data` 只保留 LLM 决策需要的目标标识、关键状态、计数、摘要、warnings/errors 摘要和 artifact / 文件路径。
- 完整读回、大对象、长列表、编译日志、像素/帧/点数据、raw property metadata、诊断栈和内部中间状态默认不进入 `data`；需要时通过 `response_options` 的 debug/raw 视图、显式请求字段或外置 artifact 获取。
- 本分册中的旧局部参数、历史别名或原子入口只作为 alias / 兼容路径；新 authoring 应优先使用本分册推荐的 JSON、folder、统一 viewport、probe 或 domain 专用入口。


本分册覆盖 `uai.level_content.v1` 的统一场景内容 CRUD 工作流。它用于描述关卡或某个 Outliner folder 下的场景实例最终态，并把 Actor、组件、组织关系、任务、验证和留证放进同一份 JSON 中执行。

## 返回契约

- Python `uai_core` wrapper 统一返回 `CommandResult`；业务结果读取 `CommandResult.data`，调试信息读取 `CommandResult.debug`，原始 envelope 只在排查时读取 `CommandResult.envelope`。
- 默认视图只保留 LLM 可直接消费的结构化摘要、计数、目标路径和验收状态；大型快照、diff、读回证据、诊断细节和原始 payload 必须进入文件产物、`artifacts`、debug/raw 视图或显式请求字段。
- `level_content_delete_scope` 的删除候选、阻断原因、删除结果和空 folder 清理结果属于业务 `data`；详细展开、残留读回和保护规则诊断默认不泄漏到 compact 视图。
- 默认 `llm_compact` 的 `data` 只保留 scope、selection/projection 摘要、资源/操作/任务/验证计数、apply/delete 成功状态、dry-run 状态、阻断/错误/警告摘要、输出 JSON 路径和 artifact 路径。
- `resources[]`、`resource_results[]`、`operation_results[]`、`task_results[]`、`validation_results[]`、`diffs[]`、`steps[]`、`diagnostics[]`、`repair_results[]`、`conflicts[]` 和完整 actor/component/property readback 默认分页、限量或移入 `debug/envelope` 与外置 JSON。
- Query / Snapshot / Diff 的大型场景 readback、Apply 的 dry-run 计划和写后读回、Delete Scope 的完整候选展开、Merge 的完整 `merged_json` 默认不内联进紧凑 `data`；需要完整内容时使用 `output_file` 或显式 debug/detail 选项。

## 边界

- 本分册负责“场景里有什么、在哪、如何组织、如何验证”。复杂资产本体仍走各自模块，例如 Blueprint、Material、Niagara、Audio、AI、Project Settings。
- `resources[]` 以 Actor 资源为核心，同时用 `category/kind/class_path` 适配 Volume、Light、Camera、Sound、Probe、任意 native/Blueprint Actor。`nav_mesh_bounds_volume` 会创建有效 Brush Bounds 并通知 NavigationSystem。
- `tasks[]` 表示构建或刷新动作，例如 `navmesh_build`、`cleanup_empty_folders`、HLOD/lighting/reflection/PCG 的 gated task；这些不是资源本身。
- `organization{}` 表示默认 folder/tag、Data Layer、Streaming、World Partition、HLOD 等组织语义。当前实现对未启用或无法通用操作的功能返回 feature gate warning/error，不伪造成功。
- `level_actor_*_json` 是兼容别名，只允许 Actor 类资源；遇到 streaming level、HLOD layer 等非 Actor 资源会在 validate 阶段拒绝。
- 写入类指令支持 `dry_run`、`preflight`、`transaction`、`validate_after_apply`、`save_level`。`save_level` 会复用 `save_current_level` 的保存风险保护；Python 控制台执行后的自动保存默认阻断，只有显式 `allow_python_gc_risk=true` 才解除。删除类操作默认受 `folder_root`、`managed_tag`、`managed_id` 和 `protected_tags` 保护。

## 输入 JSON

顶层 schema：

```json
{
  "schema": "uai.level_content.v1",
  "scope": {
    "folder_root": "UAI/Demo",
    "level": "Persistent",
    "world_partition": {
      "enabled": "auto",
      "runtime_grid": "MainGrid"
    }
  },
  "resources": [],
  "organization": {},
  "operations": [],
  "tasks": [],
  "validation": [],
  "evidence": {},
  "save_policy": {}
}
```

命令接受的输入来源：

- 顶层 `content`、`level_content`、`json` 或 `target_json`
- 字符串形式 `json_text`、`content_json`、`target_json_text`
- 文件形式 `json_file`、`file_path`、`input_file` 或 `content_file`
- 如果命令参数本身已经是 Level Content 对象，也可直接传入

常用 resource 字段：

| 字段 | 含义 |
| --- | --- |
| `id` | 稳定资源 id；写入 Actor tag `UAI.Id=<id>`，并兼容读取旧式 `UAI.Id:<id>`，用于后续 upsert/diff/delete |
| `operation` | `create`、`upsert`、`patch`、`delete`、`clone`；未写时由命令 `mode` 决定 |
| `category` / `kind` | 资源分类与适配器，例如 `actor/static_mesh`、`actor/point_light`、`spatial/nav_mesh_bounds_volume`、`probe/target_point` |
| `class_path` | 显式 UE class；未写时由 `kind` 推导 |
| `name` / `label` | Actor object name 与 editor label |
| `folder_path` | Outliner folder；未写时使用 `organization.default_folder` 或 `scope.folder_root` |
| `transform` | `location`、`rotation`、`scale` |
| `tags` | Actor tag；写入时会补 `UAI.Managed` 和 `UAI.Id=<id>`；读取阶段兼容旧式 `UAI.Id:<id>` |
| `properties` | Actor 或组件反射属性 v2 descriptor 列表；每项使用 `property_path/value_kind/value`，组件属性路径可为 `ComponentName.PropertyName`，容器携带递归类型元数据 |
| `components[]` | 实例组件规格，支持 component class、name、transform、properties |
| `attach_to` | 父 Actor 的 resource id、actor label 或 actor name |

内置 `kind` 到 class 的默认映射：

| `kind` | 默认 class |
| --- | --- |
| `actor` / `custom` | `/Script/Engine.Actor` 或显式 `class_path` |
| `static_mesh` | `/Script/Engine.StaticMeshActor` |
| `point_light` | `/Script/Engine.PointLight` |
| `camera` | `/Script/Engine.CameraActor` |
| `ambient_sound` | `/Script/Engine.AmbientSound` |
| `trigger_box` | `/Script/Engine.TriggerBox` |
| `nav_mesh_bounds_volume` | `/Script/NavigationSystem.NavMeshBoundsVolume` |
| `target_point` / `probe` | `/Script/Engine.TargetPoint` |
| `niagara_actor` | `/Script/Niagara.NiagaraActor`，未启用 Niagara 时按 class load 失败返回诊断 |

`nav_mesh_bounds_volume` 适配器：

- 推荐在 resource 上提供 `bounds.center` + `bounds.extent`，或 `bounds.min` + `bounds.max`；也兼容顶层 `center/extent`。
- apply 时会为 `ANavMeshBoundsVolume` 创建 `UCubeBuilder` Brush，并把 Actor scale 归一为 `1,1,1`，避免 Brush 尺寸与 Actor scale 双重叠加。
- 未提供显式 bounds 且本次是新创建 Actor 时，会从 `transform.location` 和 `transform.scale * 100cm` 推导兼容 fallback；需要稳定生产结果时不要依赖该 fallback。
- 默认调用 `UNavigationSystemV1::OnNavigationBoundsUpdated`；可用 `update_navigation_bounds=false` 关闭。
- `resource_results[]` 会返回 `bounds`、`requested_center`、`requested_extent`、`builder_size`、`nav_bounds_explicit`、`nav_bounds_updated`，脚本应检查 `bounds.valid=true` 且 extent 非零。

组件碰撞/物理属性适配器：

- `resources[].properties` 或 `components[].properties` 写入组件属性时，若目标是 `UPrimitiveComponent` 且 property path 命中 `BodyInstance.*`、`Collision*` 或 `CanCharacterStepUpOn`，会刷新 `RecreatePhysicsState / UpdateOverlaps / UpdateBounds / MarkRenderStateDirty / MarkRenderTransformDirty`。
- 写入 `BodyInstance.CollisionProfileName` 或 `CollisionProfileName` 时，会优先调用 `SetCollisionProfileName` 而不是先裸写 `BodyInstance`，避免 UE setter 因当前 FName 已被改成目标值而不重新加载 collision profile；`NoCollision` 会额外调用 `SetCollisionEnabled(NoCollision)`。
- `property_results[]` 中出现 `property_assignment_method=collision_profile_setter`、`collision_profile_setter_applied=true`、`collision_enabled_no_collision_applied=true`、`primitive_collision_state_refreshed=true`、`render_state_refreshed=true` 表示已触发对应副作用；仍建议用 `level_trace_world_ray` / `level_sweep_capsule` / `level_check_overlaps` 验证实际碰撞行为。
- 写入 `USkeletalMeshComponent` 的 `SkeletalMesh`、`SkeletalMeshAsset` 或 `SkinnedAsset` 时，会优先调用 `SetSkeletalMesh`，再刷新 bounds 和 render state。`property_results[]` 中出现 `property_assignment_method=skeletal_mesh_component_setter`、`skeletal_mesh_setter_applied=true`、`skeletal_mesh_path_read_back` 表示已走 setter；调用方应同时验证组件 `SkinnedAsset` 读回和 Actor bounds 非零。

Spline 组件适配器：

- `components[]` 支持 `/Script/Engine.SplineComponent`，可写入 `spline_points[]`、`spline_closed_loop`、`spline_coordinate_space` / `coordinate_space`。点支持 `location`、`arrive_tangent`、`leave_tangent` 和 `type`，常用 `type` 包括 `linear`、`curve`、`constant`、`curve_clamped`、`curve_custom_tangent`。
- Query / Snapshot 在 `include_components=true` 时会返回 `spline_point_count`、`spline_closed_loop` 和 `spline_points[]`，用于 PCG Get Spline / Spline Sampler 类工作流的写后读回。
- 对纯 `/Script/Engine.Actor` 创建后再补 root scene component 的资源，apply 会在组件处理后重新应用 Actor transform，避免 root 组件创建覆盖初始位置。`selection.label` / `actor_label` 可不带 `mode` 精确命中单个 Actor。

## 指令

| 指令 | 作用 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `level_content_query_json` | 查询当前世界中的场景内容，并按 Level Content 投影返回 | `selection`、`projection`、`output_file`、`actor_only` | `schema`、`world`、`resources[]`、`resource_count`、`organization`、`feature_gates` |
| `level_content_snapshot_json` | 生成可回写的当前场景快照 | `selection`、`projection`、`output_file` | `schema`、`resources[]`、`organization`、`snapshot=true` |
| `level_content_validate_json` | 只读校验 Level Content JSON | `content`/`json_file`、`strict`、`actor_only` | `schema`、`valid`、`issues[]`、`json_issues[]`、`feature_gates` |
| `level_content_plan_json` | 只读生成执行计划和风险清单 | `content`/`json_file`、`mode`、`strict`、`dry_run` | `schema`、`can_apply`、`steps[]`、`validation`、`feature_gates` |
| `level_content_apply_json` | 应用 create/upsert/patch/delete/clone、组织关系、任务和验证 | `content`/`json_file`、`mode`、`dry_run`、`preflight`、`transaction`、`validate_after_apply`、`delete_policy`、`protected_tags`、`save_level`、`allow_python_gc_risk` | `schema`、`success`、`dry_run`、`resource_results[]`、`operation_results[]`、`task_results[]`、`validation_results[]`、`saved`、`save_level_data`、`rollback_attempted` |
| `level_content_diff_json` | 比较目标 JSON 与当前场景差异 | `content`/`json_file`、`delete_policy`、`actor_only` | `schema`、`empty`、`diffs[]`、`current_count`、`target_count` |
| `level_content_delete_scope` | 按 Outliner folder 清理当前关卡 Actor，交互语义对齐 `asset_delete` | `folder_path` / `folder_paths` / `folder_root`、`recursive`、`dry_run`、`fail_on_blocked`、`managed_tag`、`managed_ids`、`protected_tags`、`allow_unmanaged_delete`、`delete_empty_folders`、`save_level`、`allow_python_gc_risk` | `schema`、`folder_expansions[]`、`deletable_count`、`blocked_count`、`actors[]`、`blocked[]`、`deleted_actors[]`、`remaining_actor_count`、`folder_deletions[]`、`save_level_data` |
| `level_content_merge_json` | 合并 base/current/target 三份 Level Content JSON | `base`、`current`、`target`、`conflict_policy` | `schema`、`merged_json`、`conflicts[]`、`conflict_count` |
| `level_content_repair_json` | 诊断并可安全修复 folder/托管内容残留 | `folder_root`、`apply_safe`、`cleanup_empty_folders` | `schema`、`diagnostics[]`、`repair_results[]`、`applied` |
| `level_actor_export_json` | Actor-only 查询兼容别名 | 同 `level_content_query_json` | 同 `level_content_query_json`，`actor_only=true` |
| `level_actor_snapshot_json` | Actor-only 快照兼容别名 | 同 `level_content_snapshot_json` | 同 `level_content_snapshot_json`，`actor_only=true` |
| `level_actor_validate_json` | Actor-only validate 兼容别名 | 同 `level_content_validate_json` | 非 Actor resource 返回 error issue |
| `level_actor_apply_json` | Actor-only apply 兼容别名 | 同 `level_content_apply_json` | 非 Actor resource 在 preflight 阶段失败 |
| `level_actor_diff_json` | Actor-only diff 兼容别名 | 同 `level_content_diff_json` | 同 `level_content_diff_json`，`actor_only=true` |

## Query / Snapshot

`selection` 支持：

- `mode=folder`，配合 `folder_path` / `folder_root` 和 `include_child_folders`
- `mode=selected`，查询当前编辑器选择
- `ids[]` / `actors[]`，按 `UAI.Id=<id>` / `UAI.Id:<id>`、actor label 或 object name 命中
- `label` / `actor_label` / `name` 精确命中，`label_contains` / `name_contains` / `search` 模糊命中
- `tags_all[]`、`tags_any[]`
- `class`、`class_any[]`、`classes[]`
- `radius` + `center`
- `bounds{min,max}` 或 `bounds{center,extent}`，支持 `intersects`、`contains_actor_bounds`、`contains_actor_origin`、`actor_contains_bounds`
- `data_layers[]` / `data_layer`，优先反射 Actor DataLayer 字段，缺失时兼容 `DataLayer=<name>` / `DataLayer:<name>` / 直接同名 tag

`projection` 支持：

- `include_components`
- `include_bounds`
- `include_properties[]`
- `include_attachments`

示例：

```json
{
  "selection": {
    "mode": "folder",
    "folder_path": "UAI/Demo",
    "include_child_folders": true,
    "tags_all": ["UAI.Managed"]
  },
  "projection": {
    "include_components": true,
    "include_bounds": true,
    "include_properties": ["StaticMeshComponent.StaticMesh"]
  },
  "output_file": "Saved/UeAgentInterface/LevelContent/demo_snapshot.json"
}
```

## Delete Scope

`level_content_delete_scope` 用于清理当前关卡里的 Actor，不处理 Content Browser 资产。它按 Outliner folder 展开候选，交互语义与 `asset_delete` 保持一致：默认 `dry_run=true`，先返回完整候选和阻断原因；只有确认 `blocked_count=0` 或显式 `fail_on_blocked=false` 后，才应传 `dry_run=false` 执行。

常用参数：

- `folder_path` / `folder_root` / `folder_paths` / `folder_roots`：必填其一，表示 Outliner folder，不是 `/Game` 资产目录。
- `recursive` / `include_child_folders`：是否包含子 folder，默认 `true`，保持旧 scope 清理兼容行为。
- `dry_run`：默认 `true`。为 `true` 时只报告 `would_delete_count` 和 `folder_would_delete_count`，不修改关卡。
- `fail_on_blocked`：默认 `true`。存在 `blocked[]` 时整条命令失败，不执行部分删除。
- `managed_tag`：可选。传入后，未带该 tag 且没有 `managed_id` 的 Actor 会以 `unmanaged_actor` 阻断。
- `managed_ids` / `managed_id`：可选。用于限制托管 id；不匹配的 Actor 会以 `managed_id_not_requested` 阻断。
- `allow_unmanaged_delete`：可选。未传 `managed_tag/managed_ids` 时默认允许按 folder 删除所有 Actor；传了托管过滤时默认不允许未托管 Actor，除非显式设为 `true`。
- `protected_tags[]`：命中任一 tag 的 Actor 永远阻断删除。
- `delete_empty_folders` / `delete_folders`：默认 `true`。删除 Actor 后清理空 Outliner folder。
- `save_level` / `save_after_delete`：默认 `false`。需要把删除结果落到关卡文件时显式开启；保存会复用 `save_current_level` 风险保护。
- `allow_python_gc_risk`：默认 `false`。本 Editor 会话执行过 Python 控制台命令后，`save_level` 会返回 `save_level_ok=false`、`save_level_error=save_current_level_blocked_python_gc_risk`，并在 `save_level_data.block_reason` 中标明 `python_gc_save_risk`；只有显式确认风险时才传 `true`。

关键返回：

- `folder_expansions[]`：每个请求 folder 展开的 Actor 列表。
- `actors[]`：逐 Actor 候选报告，包含 `actor_label`、`actor_name`、`object_path`、`folder_path`、`managed_id`、`tags[]`、`deletable` 和 `blocked_reasons[]`。
- `blocked[]` / `blocked_count`：阻断项与数量。
- `deletable_count` / `would_delete_count`：可删除候选数量。
- `deleted_actors[]` / `deleted_count`：真实执行后的删除读回。
- `remaining_actor_count`：执行后仍存在的候选 Actor 数；非 dry-run 下大于 0 会返回 `level_content_delete_scope_incomplete`。
- `folder_deletions[]`、`folder_delete_count`、`folder_would_delete_count`、`folder_delete_blocked_count`：空 Outliner folder 清理结果。

示例：

```json
{
  "folder_path": "UAI/ModelingCollisionPlaytest",
  "recursive": true,
  "dry_run": true
}
```

```json
{
  "folder_path": "UAI/ModelingCollisionPlaytest",
  "recursive": true,
  "dry_run": false,
  "allow_unmanaged_delete": true,
  "delete_empty_folders": true,
  "save_level": true
}
```

## Apply

`mode`：

- `create`：只创建不存在资源。
- `upsert`：默认。存在则 patch，不存在则 create。
- `patch`：只修改已存在资源。
- `delete_only`：只执行删除资源。
- `replace_scope`：结合 `delete_policy=replace_scope_managed` 替换当前托管 scope。

`delete_policy`：

- `none` / `explicit_only`：只删除 `operation=delete` 的资源。
- `only_managed_missing` / `managed_missing`：删除 scope 内带 `managed_tag` 但目标 JSON 缺失的 Actor。
- `replace_scope_managed` / `replace_scope`：替换整个托管 scope，需配合 folder/tag 保护。

写入保护：

- 默认托管 tag 为 `UAI.Managed`。
- 每个带 `id` 的 Actor 会写入 `UAI.Id=<id>`，读取时兼容旧式 `UAI.Id:<id>`。
- `protected_tags[]` 命中的 Actor 不会被删除；写入失败返回 `actor_protected`，不会被静默跳过。
- `level_content_apply_json` 的 `replace_scope_managed` / `only_managed_missing` 仍是托管替换语义，只删除目标 scope 内带 `managed_tag` 的缺失 Actor。
- 独立 `level_content_delete_scope` 是场景 Actor 的 folder 清除入口，交互结构对齐 `asset_delete`：先用 `dry_run=true` 展开 folder、列出候选、输出 `deletable_count / blocked_count / blocked[]`；确认后再传 `dry_run=false` 执行。
- `managed_tag` 或 `managed_ids` 用于要求托管保护；此时未满足托管条件的 Actor 会进入 `blocked[]`。未传托管过滤时，folder 清理默认按 folder 内所有 Actor 作为候选；如果需要强制保护未托管 Actor，传 `managed_tag="UAI.Managed"` 或 `allow_unmanaged_delete=false`。
- `protected_tags[]` 命中的 Actor 永远阻断删除；`fail_on_blocked=true`（默认）时只要存在阻断项，整条命令返回失败且不删除任何 Actor。
- `delete_empty_folders=true`（默认）时，Actor 删除后会清理请求的空 Outliner folder 以及递归匹配到的空子 folder，并在 `folder_deletions[]` 中报告 `would_delete / deleted / blocked`。

示例：

```json
{
  "mode": "upsert",
  "transaction": true,
  "preflight": true,
  "validate_after_apply": true,
  "content": {
    "schema": "uai.level_content.v1",
    "scope": {
      "folder_root": "UAI/LevelContentSmoke"
    },
    "organization": {
      "default_folder": "UAI/LevelContentSmoke",
      "managed_tag": "UAI.Managed"
    },
    "resources": [
      {
        "id": "smoke_cube",
        "kind": "static_mesh",
        "label": "LCJ_SmokeCube",
        "transform": {
          "location": [0, 0, 120],
          "rotation": [0, 0, 0],
          "scale": [1, 1, 1]
        },
        "asset": {
          "static_mesh": "/Engine/BasicShapes/Cube.Cube"
        },
        "properties": {
          "StaticMeshComponent.BodyInstance.CollisionProfileName": "BlockAll"
        }
      },
      {
        "id": "smoke_light",
        "kind": "point_light",
        "label": "LCJ_SmokeLight",
        "transform": {
          "location": [150, 0, 260]
        },
        "properties": {
          "PointLightComponent.Intensity": 1200.0
        }
      }
    ],
    "tasks": [
      {
        "type": "navmesh_build"
      }
    ],
    "validation": [
      {
        "type": "actor_exists",
        "id": "smoke_cube"
      },
      {
        "type": "property_readback",
        "id": "smoke_light",
        "property": "PointLightComponent.Intensity"
      }
    ]
  }
}
```

## Operations

`operations[]` 用于表达单纯最终态难以描述的动作：

| `operation` / `type` | 作用 |
| --- | --- |
| `delete` | 删除指定 `id` / `actor`，受 `protected_tags` 与托管规则保护 |
| `clone` | 从 `from_actor` / `source_id` 复制 Actor，再按 `id` / `patch` 写入 |
| `attach` | 将 `child` 挂到 `parent`，可带 socket/rules |
| `detach` | 解除 attach |
| `set_folder` | 修改 folder |
| `add_tag` / `remove_tag` | 修改 Actor tag |
| `align` | 支持 `copy_location` / `actor_to_actor` / `bounds_center` / `by_bounds` 的安全位置对齐；复杂 face/vertex/surface 对齐返回 report-only 并转交专用几何命令 |
| `screenshot` / `evidence` | 生成结构化留证报告；真实截图仍转交 crash-guarded screenshot 指令 |
| `repair` / `repair_report` | 委托到 `level_content_repair_json` 生成修复建议 |
| `convert` / `migrate` / `convert_report` | 转换请求按 report-only 返回，避免通用 destructive convert |
| `remap` / `retarget` | 在 folder/managed scope 内执行有上限的属性文本重映射；超过上限自动降级报告 |
| `remap_report` | 只生成重映射诊断报告，不写入世界 |

当前未做通用安全写入的 operation 会返回受控 report，不会伪造执行成功。需要修改资产本体时，应转到对应资产 JSON/folder 工作流。

## Tasks

已实现 task：

| `type` | 行为 |
| --- | --- |
| `navmesh_build` | 调用导航系统构建当前世界导航数据 |
| `cleanup_empty_folders` | 清理空 Outliner folder |
| `hlod_build` / `build_hlod` / `lighting_build` / `reflection_capture_update` / `pcg_generate` / streaming load-unload task | 返回 feature gate 结果；当前通用 Level Content 写入不越权执行这些高风险或插件相关任务 |

`tasks[]` 可带 `required_plugin`、`timeout_seconds`、`allow_in_unattended` 等字段。未启用插件、超出安全策略或无法在当前环境执行的任务返回 warning/error issue。

## Validation

已实现 validation：

| `type` | 行为 |
| --- | --- |
| `actor_exists` | 验证指定 `id` / actor 在场景中存在 |
| `property_readback` | 读取 Actor 或 Component 属性并返回结构化 readback；仅 debug 视图可附带文本证据 |
| `trace` / `line_trace` | 对 `start` 到 `end` 做只读 visibility/collision channel trace，支持 `expected_hit` |
| `overlap` / `box_overlap` | 对 `center` + `extent` 做对象 overlap 查询，支持 `min_count` / `max_count` |
| `sweep` / `capsule_sweep` | 对 capsule sweep 做只读空间验证，支持 `expected_hit` |
| `nav_path` / `navmesh_path` | 调用导航系统查找路径，返回 `path_found`、`partial`、`point_count`；导航系统不可用时结构化返回 feature gate |
| `streaming_state` / `streaming_loaded` | 读取 streaming level loaded / visible 状态，支持 expected loaded / visible |
| `data_layer_membership` | 验证 Actor DataLayer membership；优先反射真实字段，缺失时使用 DataLayer tag 兼容层 |
| `hlod_assignment` / `lod_state` | 当前返回 feature gate report-only，不阻塞普通 Actor CRUD |
| `feature_gate` | 检查任务/插件/功能开关状态 |

Validate 阶段还会覆盖：

- schema 缺失或 schema 不匹配 warning
- `resources[]` 元素类型错误
- resource `id` 缺失或重复
- Actor-only 兼容命令中的非 Actor resource
- class load 失败
- custom adapter 在 `strict=true` 时未声明 `class_path`
- property path 在 CDO 上不存在
- attach cycle
- streaming level 未加载
- World Partition / Data Layer / HLOD / PCG 等 feature gate

`issues[]` 项结构：

```json
{
  "severity": "error",
  "code": "duplicate_resource_id",
  "path": "$.resources[1].id",
  "message": "Duplicate resource id: crate_01"
}
```

## Diff / Merge / Repair

`level_content_diff_json` 按 resource id 比较目标 JSON 与当前场景。当前实现覆盖 create/update/delete 级别判断，主要用于 apply 前后确认“是否还有未完成资源差异”。

`level_content_merge_json` 采用 resource id 做三方合并：

- base/current/target 都未冲突时自动合并。
- current 与 target 同时改同一 resource 且内容不同，进入 `conflicts[]`。
- `conflict_policy=target_wins` 可显式让 target 覆盖。

`level_content_repair_json` 当前聚焦 folder 残留和安全清理；`apply_safe=true` 时只执行已知安全修复，不做跨 Level、Data Layer 或未加载外部 Actor 的破坏性修改。

## 返回与诊断

写入类结果中的单项 result 通常包含：

- `id`
- `operation`
- `status`
- `actor`
- `created`
- `patched`
- `property_results[]`
- `component_results[]`
- `warnings[]`
- `error`

失败必须检查：

- 顶层 `ok/success`
- `error`
- `issues[]`
- `resource_results[]`
- `operation_results[]`
- `task_results[]`
- `validation_results[]`
- `evidence_results`
- `rollback_attempted`

`dry_run=true` 不写入世界，只返回计划和会影响的对象；`preflight=true` 会先跑 validate，有 error 时不进入 apply。

## 测试覆盖

Automation smoke：

- `GptProjectTest.UeAgentInterface.Smoke.LevelContentJson.CrudTasksValidation`
- `GptProjectTest.UeAgentInterface.Smoke.LevelContentJson.GuardsMergeRepair`

覆盖内容：

- validate / plan / apply / query / snapshot / diff / delete scope
- Actor-only 兼容别名
- StaticMesh、PointLight、Camera、AmbientSound、TriggerBox、TargetPoint/probe、带有效 Brush Bounds 的 NavMeshBoundsVolume
- component 创建、Actor/Component 属性写入、组件碰撞 profile 切换后的 trace 行为、attach、NavMesh task、feature gate warning
- query 的 label/bounds/DataLayer tag 过滤
- validation 的 trace、overlap、nav path、streaming state 结构化返回
- evidence report 结构化结果
- clone、align、attach、detach、set_folder、add_tag、remove_tag、convert/report-only、remap、repair operation
- duplicate id、非 Actor alias 拒绝、protected delete 可控失败、merge conflict、repair 诊断

## 2026-05-29 implementation note

- `level_content_apply_json` refreshes component side effects after property import and then re-exports `property_value_read_back` from a reset string buffer. Readback values must represent the final property text once, not a concatenation of pre-refresh and post-refresh exports.
