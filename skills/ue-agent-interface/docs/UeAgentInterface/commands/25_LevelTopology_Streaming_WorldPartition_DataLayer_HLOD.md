# Level Topology / Streaming / World Partition / DataLayer / HLOD 指令

本分册覆盖 Level 拓扑层的结构化操作。它不替代 `level_content_*_json` 的 Actor 创建、组件配置和普通属性编辑；它负责 Actor 放在哪个子关卡、属于哪些 DataLayer、是否参与 World Partition 空间加载、使用哪个 HLOD Layer，以及这些拓扑关系的导出、校验、差异和回写。

## 总体边界

- `level_content_*_json` 是场景 Actor 终态 authoring 主流程，负责创建、删除、组件、属性、标签、文件夹和 transform。
- 本分册只处理 Level 组织关系：Streaming Level、World Partition、DataLayer、HLOD、Runtime Grid、Spatially Loaded。
- World Partition 相关命令会先检测当前 World 是否启用 World Partition；未启用时返回 `world_partition_not_enabled`，不会伪造成功。
- `data_layer_create_instance` 需要当前 persistent level 支持 external objects / external actors；不满足时返回 `level_external_objects_required_for_data_layer`，不会创建半成品 `AWorldDataLayers`。
- Asset-backed DataLayer 的写入目标推荐使用稳定的 `asset_path`；`instance_name` 可用于查询展示，但不是跨会话稳定 key。
- HLOD 构建默认 `report_only=true`，只返回 commandlet 计划；真正执行必须显式传 `execute=true, report_only=false, allow_commandlet=true`，并在需要 RHI 的步骤传 `allow_rhi=true`。
- 批量 apply 会在子命令失败时停止并返回已执行 `results[]`，不会静默跳过失败项。

## Level Topology JSON

```json
{
  "schema": "uai.level_topology.v1",
  "streaming_levels": [
    {
      "operation": "add_existing",
      "level_package": "/Game/Maps/Sub_A",
      "streaming_class": "/Script/Engine.LevelStreamingDynamic",
      "loaded": true,
      "visible": true
    }
  ],
  "data_layers": [
    {
      "asset_path": "/Game/DataLayers/DL_Combat",
      "type": "Runtime",
      "create_instance": true,
      "short_name": "DL_Combat"
    }
  ],
  "actor_assignments": [
    {
      "actor_ids": ["BP_NPC_01"],
      "level_package": "/Game/Maps/Sub_A",
      "data_layers": ["DL_Combat"],
      "hlod_layer": "/Game/HLOD/HL_Instancing",
      "runtime_grid": "MainGrid",
      "is_spatially_loaded": true
    }
  ]
}
```

## 拓扑编排

| 命令 | 作用 | 关键参数 | 返回重点 |
| --- | --- | --- | --- |
| `level_topology_export_json` | 导出当前拓扑快照 | `include_streaming_levels`、`include_data_layers`、`include_world_partition`、`include_hlod`、`include_actor_assignments`、`actor_assignment_limit`、`output_file` | `schema`、`streaming_levels[]`、`data_layers[]`、`world_partition`、`actor_assignments[]`、`feature_gates` |
| `level_topology_validate_json` | 校验拓扑 JSON 的可执行性 | `json` 或 `json_file` | `valid`、`issues[]`、`issue_count` |
| `level_topology_diff_json` | 比较拓扑 JSON 与当前场景 | `json` 或 `json_file` | `changed`、`diffs[]`、`diff_count` |
| `level_topology_apply_json` | 批量应用 streaming level、DataLayer 和 Actor 拓扑关系 | `json` 或 `json_file`、`dry_run` | `status`、`results[]`、`changed` |
| `level_topology_set_actor_assignments` | 一次性设置 Actor 的子关卡、DataLayer、HLOD、WP 相关分配 | `actor_ids`、`level_package`、`data_layers`、`hlod_layer`、`runtime_grid`、`is_spatially_loaded` | `results[]`、`changed` |

## Level Streaming

| 命令 | 作用 | 关键参数 | 返回重点 |
| --- | --- | --- | --- |
| `level_streaming_query` | 列出当前 World 的 streaming levels | `include_actors` | `streaming_levels[]`、`count` |
| `level_streaming_create_level` | 创建并挂载新子关卡 | `level_package`、`streaming_class`、`use_external_actors`、`create_world_partition`、`enable_world_partition_streaming`、`transform`、`move_selected_actors`、`save_after_create` | `created`、`level_package`、`streaming_class`、`saved` |
| `level_streaming_add_existing` | 将已有关卡资产作为 streaming level 挂入当前 World | `level_package`、`streaming_class`、`transform` | `added`、`level_package`、`loaded`、`visible` |
| `level_streaming_remove` | 从当前 World 移除 streaming level | `level_package`、`clear_selection`、`reset_transaction_buffer`、`delete_asset` | `removed`、`level_package`、`delete_asset` |
| `level_streaming_set_state` | 设置 streaming level 加载、可见、当前关卡和 transform | `level_package`、`loaded`、`visible`、`current`、`transform` | `changed`、`loaded`、`visible`、`should_be_loaded`、`should_be_visible` |
| `level_streaming_move_actors` | 将 Actor 移入目标子关卡 | `target_level` 或 `level_package`、`actor_ids` 或 `folder_root`、`warn_about_references` | `moved_count`、`actor_results[]` |
| `level_streaming_save` | 保存一个或全部 streaming level package | `level_package`、`all` | `saved_packages[]`、`saved_count` |
| `level_streaming_validate` | 校验子关卡存在、加载/可见状态、Actor 所属关卡 | `level_package`、`expected_loaded`、`expected_visible`、`actor_ids` | `status`、`issues[]` |

## DataLayer

| 命令 | 作用 | 关键参数 | 返回重点 |
| --- | --- | --- | --- |
| `data_layer_query` | 查询当前 World DataLayer instances | `include_actors` | `data_layers[]`、`count` |
| `data_layer_create_asset` | 创建或更新 `UDataLayerAsset` | `asset_path`、`type=Runtime|Editor`、`debug_color`、`load_filter`、`overwrite_policy`、`save_after_create` | `asset_path`、`type`、`saved` |
| `data_layer_apply_asset_json` | 按 JSON 创建或更新 DataLayerAsset | `json` 或 `json_file`、`asset_path` | 同 `data_layer_create_asset` |
| `data_layer_create_instance` | 在当前 World 创建 DataLayer instance | `asset_path`、`short_name`、`parent`、`initial_runtime_state`、`initially_visible` | `instance_name`、`asset_path` |
| `data_layer_delete_instance` | 删除当前 World 的 DataLayer instance | `layer`、`transaction` | `deleted`、`layer` |
| `data_layer_set_state` | 编辑 DataLayer instance 状态 | `layer`、`visible`、`loaded_in_editor`、`initially_visible`、`initial_runtime_state`、`short_name` | `changed`、`initial_runtime_state`、`short_name` |
| `data_layer_set_actor_membership` | 设置 Actor 与 DataLayer 的成员关系 | `actor_ids` 或 `folder_root`、`layers[]`、`mode=add|remove|replace|clear` | `matched_count`、`changed_count`、`results[]` |
| `data_layer_validate` | 校验 DataLayer 与 Actor 归属 | `layers[]`、`actor_ids`、`expect_actor_membership[]` | `status`、`issues[]` |

DataLayer 细节：

- `data_layer_query` 的每个 instance 会返回 `asset_path`、`instance_name`、`short_name`、`initial_runtime_state`、`runtime_state` 和 `runtime_state_source`；编辑器安全读回中 `runtime_state` 来自 `initial_runtime_state`，避免在 headless/editor smoke 中触发运行时状态存储访问。
- `data_layer_set_state.short_name` 对 asset-backed DataLayer 可能返回 warning `data_layer_short_name_not_editable`；这不是静默成功，调用方应读 `warnings[]`。
- `data_layer_set_actor_membership` 对 asset-backed layer 使用 Actor 的 `DataLayerAssets` 实际属性做读回校验；`add/remove/replace/clear` 都会返回每个 Actor 的 `before/after/memberships/readback_matches`。
- `clear` 语义是清空目标 Actor 的 DataLayer 归属；如果只想移除部分 layer，应使用 `mode=remove` 并传 `layers[]`。

## World Partition

| 命令 | 作用 | 关键参数 | 返回重点 |
| --- | --- | --- | --- |
| `world_partition_query` | 查询当前 World Partition 状态 | 无 | `available`、`streaming_enabled`、`world_path` |
| `world_partition_set_streaming_enabled` | 修改 World Partition streaming 开关 | `enabled`、`transaction` | `streaming_enabled` |
| `world_partition_load_region` | 通过 bounds 创建并加载 UAI 管理的 region loader | `bounds.center+extent` 或 `bounds.min+max`、`label`、`dry_run` | `loader_id`、`loaded`、`status` |
| `world_partition_unload_region` | 卸载并移除 UAI 管理的 region loader | `loader_id` | `unloaded` |
| `world_partition_load_actors` | 通过 Actor GUID 或已加载 Actor 选择创建 actor list loader | `actor_guids[]` 或 `actor_ids[]`、`dry_run` | `loader_id`、`actor_guid_count`、`loaded` |
| `world_partition_unload_actors` | 卸载 actor list loader | `loader_id` | `unloaded` |
| `world_partition_list_loaded_regions` | 列出 UAI loader 和 UE user loaded regions | 无 | `uai_loaders[]`、`user_loaded_regions[]` |
| `world_partition_check_errors` | 调用 World Partition 错误检查 | 无 | `issues[]`、`issue_count` |
| `world_partition_generate_streaming` | 生成 streaming 数据，默认只返回计划 | `execute`、`allow_commandlet`、`timeout_seconds` | `status`、`commandlet_plan`、执行时的 `exit_code` |
| `world_partition_resave_actors` | 运行 resave actors commandlet，默认只返回计划 | `actor_guids[]`、`execute`、`allow_commandlet`、`timeout_seconds` | `status`、`commandlet_plan` |

World Partition 细节：

- `world_partition_load_region` / `world_partition_load_actors` 创建的是 UAI 会话内 loader；`world_partition_unload_region` / `world_partition_unload_actors` 只卸载对应 `loader_id`。
- `world_partition_generate_streaming` 和 `world_partition_resave_actors` 默认返回 commandlet 计划；真正执行必须显式 `execute=true` 和 `allow_commandlet=true`，超时由 `timeout_seconds` 控制。
- 非 WP 地图会返回 `world_partition_not_enabled`，smoke 会覆盖这一保护路径，避免把非 WP 地图误报为已操作。

## HLOD

| 命令 | 作用 | 关键参数 | 返回重点 |
| --- | --- | --- | --- |
| `hlod_layer_create_json` | 创建或更新 HLOD Layer 资产 | `json` 或 `json_file`、`asset_path`、`overwrite_policy`、`save_after_apply` | `status`、`asset_path`、`layer_type` |
| `hlod_layer_export_json` | 导出 HLOD Layer JSON | `asset_path`、`output_file` | `layer_type`、`cell_size`、`loading_range`、`parent_layer` |
| `hlod_layer_validate_json` | 校验 HLOD Layer JSON | `json` 或 `json_file` | `valid`、`issues[]` |
| `hlod_layer_apply_json` | 按 JSON 创建或回写 HLOD Layer | `json` 或 `json_file`、`asset_path`、`overwrite_policy`、`save_after_apply` | `status`、`property_results[]` |
| `hlod_assign_actors` | 给 Actor 设置 HLOD Layer、Runtime Grid、Spatially Loaded | `actor_ids` 或 `folder_root`、`hlod_layer`、`runtime_grid`、`is_spatially_loaded` | `matched_count`、`changed_count`、`results[]` |
| `hlod_query_actors` | 查询 Actor 的 HLOD/WP 分配 | `actor_ids` 或 `folder_root` | `actors[]`、`actor_results[]` |
| `hlod_build` | 规划或执行 HLOD commandlet 步骤 | `step=stats|setup|build|delete|finalize`、`execute`、`report_only`、`allow_commandlet`、`allow_rhi` | `status`、`commandlet_plan` |
| `hlod_validate_build` | 读取当前场景 HLOD actor 数量和问题列表 | 无 | `hlod_actor_count`、`issues[]` |

HLOD 细节：

- `hlod_layer_validate_json` 会消费 JSON 内或顶层参数中的 `asset_path`，规范化为 long package path；非法路径返回 `hlod_layer_path_invalid`，已有但非 `UHLODLayer` 的资产返回 `hlod_layer_type_mismatch`。
- `hlod_build.step` 只接受 `stats|setup|build|delete|finalize`；非法步骤返回 `hlod_build_step_invalid`。
- `hlod_assign_actors` 与 `level_topology_set_actor_assignments` 会读回 HLOD layer、runtime grid 和 spatially loaded，不能只看属性写入返回。

## 测试覆盖

- `GptProjectTest.UeAgentInterface.Smoke.LevelTopology.StreamingWorkflow`
- `GptProjectTest.UeAgentInterface.Smoke.LevelTopology.DataLayerWorkflow`
- `GptProjectTest.UeAgentInterface.Smoke.LevelTopology.WorldPartitionWorkflow`
- `GptProjectTest.UeAgentInterface.Smoke.LevelTopology.HLODWorkflow`

这些 smoke 通过真实 `/api/exec` 调用覆盖创建、查询、写入、校验、删除或安全降级路径；World Partition 测试会根据当前地图是否启用 WP 自动走实际加载/卸载或 `world_partition_not_enabled` 保护路径。
