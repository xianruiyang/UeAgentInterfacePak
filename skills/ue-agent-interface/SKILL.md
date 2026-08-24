---
name: ue-agent-interface
description: 通过 UeAgentInterfaceCMD 的公开 uai Python SDK 驱动当前项目的 Unreal Editor；用于 UE 状态读取、资产增删查改、结构化 HJSON authoring、Blueprint/UMG/Material/Sequence/Niagara/Animation/IK/Modeling/PCG/NodeGraph 工作流、真实读回验证和安全的编辑器生命周期操作。Python 只转发正式 manifest 中的一条真实指令，不实现第二套 UE 业务，也不直接调用 HTTP。
---
# UE Agent Interface

本 skill 是 Agent 通过 UAI 操作 Unreal Editor 的入口。公开边界由 C++ 正式
command manifest、生成的 Python binding、统一 Result 协议和 Connection TOML
组成；`uai.command.v1` 是当前 wire protocol。

## 必须遵守的边界

1. 普通调用只使用 `import uai` 和 `uai.connect(<connection.toml>)`。
2. 每个 `ue.<namespace>.<command>(...)` 只转发一条同名真实 command；Python
   不实现 HJSON、Planning、State、Verification、领域规则、业务默认值或隐藏重试。
3. 命名方法、`Client.execute()` 与 CLI 必须共用同一个 Client、Protocol 和
   Transport。当前只实现 HTTP Adapter，但调用方不能依赖 HTTP 类型，也不得直接
   调用 HTTP。
4. 能力和参数以
   `Plugins/UeAgentInterface/Resources/UaiCommandManifest.json` 与
   `UeAgentInterfaceCMD/cli/uai/commands/generated.pyi` 为准。正式 manifest
   没有的能力必须 fail closed，不回退旧实现、不扫描源码猜参数、不新增临时替代
   指令。不知道 command 名称时，通过默认 binding 或普通 CLI 调用
   `query.command.search`，再用返回的精确 ID/hash 调用 `query.command.detail`；
   读取其字段、调用模板和稳定教程引用后才执行，不导入任务级 helper。
5. 多步骤工作流由 Agent 显式逐条调用；每一步只依据真实 Result 和独立 readback
   决定是否继续。
6. 写命令成功不等于任务完成。必须用正式读取 command 独立读回，并按资产类型
   补充 compile、save、probe、screenshot 或 diff。
7. 复杂资产优先使用服务端提供的结构化 HJSON export/apply/readback；不得在
   Python 中复制 HJSON 语义或手写完整 readback。
8. 当前项目真实状态以 UAI readback/runtime probe 为准。教程、模型记忆、静态
   配置和文件存在性不能替代项目读回。
9. 默认复用并保持用户的主 Unreal Editor。只有插件或 Editor C++ 普通编译、
   有证据确认必须关闭/重启，或用户明确要求时才关闭；不得使用 Live Coding。需要关闭时先
   读取 exact dirty resource，再使用项目 `scripts/ue/SafeExitLifecycle.py`；不得手工拼
   `external_witness`，也不得以 accepted、transport disconnect、PID 消失或强杀代替 durable
   terminal。
10. UE Automation 只能由项目正式 Runner 启动 owned worker。无渲染测试使用
    unattended NullRHI worker；需要 RHI 时使用 unattended RHI worker；普通
    CRUD、readback、probe 和 screenshot 复用主 Editor。
11. 只读 source/reference 可访问正式允许的 mount；创建、覆盖、移动、删除目标
    只允许服务端契约认可的路径，不为绕过校验改写目标。
12. 临时参数与 HJSON 写入 `<UserWorkDir>/tmp/uai_params/`，程序日志和 report
    写入 `<UserWorkDir>/runtimeLogs/`，不写进 skill 目录。
13. 为任务、回归、实验或一次性输出创建、迁移或清理 UE package 前，读取
    [Content workspace lifecycle](docs/UeAgentInterface/contracts/content_workspace_lifecycle.md)。
    Plugin 正式文档是事实 owner，本副本只负责路由；路径本身不构成清理授权。

## 入口定位

- `ProjectRoot`：从当前目录向上定位 `.uproject`，或使用用户明确路径。
- `UaiCmdRoot`：用户明确路径 -> `<ProjectRoot>/UeAgentInterfaceCMD` -> 当前
  工作区及父目录候选。
- 有效开发入口必须包含 `<UaiCmdRoot>/cli/uai/`、Connection TOML 和正式
  manifest 对应的生成 binding。
- 找不到开发入口时，先确认安装路径；确认不可用后才使用
  `<SkillDir>/tools/uai-cli.exe`，且仍须提供 Connection TOML。
- 不使用项目旧 `dist` 产物、PATH 中来源不明的裸命令或直接 HTTP 作为 fallback。

## 按需阅读

- Python SDK、Connection TOML、CLI、缺失能力和写后读回：
  `references/public-sdk-playbook.md`
- UE Essential Knowledge、UE KB、专项教程和项目读回选择：
  `references/ue-knowledge-routing.md`
- 单文件/folder HJSON 导航、字段、特殊字符、编辑和验证：
  `references/structured-hjson-editing.md`
- Niagara 制作与修复：`references/niagara-vfx-authoring.md`
- Control Rig、动画 IK 和 Shape Library：
  `references/control-rig-animation-authoring.md`
- Audio/MetaSound/SoundCue 当前正式领域合同：
  `docs/UeAgentInterface/active/t21_audio_domain.md`
- Sequence、LevelSequence 与 WidgetAnimation 当前正式领域合同：
  `docs/UeAgentInterface/active/t22_sequence_domain.md`
- Animation Curve、Montage 与相关资产当前正式领域合同：
  `docs/UeAgentInterface/active/t23_animation_curve_domain.md`
- ControlRig、IKRig、IKRetargeter 与 Skeleton 当前正式领域合同：
  `docs/UeAgentInterface/active/t24_animation_rig_graph_domain.md`
- HJSON 正式总入口：`docs/UeAgentInterface/HjsonAuthoring_Guide.md`
- 当前 Python/CLI 行为：`docs/UeAgentInterfaceCMD/PYTHON_SDK_AND_CLI.md`
- 102 条 typed CRUD、目标/字段解析、revision、C8D/C9 与旧写入口终态：
  `docs/UeAgentInterface/contracts/simple_authoring_typed_crud.md`
- 长任务、Editor session、Capture、operation lifecycle、safe-exit 与 artifact readback：
  `docs/UeAgentInterface/contracts/long_running_session_public_commands.md`

只加载当前任务需要的 reference、manifest 条目、binding 签名、KB chunk 和 HJSON
文件；内容未变化且当前上下文已有可信证据时不重复加载。

## 执行流程

1. 明确目标资产/世界、编辑范围、预期状态、破坏性边界和验收方式；涉及坐标或
   布局时建立 space contract。
2. 若需要 UE 原理或版本依据，定向读取相关知识；知识不能替代当前项目读回。
3. 用 UAI Query/readback 获取当前状态。
4. 从正式 manifest 选择一个 command，并按生成 binding 构造参数；能力缺失时
   停止并报告服务端缺口。
5. 通过 `import uai`、`uai.connect(...)` 调用一个命名方法；自动化脚本需要动态
   ID 时才用 `Client.execute()`。
6. 若为写操作，调用独立读取 command 验证持久状态，再完成必要的
   compile/save/probe/screenshot/diff。
7. 失败时读取稳定 Result/Error，不自动重放写操作；若指令返回成功却没有完成其
   语义，保留输入、结果、读回和日志证据，修复服务端实现与测试，不长期绕路。
8. 清理 Agent 创建的临时资产、测试线程和无继续价值的服务；保持用户主 Editor
   运行。

## HJSON 原则

- 导出内容应方便 LLM 使用，只暴露完成当前编辑所需的结构化字段；token 控制通过
  投影、字段分层、引用和文件拆分实现，不使用硬性 token 拒绝门禁。
- folder 导航顺序由正式 ExportProfile、`included_files`、`read_order` 和实际
  ref 决定；不得补造不存在的 manifest/index/reference。
- 默认只读目标、直接 refs 和必要 owner context，不加载无关 sibling、raw、
  readonly、debug、coverage 或 full readback。
- 同一 owner 同时出现 inline 属性和对应 grouped details ref 时，必须停止并报告
  冲突，不覆盖、合并或猜测优先级。
- 有可靠结构化 `value` 时不重复输出 `value_text`；结构意图和普通值修改保持
  分离；enum/choice 使用结构化 selected value。
- 蓝图等图资产的类属性、节点属性、节点图与连接应通过统一对象/属性/关系模型和
  独立投影组合，不能由 Python 或特定领域捷径重建。

## 输出

完成 UAI 任务时说明所用公开 SDK/CLI、Connection TOML 路径、输入与 artifact
路径、关键 Result、独立 readback/compile/probe/screenshot/smoke 验证，以及
dirty resource、Editor 和测试进程状态。不得输出认证 secret。
