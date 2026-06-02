# 指令详解：PCG

本分册覆盖 Procedural Content Generation 的 Graph 资产、GraphInstance、组件、WorldActor / PartitionActor、生成、清理、运行时探针、Inspection、数据导出、GPU/HLSL 诊断和 Level To Asset。PCG 的默认 authoring 入口是文件夹式 JSON：先导出 UE 实际 Graph 结构，再在模板上修改，最后 validate / diff / apply / snapshot 读回。文件夹结构细节见 `30_PCG_FolderFormat.md`。

## 标准工作流

```text
pcg_capabilities_query
pcg_node_catalog_export
pcg_graph_export_folder
pcg_graph_validate_folder
pcg_graph_diff_folder
pcg_graph_apply_folder
pcg_graph_compile
pcg_graph_snapshot
pcg_graph_layout
pcg_component_apply_json
pcg_generate
pcg_wait
pcg_data_export_json
```

关键原则：

- Graph 结构用 `pcg_graph_*_folder`，不要用零散属性命令拼完整 PCG Graph。
- Graph 编辑器排布用 `pcg_graph_layout`；它只是 PCG 专用入口，底层沿用 `node_graph_layout` 和 Blueprint layout kernel。
- 组件绑定和生成状态用 `pcg_component_*`、`pcg_generate`、`pcg_cleanup`、`pcg_generation_status`。
- 运行结果用 `pcg_inspection_set`、`pcg_node_inspect`、`pcg_data_export_json`、`pcg_data_assert_json` 做读回。
- GPU / HLSL 相关能力通过 `pcg_gpu_capabilities_query`、`pcg_compute_graph_validate`、`pcg_hlsl_validate` 做显式诊断。

## Graph 文件夹结构

```text
PCG_MyGraph/
  asset.json
  graph.json
  nodes/
    index.json
    __input__.json
    __output__.json
    Scatter.json
    SpawnMesh.json
  validation/
    coverage_report.json
```

`asset.json` 记录资产路径、对象路径和资产类。`graph.json` 记录节点、连线、Graph 设置和节点属性。`nodes/*.json` 是每个节点的可读拆分文件，便于 diff 和人工编辑。`validation/coverage_report.json` 记录导出覆盖范围。

## 指令列表

| 指令 | 作用 | 关键参数 | 典型用途 |
|---|---|---|---|
| `pcg_capabilities_query` | 返回 PCG UAI 能力、RHI、可用命令 | 无 | 调度前探测 |
| `pcg_node_catalog_export` | 导出可用 `UPCGSettings` 节点目录 | `output_file`, `include_deprecated` | 选节点类、查 pin 和 GPU 能力 |
| `pcg_asset_info` | 读取 PCG Graph / GraphInstance / DataAsset 概览 | `asset_path` | 资产读回和诊断 |
| `pcg_graph_export_folder` | 导出 `UPCGGraph` 文件夹式 JSON | `asset_path`, `folder_path` | 获取可编辑模板 |
| `pcg_graph_validate_folder` | 校验 PCG Graph 文件夹 | `folder_path` | apply 前阻断坏结构 |
| `pcg_graph_plan_folder` | 生成 apply 计划 | `folder_path`, `asset_path` | dry-run 和审查 |
| `pcg_graph_diff_folder` | 比较目标文件夹与现有 Graph 摘要差异 | `folder_path`, `asset_path` | apply 前确认变化 |
| `pcg_graph_apply_folder` | 从文件夹式 JSON 创建或更新 `UPCGGraph` | `folder_path`, `asset_path`, `dry_run`, `replace_nodes`, `save` | Graph authoring 主入口 |
| `pcg_graph_compile` | 重新编译 Graph 并 prime compilation cache | `asset_path` | apply 后验证 |
| `pcg_graph_snapshot` | 返回 Graph 当前结构 JSON | `asset_path` | 写后读回 |
| `pcg_graph_layout` | 自动排布 PCG Graph Editor 节点 | `asset_path`, `graph_selector`, `layout_options`, `save_after_layout`/`save`, `compile_after_layout` | 复用通用节点图/Blueprint 排布核心整理 PCG 图 |
| `pcg_graph_instance_json` | 创建/更新/读取 GraphInstance | `asset_path`, `create`, `graph`, `parameters[]`, `save` | 参数化 Graph 实例 |
| `pcg_graph_parameters_query` | 查询 Graph 或 GraphInstance 参数包 | `asset_path` | 查看 user parameters |
| `pcg_graph_parameters_apply_json` | 写入 Graph 或 GraphInstance 参数包 | `asset_path`, `parameters[]`, `save` | 参数增改 |
| `pcg_component_query` | 查询关卡内 PCGComponent | `actor`, `component` | 组件状态读回 |
| `pcg_component_apply_json` | 创建或更新 Actor 上的 PCGComponent | `actor`, `component`, `graph`, `seed`, `partitioned`, `generation_trigger`, `properties[]` | 绑定 Graph 到关卡 Actor |
| `pcg_component_snapshot_json` | 返回组件快照 | `actor`, `component` | 与 query 同语义的 snapshot 入口 |
| `pcg_world_actor_query` | 查询 PCGWorldActor | 无 | 查看分区网格和 runtime source |
| `pcg_world_actor_apply_json` | 创建或更新 PCGWorldActor 设置 | `partition_grid_size`, `enable_world_partition_generation_sources`, `treat_editor_viewport_as_generation_source` | 配置 PCG 分区环境 |
| `pcg_partition_probe` | 查询 APCGPartitionActor 状态 | 无 | World Partition / partitioned PCG 诊断 |
| `pcg_generate` | 调度 PCG 生成 | `actor`, `component`, `force`, `generation_trigger`, `wait` | 生成内容 |
| `pcg_cleanup` | 调度 PCG 清理 | `actor`, `component`, `remove_components` | 清理生成结果 |
| `pcg_regenerate` | cleanup 后 generate | `actor`, `component`, `force` | 重生成 |
| `pcg_cancel_generation` | 取消生成 | `actor`, `component` | 停止长任务 |
| `pcg_generation_status` | 查询生成/清理状态 | `actor`, `component` | 轮询 |
| `pcg_wait` | 等待生成/清理结束 | `actor`, `component`, `timeout_seconds` | 自动化收敛 |
| `pcg_runtime_generation_probe` | 查询 runtime generation 关键状态 | `actor`, `component` | runtime PCG 诊断 |
| `pcg_inspection_set` | 开关并可清空 Inspection | `actor`, `component`, `enabled`, `clear` | 节点执行读回前准备 |
| `pcg_node_inspect` | 读取节点结构与 Inspection 标记 | `actor`, `component`, `node` | 节点级诊断 |
| `pcg_data_export_json` | 导出组件生成数据摘要 | `actor`, `component`, `output_file`, `max_points_per_data` | 点数、pin、tag、样本验证 |
| `pcg_data_assert_json` | 对生成数据做阈值断言 | `actor`, `component`, `min_data_count`, `min_total_point_count` | smoke / 回归断言 |
| `pcg_component_runtime_probe` | 组件 runtime probe 兼容入口 | `actor`, `component` | 与 runtime_generation_probe 等价 |
| `pcg_screenshot` | 复用安全 viewport 截图并可先 frame actor | `actor`, `format`, `max_size`, `output_file` | 视觉证据 |
| `pcg_profile_report` | 输出 Graph 静态复杂度或组件运行态摘要 | `asset_path` 或 `actor/component` | 性能 triage 起点 |
| `pcg_gpu_capabilities_query` | 查询 RHI、ComputeFramework、GPU 节点能力 | 无 | GPU PCG 前置检查 |
| `pcg_compute_graph_validate` | 检查 Graph 内 GPU 执行节点 | `asset_path` | GPU Graph 诊断 |
| `pcg_hlsl_validate` | 检查 HLSL/Compute 类节点摘要 | `asset_path` | Custom HLSL 排查 |
| `pcg_data_asset_export_json` | 导出 `UPCGDataAsset` 摘要 | `asset_path`, `max_points_per_data` | Level To Asset 结果读回 |
| `pcg_data_asset_apply_json` | 创建或更新 `UPCGDataAsset` 元数据 | `asset_path`, `create`, `name`, `object_path_source`, `category`, `description`, `save` | DataAsset 管理 |
| `pcg_level_to_asset_export` | 调用 UE PCG Level To Asset 导出 | `asset_path`, `save` | 将当前关卡导出成 PCGDataAsset |

## 运行数据导出语义

`pcg_data_export_json` / `pcg_data_asset_export_json` 会把 `FPCGDataCollection` 中每个 `TaggedData` 导出为 `data[]`，并汇总 `data_count`、`point_data_count`、`total_point_count`。点数据识别必须覆盖 UE 5.6+ 的 `UPCGBasePointData` 族，包括传统 `UPCGPointData` 与 `UPCGPointArrayData`；不能只按 `UPCGPointData` cast，否则 Spline Sampler、Transform Points、Static Mesh Spawner 等常见节点生成的点流会被误报为 0 点。

`point_samples[]` 使用 `UPCGBasePointData` 的 `GetTransform / GetDensity / GetSeed / GetBoundsMin / GetBoundsMax` 读回，调用方可用 `max_points_per_data` 控制样本量。自动化验收建议在 `pcg_generate -> pcg_wait` 后再调用 `pcg_data_export_json` 和 `pcg_data_assert_json`，用 `min_total_point_count` 检查真实生成结果。

## PCG 图排布语义

`pcg_graph_layout` 是 PCG 专用包装入口，内部委托 `node_graph_layout`，adapter 固定为 `generic_edgraph`，实际布局仍进入同一套 Blueprint layout kernel。PCG Graph 当前可被枚举为 `/Script/PCGEditor.PCGEditorGraph`；冷启动只加载 `UPCGGraph` 时，编辑器图可能尚未物化，命令会先打开/复用 PCG 资产编辑器并 tick Slate，确认 `UEdGraph` 子图存在后再委托通用排布。后续几何采集仍使用离屏 `SGraphEditor`，返回 `geometry_used_offscreen_graph_editor=true`、`used_real_geometry=true`、`nodes[]`、`edges[]`、`metrics_before/after` 等通用字段。

常用参数：

- `asset_path` / `graph` / `graph_asset_path`：目标 `UPCGGraph`。
- `graph_selector`：透传给 `node_graph_layout`。通常 PCG 资产只有一张 `PCGEditorGraph_*`，可省略；多图或需要稳定指定时先用 `node_graph_list` 读取 `graph_path`。
- `layout_options`：透传通用 `horizontal_spacing`、`vertical_spacing`、`node_padding`、`origin_x`、`origin_y`、`insert_reroute_nodes`、`replace_existing_reroute_nodes`。
- `save_after_layout` 或兼容别名 `save`：是否保存 Graph 资产。若同时启用 `compile_after_layout`，命令会在编译后再次保存，避免编译刷新把资产重新置脏。
- `compile_after_layout` 或兼容别名 `compile`：布局完成后执行 `pcg_graph_compile`。

返回字段会额外包含：

- `schema=ue_agent_interface.pcg.graph_layout.v1`
- `delegated_command=node_graph_layout`
- `pcg_graph_layout_strategy=shared_node_graph_blueprint_layout_core`
- `pcg_graph_layout_complete`：等同底层 `layout_design_complete`。
- `pcg_editor_graph_had_materialized_edgraph_before_init`、`pcg_editor_graph_opened_editor_for_init`：用于判断本次是否为冷启动初始化 PCG 编辑器图。
- `saved_after_compile`：仅当 `save_after_layout=true` 且 `compile_after_layout=true` 时出现，表示编译后的最终保存是否完成。

PCG 图常见 fanout 分支可能让通用 layout core 返回 `layout_design_complete=false` 且 `inter_island_topological_x` 为 partial；只要 `metrics_after.overlap_count=0`、`metrics_after.backward_edge_count=0`、`route_through_island_count=0`，该布局仍可作为 PCG 编辑器节点排布使用。若后续需要 PCG 专用 reroute 节点写回，应先扩展 `PCGEditorGraph` adapter，不能绕开通用 kernel 另写一套 rank/layout。

## PCG 截图语义

`pcg_screenshot` 是 `viewport_frame_actor` + `screenshot_viewport` 的组合入口。取景目标支持 `id`、`actor`、`actor_name`、`actor_label`；传入 `actor*` 字段时会映射为 viewport framing 需要的 `id`，再执行截图。截图结果仍走通用 viewport 截图返回结构，并可通过 `output_file` 持久化。输出图片默认归一为不透明 alpha，避免 PNG 在深色 UI 或报告中被透明合成为黑图。

## 参数包格式

`pcg_graph_parameters_apply_json`、`pcg_graph_instance_json` 以及 `pcg_graph_export_folder` / `pcg_graph_apply_folder` 中 `graph.json.parameters.parameters[]` 使用同一参数包结构：

```json
[
  {
    "name": "Density",
    "type": "Float",
    "value_text": "0.5"
  }
]
```

支持的 `type` 对应 `EPropertyBagPropertyType`，常用值包括 `Bool`、`Int32`、`Float`、`Double`、`Name`、`String`、`Text`、`Object`、`SoftObject`、`Class`、`SoftClass`、`Struct`。数组或 set 参数使用 `container_types`，兼容单层 `container_type`；例如官方 Shape Grammar 栅栏 Graph 的 `ModuleInfo` 是 `Struct + Array + /Script/PCG.PCGSubdivisionSubmodule`，`MeshInfo` 是 `Object + Array + /Script/Engine.StaticMesh`。复杂类型应优先从 `pcg_graph_parameters_query` 或 `pcg_graph_export_folder` 导出模板后修改 `value_text`。

Graph 参数包可以新增或重建参数描述；GraphInstance 参数包只允许覆盖父 Graph 已存在的参数。如果 GraphInstance 参数不存在于父 Graph，命令返回 `unknown_parameter`，不会向 UE 传入无效参数名触发 PCG 断言。folder apply 会和节点/边写入一起通过 transient preflight，因此缺失 `type_object`、坏 container 或参数 import text 会在真实资产修改前失败。

## 返回和失败语义

写入类命令返回 `issues[]`、`error_count`、`created`、`saved`、`applied_*_count`。`error_count > 0` 时命令失败。`pcg_graph_apply_folder` 在写入真实资产前会先执行 folder validation 和 transient graph preflight；坏节点类、坏边、坏属性导入会在真实资产变更前阻断。Graph / GraphInstance 参数和 PCGComponent 属性同样会先做 preflight，避免坏参数或坏属性造成半写入。`generation_trigger` 必须是 UE 枚举名或 `on_demand/runtime/load` 兼容别名，非法值会失败而不是静默回退。生成类命令返回 `task_id` 和组件快照。`pcg_wait` 会在同步等待期间推进 `UPCGSubsystem`，确保 UAI HTTP 命令占用主线程时 PCG GraphExecutor 仍可完成；超时时返回 `timed_out=true` 并失败，调用方应先用 `pcg_generation_status` 或日志判断是否需要继续等待。

截图仍走已有 crash-guarded viewport 截图路径；PCG 专属命令只负责可选 frame actor 和把截图 artifact 元数据挂回返回 JSON。
