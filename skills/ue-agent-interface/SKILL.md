---
name: ue-agent-interface
description: 优先使用已定位的 UeAgentInterfaceCMD 仓库中的 uai_core Python API 驱动当前项目内的 UeAgentInterface Unreal Editor 服务；UeAgentInterfaceCMD 通常在项目根目录但不保证如此，找不到时必须先向用户确认是否已安装及安装路径，确认没有可用 UeAgentInterfaceCMD 后再回退到 skill 内置 uai-cli.exe。适用于 UE 编辑器自动化、资产制作、JSON/文件夹式结构化工作流、Blueprint/UMG/Material/Sequence/Niagara/Animation/IK/Modeling/PCG/NodeGraph 指令、smoke 验证和安全的编辑器生命周期操作。不要直接调用 HTTP。
---
# UeAgentInterface Skill

本 skill 是 UAI 工作流入口和安全路由，不是命令参数手册。完整参数、返回字段、示例和边界以 `<SkillDir>/docs/` 中同步的正式文档为准。

## 核心规则

1. 优先使用已定位 `UeAgentInterfaceCMD` 仓库中的 Python `uai_core`；不要直接调用 HTTP。
2. `UaiCmdRoot` 是 `UeAgentInterfaceCMD` 仓库根目录，默认候选是 `<ProjectRoot>/UeAgentInterfaceCMD`，但不能写死。
3. 自动找不到 `UeAgentInterfaceCMD` 时，先问用户安装路径；只有用户确认没有可用 UAICMD 或明确要求回退时，才用 `<SkillDir>/tools/uai-cli.exe`。
4. Python 直连模式优先调用 `uai_core.commands.*`；多步骤任务用 `ue.batch(..., stop_on_error=True)` 或等价 fail-fast 批处理。
5. 长 JSON、plan、vars、batch、folder payload、report 和任务脚本写入 `<UserWorkDir>/tmp/uai_params/` 与 `<UserWorkDir>/runtimeLogs/`，不要写到 skill 目录。
6. 写操作前先查清命令参数、默认值、副作用、返回字段和验证方式；不确定时先读正式命令文档或导出/readback。
7. 每次写操作后读取 `CommandResult.response`、`BatchResult.response` 或 CLI report JSON；失败时根据 `failed_index / failed_command / failed_error` 定位根因。
8. 支持结构化 JSON / folder authoring 的资产，优先导出后直接编辑 `authoring` / `minimal_authoring` JSON；新增内容只写最小 authoring 结果，再 apply/readback 补全，不手写完整 readback。
9. 原子命令只用于 bootstrap、只读探针、迁移、schema 边界、局部修补和故障恢复；deprecated 命令不能作为新 authoring 主流程。
10. 新增节点、模块、组件、控件、Material expression 或 Niagara dynamic input 前，优先用 `node_catalog_search` 获取 `kind/name/full_name/json_authoring` seed；必要时再用 `node_origin_resolve` 查资产或源码路径。
11. 复用当前 UE Editor 会话；除非必要，不启动第二个编辑器实例。需要启动时使用项目既有最小化/no-activate 入口。
12. 不运行全屏 game 测试；默认使用最小化、headless、readback、runtime probe、截图或 `UnrealEditor-Cmd.exe -NullRHI -unattended` 验证。
13. 资产写入后按资产类型做编译、读回、smoke、截图、runtime probe、coverage 或 Stack issue 验证；不能只看命令成功。

## 路径约定

- `SkillDir`：当前 `SKILL.md` 所在目录。
- `UserWorkDir`：用户当前工作目录或当前任务工作区。
- `ProjectRoot`：目标 UE 项目根目录；从当前目录向上查找 `.uproject` 或使用用户明确路径。
- `UaiCmdRoot`：已定位的 `UeAgentInterfaceCMD` 仓库根目录。
- `UAICorePath`：`<UaiCmdRoot>/cli/uai_core`。
- `FallbackCli`：`<SkillDir>/tools/uai-cli.exe`，只在确认不能使用 UAICMD 后使用。

`UaiCmdRoot` 定位顺序：

1. 用户本轮明确给出的路径。
2. `<ProjectRoot>/UeAgentInterfaceCMD`。
3. `<UserWorkDir>` 及其父目录下的 `UeAgentInterfaceCMD`。
4. 当前工作区内可低成本确认的候选。
5. 仍找不到时向用户确认，不直接回退 CLI。

## 必读路由

按任务只读需要的文件，不全量加载无关文档：

- 日常命令速查：`references/command-map.md`
- Python `uai_core` 定位、模板和脚本写法：`references/uai-core-python-playbook.md`
- 批处理和 fail-fast：`references/batch-execution-playbook.md`
- CLI 回退、crash、release gate：`references/cli-diagnostics-release.md`
- Niagara 视觉效果制作/修复：`references/niagara-vfx-authoring.md`
- Control Rig、动画 IK、Shape Library：`references/control-rig-animation-authoring.md`
- 结构化 JSON 总入口：`docs/UeAgentInterface/JsonAuthoring_Guide.md`
- 直接 JSON authoring 主链路：`docs/UeAgentInterface/json-authoring/00_DirectJsonAuthoring.md`
- 具体命令参数和返回字段：`docs/UeAgentInterface/commands/*.md`
- CLI 细节：`docs/UeAgentInterfaceCMD/USAGE.md`

skill 内同步文档不包含 `deprecatedCommand/**`。如历史兼容确实要读 deprecated 文档，必须回到插件仓库归档文档确认边界，并说明迁移理由。

## UE 工作流程

1. 分析用户需求：明确资产、效果、编辑范围、风险、验收方式和是否涉及空间语义。
2. 涉及 UE 概念、资产体系、Blueprint、Material、Niagara、动画、渲染或调试时，先读 `ue-essential-knowledge` 相关分类；再按需读 `ue-kb` 和其它相关 skill。结构化 JSON / UAI 指令内部实现以本地 UAI 源码、正式文档和实测为准，不用 KB 替代。
3. 查找需要的 UAI 指令，确认参数、默认值、副作用、返回字段和验证方式。
4. 如涉及节点或模块，先用当前 UE 真实查询能力确认候选；不要凭记忆拼名称。
5. 涉及位置、方向、坐标、transform、屏幕/UI 布局、视觉构图或截图验收时，必须使用 `understand-space` 建立空间语义和读写/验收坐标系。
6. 拟定可执行方案：资产路径、命令序列、JSON 修改点、预期读回字段、验收方法和失败处理。
7. 执行时 fail fast；发现方案与真实读回冲突时先修正方案。
8. 完成后验收 response/report、编译结果、日志/Stack、关键参数读回、runtime probe、截图、dirty resource 和保存状态。
9. 验收失败时先补证据再定位根因，不继续堆无关命令。

## 结构化 JSON Authoring

默认路线：

`export/readback -> 直接编辑 authoring/minimal_authoring JSON -> validate/lint/adapter -> apply -> export/readback -> 类型化验收`

- 用 `node_catalog_search` 的 `json_authoring` 或 seed 新增可支持对象；只补必要上下文和值，apply 后重新读回；JSON 主身份字段是 `kind/name/full_name`。
- `node_origin_resolve` 只用于查路径和解析状态，不打开 IDE、不聚焦 Content Browser、不做 UI 操作。
- Python 可辅助批量生成、参数化调用、adapter 调试或重复变量替换，但不应代替直接 JSON authoring 成为主流程。
- 旧字段只用于 adapter 兼容、readback 或 legacy 输出；新教程和新 authoring 不以旧字段作为主路径。
- 写入前后都要读回；只读到“字段存在”不等于运行时使用它，特别是 Niagara mode/static switch、Renderer binding、UMG slot、Blueprint pin、Material root input 等分支。

## 调用摘要

Python 直连：

1. 定位 `ProjectRoot` 和 `UaiCmdRoot`。
2. 将 `<UaiCmdRoot>/cli` 加入 `sys.path`。
3. `from uai_core import UaiCore`。
4. `ue = UaiCore.from_config(require_token=True)`。
5. 先 `ue.doctor()`，失败则停止写操作。
6. 调用 `uai_core.commands.*` 或 `ue.batch(..., stop_on_error=True)`。
7. 将 response/report 用 UTF-8 写入 `<UserWorkDir>/runtimeLogs/`。

CLI 回退：

1. 只使用 `<SkillDir>/tools/uai-cli.exe`。
2. 先跑 doctor/compat 类只读检查。
3. `run` 用于可复用 plan，`batch` 用于一次性批处理。
4. 所有 report 写入 `<UserWorkDir>/runtimeLogs/`。

## 领域专项入口

- Niagara：完整效果制作走 folder JSON；先读 `references/niagara-vfx-authoring.md`，再读 Niagara command docs。重点验收 compile log、Stack issue、module input 活跃分支、Renderer/material、runtime probe 和截图。
- Control Rig / 动画 IK：先读 `references/control-rig-animation-authoring.md`。Control Rig、AnimBlueprint、AnimSequence 曲线、Trace/Collision 分层验证，不用单张截图替代读回。
- Blueprint / UMG / Material / Sequence / PCG：优先导出 folder JSON；新增节点先走 `node_catalog_search`，再把 seed 写进 JSON。
- Project Settings / Config、DataAsset、DataTable、Curve、Montage 等单文件资产：优先单文件 JSON round-trip。
- 资产删除、编辑器关闭、release、crash 排查等高风险操作：先读对应命令文档或 diagnostics reference，确认 dry-run、dirty、引用、路径范围和清理策略。

## 输出要求

完成 UAI 操作后说明：

1. 调用入口：`<UaiCmdRoot>/cli/uai_core` 或 `<SkillDir>/tools/uai-cli.exe`。
2. `UaiCmdRoot` 来源；若使用 CLI 回退，说明用户已确认无可用 UAICMD 或明确要求回退。
3. 使用模式：Python wrapper、Python batch、CLI run 或 CLI batch。
4. Python 脚本、输入 JSON、folder JSON、response/report 路径。
5. 成功/失败、失败索引和关键错误。
6. 已执行验证。
7. 剩余 warning、dirty resource、editor/process 清理状态。
