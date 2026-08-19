# 指令详解：Skeletal Mesh 文件夹式 JSON

## 紧凑返回契约

- 默认 `llm_compact` 的 `data` 只保留 LLM 决策需要的目标标识、关键状态、计数、摘要、warnings/errors 摘要和 artifact / 文件路径。
- 完整读回、大对象、长列表、编译日志、像素/帧/点数据、raw property metadata、诊断栈和内部中间状态默认不进入 `data`；需要时通过 `response_options` 的 debug/raw 视图、显式请求字段或外置 artifact 获取。
- 本分册中的旧局部参数、历史别名或原子入口只作为 alias / 兼容路径；新 authoring 应优先使用本分册推荐的 JSON、folder、统一 viewport、probe 或 domain 专用入口。


## 返回契约

- Python wrapper 返回 `CommandResult`：业务结果在 `data`，诊断细节在 `debug`，原始响应在 `envelope`。LLM 默认读取 `data`，只有显式调试时读取 `debug/envelope`。
- 默认紧凑返回只保留资产路径、folder 路径、Skeleton / PhysicsAsset / material / LOD / socket / morph / skin profile / cloth 摘要、关键计数、apply/export/validate 状态、warnings 摘要和必要的读回状态。
- Mesh integrity、Morph Target、Skin Weight Profile、cloth、sampling region、import data、deformer、LOD/section、readback diff、validation report 等大报告默认外置到 folder JSON、`debug` 或 `envelope`；`data` 只保留报告路径、计数和关键失败摘要。
- `morph_targets[]`、skin profile 列表、LOD/section 列表、socket 列表和 material 列表默认分页、限制数量或摘要化；完整结构以导出的文件夹 JSON 为准。
- preview / import / remove 动作命令默认返回目标名、执行状态、保存状态、读回摘要和错误/警告计数；不内联 raw delta、raw skin weight、vertex/index buffer 或 cloth simulation data。
- 如需完整诊断，调用方显式传 `response_options.view=debug` 或等价调试选项。

## 主流程

Skeletal Mesh 使用文件夹式结构化 HJSON 做可维护 authoring。不要用普通 JSON 手写 vertex/index/skin weight/morph/cloth 原始数据；这些内容只导出摘要、hash 或 import policy，真正重建应走导入或 UE 专用构建 API。

推荐流程：

1. 准备 SkeletalMesh 资产。
2. `skeletal_mesh_export_folder` 导出真实结构。
3. 修改导出的 `materials.json`、`sockets.json`、`physics.json`、`mesh.json` 等文件。
4. `skeletal_mesh_validate_folder` 做只读校验。
5. `skeletal_mesh_apply_folder` 回写，再导出确认读回。

## 命令

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `skeletal_mesh_get_info` | 读取 SkeletalMesh 摘要 | `asset_path` |
| `skeletal_mesh_export_folder` | 导出 SkeletalMesh 文件夹式 JSON | `asset_path`；可选 `folder_path` |
| `skeletal_mesh_validate_folder` | 只读校验文件夹 JSON | `folder_path`；可选 `asset_path` |
| `skeletal_mesh_apply_folder` | 应用文件夹 JSON | `folder_path`；可选 `asset_path`、`dry_run`、`validate_only`、`save_after_apply` |
| `skeletal_mesh_get_morph_targets` | 读取 Morph Target 列表与摘要 | `asset_path` |
| `skeletal_mesh_validate_morph_targets` | 校验 Morph Target 与 LOD/数量摘要 | `asset_path` |
| `skeletal_mesh_preview_morph_target` | 用临时 SkeletalMeshComponent 设置 Morph 权重做无 UI 预览校验 | `asset_path`、`morph_target` 或 `name`；可选 `weight` |
| `skeletal_mesh_remove_morph_target` | 删除指定 Morph Target | `asset_path`、`morph_target` / `name` / `morph_target_name`；可选 `save_after_apply` 或兼容 `save_after_set` |
| `skeletal_mesh_import_skin_weight_profile` | 从 FBX 导入指定 LOD 的 Skin Weight Profile | `asset_path`、`source_filename`、`profile_name`；可选 `lod_index`、`save_after_import` |
| `skeletal_mesh_remove_skin_weight_profile` | 删除 Skin Weight Profile 或指定 LOD 的 profile 数据 | `asset_path`、`profile_name`；可选 `lod_index`、`save_after_apply` |
| `skeletal_mesh_preview_skin_weight_profile` | 用临时 SkeletalMeshComponent 设置 Skin Weight Profile 做无 UI 校验 | `asset_path`、`profile_name` |

## 导出结构

- `asset.json`：资产身份、schema、class、engine version。
- `mesh.json`：Skeleton、PhysicsAsset、PostProcess AnimBlueprint、LOD/material/socket/morph/skin profile 数量。
- `materials.json`：材质槽、slot name、material reference、imported slot name。
- `lods/index.json`：LOD 摘要与编辑策略。LOD0 视为 `import_only`，不通过普通 JSON 手写 raw buffer。
- `sockets.json`：mesh-only socket 新增、更新、删除。
- `bounds.json`：bounds 摘要。
- `physics.json`：physics asset 绑定。
- `morph_targets.json`、`skin_weight_profiles.json`、`cloth.json`、`sampling_regions.json`、`import_data.json`：摘要/占位，不作为普通 JSON 直接重建原始数据。
- `clothing.json`：`cloth.json` 的兼容别名，保留给旧脚本；新流程优先读取 `cloth.json`。
- `import_data.json`：导入源文件追踪，包含 `first_filename`、`source_files[]`、`source_filenames[]`、`source_file_count`、`can_reimport`，用于 FBX reimport / Morph / Skin Weight Profile 导入前验证。
- `deformers.json`：Mesh Deformer / ML Deformer / Deformer Graph 引用关系摘要和插件状态。
- `raw_properties.json`、`readonly_properties.json`：通用属性承载占位。
- `validation/coverage_report.json`、`validation/readback_diff.json`：覆盖状态和读回 diff。

## 可回写字段

`skeletal_mesh_apply_folder` 当前稳定回写：

- `materials.json.materials[]`
  - `slot_index`
  - `material`
  - `slot_name`
- `physics.json.physics_asset`
- `mesh.json.post_process_anim_blueprint`
- `sockets.json.sockets[]`
  - `socket_name` 或 `name`
  - `bone_name`
  - `relative_location`
  - `relative_rotation`
  - `relative_scale`
  - `remove`
- `morph_targets.json.operations[]`
  - `name` 或 `morph_target_name`
  - `remove=true`

Morph Target 的 raw delta 不通过 JSON 手写。当前稳定能力是导入后读回、摘要校验、删除指定 target，以及与动画曲线/AnimBlueprint/Deformer 关系检查。需要新增或重建 Morph Target delta 时，应走 FBX/DCC 导入或后续专用构建命令。

Skin Weight / Skin Weight Profile 的 raw 权重不通过普通 JSON 手写；导出内容用于摘要、profile 列表、LOD/section 兼容性检查和导入结果验证。profile 导入/删除使用显式动作命令，不由 `skeletal_mesh_apply_folder` 隐式触发，避免一次 folder apply 悄悄重建大量权重数据。

## Morph Target 导入与验证流程

Morph Target 的创建入口是 `asset_import_fbx_skeletal_mesh`，不是 `skeletal_mesh_apply_folder`。FBX 源文件需要满足 UE Morph Target 导入的基本条件：SkeletalMesh、同拓扑 blend shape / shape key、至少可作为 SkeletalMesh 导入的骨骼/蒙皮结构。静态网格、GLB 或只有普通动画曲线的文件不能直接验证该 FBX Morph Target 主路径。

推荐流程：

1. 用 DCC 或可信源准备带 Morph Target 的 FBX。
2. 调用 `asset_import_fbx_skeletal_mesh`，设置：
   - `import_morph_targets=true`
   - `validate_after_import=true`
   - `expected_morph_targets[]` 写入预期 target 名称
   - 测试导入时 `destination_path` 使用 `/Game/__UeAgentInterfaceSmoke/...` 或其它明确测试目录
3. 读取导入返回：
   - `skeletal_mesh_asset_path`
   - `morph_target_count`
   - `morph_targets_imported[]`
   - `validation_error_count`
   - `validation_passed`
   - `validation_report.issues[]`
4. 再调用 `skeletal_mesh_get_morph_targets` 读回 `morph_targets.json` 同源摘要。
5. 调用 `skeletal_mesh_validate_morph_targets` 检查 `has_valid_data`；无有效 delta 会进入 `validation_issues[]`，code 为 `morph_target_has_no_valid_data`。
6. 调用 `skeletal_mesh_preview_morph_target` 做无 UI transient component 设置校验；返回 `preview_status=transient_component_morph_set` 才能说明目标名能被组件设置。
7. 不保留测试资产时，优先让导入资产不落盘，验证后通过 dirty resource 流程丢弃；如果导入时保存了资产，必须清理测试 Content 路径。

失败语义：

- `source_file_not_found`：源 FBX 不存在。
- `source_file_is_not_fbx`：源文件扩展名不是 FBX。
- `invalid_destination_path`：目标路径不是合法 UE long package path。
- `fbx_import_created_no_assets`：UE FBX 工厂没有生成资产。
- `fbx_skeletal_mesh_import_validation_failed`：导入后硬校验失败，常见原因是 `expected_morph_targets[]` 未匹配到实际导入 target。具体项在 `validation_issues[]` 和 `validation_report.issues[]`。
- `morph_target_not_found`：`skeletal_mesh_preview_morph_target` 指定的 target 名不存在。

`skeletal_mesh_get_morph_targets` 返回的 `morph_targets[]` 当前包含：

- `name`
- `has_valid_data`

`morph_targets.json.operations[]` 只支持删除：

```json
{
  "operations": [
    {
      "name": "OldMorph",
      "remove": true
    }
  ]
}
```

新增、替换或修改 Morph Target delta 不走 JSON operations；必须重新导入 FBX 或后续专用构建命令。`skeletal_mesh_remove_morph_target` 是同一删除能力的显式动作命令，参数支持 `morph_target`、`name` 或 `morph_target_name`。

`skeletal_mesh_import_skin_weight_profile` 调用 UE 的 alternate skin weight 导入工具，从 `source_filename` 导入到 `profile_name` + `lod_index`。返回 `imported`、`readback` 和保存状态；源文件不存在、LOD 越界或导入失败会硬失败。

`skeletal_mesh_remove_skin_weight_profile` 不传 `lod_index` 时删除整个 profile 记录和各 LOD 数据；传 `lod_index` 时只删除该 LOD 数据，并保留 profile 记录供其它 LOD 使用。

`skeletal_mesh_preview_morph_target` 与 `skeletal_mesh_preview_skin_weight_profile` 都是无 UI runtime 预览校验命令：创建 transient `USkeletalMeshComponent`，设置目标 morph/profile，然后返回设置状态。它们不截图、不保存资产，适合作为自动化 smoke 的轻量验证。

`skeletal_mesh_validate_folder` 和 `skeletal_mesh_apply_folder` 都会先解析文件夹内所有已存在的可选 JSON 文件；只有文件不存在才会按可选文件跳过。只要出现 error 级 `json_issues[]`，命令就返回失败，不会继续静默写入。`skeleton.json`、`lods/index.json`、`sections.json`、`skin_weights.json`、`bounds.json`、`skin_weight_profiles.json`、`cloth.json`、`clothing.json`、`deformers.json`、`sampling_regions.json`、`import_data.json`、`raw_properties.json`、`readonly_properties.json` 和 `validation/*.json` 在 SkeletalMesh folder workflow 中属于摘要、只读或非主 authoring 入口；如果这些文件里出现 `apply/remove/delete/operations` 等明确写意图，会返回 `unsupported_apply_profile`。例外是 `morph_targets.json.operations[]` 当前只支持 `remove=true` 删除 Morph Target；Skin Weight Profile 的导入/删除必须使用 `skeletal_mesh_import_skin_weight_profile` / `skeletal_mesh_remove_skin_weight_profile`。

返回字段：

- `applied` / `dry_run`
- `structured_fields_applied`
- `raw_properties_applied`
- `operations_executed`
- `json_issues[]` / `json_issue_count`
- `property_results[]`
- `readback`
- `validation_report`

示例：

```json
{
  "folder_path": "D:/Project/Saved/UeAssetFolders/SkeletalMesh/Game/Characters/Hero/SK_Hero",
  "save_after_apply": false
}
```

## 边界

- 不通过 JSON 直接编辑 vertex buffer、index buffer、skin weight、morph target raw delta、cloth simulation data。
- 这些高风险数据需要导入、重建或专用命令处理，避免“JSON 看似成功但资产内部状态不一致”。
- `validate_folder` 是只读校验；正式落盘前仍要执行 apply 后读回与必要的 UE 资产验证。
