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
- 教程中的节点、模块、类和资产名通过 `node_catalog_search`、资产查询或当前 UE 读回确认。
- 教程与当前引擎版本、插件能力或项目读回冲突时，以当前版本事实和项目读回为准。
- 教程未覆盖 apply/readback 边界时，不猜 HJSON 字段；回到 authoring contract、实际导出和 readback。

## Token 边界

- 不为已知执行读取 KB。
- 不加载整套 essential knowledge、整个 KB、全部搜索结果或完整长教程。
- 只 fetch 支撑当前判断的 chunk；大段来源不进入默认上下文。
- KB 结论、正式 manifest 条目、binding 签名和项目 readback 各自按当前 context 复用，不重复注入。
