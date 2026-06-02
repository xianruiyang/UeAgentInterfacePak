# 指令详解：StaticMesh / EnhancedInput

> 废弃写入命令已迁移到 `deprecatedCommand/04_StaticMesh_EnhancedInput.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

## StaticMesh

### StaticMesh 文件夹式 JSON 主流程

StaticMesh 的长期 authoring 主流程是：

`static_mesh_export_folder -> 修改导出的 JSON -> static_mesh_validate_folder -> static_mesh_apply_folder -> 再导出读回`

不要用普通 JSON 手写 vertex/index/UV/Nanite 内部数据。raw geometry、UV channel、Nanite cluster、distance field 等只导出摘要、统计和校验报告；真正重建走 FBX/建模/Geometry Script 或 UE 专用构建 API。

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `static_mesh_export_folder` | 导出 StaticMesh 文件夹式 JSON | `asset_path`；可选 `folder_path` | 生成真实结构模板 |
| `static_mesh_validate_folder` | 只读校验导出的文件夹 JSON | `folder_path`；可选 `asset_path`、`dry_run` | apply 前检查坏 JSON、未知字段和越界值 |
| `static_mesh_apply_folder` | 应用文件夹 JSON 中的安全字段 | `folder_path`；可选 `asset_path`、`dry_run`、`validate_only`、`build_after_apply`、`save_after_apply` | 回写材质、socket、simple collision、lightmap、Nanite 安全设置 |
| `static_mesh_validate_geometry` | 读取 raw geometry 摘要和 section 校验 | `asset_path` | 检查顶点/三角/section 统计，不修改资产 |
| `static_mesh_validate_uvs` | 读取 UV/lightmap 摘要 | `asset_path` | 检查 lightmap 坐标、UV channel 数 |
| `static_mesh_reimport` | 自动化重导入 StaticMesh | `asset_path`；可选 `source_filename`、`save_after_reimport`、`show_notification` | 使用 UE reimport handler 从源文件重建资产 |
| `static_mesh_build` | 显式触发 StaticMesh build | `asset_path` | 修改 Nanite/build settings 后显式构建 |
| `static_mesh_preview_collision` | 无 UI 读取碰撞预览数据 | `asset_path` | 返回 simple collision、bounds 和建议 trace/sweep/overlap 验证命令 |

导出结构：

- `asset.json`：资产身份、class、engine version。
- `mesh.json`：LOD/material/socket/collision/lightmap/Nanite 总览，可安全回写 `allow_cpu_access`、`lightmap_resolution`、`lightmap_coordinate_index`。
- `materials.json`：材质槽、slot name、material 引用；可回写材质和 slot name。
- `lods/index.json`、`sections.json`：LOD 与 section 摘要，raw mesh 不回写。
- `collision.json`：`boxes[] / spheres[] / capsules[]` 与 `collision_complexity`；可回写简单碰撞。`convex_hulls: []` 或 `clear_convex_hulls=true` 用于清理已有凸包碰撞；非空 `convex_hulls[]` 创建凸包仍属于不支持的几何重建入口，会在 validate/apply 前返回 `unsupported_apply_profile`。
- `sockets.json`：创建、更新、删除 socket；默认 `replace_all=true`，即 JSON 中的非删除 socket 列表代表最终状态，apply 会移除未列出的旧 socket。需要局部 patch 时可显式写 `replace_all=false`。
- `lightmap_uv.json`、`nanite.json`、`build_settings.json`：外围设置与摘要。
- `import_data.json`：导入源文件追踪，包含 `first_filename`、`source_files[]`、`source_filenames[]`、`source_file_count`、`can_reimport`，用于 reimport 前验证。
- `raw_mesh_summary.json`、`readonly_properties.json`：只读摘要。
- `validation/*.json`：coverage、geometry、collision、UV、lightmap、Nanite、diagnostics 与 readback diff。

`static_mesh_apply_folder` 返回 `json_issues[]`、`property_results[]`、`readback` 和 `validation_report`。文件存在但 JSON 解析失败会直接失败；数组坏项、未知字段、缺必填字段会带完整 JSON path。

`static_mesh_validate_folder` 和 `static_mesh_apply_folder` 都会先解析文件夹内所有已存在的可选 JSON 文件；只有文件不存在才会按可选文件跳过。只要出现 error 级 `json_issues[]`，命令就返回失败，不会继续静默写入。`lods/index.json`、`sections.json`、`lightmap_uv.json`、`build_settings.json`、`import_data.json`、`raw_mesh_summary.json`、`raw_properties.json`、`readonly_properties.json` 和 `validation/*.json` 在 StaticMesh folder workflow 中属于摘要、只读或非主 authoring 入口；如果这些文件里出现 `apply/remove/delete/operations` 等明确写意图，会返回 `unsupported_apply_profile`。需要改通用 UObject 属性时，走 `asset_export_property_json -> asset_apply_property_json`，不要把写意图塞进 StaticMesh folder 的摘要文件里。

`static_mesh_apply_folder` 写入 `collision.json` 时会同时对 `UStaticMesh` 和 `UBodySetup` 调用事务修改并刷新碰撞数据，因此可以替代旧 simple collision 原子写入入口在编辑器 dirty、撤销和读回上的副作用。

`static_mesh_apply_folder` 写入 `sockets.json` 时会对 `UStaticMesh` 和已有 `UStaticMeshSocket` 调用事务修改。默认全量替换 socket 集合，以保证 `export_folder -> apply_folder` 可以恢复到导出时的 socket 状态；如果只想做增量创建/更新/删除，显式设置 `replace_all=false`。

`static_mesh_reimport` 不弹文件选择框；如果传 `source_filename`，该文件必须存在，并作为强制新源文件。返回 `can_reimport`、`source_filenames[]`、`reimport_status`、`readback`。失败时不会把 `cannot_reimport` 或 `source_file_not_found` 静默吞掉。

`static_mesh_preview_collision` 是 headless 预览命令，不负责打开 StaticMesh 编辑器截图。它用于把 collision 数据结构化返回；真实场景行为仍应再用 `level_trace_world_ray`、`level_sweep_capsule` 或 `level_check_overlaps` 验证。

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `static_mesh_open_editor` | 打开静态网格编辑器 | `asset_path` | 进入网格编辑上下文 |
| `static_mesh_get_info` | 读取网格信息（含 bounds / socket / 碰撞 / 预览） | `asset_path` | 修改前读取整体状态 |
| `static_mesh_get_bounds` | 只读取静态网格 bounds | `asset_path` | 供脚本直接拿宽高深与中心 |
| `static_mesh_get_local_corners` | 读取局部包围盒 8 个角点 | `asset_path` | 做拼装、特征点对齐、预估占地 |
| `static_mesh_set_preview_view` | 设置网格编辑器预览相机 | `asset_path`、`yaw`、`pitch`、`distance`、`fov` | 多角度检查模型 |

### `static_mesh_get_bounds` 与 `static_mesh_get_local_corners`

- `static_mesh_get_info` 原本已经包含 `bounds`
- 新增这两个命令的目的，是让脚本在批量搭建和对齐时少解析无关字段

建议：

- 只想知道模型尺寸、中心、包围盒：用 `static_mesh_get_bounds`
- 想做角点级几何判断：用 `static_mesh_get_local_corners`
- 想看完整网格摘要：用 `static_mesh_get_info`

### `static_mesh_get_info`

当前还会返回：

- `material_slot_count`
- `material_slots[]`
  - `slot_index`
  - `slot_name`
  - `imported_slot_name`
  - `material_path`
  - `overlay_material_path`
- `collision.spheres[]`
- `collision.capsules[]`

### 简单碰撞补充

- `static_mesh_apply_folder` 中的 `boxes[] / spheres[] / capsules[]` 是全量替换各自数组，不是追加。
- 需要清理凸包时，在 `collision.json` 中写 `convex_hulls: []` 或 `clear_convex_hulls=true`。
- `capsules[].length` 是胶囊中间圆柱段长度，不含两端半球。

## EnhancedInput

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `enhanced_input_create_action` | 创建 `InputAction` | `asset_path`、`value_type` | 新建 Move / Look / Jump 动作 |
| `enhanced_input_get_action_info` | 读取 `InputAction` 信息 | `asset_path` | 校验值类型与触发配置 |
| `enhanced_input_export_action_json` | 导出 `InputAction` 单文件 JSON | `asset_path`；可选 `output_file` | 把小型 Action 资产拉成单个真源 JSON |
| `enhanced_input_apply_action_json` | 从单文件 JSON 回写 `InputAction` | `json_file`；可选 `asset_path`、`create_if_missing` | 批量改值类型、布尔标志与 action 级触发器/修饰器 |
| `enhanced_input_create_mapping_context` | 创建 `InputMappingContext` | `asset_path` | 新建一套输入映射 |
| `enhanced_input_get_mapping_context_info` | 读取 `MappingContext` 信息 | `asset_path` | 列出现有映射关系 |
| `enhanced_input_export_mapping_context_json` | 导出 `InputMappingContext` 单文件 JSON | `asset_path`；可选 `output_file` | 把整套映射关系导出成单个真源 JSON |
| `enhanced_input_apply_mapping_context_json` | 从单文件 JSON 回写 `InputMappingContext` | `json_file`；可选 `asset_path`、`create_if_missing` | 以 JSON 真源重建 mappings[] |

逐条修改 InputAction / MappingContext 的 setter/add/remove 入口已归档到废弃分册。正式 authoring 应通过 `enhanced_input_export_*_json -> enhanced_input_apply_*_json` 做单文件 JSON round-trip，并检查 apply 返回的写入观测字段。

### EnhancedInput JSON 工作流

- 这是 `InputAction / InputMappingContext` 的主编辑工作流。
- 当前不再推荐把这两类小资产当成“逐条 add/remove/set 命令”来长期 authoring。
- `InputAction` 和 `InputMappingContext` 当前不走文件夹式真源。
- 这两类资产内容小、层级浅，推荐直接使用“单资产 = 单 JSON”的工作流。
- `enhanced_input_export_*_json` 会导出 UTF-8 单文件 JSON。
- `enhanced_input_apply_*_json` 会从 JSON 回写；当 `modifier_classes / trigger_classes / mappings` 字段存在时，语义是“按 JSON 全量替换该数组”。
- `json_file` 文件缺失、读取失败或 JSON 语法解析失败会直接失败返回 `json_file_not_found / load_json_file_failed / json_parse_failed`；映射项缺 `action_path/key`、无效 key、action 不存在等 schema 问题会以明确错误码返回，不会静默跳过。

推荐方法：

1. 先最小创建 `InputAction` / `InputMappingContext`
2. 先 export 单 JSON
3. 以导出结果为模板补全字段
4. 再 apply

#### `enhanced_input_export_action_json`

- 必填：`asset_path`
- 可选：`output_file`
- 导出字段：
  - `asset_path`
  - `value_type`
  - `consume_input`
  - `trigger_when_paused`
  - `reserve_all_mappings`
  - `modifier_classes[]`
  - `trigger_classes[]`

#### `enhanced_input_apply_action_json`

- 推荐参数：`json_file`、`save_after_apply`
- 可选：`asset_path`
  - 不填时默认取 JSON 里的 `asset_path`
- 可选：`create_if_missing`
  - 默认 `true`

#### `enhanced_input_export_mapping_context_json`

- 必填：`asset_path`
- 可选：`output_file`
- 导出字段：
  - `asset_path`
  - `mappings[]`
    - `key`
    - `action_path`
    - `modifier_classes[]`
    - `trigger_classes[]`

#### `enhanced_input_apply_mapping_context_json`

- 推荐参数：`json_file`、`save_after_apply`
- 可选：`asset_path`
  - 不填时默认取 JSON 里的 `asset_path`
- 可选：`create_if_missing`
  - 默认 `true`
- 当 JSON 中存在 `mappings[]` 时，会先清空现有映射，再按 JSON 重建。

## 最小请求示例

```json
{
  "request_id": "sm-001",
  "command": "static_mesh_get_local_corners",
  "params": {
    "asset_path": "/Engine/BasicShapes/Cube.Cube"
  }
}
```

## 废弃命令

本分册不再列出已废弃写入命令；这些命令仅保留在 `deprecatedCommand/04_StaticMesh_EnhancedInput.md`，供旧脚本兼容、bootstrap、迁移和故障补修查阅。
