# 指令详解：Deformer / ML Deformer / Geometry Cache

## 紧凑返回契约

- 默认 `llm_compact` 的 `data` 只保留 LLM 决策需要的目标标识、关键状态、计数、摘要、warnings/errors 摘要和 artifact / 文件路径。
- 完整读回、大对象、长列表、编译日志、像素/帧/点数据、raw property metadata、诊断栈和内部中间状态默认不进入 `data`；需要时通过 `response_options` 的 debug/raw 视图、显式请求字段或外置 artifact 获取。
- 本分册中的旧局部参数、历史别名或原子入口只作为 alias / 兼容路径；新 authoring 应优先使用本分册推荐的 JSON、folder、统一 viewport、probe 或 domain 专用入口。


本分册覆盖角色顶点变形链路中版本敏感的资产：Geometry Cache、Deformer Graph、Deformer Source Library、Mesh Deformer Collection、ML Deformer。

## 返回契约

- Python wrapper 返回 `CommandResult`：业务结果在 `data`，诊断细节在 `debug`，原始响应在 `envelope`。LLM 默认读取 `data`，只有显式调试时读取 `debug/envelope`。
- 默认紧凑返回只保留资产路径、JSON / folder 路径、资产 class、插件状态、关键计数、导入/编译/训练/校验状态、warnings 摘要和必要 artifact 路径。
- shader、compile log、training log、diagnostics、validation report、property_results、readback diff、raw_properties、Geometry Cache 帧采样、Deformer graph/kernels/data interfaces/source libraries、ML training inputs 等大对象默认不进入 `data` 全量展开；完整内容放入 `debug`、`envelope` 或文件/folder 产物。
- `properties[]`、`graphs[]`、`nodes[]`、`pins[]`、`samples[]`、`tracks[]`、`materials[]`、`validation_issues[]`、`diagnostics[]` 等大列表默认分页、限制数量或摘要化。
- Geometry Cache 截帧默认返回 headless 采样摘要和截图/采样产物路径；不内联顶点帧、索引缓冲或图片内容。
- ML Deformer 训练相关命令默认只返回训练输入校验、训练状态或日志尾部摘要；长日志和训练诊断必须走 `debug` 或 artifact。
- 如需完整诊断，调用方显式传 `response_options.view=debug` 或等价调试选项。

原则：

- Deformer / ML Deformer 先读插件状态、UE 版本、asset class 和真实属性，再编辑。
- 不用普通 JSON 手写 Geometry Cache 顶点帧、Deformer kernel/HLSL 大图、ML 训练产物。
- 可回写的通用 UObject 属性统一走 `asset_apply_property_json` 同一套解析、读回和 `property_results[]` 诊断。
- Deformer / ML 训练和 shader 编译是显式动作；apply JSON 不会隐式触发长训练。

## Geometry Cache / Alembic

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `asset_import_geometry_cache` | 通过 UE 自动导入管线导入 Geometry Cache / Alembic | `source_file`、`destination_path` |
| `geometry_cache_get_info` | 读取 Geometry Cache 资产摘要 | `asset_path` |
| `geometry_cache_validate_against_skeletal_mesh` | 校验 Geometry Cache 与 SkeletalMesh 引用关系 | `geometry_cache` 或 `geometry_cache_path`、`skeletal_mesh` 或 `skeletal_mesh_path` |
| `geometry_cache_screenshot_frame` | 无 UI 读取指定帧/时间的 Geometry Cache 采样摘要 | `asset_path`、`frame_index` 或 `time_seconds` |

`geometry_cache_screenshot_frame` 不伪造截图、不拉起资产预览窗口。它会按 `frame_index` 或 `time_seconds` 读取 `GeometryCache::GetMeshDataAtTime` 的结构化帧采样，并返回：

- `capture_status=headless_frame_sample`
- `visual_screenshot_available=false`
- `sample.time_seconds`、`sample.frame_index`
- `sample.meshes[]`、`total_vertex_count`、`total_index_count`、`total_triangle_count`
- `has_normals`、`has_uvs`、`bounds`
- `validation_issues[]`、`validation_error_count`、`validation_passed`

需要视觉检查时，把 Geometry Cache 放入预览场景或关卡，正常推进预览时间后再走 viewport screenshot。

`geometry_cache_get_info` 会直接读取 UE GeometryCache API，并返回：

- `frame_start`、`frame_end`、`frame_count`、`duration`、`hash`
- `track_count`、`tracks[]`
- `material_count`、`materials[]`
- `sampled_times[]`、`samples[]`
- `vertex_count_per_track`、`triangle_count_per_track`
- `topology_constant` 与 `topology_sample_policy`，当前按 start/mid/end 的 mesh 数、顶点数和索引数比较
- `has_normals`、`has_uvs`、`bounds`
- `import_file`
- `validation_issues[]`

如果 `asset_path` 指向的不是 Geometry Cache，命令返回硬错误 `asset_is_not_geometry_cache`，不会把其他资产伪装成 Geometry Cache 摘要。

`geometry_cache_validate_against_skeletal_mesh` 会返回：

- `geometry_cache_found`、`skeletal_mesh_found`
- `geometry_cache_class`、`skeletal_mesh_class`
- `geometry_cache_vertex_count`、`skeletal_mesh_lod0_vertex_count`
- `compatible_with_skeletal_mesh`
- `validation_issues[]`、`validation_error_count`、`validation_passed`

该验证只做自动化层可稳定读取的类型和顶点数校验；完整变形语义仍取决于 DCC 导出、Alembic/GeometryCache 导入设置、ML Deformer 模型类型和采样绑定。

## Deformer Graph Folder Workflow

推荐流程：

`deformer_graph_create -> deformer_graph_export_folder -> 修改 details/index.json 指向的 details/<group>.json#/fields[] -> deformer_graph_validate_folder -> deformer_graph_apply_folder -> deformer_graph_export_folder 读回`

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `deformer_graph_create` | 创建空 Deformer Graph 资产 | `asset_path`；可选 `class_path`、`save_after_create` |
| `deformer_graph_get_info` | 读取 Deformer Graph 摘要 | `asset_path` |
| `deformer_graph_export_folder` | 导出 Deformer Graph 文件夹式 JSON | `asset_path`、`folder_path` |
| `deformer_graph_validate_folder` | 校验文件夹 JSON 解析、插件状态和结构化摘要 | `folder_path` |
| `deformer_graph_apply_folder` | 应用 grouped Details 字段改动；`raw_properties.json` 只作诊断快照，不作为编辑入口 | `folder_path`；可选 `dry_run`、`validate_only`、`save_after_apply` |
| `deformer_graph_compile` | 调用 Optimus `Compile()` 并返回同步编译诊断 | `asset_path` |
| `deformer_graph_get_compile_log` | 返回当前 Optimus 编译状态快照 | `asset_path` |

导出结构：

- `asset.json`：资产身份、class、engine version、plugin_status、property_summary。
- `settings.json`：Optimus Deformer 状态、预览网格、Graph/Resource/Variable/Binding 数量和属性摘要。
- `resources.json`、`variables.json`、`bindings.json`：真实 Optimus Resource、Variable、Component Binding 摘要。
- `graphs.json`：真实 Optimus Graph、Node、Pin、Link 的只读摘要。
- `kernels.json`：实现 compute-kernel / shader-text provider 的节点、执行域、shader 文本和声明摘要；长文本会截断并带 `*_truncated`。
- `data_interfaces.json`：实现 data-interface provider 的节点摘要。
- `source_libraries.json`：Deformer 内 Function Graph 摘要。
- `raw_properties.json`：旧诊断快照。仅用于显式迁移或 debug/readback 识别，不作为当前 apply/edit 输入。
- `readonly_properties.json`：只读属性摘要。
- `validation/*.json`：coverage、compile、shader、binding、readback、diagnostics。

`deformer_graph_validate_folder` 和 `deformer_graph_apply_folder` 都会先解析文件夹内所有已存在的 JSON 文件，并在任何 error 级 `json_issues[]` 出现时失败。`settings.json`、`resources.json`、`variables.json`、`data_interfaces.json`、`kernels.json`、`graphs.json`、`bindings.json`、`source_libraries.json`、`readonly_properties.json` 和 `validation/*.json` 是摘要/只读文件；如果这些文件里出现 `apply/remove/delete/operations` 等明确写意图，会返回 `unsupported_apply_profile`。`deformer_graph_apply_folder` 在回写 `raw_properties.json` 前会先跑完整 folder validation，避免在文件夹已经有错误时发生部分写入。

边界说明：

- 文件夹导出已经覆盖 Optimus 的可稳定读取结构，但 `graphs.json / kernels.json / data_interfaces.json` 是只读摘要；不从摘要 JSON 反推创建/删除节点、连线或修改 HLSL。
- 深层 Graph mutation 必须走专门的 Optimus adapter，避免把节点图结构当普通属性误写。
- `deformer_graph_compile` 会真实调用 `UOptimusDeformer::Compile()`，返回 `compile_invoked`、`compile_returned_ok`、`deformer_status`、`diagnostics[]`。UE 的 shader 编译可能异步返回，命令只保证同步 Optimus graph compile diagnostics。
- `coverage_report.json` 的 `adapter_boundaries[]` 会列出深层节点图 mutation、异步 shader diagnostics、runtime readback diff 等边界；这些边界不会伪装成空 `items=[]` 的完成状态。

通用属性项格式：

```hjson
{
  property_path: SomeProperty
  value_kind: float
  value: {literal: 1.0}
}
```

如果属性是支持的 UE 曲线类型，`value_kind` 为 `curve`，`value` 使用公共曲线 schema；apply 会复用同一 codec 和 `json_issues[]` 诊断。

## Deformer Source Library / Mesh Deformer Collection

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `deformer_source_library_create` | 创建具体 Source Library 类资产 | `asset_path`、`class_path`、可选 `save_after_create` |
| `deformer_source_library_export_json` | 导出单文件属性 JSON | `asset_path`；可选 `output_file` |
| `deformer_source_library_validate_json` | 校验单文件 JSON | `json_file` 或内联 JSON |
| `deformer_source_library_apply_json` | 应用显式 `apply=true` 的属性项 | `json_file` 或内联 JSON；可选 `dry_run`、`validate_only`、`save_after_apply` |
| `mesh_deformer_collection_create` | 创建 Mesh Deformer Collection | `asset_path`；可选 `class_path`、`save_after_create` |
| `mesh_deformer_collection_export_json` | 导出 Collection 单文件属性 JSON | `asset_path`；可选 `output_file` |
| `mesh_deformer_collection_validate_json` | 校验 Collection JSON | `json_file` 或内联 JSON |
| `mesh_deformer_collection_apply_json` | 应用显式 `apply=true` 的属性项 | `json_file` 或内联 JSON；可选 `dry_run`、`validate_only`、`save_after_apply` |

Source Library 的具体类随插件/UE 版本变化，`create` 必须显式传 `class_path`。如果类不可用，返回会带 `plugin_status` 和候选状态，不会假装成功。

`deformer_source_library_validate_json/apply_json`、`mesh_deformer_collection_validate_json/apply_json`、`ml_deformer_validate_json/apply_json` 都要求输入来自对应 `*_export_json` 生成的专用属性 JSON。命令会校验 `profile`、`asset_class` 和目标资产真实 class；缺少这些字段、profile 不匹配、或者把 StaticMesh/SkeletalMesh 这类其它资产的通用属性 JSON 塞给 Deformer 专用命令，都会返回 `json_missing_required_field`、`json_profile_mismatch`、`json_asset_class_mismatch` 或 `asset_is_not_*`，并在返回中带 `expected_profile`、`error_count`、`warning_count`。通用 UObject 属性仍然可以用 `asset_export_property_json -> asset_apply_property_json`，但不要用 Deformer 专用命令伪装成通用属性入口。

## ML Deformer

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `ml_deformer_create` | 创建可用的 ML Deformer 模型资产 | `asset_path`；可选 `class_path`、`save_after_create` |
| `ml_deformer_get_info` | 读取模型资产摘要 | `asset_path` |
| `ml_deformer_export_json` | 导出单文件属性 JSON 和训练输入/参数反射摘要 | `asset_path`；可选 `output_file` |
| `ml_deformer_validate_json` | 校验 JSON 与属性候选项 | `json_file` 或内联 JSON |
| `ml_deformer_apply_json` | 应用显式 `apply=true` 的属性项，不启动训练 | `json_file` 或内联 JSON；可选 `dry_run`、`validate_only`、`save_after_apply` |
| `ml_deformer_validate_training_inputs` | 校验训练输入资产、骨架、拓扑和时长一致性 | `skeletal_mesh`、`training_anim_sequence`、`target_geometry_cache`、可选 `deformer_graph`、`duration_tolerance_seconds`、`strict_duration_match` |
| `ml_deformer_get_training_log` | 读取训练日志尾部 | `log_file` |
| `ml_deformer_train` | 显式训练入口状态/保护 | `confirm_long_running_training` |
| `ml_deformer_preview` | 返回当前 preview adapter 状态 | `asset_path` |

训练和预览边界：

- `ml_deformer_apply_json` 只写配置属性，不训练。
- `ml_deformer_export_json` 的 `training_inputs`、`training_parameters` 是按模型资产属性做出的反射摘要，不再输出空占位。
- `ml_deformer_train` 必须显式调用，当前仍只报告 `training_adapter_not_available`，不会在未确认模型类、插件、数据集、GPU/训练环境时启动长任务。
- `ml_deformer_preview` 当前只报告 `preview_adapter_not_available`；预览需要模型专用 adapter 或运行时场景承载。
- UeAgentInterface 默认不强制启用 `MLDeformerFramework / NearestNeighborModel / NeuralMorphModel / VertexDeltaModel`，避免在普通编辑器启动时触发模型插件的 Python/训练依赖安装；需要训练或模型专用创建时，由项目显式启用对应插件，命令会通过 `plugin_status` 和 `candidate_classes` 报告可用性。
- 训练失败应通过 `ml_deformer_get_training_log` 和后续模型专用 adapter 返回结构化日志。

`ml_deformer_validate_training_inputs` 会返回：

- `inputs[]`：每个输入资产的路径、是否必填、是否找到、实际 class、期望 class、类型是否正确。
- `skeleton_check`：`skeletal_mesh_skeleton`、`animation_skeleton`、`compatible`。
- `topology_check`：`skeletal_mesh_lod0_vertex_count`、Geometry Cache start/mid/end 顶点数、是否可比较、顶点数是否匹配。
- `timing_check`：训练动画时长、Geometry Cache 时长、差值、容差、是否严格匹配。
- `validation_issues[]`、`validation_error_count`、`validation_warning_count`、`validation_passed`。

默认情况下，时长不匹配超过 `duration_tolerance_seconds` 会返回 warning；传 `strict_duration_match=true` 时作为 error。模型专用训练语义仍由后续 ML Deformer adapter 做最终判断。

## 通用返回字段

这些命令会尽量返回：

- `plugin_status`：`GeometryCache / AlembicImporter / DeformerGraph / MLDeformerFramework / NearestNeighborModel / NeuralMorphModel / VertexDeltaModel` 等插件状态。
- `engine_version`
- `asset_class`
- `property_summary` 或 `properties[]`
- `json_issues[] / json_issue_count`
- `property_apply.property_results[]`
- `selected_property_count`
- `applied / dry_run`

把 `json_parse_failed`、`json_missing_required_field`、`property_not_found`、`property_value_kind_mismatch` 和 `property_value_decode_failed` 当硬失败处理；正常 authoring 不使用文本导入或文本规范化结果判定成功。
