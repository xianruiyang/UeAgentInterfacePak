# UeAgentInterface 使用入口

本文是 UeAgentInterface 的调用入口说明。完整命令参数、返回字段和边界以 `<SkillDir>/docs/UeAgentInterface/commands/` 下的正式分册为准。

## 推荐入口

日常自动化优先使用 CLI，不直接手写 HTTP：

```text
<SkillDir>/tools/uai-cli.exe
```

推荐流程：

1. `doctor` 检查 UE Editor 服务连通性，并通过 `--report-file <UserWorkDir>/runtimeLogs/uai_doctor.json` 指定 report。
2. 多步骤任务用 `run --plan <UserWorkDir>/tmp/uai_params/<plan.json> --vars <UserWorkDir>/tmp/uai_params/<vars.json>`。
3. 一次性批处理用 `batch --file <UserWorkDir>/tmp/uai_params/<batch.json>`。
4. 读取 `<UserWorkDir>/runtimeLogs/*.json` 定位失败命令、失败索引和返回数据。
5. 写入资产或配置后做 export/readback、compile、probe、screenshot、smoke 或 coverage 验证。

不要在命令行里内联长 JSON；复杂参数写入 JSON 文件。

## 文档阅读顺序

1. `<SkillDir>/docs/UeAgentInterface/commands/README.md`：正式命令总索引、任务路由、工作流优先级。
2. `<SkillDir>/docs/UeAgentInterface/UeAgentInterface_Status.md`：当前能力与边界快照。
3. `<SkillDir>/docs/UeAgentInterface/Workflow_ExecBatch_Practice.md`：批处理和高效调用。
4. `<SkillDir>/docs/UeAgentInterfaceCMD/USAGE.md`：CLI 具体参数和 report/log 行为。
5. `<SkillDir>/docs/UeAgentInterface/commands/<编号>_*.md`：具体分册。

skill 内不同步 `deprecatedCommand/**` 和 generated 覆盖矩阵；需要排查同步差异时再回到插件仓库源文档。

## 分册路由

| 范围 | 分册 |
| --- | --- |
| Core / Level / Assets / Landscape | `<SkillDir>/docs/UeAgentInterface/commands/01_Core_Level_Assets_Landscape.md` |
| Blueprint | `<SkillDir>/docs/UeAgentInterface/commands/02_Blueprint.md` |
| UMG / WidgetBlueprint | `<SkillDir>/docs/UeAgentInterface/commands/03_UMG.md` |
| StaticMesh / EnhancedInput | `<SkillDir>/docs/UeAgentInterface/commands/04_StaticMesh_EnhancedInput.md` |
| Material / Material Instance / Material Function | `<SkillDir>/docs/UeAgentInterface/commands/05_Material.md` |
| Level Sequence / UMG Animation / Sequencer | `<SkillDir>/docs/UeAgentInterface/commands/06_Sequence.md` |
| Niagara System | `<SkillDir>/docs/UeAgentInterface/commands/07_Niagara_System.md` |
| Niagara Emitter / Renderer / Event / Parameter | `<SkillDir>/docs/UeAgentInterface/commands/08_Niagara_Emitter.md` |
| Niagara Stage / Graph / Node / Module Input | `<SkillDir>/docs/UeAgentInterface/commands/09_Niagara_StageGraph.md` |
| Modeling Mode | `<SkillDir>/docs/UeAgentInterface/commands/10_Modeling.md` |
| AnimBlueprint | `<SkillDir>/docs/UeAgentInterface/commands/11_AnimBlueprint.md` |
| Montage | `<SkillDir>/docs/UeAgentInterface/commands/12_Montage.md` |
| Animation Assets / Skeleton | `<SkillDir>/docs/UeAgentInterface/commands/13_AnimationAssets_Skeleton.md` |
| IK Rig / IK Retargeter | `<SkillDir>/docs/UeAgentInterface/commands/14_IKRig_IKRetargeter.md` |
| Niagara folder format | `<SkillDir>/docs/UeAgentInterface/commands/15_Niagara_FolderFormat.md` |
| Skeletal Mesh folder format | `<SkillDir>/docs/UeAgentInterface/commands/16_SkeletalMesh_FolderFormat.md` |
| Control Rig / Shape Library | `<SkillDir>/docs/UeAgentInterface/commands/17_ControlRig_FolderFormat.md` |
| Deformer / ML Deformer / Geometry Cache | `<SkillDir>/docs/UeAgentInterface/commands/18_Deformer_MLDeformer_GeometryCache.md` |
| AI Behavior / Blackboard / StateTree / EQS / Navigation / Smart Object | `<SkillDir>/docs/UeAgentInterface/commands/19_AI_Behavior_Blackboard_StateTree_EQS_Navigation_SmartObject.md` |
| Audio | `<SkillDir>/docs/UeAgentInterface/commands/20_Audio.md` |
| Texture / RenderTarget / Media | `<SkillDir>/docs/UeAgentInterface/commands/21_Texture_RenderTarget_Media.md` |
| Project Settings / Config | `<SkillDir>/docs/UeAgentInterface/commands/22_ProjectSettings_Config.md` |
| Level Content JSON | `<SkillDir>/docs/UeAgentInterface/commands/23_LevelContent_JSON.md` |
| DataAsset / PrimaryAsset / DataTable | `<SkillDir>/docs/UeAgentInterface/commands/24_DataDriven_DataAsset_DataTable.md` |
| Level Topology / Streaming / World Partition / DataLayer / HLOD | `<SkillDir>/docs/UeAgentInterface/commands/25_LevelTopology_Streaming_WorldPartition_DataLayer_HLOD.md` |
| Physics / Chaos 基础 | `<SkillDir>/docs/UeAgentInterface/commands/26_Physics_Baseline.md` |
| Localization / Packaging / Platform Profiles | `<SkillDir>/docs/UeAgentInterface/commands/27_Localization_Packaging_PlatformProfiles.md` |
| Node Graph 通用排布 | `<SkillDir>/docs/UeAgentInterface/commands/28_NodeGraph.md` |

## 调用格式

底层 HTTP 协议仍是 `POST /api/exec`：

```json
{
  "request_id": "task-001",
  "command": "command_name",
  "params": {}
}
```

CLI `batch` 文件通常写成：

```json
{
  "stop_on_error": true,
  "steps": [
    {
      "request_id": "step-001",
      "command": "get_world_state",
      "params": {}
    }
  ]
}
```

## 资产编辑原则

默认不要用一长串原子命令手搓完整资产。优先级：

1. 单文件 JSON：小型资产、DataAsset/DataTable、配置、曲线、RenderTarget 等。
2. 文件夹式 JSON：Blueprint、UMG、AnimBlueprint、Material、Sequence、Niagara、ControlRig、SkeletalMesh 等。
3. Level Content / Level Topology JSON：场景 Actor 内容和关卡拓扑。
4. 动作命令：compile、screenshot、runtime probe、build、import、packaging。
5. 原子写入命令：只用于 bootstrap、迁移、探针、局部补修和故障恢复。

标准节奏：

```text
bootstrap -> export -> refine -> validate -> apply -> export/readback -> verify
```

## 写入后必须检查

写入 JSON、folder JSON 或 `value_text` 后，检查命令返回中的诊断字段：

- `issues[]` / `warnings[]`
- `property_results[]`
- `requested_value_text`
- `applied_value_text`
- `property_value_read_back`
- `property_import_status`
- `property_import_verified`
- `property_import_error`
- `value_text_exact_match`
- `value_text_changed_after_import`
- `cpp_type`

`json_file` 读取失败、JSON 解析失败、属性不存在、ImportText 失败或 folder 可选文件存在但不可解析，都必须当作需要处理的失败，不要继续下一步写入。

## 长任务和编辑器生命周期

Packaging、Localization commandlet、部分 build/probe 属于长任务，必须使用 `timeout_seconds` 和显式许可参数，例如 `allow_uat=true`、`allow_commandlet=true`。

关闭编辑器前的安全顺序：

1. `editor_list_dirty_resources`
2. `editor_resolve_dirty_resources`
3. `editor_close`

出现 UE 崩溃或 UAI 服务异常退出时，先收集 crash context、UE log、CLI report 和本轮 runtime log，定位根因后再继续同类命令。

## 覆盖状态

截至最近一次 coverage：

- 命令总数：`867`
- 缺正式文档：`0`
- 缺实现：`0`
- 缺 smoke：`0`
- actionable smoke debt：`0`

覆盖状态以插件源仓库的 `docs/generated/command_coverage_matrix.md` 为准；skill 内不携带 generated 覆盖矩阵。
