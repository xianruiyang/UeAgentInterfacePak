# UeAgentInterfacePak

> 本仓库把 UAI 的发布引用、Codex skills、UE 知识内容和分发文档放在一个 Pak 入口中。当前
> `codex/uai-development` 是开发与整理现场，不是已经通过正式门禁的发行包；文件存在、Git clean 或
> 示例曾经成功，都不等于对应能力在当前版本已验证。

## 快速导航

| 要做的事 | 入口 | 边界 |
| --- | --- | --- |
| 了解 Pak parent 与安装方式 | 本 README | 不从 parent README 推断具体 command 已可用 |
| 修改 UE 插件或正式命令文档 | `UeAgentInterface/` submodule | 进入插件 owner 仓库单独开发、测试和提交 |
| 修改公开 Python SDK、薄 CLI 或发布工具 | `UeAgentInterfaceCMD/` submodule | 进入 CMD owner 仓库单独开发、测试和提交 |
| 维护 Pak 直接分发 skill | [`skills/README.md`](skills/README.md) | 区分 Pak-owned、submodule、external owner 与 installed |
| 查询 UE 本地知识 | `skills/ue-kb/SKILL.md`、`skills/ue-kb/kb-manifest.json` | 大体积 payload 通过知识入口消费，不参加父仓库普通搜索 |
| 审计重构前证据 | [`retired/strict_v2/README.md`](retired/strict_v2/README.md) | history-only；no-import、no-runtime、no-authority |

## 项目目标与当前证据边界

UAI 的根本目标是让 LLM 能操作 Unreal Engine，并完成符合用户意图的高质量 UE 内容。长期覆盖目标包括
UE 基础创作面以及 PCG、Paper2D 等适用官方插件能力；这是目标，不是当前完成声明。当前能力是否成立，
必须回到对应 Plugin/CMD commit、正式文档、真实 mechanics、持久化、独立读回和实际内容验收，不能由
README、command 数量、binding、示例图或旧测试外推。

当前还需遵守这些现实边界：

- 质量优先；质量同等充分时再降低 Token 与操作压力，两者不退化时再提高速度。
- 实机实时调试不属于当前可承诺能力。模型交互延迟、缺少连续视频理解和长序列帧识别衰减，使它无法
  承担要求实时反应的操作；截图、相机控制和短序列帧只能支持有界观察，不能冒充实时调试。
- 截图与结构读回仍可能遗漏或误判，视觉结果需要多证据校验。
- 默认不弹出或抢占 UE 窗口，不进行全屏调试；需要前台交互时应先取得用户授权。
- 支持的 UE 版本、平台和模型组合应由具体发行提交及其构建/运行证据声明；本开发 checkout 不固定一条
  未验证的版本或“仅某模型可用”结论。

## 效果一览

下面是项目在不同阶段、不同人工监督强度下得到的探索性展示。它们说明 UAI 工作流曾经介入过哪些
方向，但不构成当前版本的稳定能力承诺，也不保证能自动复现同等结果。

| 水面材质 | Niagara 火焰 |
| --- | --- |
| ![水面材质效果](docs/images/showcase/waterMaterial.png) | ![Niagara 火焰效果](docs/images/showcase/fireNiagara.png) |
| 多轮观察与调整后的水面材质探索。 | 多轮调整形态、烟、余烬和热扰动后的 Niagara 探索。 |
| PCG 建筑 | 白盒关卡 |
| ![PCG 建筑体块效果](docs/images/showcase/pcgBuilding.png) | ![白盒关卡效果](docs/images/showcase/levelDesign.png) |
| PCG 建筑体块探索。 | 空间、路线和尺度验证的白盒尝试。 |
| UMG UI 复刻 |  |
| ![反复交互后的 UMG UI 复刻展示](docs/images/showcase/uiCopy.png) |  |
| 对照参考图与结构读回，多轮修正布局、字号、分组和局部细节。 |  |

## 仓库内容与生命周期

| 路径 | 当前职责 | 安装或维护边界 |
| --- | --- | --- |
| `UeAgentInterface/` | UE Editor 插件的发布 gitlink | 普通使用需要插件；修改进入 nested owner，Pak 只更新已验证提交的 gitlink |
| `UeAgentInterfaceCMD/` | 公开 `uai` SDK、薄 CLI 与发布工具的发布 gitlink | Agent 使用 SDK 时需要可定位；修改进入 nested owner |
| `skills/ue-agent-interface/` | Pak-owned UAI workflow 分发候选，含正式文档同步副本和内置 CLI | 使用 UAI workflow 时安装；Pak 与 installed 需单独同步验证 |
| `skills/ue-essential-knowledge/` | Pak-owned UE 核心知识导航分发候选 | 推荐；不承载任务级复盘 |
| `skills/ue-kb/` | Pak-owned UE 本地知识内容与索引分发候选 | 离线知识工作流使用；从 manifest/skill 进入 |
| `skills/kbcli-knowledge-base/` | kbCli runtime submodule 发布引用 | 由其外部仓库和 gitlink 管理，不做 installed-to-Pak 复制 |
| `understand-space`（外部） | AgentBase-owned 通用空间能力 | Pak 不保留同名副本；installed deployment 只跟随 AgentBase owner |
| `docs/images/` | 本 README 的展示与菜单图片 | 随包 |
| `retired/strict_v2/` | 重构前历史证据 | 不安装、不运行、不作为当前规范；逐消费者审计后才退出 |

当前 tree 没有 `releases/` 目录，因此本 README 不把它列为已有发布入口。正式 release manifest、notes 或
tag 只有在相应产物实际建立并通过发布门禁后才能被声明。

## 获取包内容

克隆或复制一个明确的 Pak 版本后，初始化 submodule：

```powershell
git submodule update --init --recursive
```

如果只需要插件，可以直接使用插件 owner 仓库，并放到目标项目的 `Plugins/UeAgentInterface/`。使用
整个 Pak 时，仍应确认 Pak gitlink、direct skills 与 intended release 属于同一验证集合；当前 nested
working tree 与 gitlink 不同，不会自动成为发布内容。

## 插件安装

1. 关闭目标 UE 项目和 Visual Studio。
2. 在目标项目根目录创建 `Plugins` 目录。
3. 将正式 Pak 中的 `UeAgentInterface/` 放到 `Plugins/UeAgentInterface/`。
4. 对 C++ 项目重新生成工程文件并执行非 Live Coding 的 Editor target 构建。
5. 打开 `.uproject` 并确认插件启用。

插件依赖以对应提交的 `UeAgentInterface.uplugin` 为准，不在 Pak README 复制一份容易失效的插件列表。
引擎版本或内置插件不匹配时，应先解决加载/编译问题，再使用 UAI 自动化。

## Skill 安装

完整工作流通常使用 `ue-agent-interface`；离线 UE 知识检索还会使用 `ue-kb` 和
`kbcli-knowledge-base`，`ue-essential-knowledge` 提供轻量主题导航。具体 owner 与同步边界见
[`skills/README.md`](skills/README.md)。

`C:/Users/<User>/.codex/skills/` 是机器 installed deployment，不是本仓库的另一份可随意反向覆盖真源。
Pak-owned skill 应从 Pak 向 installed 做有界同步和完整文件集检查；正式同步入口只接受已登记的 Pak
publication owner。`understand-space` 由 AgentBase 提供，不参加 Pak 同步，也不得从任意 Pak 同名路径
覆盖 installed。

`ue-agent-interface` 内置 `<SkillDir>/tools/uai-cli.exe` 作为回退入口。日常自动化优先定位正式
`UeAgentInterfaceCMD` 仓库并使用其公开 Python SDK：

```text
<UaiCmdRoot>/cli/uai
```

找不到 UAICMD 时先询问安装路径；只有确认没有可用开发入口或用户明确要求回退，才使用 skill 内置
CLI。不要把任意 `dist/uai-cli.exe` 或 PATH 中的裸命令当作隐式 fallback。

## 启动服务与连接

安装并启用插件后，从 Unreal Editor 菜单打开：

`Window` → `UeAgentInterface` → `Start UeAgentInterface Server`

![UE 菜单中的 UeAgentInterface 服务入口](docs/images/ue-agent-interface-menu.png)

当前正式客户端方向是一份 Connection TOML 加公开 `uai` SDK：

```python
import uai

with uai.connect("connection.toml") as ue:
    result = ue.query.command_search(
        "inspect the current editor runtime",
        limit=3,
    )
```

Python 只调用公开 SDK，不直接 HTTP，也不在客户端复制 UE 业务实现。每条 named method 或
`Client.execute()` 只应转发正式 manifest 中的一条真实 command；最终成功仍由该 command 的业务错误、
必要持久化和独立读回判断。

## 推荐工作流

1. 使用明确版本的插件、CMD 和 Pak skills，并确认它们的版本关系。
2. 启动 UE 项目，通过菜单开启 UAI Server；默认最小化或不抢焦点。
3. 先定位 UAICMD，优先使用公开 `uai` SDK；满足回退条件时才用 skill 内置 CLI。
4. 查询 command、node、component 或 actor candidate，直接消费正式返回的 identity，不在调用侧建立别名表。
5. 临时 Connection TOML、params、batch 和任务脚本写到用户工作区 `tmp/`；report、截图与运行日志写到
   `runtimeLogs/`，不写入 Pak 或 skill 目录。
6. 对复杂资产优先使用结构化 authoring；应用后检查错误、warning、compile/settle、dirty resource、
   持久化、独立读回与必要截图。
7. 真实任务暴露基础能力缺口时，在正确 Plugin/CMD/knowledge owner 修复，再回到原内容复验。

## 知识库使用

`ue-kb` 是 portable knowledge content，`kbcli-knowledge-base` 提供查询 runtime。Hybrid 查询需要对应
vector service 与 embedding 环境；环境不完整时可降级到 keyword 或直接阅读 Markdown，但必须说明
降级状态，不能把 keyword-only 结果描述成 Hybrid。

最低限度的只读入口是：

- `skills/ue-kb/SKILL.md`
- `skills/ue-kb/kb-manifest.json`
- `skills/ue-kb/references/guides/standalone.md`
- `skills/ue-kb/references/maps/topic-map.md`
- `skills/ue-kb/references/maps/source-layout.md`

`ue-kb` 以及 `ue-agent-interface/knowledge/niagara-bplus` 内的大体积 `content/`、`chunks/`、
`references/`、`data/`、`indexes/` 和 `state/` 是有意分发 payload；Pak parent 的 `.ignore` 只让它们
退出普通发现，不改变 tracking 或知识职责。

## 普通发现合同

从 Pak parent 做普通 `rg`、`fd` 或 `srcq` 发现时，根 `.ignore` 默认跳过：

- 三个 nested repository；
- `retired/strict_v2/` 历史面；
- `ue-kb` 与 UAI skill 内嵌 Niagara knowledge 的大体积 packaged payload。

需要维护某个 owner 时，进入对应 nested repository 或使用明确路径；需要审计被排除对象时显式使用
`--no-ignore`。不要删除 `.ignore` 来做日常浏览，也不要把它当作内容不可达或可以删除的证据。

根 `.gitignore` 只排除 runtime、cache、临时、虚拟环境、package metadata 和 skill-local report 等
可重建本地输出。Knowledge indexes、内置 CLI、templates 和正式 docs 是分发内容，不因“generated”或
二进制形态自动进入 ignore。

## 开发与发布维护

- Plugin、CMD 与 kbcli 是独立仓库；先在正确 owner 形成提交和证据，再由 Pak 更新 gitlink。
- `ue-agent-interface`、`ue-essential-knowledge` 与 `ue-kb` 是 Pak 直接分发候选；修改后需按正式同步流程
  更新 installed 并做完整一致性检查。
- Plugin/CMD 正式文档进入 `ue-agent-interface/docs/` 时，只同步适合日常 skill 阅读的内容；deprecated、
  generated coverage、临时调试与任务复盘不得进入分发副本。
- Skill 内 CLI 来自 CMD 的正式构建；刷新时在 `tools/uai-cli.release.json` 记录 CMD 来源提交、公开 CLI 版本和 artifact hash，并只分发当前 Connection TOML 模板，再验证 packaged executable。
- `release dev-mirror` 只用于本地镜像或排查，不是正式发布。
- 正式发布必须使用当前项目政策与对应 CMD 版本登记的门禁，验证 clean commit/tree、submodule gitlink、
  skill/installed parity、包 hygiene 和适用测试；本 README 不把命令存在或一次旧结果当成准入。
- GitHub push、tag、Release 和远端发布仍是用户边界；Codex 自管开发提交不会自动进入用户主线或远端。

## 参考

- [Epic：Plugins in Unreal Engine](https://dev.epicgames.com/documentation/unreal-engine/plugins-in-unreal-engine)
- [Epic：Working with Plugins](https://dev.epicgames.com/documentation/unreal-engine/working-with-plugins-in-unreal-engine)
- [Git：git-submodule](https://git-scm.com/docs/git-submodule)
