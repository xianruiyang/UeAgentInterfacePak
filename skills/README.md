# Skills 生命周期入口

本目录是 Pak 的 skill 发布投影，不是“目录存在即已验证”的能力清单。开发内容、installed 副本、外部
owner 与历史副本必须按下表分别维护；未经正式同步和验证，Pak working tree 不自动代表当前机器生效
版本或可发布版本。

| 路径 | 当前职责 | 维护边界 |
| --- | --- | --- |
| `ue-agent-interface/` | Pak 直接持有的 UAI workflow 分发候选 | 正式命令文档来自 Plugin/CMD owner；内置 CLI 是回退入口；修改后须单独验证并同步 installed |
| `ue-essential-knowledge/` | Pak 直接持有的 UE 核心知识导航分发候选 | 只承载跨任务稳定的分类入口，不承载任务复盘或临时调试结论 |
| `ue-kb/` | Pak 直接持有的 UE 知识内容与索引分发候选 | 从 `SKILL.md` 与 `kb-manifest.json` 进入；大体积 payload 默认不参加 Pak parent 普通搜索 |
| `kbcli-knowledge-base/` | 外部 kbCli runtime 的 Git submodule 发布引用 | 通过 submodule owner/version 更新；不得用 installed-to-Pak 文件复制覆盖 |
| `understand-space`（外部） | AgentBase-owned 通用空间能力 | 本目录不保留同名副本；installed deployment 只跟随 `D:/program/AgentBase` owner |

`C:/Users/gzxt/.codex/skills/` 是当前机器的 installed deployment，不属于本仓库 Git 真源。Pak-owned
skill 只有在明确的 Pak → installed 同步和完整一致性检查后才进入当前机器；AgentBase-owned
`understand-space` 不参加这条同步。

## 普通发现

Pak 根 `.ignore` 默认跳过 `ue-kb` 以及 `ue-agent-interface/knowledge/niagara-bplus` 的 chunks、content、
data、indexes、references 与 state payload，但保留本文件、各 skill 的 `SKILL.md`、manifest 和轻量
入口可见。维护知识 payload 时使用明确路径或 `--no-ignore`；不要为了让父仓库搜索更短而删除、搬移
或重新生成分发内容。

Skill 内容正确性、installed parity、kbcli 版本和 external `understand-space` owner parity 属于独立验证 lane。
本导航只定义 owner 与生命周期，不替代这些结果。

kbCli Release 的可执行版本必须由 active installed `kbcli-knowledge-base` 运行
`version --json`/`doctor --json` 读回；Pak submodule 的 Git HEAD 或文件存在不自动成为 UAI 消费
版本。`kb-models.json` 是机器级绑定，不要求随 Pak 分发，但缺失时 Hybrid 必须按目标 KB 的状态诊断
后精确降级。三类 Pak-owned UE/UAI skill 的交叉职责与真实消费入口统一见
`ue-agent-interface/references/ue-knowledge-routing.md`。
