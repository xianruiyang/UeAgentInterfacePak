# UE Knowledge And Tutorial Routing

本页区分 UE 通用知识、版本教程、UAI 命令契约和项目真实状态。它们可以串联，但不能互相替代。

## 信息层级

| 信息 | 默认入口 | 用途 |
| --- | --- | --- |
| UAI 命令契约 | C++ 正式 manifest、生成 binding | 命令名、参数、返回、副作用和验证 |
| UE 核心知识 | `ue-essential-knowledge` | 对象、资产、Blueprint、Material、Niagara、动画、世界、渲染等机制 |
| UE 版本知识和教程 | `ue-kb` | 官方文档、版本敏感行为、完整工作流和社区实践 |
| 领域专项教程 | 对应专项 KB，例如 `uai-niagara-bplus` | 效果拆解、模块组合、材质和案例流程 |
| 项目当前事实 | UAI readback/probe、源码或等价 runtime probe | 当前 Editor、资产、关卡、编译和运行结果 |

## 唯一 owner 与消费合同

| 层 | 唯一 owner / 正式来源 | 运行时消费与版本证据 | 失效和降级 |
| --- | --- | --- | --- |
| UAI 命令行为 | Plugin C++ command manifest；CMD 生成 binding 与正式 SDK/CLI 文档 | `ue-agent-interface` 只消费当前 manifest、`uai.command.v1` 和实际 Connection TOML；不确定时查询当前 command detail | command 缺失、schema 不匹配或 readback 失败时停止相关 UE 写入并报告能力缺口；不改用直接 HTTP、旧 CLI 或 Python 第二实现 |
| 高价值阅读导航 | Pak-owned `ue-essential-knowledge`，单向同步到 installed | 文件内容与 Pak -> installed 一致性是部署身份；它没有权威 UE 事实版本 | 分类仍是框架或条目缺失时明确报告，再进入 `ue-kb`、官方文档、源码或项目读回；不得按模型记忆补成事实 |
| UE 版本知识 | `ue-kb/kb-manifest.json` 登记的 source；官方文档、引擎源码或明确 Supplemental source 才是事实来源 | `content_version`、`source_id`、source fingerprint/更新时间、`chunk_id` 和 source URL 定位本次证据；FTS/vector 是可重建投影 | Hybrid 依赖不完整时先报告精确状态，再按该 skill 合同降级 keyword 或 standalone Markdown；不得把降级结果称为 Hybrid |
| 通用 KB 运行时 | external `D:/program/RagTest` / `kbcli-knowledge-base` | 每次从 active installed skill 解析 Release，读取 `kb version --json`、`doctor` 和目标 manifest 状态；RagTest Git HEAD 不替代消费版本 | runtime 不可执行时只保留直接来源读取；机器模型绑定缺失只使 vector/Hybrid 不可用，不等于 UE 知识内容失效 |
| 通用空间意图 | AgentBase-owned `understand-space`，installed 是活动消费者 | 使用 AgentBase owner 与 installed parity；Pak 不保留同名投影，正式同步入口拒绝 external owner | 空间任务缺少该合同或 frame/identity 未决时停止依赖空间结论的写入；不影响与空间无关的 UAI 读取 |

Pak-owned 三个 UE/UAI skill 只按 Pak -> installed 单向同步。installed 是当前机器消费面，
不是反向真源；Pak 不保留 `understand-space` 同名投影，该能力只解析 AgentBase owner。不同层发生冲突时，
分别回到其 source/version owner 和当前项目 readback 判断“预期”与“现状”，不能按 skill 命中顺序
拼接，也不能用当前运行结果静默改写规范。KB source 的 UE 版本与当前产品引擎不一致时，只能把
该 source 用作明确标注的背景或检索线索；版本相关行为必须回到当前引擎源码、当前 manifest 和
真实产品 readback，不能用较新文档替代当前版本证据。

## 决策顺序

1. 命令和当前用法已知、任务不需要额外 UE 原理时，直接执行，不读取 KB。
2. 需要理解 UE 概念、系统约束或验证方法时，只读 `ue-essential-knowledge` 的相关分类。
3. 需要版本依据、官方资料、完整制作教程或 essential knowledge 不足时，查询 `ue-kb`。
4. 需要专项案例时查询对应专项 KB；Niagara BPlus 使用 `uai-niagara-bplus`。
5. 教程给出目标状态、步骤依赖和验收思路后，再从正式 manifest 和生成 binding 选择 UAI 命令。
6. 结论涉及当前项目时，必须回到 UAI readback/probe 确认。

跨系统任务按“核心概念 -> 具体系统 -> 调试/验证 -> UAI authoring”读取，不一次加载所有分类。涉及坐标、方向、transform、屏幕或布局时同时使用 `understand-space`。

## KB 查询

1. 使用目标 KB skill 声明的精确 `kb-manifest.json`。
2. kbCli 运行时通过 `kbcli-knowledge-base` skill 解析，不使用 PATH 裸 `kb` 或源码 Debug build。
3. 默认 Hybrid；查询使用 source language，并保留 UE 类名、节点名、模块名等英文标识符。
4. search 只定位候选；形成结论前 fetch 少量关键 chunk。
5. 保留 `chunk_id`、`source_path` 和已有 source URL；区分官方文档与 Supplemental/社区来源。
6. Hybrid 不可用时说明缺失依赖，再降级 keyword；不能把 keyword-only 称为 Hybrid。
7. 已有可信且未过期的教程结论时不重复查询。

## 从教程到执行

- 从教程提取目标状态、必要资产、约束、步骤依赖和验收方式，不直接复制为 UAI 参数。
- 教程中的节点、模块和其他可创建内容先通过 `query.command.search/detail` 定位对应领域的
  exact candidate command，再在真实创建上下文中查询；已有资产和对象通过正式内容/资产
  查询或当前 UE 读回确认。不得恢复 `node_catalog_search` 作为全局目录。
- 教程与当前引擎版本、插件能力或项目读回冲突时，以当前版本事实和项目读回为准。
- 教程未覆盖 apply/readback 边界时，不猜 HJSON 字段；回到 authoring contract、实际导出和 readback。

## 真实纵向案例：Level viewport 取景与截图

当目标是把真实关卡内容取景后截图，projection type 会改变计划和 oracle，应同时触发三个层次：

1. `ue-essential-knowledge` 的
   `references/07-world-level-rendering/viewport-projection-and-framing.md`
   将投影类型列为显式空间与验证维度。
2. `ue-kb` 查询 UE 5.7 的 `Viewport Toolbar` / `CameraComponent` 来源，作为 Perspective、
   Orthographic 和 Projection Type 的可定位背景；search 只定位，结论前 fetch source chunk。
   当前项目产品运行于 UE 5.6，因此这些 5.7 chunks 不拥有 5.6 行为结论。
3. 从正式 manifest 使用 `viewport.instance.list`，只为 perspective 图像目标选择
   `viewport_type=perspective`，冻结同一 `viewport_ref`，再执行 state read、camera frame、
   capture、restore 和最终 readback。

T52 的真实七 Actor 白盒消费者直接证明了该知识会改变结果：未区分投影时选到正交 viewport，
frame/restore 失败；保持原 frame policy、只选择同 world 的 perspective viewport 后，frame、
512x200 PNG capture、像素/内容 oracle、restore 以及两次正式 owned-worker run 均通过。证据入口是
`plan/results/TROOT-UAI-52-OWNED-RHI-REAL-CONTENT-VISUAL.r10.json`。这不证明非透视
`viewport.camera.frame` 的行为。该 UE 5.6 产品结果和当前 Plugin 实现才是本案例的行为证据，
5.7 文档只解释为何 projection type 值得作为候选验证维度。

相近非触发场景：若当前 command 和语义已知，只读取 `editor.dirty_resources` 或查询 command detail，
且不需要 UE 机制、版本依据或空间判断，只使用 `ue-agent-interface`，不加载 essential knowledge、
`ue-kb` 或 `understand-space`。

## Token 边界

- 不为已知执行读取 KB。
- 不加载整套 essential knowledge、整个 KB、全部搜索结果或完整长教程。
- 只 fetch 支撑当前判断的 chunk；大段来源不进入默认上下文。
- KB 结论、正式 manifest 条目、binding 签名和项目 readback 各自按当前 context 复用，不重复注入。
