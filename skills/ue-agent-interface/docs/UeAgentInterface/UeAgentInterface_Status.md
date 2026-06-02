# UeAgentInterface 当前能力与边界

本文只记录当前已经实现、文档化并纳入覆盖矩阵的能力快照。具体命令参数以 `<SkillDir>/docs/UeAgentInterface/commands/` 分册为准。

## 覆盖状态

最近一次 `uai-cli release coverage`：

- 命令总数：`876`
- 缺正式文档：`0`
- 缺实现：`0`
- 缺 smoke：`0`
- actionable smoke debt：`0`
- 所有命令均有 direct smoke/source-audit 覆盖记录

生成文件：

- `docs/generated/command_coverage_matrix.json`
- `docs/generated/command_coverage_matrix.md`
- `docs/generated/smoke_coverage_debt.md`

## 已完成能力

| 领域 | 当前能力 | 主要分册 |
| --- | --- | --- |
| Core / Editor lifecycle | world state、transaction、undo/redo、dirty resource、open/save/close、batch 基础能力 | `01`, `UeAgentInterface_Usage.md` |
| Level / Actor / Component | Actor/Component 查询、transform、属性、选择、folder/tag、trace/sweep/overlap、NavMesh 基础、截图和 viewport 控制 | `01` |
| Level Content JSON | 场景 Actor/Component 内容的 query/validate/plan/apply/diff/snapshot/delete/merge/repair | `23` |
| Level Topology | Level Streaming、World Partition、DataLayer、HLOD 操作和构建任务 | `25` |
| Blueprint | Blueprint folder workflow、变量、组件、图节点、Pin、编译、截图、CDO、reparent | `02` |
| UMG | WidgetBlueprint folder workflow、WidgetTree、Slot、属性、绑定、UMG 动画基础 | `03` |
| StaticMesh / EnhancedInput | StaticMesh folder workflow、collision、socket、lightmap/Nanite 安全字段、InputAction/InputMappingContext JSON | `04` |
| Modeling | Modeling Mode、selection、active tool、primitive wrapper、mesh edit wrapper、UV/material/collision helper | `10` |
| Material | Material、Material Instance、Material Function folder workflow 和图/参数读写 | `05` |
| Sequence | Level Sequence folder workflow、binding、track、key、camera cut、spawnable、subsequence、UMG animation | `06` |
| Niagara | System、Emitter、Script folder workflow、Stack issue、refresh、compile log、preview advance、runtime probe、screenshot | `07`, `08`, `09`, `15` |
| AnimBlueprint | AnimBlueprint folder workflow、Layer Interface、Anim Layer、State Machine、Transition、图节点、预览、CDO | `11` |
| Montage | Montage 单文件 JSON、slot、segment、section、notify、notify state、Skeleton slot/group | `12` |
| Animation / Skeleton | AnimSequence、BlendSpace、Skeleton、socket、virtual bone、metadata、notify、sync marker | `13` |
| IK Rig / Retargeter | IK Rig / IK Retargeter folder workflow、preview solve、auto map/align、batch retarget | `14` |
| SkeletalMesh | SkeletalMesh folder workflow、Morph Target、Skin Weight Profile、socket、physics/deformer 引用摘要 | `16` |
| Control Rig | Control Rig folder workflow、Shape Library JSON、compile/log、runtime probe、screenshot、Sequencer bake | `17` |
| Deformer / Geometry Cache | Geometry Cache import/info/validate、Deformer Graph folder workflow、ML Deformer/Data collection JSON | `18` |
| AI | Blackboard、BehaviorTree、StateTree、EQS、AI Perception、Navigation、Smart Object、AI stack export/validate/probe | `19` |
| Audio | SoundWave、SoundCue、MetaSound、Attenuation、Concurrency、SoundClass/Mix/Submix、EffectPreset、runtime probe/record/meter | `20` |
| Texture / RenderTarget / Media | Texture import/reimport/stat/export、RVT、TextureArray/Cube/Volume、RenderTarget、Media、TextureGraph、SubUV、Paper2D | `21` |
| Project Settings / Config | ISettingsModule 实时反射导出/校验/diff/apply；受限 config section fallback | `22` |
| Data Driven | DataAsset、PrimaryAsset、DataTable JSON workflow、scan/query/sample、all-or-nothing DataTable apply | `24` |
| Physics 基础 | Capabilities、Primitive physics query/validate/patch plan、PhysicalMaterial、PhysicsConstraint、PhysicsAsset、runtime probe | `26` |
| Production Pipeline | Localization、StringTable、PO/report/culture preview、Packaging UAT plan/run/status/log/artifact/clean、Platform/Profile/SDK/DeviceProfile/Scalability | `27` |
| Node Graph | 普通 Blueprint、UMG 逻辑图、AnimBlueprint pin 图、Material / MaterialFunction 表达式图和可枚举横向 EdGraph 的通用 list/layout 入口 | `28` |

## 重要边界

- Project Settings 普通字段统一走 `project_settings_*`，业务分册不重复实现普通设置页字段编辑。
- 普通 `.ini` section 裸写只走受限 `config_*` fallback；平台 config、DeviceProfile、Localization target 等必须走专用 schema。
- Level Actor 持久内容 authoring 优先走 `level_content_*_json`；旧 Actor 原子写入命令只保留兼容、bootstrap、探针和局部补修。
- 关卡拓扑系统优先走 `level_topology_*`、`level_streaming_*`、`data_layer_*`、`world_partition_*`、`hlod_*`；不要把拓扑关系硬塞进普通 Actor CRUD。
- 复杂资产 authoring 优先走 JSON / folder JSON，不推荐通过原子写入命令完整手搓。
- Raw render resource、raw vertex/index/skin weight/morph delta/cloth simulation data、shader 内部缓存和 cook 内部依赖图不作为普通 JSON 手写面。
- 需要额外启用插件的能力不并入基础承诺；命令应先检查 feature/plugin availability，再返回 `feature_unavailable` 或等价诊断。
- PIE 操控不是当前主承诺。当前主要依赖 editor-safe runtime probe、trace、readback、compile log、screenshot 和 automation smoke。

## 可选插件与未承诺范围

以下能力可能已有部分读取、验证或 guard，但不作为“无需插件即可稳定完整 authoring”的基础能力：

- GAS / Gameplay Ability System
- PCG 深度图 authoring
- Chaos Vehicles
- Geometry Collection / Destruction
- Field System
- Chaos Cloth / Flesh / PhysicsControl
- Gameplay Debugger
- Networking/Replication 深度运行时调试
- Editor Utility 深度 UI workflow

这些模块如果要纳入正式命令集，应先单独做设计文档、冗余复查、插件可用性 guard、实现和 smoke。

## 质量门禁

每次新增或修改命令后应通过：

1. UBT build。
2. 对应 UE automation smoke。
3. `uai-cli release coverage`，确认 doc/implementation/smoke/actionable debt 为 0。
4. CLI release/source audit。
5. Dev/Pak 目标文件 hash 检查。
6. skill sync check，如修改 skill 路由。
7. touched files strict UTF-8 检查。
8. 无残留 `UnrealEditor`、`UnrealEditor-Cmd`、`CrashReportClient`。

UE 启动阶段可能存在非目标 warning/error 文本；判断结果以目标 automation result、report JSON、crash folder 和日志上下文为准。

## 当前维护重点

当前最大短板不是普通命令覆盖，而是工程化维护：

- 整理仓库 dirty/untracked/deleted 状态。
- 固化 CI / 发布门禁。
- 增加更真实的端到端 workflow 回归。
- 继续把用户任务导向 cookbook 和分册参数表分离维护。
