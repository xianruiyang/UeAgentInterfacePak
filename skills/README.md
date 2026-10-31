# Skills 生命周期入口

本目录是 Pak 的 skill 发布投影。开发内容、installed 副本、外部 owner 与历史副本按下表分别维护；
Pak working tree 不自动改变当前机器正在消费的 installed 版本。

| 路径 | 当前职责 | 维护边界 |
| --- | --- | --- |
| `ue-agent-interface/` | Pak 直接持有的 UAI workflow 分发候选 | 正式命令文档来自 Plugin/CMD owner；当前机器需要消费改动时显式同步 installed |
| `ue-essential-knowledge/` | Pak 直接持有的 UE 关键基础知识、设计原理与分类导航 | 包括关卡设计、白盒和游戏框架；不承载 UAI 操作协议、任务复盘或临时调试结论 |
| `ue-kb/` | Pak 直接持有的 UE 知识内容与索引分发候选 | 从 `SKILL.md` 与 `kb-manifest.json` 进入；大体积 payload 默认不参加 Pak parent 普通搜索 |
| `kbcli-knowledge-base/` | 外部 kbCli runtime 的 Git submodule 发布引用 | 通过 submodule owner/version 更新；不得用 installed-to-Pak 文件复制覆盖 |
| `understand-space`（外部） | AgentBase-owned 通用空间能力 | 本目录不保留同名副本；installed deployment 跟随其外部 owner |

`C:/Users/<User>/.codex/skills/` 是当前机器的 installed deployment，不属于本仓库 Git 真源。Pak-owned
skill 通过明确的 Pak → installed 命令直接同步；AgentBase-owned `understand-space` 不参加这条同步。

安装时将需要的 Pak-owned skill 整个目录复制到 Codex 的 skills 目录。更新已有同 owner 副本前保留
本地修改，再以新目录替换，避免仅合并文件而留下旧 exe、旧模板或已删除文档。`kbcli-knowledge-base`
按其自身安装说明部署运行时；不要把外层 GptProjectTest 的同步脚本当作 Pak 必带入口。

## 普通发现

Pak 根 `.ignore` 默认跳过 `ue-kb` 以及 `ue-agent-interface/knowledge/niagara-bplus` 的 chunks、content、
data、indexes、references 与 state payload，但保留本文件、各 skill 的 `SKILL.md`、manifest 和轻量
入口可见。维护知识 payload 时使用明确路径或 `--no-ignore`；不要为了让父仓库搜索更短而删除、搬移
或重新生成分发内容。

Skill 内容正确性由其实际消费者负责；本导航只定义 owner 与生命周期。

kbCli Release 的可执行版本必须由 active installed `kbcli-knowledge-base` 运行
`version --json`/`doctor --json` 读回；Pak submodule 的 Git HEAD 或文件存在不自动成为 UAI 消费
版本。`kb-models.json` 是机器级绑定，不要求随 Pak 分发，但缺失时 Hybrid 必须按目标 KB 的状态诊断
后精确降级。三类 Pak-owned UE/UAI skill 的交叉职责与真实消费入口统一见
[`ue-agent-interface/references/verification-and-knowledge.md`](ue-agent-interface/references/verification-and-knowledge.md)。
