# UeAgentInterface 指令文档索引

本目录是 UeAgentInterface 的正式命令分册入口。skill 内只同步正式分册，不同步 `deprecatedCommand/**` 和 generated 覆盖矩阵。

## 查阅顺序

1. 先看本文，确定应该使用哪个分册和哪类工作流。
2. 再打开具体分册，查看命令参数、返回字段、错误码和边界。
3. 需要确认覆盖矩阵或废弃命令归档时，回到插件仓库源文档，不在 skill 内查阅。

## 工作流优先级

| 优先级 | 工作流 | 适用对象 | 典型命令 |
| --- | --- | --- | --- |
| 1 | 单文件 JSON | 小型资产、表格、配置、浅层数据 | `asset_*_property_json`, `curve_*_json`, `data_asset_*_json`, `data_table_*_json`, `render_target_*_json` |
| 2 | 文件夹式 JSON | 图、树、复合资产、复杂编辑面 | `blueprint_*_folder`, `umg_*_folder`, `material_*_folder`, `niagara_*_folder`, `control_rig_*_folder` |
| 3 | 场景/拓扑 JSON | Level Actor 实例、Component、Streaming、DataLayer、HLOD | `level_content_*_json`, `level_topology_*_json` |
| 4 | 动作 / probe / build | 编译、截图、运行时探针、导入、构建、长任务 | `*_compile`, `*_screenshot`, `*_runtime_probe`, `packaging_*`, `*_build` |

通用节奏：

```text
bootstrap -> export -> refine -> validate -> apply -> export/readback -> smoke/probe
```

不要凭记忆猜 `property_name`、`value_text`、Pin 类型或 UE 对象路径。能导出真实模板时，先导出，再在模板上改。

## 分册索引

| 分册 | 命令数 | 主要范围 | 何时优先使用 |
| --- | ---: | --- | --- |
| `01_Core_Level_Assets_Landscape.md` | 86 | Core、Level 原子能力、Viewport、Asset、Landscape、Navigation、Trace、Screenshot | 读世界状态、基础 Actor/Component 查询、视口和低层诊断 |
| `02_Blueprint.md` | 38 | Blueprint 创建、编译、folder workflow、图和变量 | 普通 Blueprint authoring |
| `03_UMG.md` | 12 | WidgetBlueprint、WidgetTree、Slot、UMG 动画基础 | UI / WidgetBlueprint authoring |
| `04_StaticMesh_EnhancedInput.md` | 34 | StaticMesh folder workflow、collision、socket、EnhancedInput JSON | StaticMesh 和输入资产 |
| `05_Material.md` | 25 | Material、Material Instance、Material Function folder workflow | 材质图和参数 |
| `06_Sequence.md` | 38 | Level Sequence、Binding、Track、UMG Animation、Sequencer folder workflow | 过场、镜头、属性轨 |
| `07_Niagara_System.md` | 27 | Niagara System、编译、截图、Stack issue、runtime probe | Niagara System 级操作和验证 |
| `08_Niagara_Emitter.md` | 20 | Niagara Emitter、Renderer、Event、参数 | Emitter 和渲染/事件结构 |
| `09_Niagara_StageGraph.md` | 23 | Niagara Stage、Graph、Node、Module Input | Niagara 图和模块输入 |
| `10_Modeling.md` | 22 | Modeling Mode、选择、工具 wrapper、primitive、mesh edit | 建模模式和白盒几何 |
| `11_AnimBlueprint.md` | 56 | AnimBlueprint folder workflow、State Machine、Anim Layer、图节点 | 动画蓝图 |
| `12_Montage.md` | 30 | Montage JSON、slot、segment、section、notify、Skeleton slot/group | 动画 Montage |
| `13_AnimationAssets_Skeleton.md` | 25 | AnimSequence、BlendSpace、Skeleton | 动画资产和骨架 |
| `14_IKRig_IKRetargeter.md` | 27 | IK Rig、IK Retargeter、retarget batch | IK 和重定向 |
| `15_Niagara_FolderFormat.md` | 6 | Niagara System / Emitter / Script folder schema | Niagara 结构化 JSON 细节 |
| `16_SkeletalMesh_FolderFormat.md` | 11 | SkeletalMesh folder workflow、Morph、Skin Weight Profile | 骨骼网格资产 |
| `17_ControlRig_FolderFormat.md` | 21 | Control Rig、Shape Library、compile/probe/bake | Control Rig authoring |
| `18_Deformer_MLDeformer_GeometryCache.md` | 28 | Deformer Graph、ML Deformer、Geometry Cache | 变形器和几何缓存 |
| `19_AI_Behavior_Blackboard_StateTree_EQS_Navigation_SmartObject.md` | 56 | Blackboard、BehaviorTree、StateTree、EQS、AI Perception、Navigation、Smart Object | AI 行为栈 |
| `20_Audio.md` | 60 | SoundWave、SoundCue、MetaSound、SoundClass/Mix/Submix、probe/record | 音频资产和音频运行诊断 |
| `21_Texture_RenderTarget_Media.md` | 95 | Texture、RenderTarget、RVT、Media、TextureGraph、Paper2D | 贴图、RT、媒体和 2D 贴图资产 |
| `22_ProjectSettings_Config.md` | 7 | Project Settings 实时反射、受限 Config fallback | 编辑项目设置和安全 ini section |
| `23_LevelContent_JSON.md` | 14 | Level Actor / Component 增删查改 JSON、snapshot、merge、repair | 场景 Actor 持久内容 authoring |
| `24_DataDriven_DataAsset_DataTable.md` | 13 | DataAsset、PrimaryAsset、DataTable JSON | 数据驱动资产 |
| `25_LevelTopology_Streaming_WorldPartition_DataLayer_HLOD.md` | 39 | Level Streaming、World Partition、DataLayer、HLOD | 关卡拓扑和构建任务 |
| `26_Physics_Baseline.md` | 14 | 基础 Physics、PhysicalMaterial、Constraint、PhysicsAsset、runtime probe | 不依赖额外插件的物理基础 |
| `27_Localization_Packaging_PlatformProfiles.md` | 40 | Localization、StringTable、Packaging、TargetPlatform、DeviceProfile、Scalability | 本地化、打包和平台 profile |
| `28_NodeGraph.md` | 2 | 跨资产节点连线图 list/layout | 对 Blueprint、UMG、AnimBlueprint、Material 等节点连线图使用统一排布入口 |
| `29_PCG.md` | 40 | PCG Graph、GraphInstance、Component、WorldActor、Partition、生成、Inspection、数据和 GPU/HLSL 诊断 | Procedural Content Generation authoring 和验证 |
| `30_PCG_FolderFormat.md` | 0 | PCG Graph folder schema、验证、preflight 和 apply 语义 | 需要审查或手写 PCG 文件夹式 JSON 时 |

## 按任务路由

| 任务 | 首选入口 | 不应优先使用 |
| --- | --- | --- |
| 在场景里创建、修改、删除 Actor / Component | `23_LevelContent_JSON.md` | 旧单步 Actor 创建和逐条 transform/property 原子命令 |
| 关卡流送、DataLayer、World Partition、HLOD | `25_LevelTopology_Streaming_WorldPartition_DataLayer_HLOD.md` | 把拓扑系统硬塞进普通 Actor CRUD |
| 普通 Blueprint / UMG / AnimBlueprint | `02_Blueprint.md`, `03_UMG.md`, `11_AnimBlueprint.md` | 大量节点/属性原子命令手搓完整资产 |
| 材质、Sequencer、Niagara、Control Rig | 对应 folder workflow 分册 | 单条节点写入作为主 authoring |
| StaticMesh / SkeletalMesh / Deformer | `04`, `16`, `18` 分册 | 直接写 raw vertex / raw skin weight / raw render data |
| AI 行为、寻路、EQS、感知、Smart Object | `19_AI_Behavior_Blackboard_StateTree_EQS_Navigation_SmartObject.md` | 仅靠 Actor/Component 属性写入表达完整 AI 行为 |
| Audio、Texture、RenderTarget、Media | `20_Audio.md`, `21_Texture_RenderTarget_Media.md` | 通用资产属性命令作为完整 authoring 主流程 |
| Project Settings 或 `.ini` | `22_ProjectSettings_Config.md` | 各业务分册重复编辑普通设置字段 |
| DataAsset、PrimaryAsset、DataTable | `24_DataDriven_DataAsset_DataTable.md` | 把 DataTable 当普通 DataAsset 或 StringTable |
| Packaging、Localization、Platform Profile | `27_Localization_Packaging_PlatformProfiles.md` | UAI release pipeline 或普通 Project Settings 镜像 |
| 跨资产节点连线图排布 | `28_NodeGraph.md` | 针对每类资产手写不同 layout 调用 |

## 通用返回和诊断约定

写入类命令必须让失败可定位：

- `issues[]` / `warnings[]` 使用 `severity/code/path/message`。
- `json_file` 读取失败或解析失败必须直接失败，不得静默回退。
- `property_results[]` 应保留逐项写入状态。
- `requested_value_text`、`applied_value_text`、`property_value_read_back`、`property_import_status`、`property_import_verified`、`property_import_error`、`value_text_exact_match`、`value_text_changed_after_import`、`cpp_type` 是属性写入诊断核心字段。
- `value_text_changed_after_import=true` 需要人工复核，可能只是 UE 规范化，也可能表示写入分支不生效。
- 长任务返回 `task_id/status/command_line/log_file/report_file/exit_code/phase/last_log_lines[]`，真实执行必须有显式许可参数。

## 维护规则

本文档在 skill 内是同步副本。命令实现、正式参数、返回字段和边界的源头仍在插件仓库文档；skill 副本只负责日常阅读路由。

新增或修改命令时必须同步：

1. 命令实现和路由。
2. 对应正式分册中的命令表、参数、返回字段、错误码和边界。
3. UE automation smoke 或 source audit 覆盖。
4. 插件源仓库中由 `uai-cli release coverage` 生成的 `docs/generated/command_coverage_matrix.*`。
5. 如改动影响 Codex skill 的阅读路由，只同步正式分册到 `UeAgentInterfacePak/skills/ue-agent-interface/docs/UeAgentInterface/commands/`，不得同步 `deprecatedCommand/**` 或 generated 覆盖矩阵。
6. 同步 Pak skill 后，再用 `scripts/skills/sync_codex_skills.py` 同步本机 installed skill 并做一致性检查。

当前本文档不再维护历史“增量补齐命令长列表”。命令存在性以插件源仓库的 coverage matrix 和各正式分册为准。
