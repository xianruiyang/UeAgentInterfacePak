# 指令详解：Control Rig / Control Rig Shape Library

Control Rig 使用文件夹式结构化 JSON 作为主 authoring 流程。Control Rig Shape Library 是独立可复用资产，使用单文件 JSON；Control Rig folder 内只保存对 Shape Library 的引用和 control 自身的 shape 设置。

本分册记录当前真实可用能力。设计原则是：Control Rig 资产本体用 folder JSON 管理，AnimBlueprint / Sequencer 接入和 bake 这类跨资产动作必须走对应资产 workflow 或显式动作命令。

## 主流程

推荐顺序：

1. `control_rig_create` 创建最小资产。
2. `control_rig_export_folder` 导出 UE 真实结构。
3. 修改导出的 `settings / shape_libraries / hierarchy / variables / graphs` JSON。
4. `control_rig_validate_folder` 只读校验。
5. `control_rig_apply_folder` 回写并编译。
6. 再次 export 或用 `control_rig_get_info / control_rig_runtime_probe` 读回验证。

不要用零散命令手搓完整 Control Rig。编辑前必须先了解目标命令每个参数的意义、默认值、副作用、返回字段和验证方法。

## Control Rig 命令

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `control_rig_create` | 创建 Control Rig Blueprint | `asset_path`；可选 `control_rig_type`、`preview_skeletal_mesh`、`import_hierarchy_from_preview`、`save_after_create` |
| `control_rig_get_info` | 读取 Control Rig 摘要与事件能力诊断 | `asset_path`；可选 `require_animation_editing_ready` |
| `control_rig_export_folder` | 导出文件夹式 JSON | `asset_path`；可选 `folder_path`、`clean_output_dir` |
| `control_rig_validate_folder` | 只读校验 folder JSON | `folder_path`；可选 `asset_path`、`create_if_missing`、`require_animation_editing_ready` |
| `control_rig_apply_folder` | 应用 folder JSON | `folder_path`；可选 `asset_path`、`dry_run`、`validate_only`、`create_if_missing`、`compile_after_apply`、`save_after_apply`、`require_animation_editing_ready` |
| `control_rig_compile` | 编译 Control Rig Blueprint | `asset_path` |
| `control_rig_get_compile_log` | 编译并返回 compile report | `asset_path` |
| `control_rig_open_editor` | 打开 Control Rig 编辑器 | `asset_path`，遵守最小化/不抢焦点规则 |
| `control_rig_graph_get_view` | 读取 RigVM/蓝图图视图 | `asset_path`；可选 `graph_name_or_path` |
| `control_rig_graph_set_view` | 设置图视图 | `asset_path`；可选 `graph_name_or_path`、`view_x`、`view_y`、`zoom`、`snap_to_pixel_grid`、`update_document_view_state`、`save_after_set` |
| `control_rig_viewport_get_camera` | 读取预览视口相机 | `asset_path` |
| `control_rig_viewport_set_camera` | 设置预览视口相机 | `asset_path`、相机参数 |
| `control_rig_screenshot` | 截图图/视口/窗口 | `asset_path`、`target=graph|viewport|window`；可选 `graph_name_or_path` |
| `control_rig_runtime_probe` | 创建 transient rig 实例并采样 | `asset_path`；可选 `frames`、`event_name`、`variables`、`variable_inputs[]`、`sample_bones[]`、`sample_controls[]`、`sample_variables[]` |
| `control_rig_bake_to_animation` | 从 Sequencer 显式 Bake To Animation | `sequence_path`、`binding_id` 或 `binding_guid`、`output_anim_sequence`；新建 AnimSequence 可用 binding 上的 SkeletalMesh 推断 skeleton，也可显式传 `target_skeleton` 或 `preview_skeletal_mesh` |
| `control_rig_bake_to_control_rig` | 从 Sequencer 显式 Bake To Control Rig | `sequence_path`、`binding_id` 或 `binding_guid`、`control_rig_class`；目标类必须是 `UFKControlRig` 或支持 Inverse event |

### `control_rig_create`

`control_rig_screenshot` 复用 Blueprint 截图实现；Slate UI 截图默认走离屏 WidgetRenderer，返回 `legacy_backbuffer_capture=disabled`，不再使用真实窗口 backbuffer 截图。`target=graph` 时可传 `capture_width/capture_height` 控制非侵入离屏画布尺寸，默认 `1440 x 900`。`target=viewport` 会先复用已存在的编辑器视口 tab，再尝试唤起 tab；Control Rig 的预览视口通常是 Persona `Viewport`，不能把 Blueprint `SCSViewport` 当作 Control Rig 视口事实源。
`control_rig_graph_set_view` 复用 Blueprint 图视图入口；`snap_to_pixel_grid` 默认 `true`，会按 `round(view * zoom) / zoom` 对齐屏幕像素，避免非 1 缩放下图面文字和线缆发糊。`update_document_view_state` 默认同步 UE 下次打开图时使用的文档视图状态，`save_after_set=true` 时把该状态写入资产包。

参数：

- `asset_path`：必填，长包名，例如 `/Game/ControlRig/CR_Player`。
- `control_rig_type`：可选，`independent_rig`、`rig_module`、`modular_rig`。
- `preview_skeletal_mesh`：可选，骨骼网格体路径。
- `import_hierarchy_from_preview`：可选，默认有 preview mesh 时导入骨骼层级。
- `save_after_create`：可选。

返回包含 `asset_path`、`control_rig_class`、`preview_skeletal_mesh`、`shape_libraries[]`、`hierarchy`、`graphs[]`、`variables`、`created`、`saved`。

### 动画编辑事件门禁

用于“基于已有骨骼动画继续编辑”的 Control Rig 必须具备双向事件链路：

- `Forwards Solve`：从 controls / variables / solver 驱动骨骼。
- `Backwards Solve`：从当前骨骼姿态回填 controls，使已有 AnimSequence / Sequencer 姿态能成为可编辑的控制点基线。

`control_rig_get_info`、`control_rig_export_folder` 和 `control_rig_apply_folder` 的 readback 会返回：

- `supported_events[]`
- `required_animation_editing_events[]`
- `supports_forward_solve`
- `supports_backward_solve`
- `supports_inverse_event`
- `animation_editing_ready`
- `bake_to_control_rig_ready`
- `event_diagnostics`

当 `require_animation_editing_ready=true` 时，`control_rig_get_info` 或 `control_rig_apply_folder / validate_folder` 会在缺 `Forwards Solve` 或 `Backwards Solve` 时失败并返回 `control_rig_missing_bidirectional_animation_editing_events`。普通运行时 Control Rig 可以不启用该门禁；骨骼动画 authoring、Bake To Control Rig、从 idle/动作原型转可编辑 controls 的流程必须启用。

### `control_rig_apply_folder`

返回重点字段：

- `valid`
- `json_issue_count`
- `error_count`
- `warning_count`
- `issues[]`
- `applied.variables_added`
- `applied.variable_defaults_updated`
- `applied.variable_flags_updated`
- `coverage`
- `compile_report`
- `readback`
- `save_after_apply`
- `saved`

`issues[]` 使用统一结构：

- `severity`
- `code`
- `path`
- `message`

未知字段返回 `json_unknown_field`。字段类型错误、必填字段缺失、资产引用丢失、RigVM node/link 写入失败、变量默认值导入失败等会返回对应 error。HTTP 成功不等于资产正确；必须检查 `valid/error_count/warning_count/compile_report/readback`。

`compile_after_apply=true` 是默认行为。编译失败会写入 `issues[]`，其中包含 `control_rig_compile_failed`，命令返回失败；若同时传 `save_after_apply=true`，只有 `valid=true` 且无阻断 error 时才会保存，编译失败时 `saved=false`。

骨骼动画 authoring 场景应传 `require_animation_editing_ready=true`，并检查 `readback.animation_editing_ready=true`。如果失败，先补 Control Rig 的 `Backwards Solve`，不要继续进入 Sequencer 姿态编辑。

### `control_rig_runtime_probe`

该命令会编译目标 Control Rig，创建 transient `UControlRig` 实例，并按参数执行支持的事件。

常用参数：

- `frames`：执行帧数，默认 1，范围 0 到 1000。
- `event_name`：默认 `Forwards Solve`。如果 rig 不支持该事件，返回 `execution_skipped=true`，不是假装执行。
- `execute_construction`：默认 true。当前 rig 不支持 construction 事件时返回 `construction_skipped=true`。
- `variables`：对象形式输入变量，例如 `{ "FootIKAlpha": 0.25 }`。
- `variable_inputs[]`：数组形式输入变量，项内写 `name` 和 `value` 或 `default_value`。
- `sample_variables[]`：指定要读回的变量。
- `sample_bones[] / sample_controls[]`：指定要读回的层级元素。

返回会包含 `supported_events`、`construction_*`、`execution_*`、`compile_report`、`issues[]`、`bones[]`、`controls[]`、`variables[]`。

## Folder 结构

导出目录包含：

- `asset.json`
- `settings/control_rig.json`
- `settings/preview.json`
- `shape_libraries/references.json`
- `hierarchy/bones.json`
- `hierarchy/nulls.json`
- `hierarchy/controls.json`
- `hierarchy/curves.json`
- `hierarchy/connectors.json`
- `hierarchy/sockets.json`
- `hierarchy/rigid_bodies.json`
- `hierarchy/metadata.json`
- `variables/variables.json`
- `graphs/graphs.json`
- `graphs/ik_nodes.json`
- `validation/coverage_report.json`
- `validation/diagnostics.json`
- `validation/unsupported_profiles.json`
- `validation/compile_report.json`
- `validation/readback_diff.json`
- `validation/runtime_probe_report.json`
- `validation/rigvm_unit_registry.json`

当前稳定回写面：

- `asset.json`：资产路径、类型等基础信息参与校验。
- `settings/preview.json`：preview skeletal mesh 与可选 hierarchy import。
- `shape_libraries/references.json`：Shape Library 引用。
- `hierarchy/bones.json`：骨骼层级导入/读回。
- `hierarchy/nulls.json`：null 元素。
- `hierarchy/controls.json`：control、control settings、value/offset/shape transform。
  - `offset_transform` 表示 Control 的 offset transform 真源；导出端必须使用 Control offset，而不是普通 local transform。普通 local/value transform 为零并不代表 offset 可安全置零，尤其是 control 挂在 Null/Space 下时。
- `hierarchy/curves.json`：curve 元素。
- `variables/variables.json`：变量新增、类型校验、默认值、instance editable、read only、category。
- `graphs/graphs.json`：RigVM graph 的 unit/template/variable node、pin default、link。
- `graphs/ik_nodes.json`：PBIK / legacy FullBodyIK 的结构化 IK pin default 补丁。用于清晰表达人形 `effectors`、`bone_settings`、`constraints`、solver settings 和 debug settings，避免手写 UE struct default 字符串。
- `settings/control_rig.json` 会导出 `event_queue=["Construction","Forwards Solve","Backwards Solve"]` 和 `animation_editing_required_events[]`，用于提醒 authoring rig 的最低事件要求；真实可用性以 `asset.json` / readback 中的 `animation_editing_ready` 为准。
- apply 后编译并返回 `compile_report` 与 `readback`。

当前显式 unsupported apply 面：

- `graphs/construction_event.json`
- `graphs/forward_solve.json`
- `graphs/backward_solve.json`
- `variables/exposed_properties.json`
- `functions/functions.json`
- `modular/modules.json`
- `modular/connections.json`
- `modular/connectors.json`
- `presets/foot_ground_fbik.json`
- `raw_properties.json`
- `readonly_properties.json`

这些 profile 不再作为空占位文件导出到 authoring 目录，只在 `validation/unsupported_profiles.json` 中作为只读能力报告出现。若旧导出目录或手写目录仍包含上述文件，只要文件里包含实际写入内容，`control_rig_apply_folder` 会失败并返回 `unsupported_apply_profile`，提示应改走对应资产 workflow、`graphs/graphs.json`、显式动作命令或后续专用实现。

## Variables JSON

示例：

```json
{
  "schema": "ue_agent_interface.control_rig.variables.v1",
  "variables": [
    {
      "name": "FootIKAlpha",
      "cpp_type": "float",
      "type": {
        "pin_category": "real",
        "pin_subcategory": "float"
      },
      "default_value": 0.75,
      "direction": "input",
      "instance_editable": true,
      "read_only": false,
      "category": "FootIK"
    },
    {
      "name": "UseInternalTrace",
      "cpp_type": "bool",
      "type": {
        "pin_category": "bool"
      },
      "default_value": true,
      "direction": "input",
      "instance_editable": true
    }
  ],
  "variable_count": 2
}
```

规则：

- 新变量通过 `FBlueprintEditorUtils::AddMemberVariable` 创建。
- 已存在变量必须类型一致；类型不同会返回 `control_rig_variable_type_update_not_supported`。
- `default_value` 支持 string、number、bool、vector/color 等结构化对象，并会经 UE `ImportText` 写入 CDO 后读回。
- 默认值导入失败返回 `control_rig_variable_default_import_failed`。

## RigVM Graph JSON

`graphs/graphs.json` 是当前 canonical graph apply 文件。它表达节点、位置、pin default 和 link。

RigVM 节点 authoring 前必须先读取 `control_rig_export_folder` 的 `graphs/graphs.json` 和 `validation/rigvm_unit_registry.json`，或通过 `control_rig_get_info / control_rig_validate_folder` 确认目标 unit、template、pin 与事件能力。不要凭 RigVM 节点菜单显示名、Control Rig 教程名称或 C++ 类名猜 `node_path`、unit 名、pin default 或 link。

重要规则：

- `replace_nodes` 控制是否替换目标图现有节点。整图重建时设为 `true`；局部追加或修补时保持 `false`，否则会删除未在 JSON 中保留的节点。
- `unit_struct` 必须能解析为 UE 当前可用的 Control Rig/RigVM unit。
- 不确定 pin 名称时先 export，再基于导出 pin 路径修改。
- pin 写入失败必须返回 `pin_not_found` 或更具体诊断，不能靠截图猜。
- graph apply 后必须编译，并检查 `compile_report.error_count=0`。
- `validation/rigvm_unit_registry.json` 用于查看当前 UE 版本中可用 unit，避免硬编码过时 unit 名称。

### Structured IK Nodes JSON

`graphs/ik_nodes.json` 是 `graphs/graphs.json` 的结构化补丁层。`control_rig_apply_folder` / `control_rig_validate_folder` 会先读取该文件，把每个条目转换成对应 RigVM 节点的 `pin_defaults`，再走 canonical `graphs/graphs.json` 写入。它不替代节点连线；control 到 effector transform 的 link 仍应写在 `graphs/graphs.json.links[]`。

PBIK 推荐用于人形 authoring rig，因为 `/Script/PBIK.RigUnit_PBIK` 没有 deprecated 标记，并且原生支持 per-bone `BoneSettings`：rotation/position stiffness、三轴 Free/Limited/Locked、min/max、preferred angles、excluded bones。肘、膝这类关键关节应优先用 `preferred_angles` 指定自然弯曲方向，再用 limits 和 stiffness 限制极端姿态。

示例：

```json
{
  "schema": "ue_agent_interface.control_rig.ik_nodes.v1",
  "nodes": [
    {
      "graph": "RigVMModel",
      "name": "pbik_full_body",
      "solver_type": "pbik",
      "position": { "x": 1200, "y": 300 },
      "root": "Hips",
      "effectors": [
        { "bone": "hand_r", "position_alpha": 1.0, "rotation_alpha": 0.6, "strength_alpha": 1.0, "chain_depth": 4, "pull_chain_alpha": 0.7, "pin_rotation": 0.35 },
        { "bone": "hand_l", "position_alpha": 1.0, "rotation_alpha": 0.4, "strength_alpha": 0.45, "chain_depth": 4, "pull_chain_alpha": 0.35, "pin_rotation": 0.2 },
        { "bone": "foot_r", "position_alpha": 0.8, "rotation_alpha": 0.2, "strength_alpha": 0.35, "chain_depth": 3 },
        { "bone": "foot_l", "position_alpha": 0.8, "rotation_alpha": 0.2, "strength_alpha": 0.35, "chain_depth": 3 }
      ],
      "bone_settings": [
        { "bone": "Hips", "rotation_stiffness": 0.8, "position_stiffness": 0.7 },
        { "bone": "spine_01", "rotation_stiffness": 0.65 },
        { "bone": "upperarm_r", "rotation_stiffness": 0.15 },
        { "bone": "lowerarm_r", "x": "Limited", "min_x": -5, "max_x": 145, "y": "Locked", "z": "Locked", "use_preferred_angles": true, "preferred_angles": { "x": 0, "y": 0, "z": -35 } },
        { "bone": "thigh_r", "rotation_stiffness": 0.15 },
        { "bone": "calf_r", "x": "Limited", "min_x": -5, "max_x": 150, "y": "Locked", "z": "Locked", "use_preferred_angles": true, "preferred_angles": { "x": 0, "y": 0, "z": 35 } }
      ],
      "excluded_bones": ["weapon_socket"],
      "settings": {
        "iterations": 40,
        "sub_iterations": 6,
        "mass_multiplier": 1.0,
        "allow_stretch": false,
        "root_behavior": "PinToInput",
        "global_pull_chain_alpha": 0.75,
        "max_angle": 25,
        "over_relaxation": 1.1
      },
      "debug": { "draw_debug": false, "draw_scale": 1.0 }
    }
  ]
}
```

字段说明：

- `name` / `node`：RigVM 节点名。若 `graphs/graphs.json` 中不存在该节点，会补一个 unit node；若已存在则只更新其 `pin_defaults`。
- `solver_type`：`pbik` 默认生成 `/Script/PBIK.RigUnit_PBIK`；`legacy_fullbodyik` 生成 `/Script/FullBodyIK.RigUnit_FullbodyIK`，仅用于兼容旧资产。
- `root` / `root_bone`：PBIK 为骨骼 `FName`，legacy FullBodyIK 为 `FRigElementKey`。
- `effectors[]`：PBIK 写入 `FPBIKEffector`，支持 `bone`、`transform`、`position_alpha`、`rotation_alpha`、`strength_alpha`、`chain_depth`、`pull_chain_alpha`、`pin_rotation`。手、脚等末端 control 必须作为 effector；肘、膝等中间关键关节如果要被候选预览或关键帧直接控制，也必须作为低权重/短链 effector 接入 Forward Solve，而不能只在 Backwards Solve 里回填 control。
- `bone_settings[]`：仅 PBIK。每项支持 `bone`、`rotation_stiffness`、`position_stiffness`、`x/y/z`、`min_x/max_x/min_y/max_y/min_z/max_z`、`use_preferred_angles`、`preferred_angles`。`x/y/z` 可写 `Free`、`Limited`、`Locked`。
- `excluded_bones[]`：仅 PBIK。
- `constraints[]`：仅 legacy FullBodyIK。支持 `bone`、`enabled`、`use_stiffness`、`linear_stiffness`、`angular_stiffness`、`use_angular_limit`、`angular_limit`、`use_pole_vector`、`pole_vector_option`、`pole_vector`、`offset_rotation`。
- `settings`：PBIK solver settings，支持 `iterations`、`sub_iterations`、`mass_multiplier`、`allow_stretch`、`root_behavior`、`pre_pull_root_settings`、`global_pull_chain_alpha`、`max_angle`、`over_relaxation`。
- `WorkData` 是 PBIK 的内部运行时工作数据 pin。它可能出现在导出的 `graphs/graphs.json.pin_defaults` 中，但 `control_rig_apply_folder` 会跳过该 pin，不把它当作用户可写默认值。

人形骨骼动画 authoring rig 的最低要求：

- 必须有 `Forwards Solve` 和 `Backwards Solve`。
- Forward Solve 使用 PBIK 或等价求解器驱动骨骼，不要直接逐骨骼硬写最终姿态作为主路径。
- Backwards Solve 必须把当前骨骼姿态回填到 controls，使已有 AnimSequence/Sequencer 帧能成为可编辑基线。
- 手、脚、头、胸、骨盆等 end effector controls 与肘、膝、脊柱等关键关节 `bone_settings` 必须在 JSON 中显式表达；不要依赖默认空约束。
- 需要直接调肘、膝弯曲方向时，除了 `bone_settings.preferred_angles/limits`，还应给对应骨骼添加低权重 PBIK effector 并在 `graphs/graphs.json.links[]` 中连接控制点 transform；否则移动该 control 只会改变控制点自身，不会改变 Forward Solve 后的骨骼姿态。
- 调姿势时先用 `control_rig_runtime_probe` 或 sequence probe 验证读回，再进入截图判断。

## 运行时 IK / Trace Authoring 注意事项

Control Rig folder JSON 只能证明 RigVM 图被写入，不能单独证明运行时 IK 已生效。涉及足底贴地、手部贴合、武器约束、楼梯/斜坡贴合时，必须同时验证 Control Rig、AnimBlueprint、动画曲线和碰撞/Trace 语义。

通用规则：

- Trace 类 unit 先确认空间语义，再写起点/终点。UE 5.6 常见 `SphereTraceByObjectTypes` 的 Control Rig 输入/输出按 Rig/Global 语义处理，内部再查询 UE world；不要在 JSON 中额外做错误的二次世界变换。
- 地面 Trace 不要默认用 `Visibility` 命中自身。通常应限定 object types 到 `WorldStatic`；如要支持移动平台，定义明确的地面 channel/object type。
- no-hit 必须显式处理：保持原动画姿态、降低 IK alpha、或使用上一帧平滑目标。不能让默认零向量继续进入求解。
- 调试时建议暴露 `DBG_*` 变量或 control 记录 Trace start/end/hit/hit normal/hit bool，再用 `control_rig_runtime_probe` 采样。截图只能辅助定位，不替代 compile/readback/probe。
- 足底贴地通常保留动画的水平 X/Y，只用 Trace 命中修正 Z 和必要旋转。把预测落点完整向量直接作为脚目标，容易造成脚在地面横向拖拽。
- 移动中 IK 权重要由动画曲线、速度或步态阶段调节。满权重锁脚会导致楼梯/斜坡上移动卡顿、脚滑或姿态被拉坏。
- `Shape Library` 只影响控制形状显示，不参与上述 Trace、IK alpha、求解或 AnimBlueprint 接入。

## Control Rig Shape Library

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `control_rig_shape_library_create` | 创建 Shape Library 资产 | `asset_path`、`save_after_create` |
| `control_rig_shape_library_get_info` | 读取 Shape Library 摘要 | `asset_path` |
| `control_rig_shape_library_export_json` | 导出单文件 JSON | `asset_path`；可选 `output_file` |
| `control_rig_shape_library_validate_json` | 校验单文件 JSON | `json_file`；可选 `asset_path` |
| `control_rig_shape_library_apply_json` | 应用单文件 JSON | `json_file`；可选 `asset_path`、`create_if_missing`、`save_after_apply` |

Shape Library JSON 示例：

```json
{
  "schema": "ue_agent_interface.control_rig_shape_library.v1",
  "asset_path": "/Game/ControlRig/Shapes/CRSL_Player",
  "asset_class": "/Script/ControlRig.ControlRigShapeLibrary",
  "default_shape": {
    "shape_name": "Default",
    "static_mesh": "/ControlRig/Controls/DefaultShapes/SM_Cube.SM_Cube",
    "transform": {
      "location": { "x": 0, "y": 0, "z": 0 },
      "rotation": { "pitch": 0, "yaw": 0, "roll": 0 },
      "scale": { "x": 1, "y": 1, "z": 1 }
    }
  },
  "default_material": "",
  "xray_material": "",
  "material_color_parameter": "ShapeColor",
  "shapes": []
}
```

关系：

- Shape Library 保存可复用控制形状定义，不参与 RigVM 求解。
- Control Rig 通过 `shape_libraries/references.json` 引用 Shape Library。
- 单个 control 的 `shape_name` 只是名称引用，最终 mesh/material 来自已绑定的 Shape Library。
- 官方默认控制点显示优先使用 `/ControlRig/Controls/DefaultGizmoLibraryNormalized.DefaultGizmoLibraryNormalized` 作为 Shape Library；常规展示优化应改 `hierarchy/controls.json` 中每个 control 的 `settings.shape_name`、`settings.shape_color`、`settings.shape_visible` 和 control 级 `shape_transform`。
- 只有确实需要新增或替换可复用静态网格形状时，才创建或修改自定义 Shape Library。不要为了缩放、隐藏、换色或套用默认圈/箭头/方框样式而复制并改写默认 Shape Library。

## AnimBlueprint 与 Sequencer 边界

- AnimBlueprint 接入 Control Rig 节点属于 AnimBlueprint folder workflow，不由 `control_rig_apply_folder` 隐式修改。
- Sequencer Control Rig track / section / binding 属于 Sequence folder workflow，不由 Control Rig folder 隐式修改。
- `control_rig_bake_to_animation` 和 `control_rig_bake_to_control_rig` 是显式动作命令。执行后必须重新导出 Level Sequence 或 AnimSequence 验证结果。
- `control_rig_bake_to_animation` 使用 `USequencerToolsFunctionLibrary::ExportAnimSequence`，不依赖已打开 Sequencer，也不会为了导出异步打开 Sequencer 编辑器。
- `control_rig_bake_to_animation` 导出后会读回 AnimSequence DataModel；如果 `bone_track_count=0`，命令返回失败 `control_rig_bake_to_animation_empty_bone_tracks`，避免把空动画误报为成功。
- 两个 bake 指令都会先返回 `binding_preflight`：`binding_exists`、`bound_object_count`、`skeletal_mesh_component`、`skeletal_mesh`、`skeleton` 和 `error`。binding 不存在、没有 SkeletalMesh、skeleton 不兼容时必须失败。
- `control_rig_bake_to_control_rig` 会在调用 UE bake API 前检查 `control_rig_class`。非 FK 且不支持 Inverse event 时返回 `control_rig_bake_requires_fk_or_inverse_event`，避免 UE 内部静默失败或产生不可用 track。

## 覆盖与验证

`validation/coverage_report.json` 是当前覆盖状态源真相。当前应返回：

- `implementation_status=complete_folder_profile`
- `is_complete_target_schema=true`
- `blocking_gaps=[]`
- `covered_profiles` 包含 `variables`、`rigvm_graphs`、`runtime_probe`、`editor_view`、`shape_library_asset`
- `unsupported_apply_count=11`，对应上面列出的跨资产或暂不安全回写面

最低 smoke：

1. 创建 Control Rig。
2. 导出 folder。
3. 修改 `variables/variables.json` 添加变量。
4. validate 返回 `valid=true`、`json_issue_count=0`。
5. apply 返回 `variables_added>0`、`compile_report.error_count=0`。
6. runtime probe 输入变量并读回。
7. Shape Library create/export/validate/apply。
8. 对 unsupported profile 写入实际内容，确认返回 `unsupported_apply_profile`。
9. 动画编辑门禁 smoke：`control_rig_get_info(require_animation_editing_ready=true)` 对缺 `Backwards Solve` 的普通 rig 返回 `control_rig_missing_bidirectional_animation_editing_events`；支持双向事件的 rig 返回 `animation_editing_ready=true`。
10. Sequencer bake smoke：缺 Inverse 的普通 Control Rig 返回结构化错误；`/Script/ControlRig.FKControlRig` bake 成功；`control_rig_bake_to_animation` 能在不打开 Sequencer 的情况下导出 AnimSequence。

## 适用边界

- Control Rig 是 RigVM Blueprint 资产，不能直接写 `.uasset` 二进制内部结构。
- 脚底贴地、手部贴合、武器控制、程序化修正等效果应通过 `hierarchy / variables / graphs` 组合表达，再用 compile + runtime probe 验证。
- 预览相机和截图只属于编辑器辅助，不影响运行时结果。
- UI 截图不能替代 compile、readback 和 probe。
