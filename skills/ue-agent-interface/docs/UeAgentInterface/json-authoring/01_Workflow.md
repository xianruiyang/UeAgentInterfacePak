# JSON Authoring Workflow

本页定义结构化 JSON authoring 的通用工作流。它适用于 Niagara、Material、Blueprint/UMG、Sequence、ControlRig、PCG、Project Settings、DataAsset/DataTable 和其它已接入 profile/adapter 的域。

## 目标

LLM 只编辑面向 authoring 的 JSON，不直接改 UE 原始导出和 readback 证据。默认工作方式是直接打开并修改 JSON；只有批量生成、参数化调用、adapter 调试或重复变量过多时才写 Python 辅助。完整链路是：

```text
export or fixture
-> project to authoring profiles
-> edit authoring/minimal_authoring
-> node_catalog_search for new candidates when needed
-> lint
-> adapter to current UAI JSON/folder
-> validate or dry-run
-> apply
-> export/readback
-> verify semantic result
```

## Profile 分层

| Profile | 用途 | LLM 是否编辑 |
| --- | --- | --- |
| `minimal_authoring` | 最小可写意图，适合新增结构、小范围改值、一次性 action。 | 是 |
| `authoring` | 完整可写意图，带必要候选、selector 和安全提示。 | 是 |
| `readback` | UE 当前状态、默认值、链接、对象路径、可见性、能力状态。 | 否 |
| `diagnostics` | validation、coverage、compile、runtime、warning、diff、unsupported 证据。 | 否 |
| `legacy_full` | 当前 UAI 原始导出兼容层。 | 否，除 adapter/migration 使用 |

## 标准步骤

1. 用 UAI 导出目标资产，或使用固定 fixture。
2. 生成 `authoring`、`minimal_authoring`、`readback`、`diagnostics`、`legacy_full`。
3. 只编辑 `authoring` 或 `minimal_authoring`。
4. 新增节点、模块、组件、控件或输入来源前，先按 `00_DirectJsonAuthoring.md` 用 `node_catalog_search` 查询真实候选。
5. 把返回的 `json_authoring` 整个对象放入其 `profile_path` 指定的位置，或只复制 `json_authoring.seed`。`kind/name/full_name` 是查询、JSON 写入和来源解析的统一身份；`name` 只用于阅读和生成默认本地 id，稳定写入必须依赖 `full_name`。
6. 对普通 input 值，只改 `value` 内部字段，不用 `operation` 表达普通改值。
7. 对新增、删除、清空、替换、批量 patch 等非普通值编辑，才使用 `operation`。
8. 运行 authoring hygiene lint。
9. 用对应 adapter 输出当前 UAI 可 apply 的 JSON/folder。
10. 优先 `validate` 或 `dry_run`，再 apply。
11. apply 后重新 export/readback，按同一主体、同一坐标系、同一状态比较结果。
12. 记录 response/report、warning、dirty resource 和剩余边界。

## JSON 直接编辑优先级

优先顺序：

1. 直接改 `authoring` / `minimal_authoring` JSON。
2. 用 `node_catalog_search` 返回的 `json_authoring` / `seed` 作为新增候选的最小 JSON 片段。
3. 用 Python 生成或修改 JSON 文件，但仍让 JSON 明确表达最终业务意图。
4. 只有 bootstrap、探针、迁移、schema 边界和故障恢复才使用原子命令。

不要让 Python 隐式替代 JSON authoring 语义；脚本可以批量写 JSON，但最终需要能从 JSON 中读懂本次改了什么、为什么可 apply、如何 readback。

## Editor 生命周期

- 普通导出、apply、readback、smoke 默认复用当前 UE Editor 会话。
- 不因为一次普通 smoke 结束就关闭用户已经打开的 UE。
- 只有需要重新编译插件/UE C++ 且 DLL 被 Editor 占用时，才先处理 dirty resource，然后安全关闭 UE。
- 如果本轮脚本自己启动了临时 headless/editor 进程，脚本结束时必须清理该进程。
- 每轮结束仍要确认没有额外 `UnrealEditor-Cmd`、`CrashReportClient` 或测试残留进程。

## 证据优先级

结构化 JSON schema 和字段语义必须来自：

1. 当前插件源码和 adapter/lint 实现。
2. 当前 UAI 导出 JSON 和 readback。
3. 命令文档。
4. live smoke 或离线单测。

不要用 KB 推断本项目私有 JSON 字段含义。
