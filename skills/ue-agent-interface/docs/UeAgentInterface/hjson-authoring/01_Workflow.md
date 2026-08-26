# HJSON Authoring Workflow

本页定义结构化 HJSON authoring 的通用工作流。它适用于 Niagara、Material、Blueprint/UMG、Sequence、ControlRig、PCG、Project Settings、DataAsset/DataTable 和其它已接入 profile/adapter 的域。

## 目标

LLM 只编辑面向 authoring 的 folder HJSON，不直接改 UE 原始导出、readback、debug 或 legacy 证据。默认工作方式是直接打开并修改 `llm_authoring`；只有批量生成、参数化调用、adapter 调试或重复变量过多时才写 Python 辅助。

```text
export/readback folder
-> read manifest/index/reference
-> edit llm_authoring files
-> exact domain candidate command for new content when needed
-> lint
-> validate or dry-run when available
-> apply
-> export/readback
-> verify semantic result
```

## Profile 分层

| Profile | 用途 | LLM 是否编辑 |
| --- | --- | --- |
| `llm_authoring` | 默认可写主面；包含 public seed、container context、editable authoring、required readonly。 | 是 |
| `readback` | UE 当前状态、默认值、链接、对象路径、可见性、能力状态。 | 否 |
| `debug` / `diagnostics` | validation、coverage、compile、runtime、warning、diff、unsupported 证据。 | 否 |
| `legacy` | 显式迁移、负例、错误或 debug/readback 识别层。 | 否，除显式迁移或诊断使用 |

`include_raw_properties`、debug/raw/readback 输出是显式诊断选项，不是默认 authoring。

## 标准步骤

1. 用 UAI 导出目标资产，或使用固定 fixture。
2. 按当前 ExportProfile/folder contract 的 `included_files` 和教程 `read_order` 读取必需 identity/entry 导航文件；不假定 manifest/index/references 必然存在。
3. 只打开当前目标需要的 `llm_authoring` 文件；大型 `items/<id>/...` 按需读取。
4. 只编辑 authoring 文件，不改 readback/debug/legacy。
5. 新增节点、模块、组件、控件或输入来源前，先按 `00_DirectHjsonAuthoring.md` 调用对应领域的 exact candidate command 查询真实候选。
6. 候选只复制最小 `candidate.name` 或 `candidate.id`；原生 graph/pin、stage、parent、level 与 placement context 写在领域合同指定的外层。明确知道的更多字段只能作为 assertion；完整搜索行、内部 revision、label、tooltip 和分类不进入 HJSON。
7. 对普通 input 值，只改 `value` 内部字段，不用 `operation` 表达普通改值。
8. 对新增、删除、清空、替换、批量 patch 等非普通值编辑，才使用 `operation`。
9. 运行 authoring hygiene lint。
10. 优先 dedicated validate 或 dry-run；缺 dedicated validate 时记录 coverage gap 并用 export/readback/consistency gate 补证据。
11. apply 后重新 export/readback，按同一主体、同一坐标系、同一状态比较结果。
12. 记录 response/report、warning、dirty resource 和剩余边界。

## JSON 直接编辑优先级

优先顺序：

1. 直接改 `llm_authoring` JSON。
2. 用领域 candidate command 返回的 `name` 或紧凑 `id` 构造该领域允许的最小 HJSON 片段，并把创建 context 保留在候选外层。
3. 用 Python 生成或修改 HJSON 文件，但仍让 JSON 明确表达最终业务意图。
4. 只有 bootstrap、探针、迁移、schema 边界和故障恢复才使用原子命令。

不要让 Python 隐式替代 HJSON authoring 语义；脚本可以批量写 HJSON，但最终需要能从 HJSON 中读懂本次改了什么、为什么可 apply、如何 readback。

## Large Item Rule

- `index.hjson` 只做导航摘要。
- 默认上下文只加载 manifest/index/reference 和当前目标文件。
- Level Actor/Component 等大型 item 文件只在当前任务确实要编辑该 item 时读取。
- P3 验证中 Level 有 30 个 actor/component item JSON 超过 16,000 bytes；Guide、示例和命令包不得暗示这些文件应默认全量加载。
- 如果 item 中仍有 raw/readback-only 内容，应优先放到 readback/debug 或后续拆分任务处理。

## Editor 生命周期

- 普通导出、apply、readback、smoke 默认复用当前 UE Editor 会话。
- 不因为一次普通 smoke 结束就关闭用户已经打开的 UE。
- 只有需要重新编译插件/UE C++ 且 DLL 被 Editor 占用时，才先处理 dirty resource，然后安全关闭 UE。
- 如果本轮脚本自己启动了临时 headless/editor 进程，脚本结束时必须清理该进程。
- 每轮结束仍要确认没有额外 `UnrealEditor-Cmd`、`CrashReportClient` 或测试残留进程。

## 证据优先级

结构化 HJSON schema 和字段语义必须来自：

1. 当前插件源码和 adapter/lint 实现。
2. 当前 UAI 导出 JSON 和 readback。
3. 命令文档。
4. live smoke 或离线单测。

不要用 KB、网络或旧大分册推断本项目私有 JSON 字段含义。
