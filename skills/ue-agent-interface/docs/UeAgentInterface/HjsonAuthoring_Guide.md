# UAI HJSON Authoring Guide

本指南定义 UeAgentInterface 结构化 HJSON 的 LLM authoring 主路径。它不替代单命令文档；字段、参数、返回和支持面仍以 `commands/<category>/<command>.md`、当前插件源码、adapter/profile、实际导出和 readback/smoke 为准。

## Documentation Route

| 文档 | 内容 |
| --- | --- |
| `hjson-authoring/00_DirectHjsonAuthoring.md` | 直接编辑 `llm_authoring` HJSON、领域 candidate identity -> HJSON binding -> apply/readback 的统一主链路。 |
| `hjson-authoring/01_Workflow.md` | export -> read guide/index -> edit `llm_authoring` -> validate/dry-run -> apply -> readback 的通用流程。 |
| `hjson-authoring/02_CommonInputValue.md` | 通用 `value`、enum、source、只读字段和 compact HJSON 规则。 |
| `hjson-authoring/03_OperationsAndSelectors.md` | selector、operation、新增/删除/替换结构、最小 seed。 |
| `hjson-authoring/04_SpaceContract.md` | transform、layout、socket、IK、graph/node/widget 坐标合同。 |
| `hjson-authoring/05_Validation.md` | lint、adapter、validate/dry-run、apply、readback、coverage gap 处理。 |
| `hjson-authoring/06_LegacyMigration.md` | 旧输入拒绝、历史归档和 deprecated 命令边界。 |
| `hjson-authoring/07_ImplementationConsistency.md` | docs/source/wrapper/pack/export 一致性检查入口、失败处理和搜索边界。 |
| `hjson-authoring/08_NiagaraApplyDomain.md` | Niagara System/Emitter/Script、stage/module/dynamic input 的统一 Apply/Export 纵切、契约与能力边界。 |
| `hjson-authoring/recipes/*.md` | 模块特有规则，只讲通用教程之外的差异。 |
| `commands/<category>/<command>.md` | 命令参数、返回字段、folder HJSON 支持范围、validate/diff 覆盖和实现边界。 |

## Main Authoring Contract

结构化 folder 默认 profile 是 `llm_authoring`。LLM 默认直接编辑该 profile 下的 folder HJSON；Python 只用于批量生成、参数化调用、adapter 调试或重复变量过多的辅助工作，不能替代 HJSON 中的业务意图。

落盘的 authoring、folder package、fixture、contract 和 CLI report 默认使用 HJSON。UAI HTTP 请求/响应 envelope、内存对象和 `--json-output` stdout 仍是 JSON 传输格式；历史命令名或参数名里的 `json` 只表示兼容 API 字段名，不表示 authoring 文件仍为 compact JSON。

路径兼容边界：

- `output_file` 传 `.json` 时，authoring 导出会规范化写到同名 `.hjson`，返回的 `output_file` / `output_format` 以实际落盘为准。
- `json_file` 作为历史输入参数时，若命令已声明兼容别名，可按同名 `.hjson` 读取；不声明兼容的 HJSON authoring 文件输入必须直接传 `.hjson`。
- Level Content file input 明确拒绝 `.json` authoring 文件并返回 `hjson_file_required`。
- inline `json`、`json_text`、`curve_json`、`value_json`、response/report/runtime JSON 不属于 authoring 文件格式迁移范围。

默认阅读顺序：

1. 先按当前 ExportProfile/folder contract 的 `included_files` 和教程 `read_order` 读取必需 identity/entry 导航文件；不假定一定存在 `manifest.hjson`、`index.hjson` 或 references。
2. 再按当前目标打开契约列出的 authoring unit、collection index、graph index 或直接 ref。
3. 只有需要编辑某个大型集合项时，才打开 `items/<id>/...` 下的具体文件。
4. 不把大型 Actor/Component item、raw/readback-only 内容或 debug report 放进默认一次性上下文。P3 验证中 Level 已出现 30 个 actor/component item HJSON 超过 16,000 bytes；这些文件必须按需读取。

`llm_authoring` 只包含：

- `public_seed_identity`
- `container_context`
- `editable_authoring`
- `required_readonly`

默认不包含：

- `legacy_compat`
- `debug_diagnostics`
- `readback_report`
- `raw_heavy`
- `command_param_only`

命令参数和 folder HJSON 字段必须分开理解。`asset_path`、`folder_path`、`dry_run`、`include_raw_properties`、`clean_output_dir` 等是命令参数或显式诊断选项，不是默认可编辑 authoring 字段。

## Direct HJSON Authoring First

```text
export/readback folder package
-> follow ExportProfile included_files/tutorial read_order
-> edit only required llm_authoring files
-> when adding content, query the exact owning domain candidate command
-> copy the exact candidate projection allowed by that domain into its HJSON
-> validate/lint/dry-run when available
-> apply
-> export/readback/compile/probe
-> semantic verification
```

不要用一长串原子命令替代已有 HJSON/folder workflow。新增内容默认走“最小 seed -> apply 补全 -> readback 继续编辑”：不要从 readback 复制完整对象，也不要手写 UE/UAI 会生成的 id、template、slot、pin、默认属性、diagnostics 或 derived 字段。

多数公开 seed 以两类字段表达主身份：

- `path`：调用方已经知道资产、类、对象或 owner 路径时使用。
- `name`：从当前领域 candidate command 返回的无路径候选或上下文可解析候选使用；同时保留该领域要求的 `binding_revision` 与 context。

领域合同也可以要求保留完整 candidate object。当前 Blueprint node/Component root authoring 就属于这种情况：完整 `candidate` 原样进入 HJSON，服务端写前校验并展开 native class/name 字段。不能为了套用 `path/name` 概括而在调用侧拆解或重建它。

字段是否可写只由当前 CommandSpec 或 folder contract 决定；folder authoring 不把历史 identity alias 自动迁移为新 target。旧结构拒绝和 deprecated 命令边界见 `hjson-authoring/06_LegacyMigration.md`。

## Merge-First Folder Shape

- `index.hjson` 只做导航摘要，不保存完整对象。
- 短小内容合并进资产级或集合级 HJSON。
- 只有大型集合、独立生命周期、独立 diff/apply 价值或上下文过大的内容才拆到 `items/<id>/...`。
- Graph 逻辑整体写在 `graphs/items/<graph_id>/graph.hjson`，包含 nodes/pins/links 或等价逻辑内容。
- Graph 视觉布局写在 `graphs/items/<graph_id>/layout.hjson`，只保存节点位置、注释框、折叠状态等布局信息。
- 旧平铺 `graphs/<name>.hjson`、旧 `widget_tree/tree.hjson` 和旧 properties/index 布局只允许出现在显式迁移、负例、错误或 debug/readback 语境，不是 authoring 输入。

## Details Grouped Authoring

UE Details、UObject 属性面板和资产设置面板可编辑字段统一走公共 Details authoring 层。

- 默认导出不在入口 HJSON 内展开 `properties[]`、`settings_properties[]` 等 Details 描述数组；入口只保留身份、业务结构和 `details` / `*_details` 引用。
- 创建 seed 可以在新 owner 条目中使用结构正确的 inline `properties[]` / `*_properties[]` 写初始值；公共 apply 会在 owner 创建后通过与 grouped Details 相同的属性导入器应用。
- 同一 owner 只能有一个属性来源：inline 字段与对应 `details` / `*_details` ref 同时存在时，在修改资产前返回 `inline_grouped_details_conflict`，不覆盖、不合并、不猜优先级。
- 分组文件写入相邻 `details/<owner_scope>/index.hjson` 和同目录 group 文件；Level Actor/Component/WorldSettings 可直接使用对象目录下的 `details/index.hjson`。
- `details` / `*_details` ref 里的 `category` 只是阅读和调试 metadata，不参与目录分层；不要创建 `details/<category>/<owner_scope>` 这类旧路径。
- owner scope 会经过共享文件名 stem 清洗，避免 `|`、冒号、空格等字符污染 Windows 路径。
- `details/index.hjson` 是导航和完整性摘要；实际可编辑字段在 group 文件的 `fields[]` 中。
- group field 默认保留 `property_path`、`display_name`、`value_kind` 和 canonical `value`；字段受禁用或编辑条件约束时保留 `availability`，有编辑意义时保留 `tooltip` 和 enum/object/class `candidates`。
- grouped Details authoring 不输出 `category_path` 或复数 `operations`；分组由文件和 `details/index.hjson` 表达。它们只允许作为 debug/readback 证据，不是 authoring 输入。
- 展示型 `value_text` 只在 debug/readback profile，或确实无法提供可靠结构化 `value` 时保留。
- 为减少重复，默认不保留和 canonical `value` 等价的展示副本，例如 `value_text`、`default_value_text`；authoring apply 只读取 `value`，不从非法或缺失的 `value` 回退到文本。
- `raw_properties`、`readonly_properties`、`missing_properties`、`unsupported_properties` 是诊断或只读材料，不会被公共层自动当作可编辑 Details 外置。
- apply/validate 对 inline seed 和 grouped Details 使用同一公共解析、冲突检查和属性导入链路；diff 和已有 owner 的持续编辑仍以导出的 grouped Details 为稳定来源。
- 只返回 response、没有稳定输出文件边界的命令仍返回 inline JSON；它们必须走同一 compact writer，但不会伪造 folder `details/` 文件。

## Structured HJSON Navigation And Formatting

- 当前公共 authoring 方言固定为 `uai-hjson-authoring/1`。C++ 的 `FUeAgentStructuredHjsonFormatter` / `FUeAgentStructuredHjsonParser` 与 CLI 的 `authoring_io` 必须按同一方言读写；不得把通用第三方 HJSON parser 的宽松行为当作 UAI authoring 合同。
- 公共文件入口只接受 object root。整数在 AST 中保留任意精度十进制文本；有限浮点按 IEEE-754 binary64 语义输出最短可回读表示，并保留 `-0.0` 与整数形浮点的类型。`NaN`、`Infinity`、`-Infinity` 在读取和写出两侧都拒绝。
- canonical writer 固定 key 排序、二空格缩进、LF 换行与结尾单换行。C++ 与 Python 对同一语义必须生成相同 canonical bytes；writer 写出的文档必须能被同方言 reader 重新读取。
- 方言支持三单引号 multiline string。开始分隔符后只能有空白和换行；结束分隔符单独占行；非空内容缩进不得小于结束分隔符缩进。canonical writer 可以把 multiline 值写成带转义的双引号字符串，不要求保留原始文本布局。
- parser、writer 和结构扫描使用显式 frame/task stack，不设置 `max_depth`、`nesting_limit` 或其他人工语义深度上限。合法深层输入仅受进程总内存、文件大小和调用方整体资源预算约束。
- Object Apply 与 PropertyValueCodec 同样不把固定 depth 作为 authoring 语义门禁。UObject、UStruct、array、set、map、fixed array 和 optional 沿真实反射类型递归；循环保护依据当前 active object identity path，资源保护使用容器元素、字符串、总输入或运行资源预算，不能把 `apply_depth_limit_exceeded` / `max_depth_exceeded` 换名后继续拒绝合法深层结构。
- create/replace 的缺失值只从 UE factory、constructor、CDO/archetype/template、`UScriptStruct::InitializeStruct`、graph schema 或真实 staged object 获得。provider shorthand 先解码到 typed property storage，再从该 storage canonical encode/readback；多态 owned object 没有 existing object、显式兼容 class 或唯一可靠 class source 时返回 `owned_object_class_source_required`，不猜基类、第一候选或业务默认。
- parse/write/IO 失败必须包含 `dialect`、`phase`、稳定 `code`、`pointer`、`line`、`column` 与 source file（适用时）。LF、CRLF、CR 的位置计算一致；禁止用自由文本匹配替代稳定错误字段。
- 公共文件写入使用同目录临时文件，完成 UTF-8 写入和 flush 后重新 parse，再以 replace 发布；任一步失败都清理临时文件并保持既有 final 不变。C++ 调用方应使用 `TryWrite*` / `SaveObject` 获取失败，不应把 legacy `Write*` 返回的空字符串当成功。
- folder HJSON 按 ExportProfile `included_files`、教程 `read_order` 和实际 ref 导航到目标 authoring unit 与必要 owner context；不存在的 manifest/index/references 不得由调用方补造。默认不读取 sibling、raw、readonly、debug、coverage 或完整 readback。
- 程序化读取文件使用 `load_authoring_file(...)`；已有字符串使用 `loads_authoring_hjson(...)`。程序化写出使用 `write_authoring_file(...)` 或 `dumps_authoring_hjson(...)`。
- 小范围人工修改可以直接编辑目标 HJSON，但写后必须重新 parse；批量或跨文件修改必须使用结构化 parser/writer，不使用正则、全局字符串替换或手工转义。
- 公共路径 resolver 负责 owner scope、Details group 和 ref 的目录映射；不得重复拼接 category、owner 或 section，不能生成重复中间目录。
- directory workspace load 使用可中止的 stat visitor；文件数在访问第 `MaxFiles + 1` 项时立即失败，文件大小和总 bytes 在枚举期间累计。directory load result 通过 `enumeration.entries_visited`、`enumeration.bytes_visited` 和 `enumeration.stopped_early` 报告实际扫描边界，不允许先全量递归枚举再检查预算。
- Windows workspace 路径在读写前通过 handle final path 重新执行 root containment。workspace root 或内部 reparse directory 默认拒绝；junction 指向 root 外返回 `workspace_reparse_escape`，无法可信解析返回 `workspace_reparse_resolution_failed`。该规则同时适用于 directory/single-file load、reference、copy 和尚不存在目标的 write/export 路径。
- 共享 Export writer 不直接逐文件修改 final。它先完成完整 plan 和路径/冲突/token 检查，再在 final 同一父目录建立 same-volume staging，写入并重新 parse 全部 HJSON；发布时以 journal 记录 `final -> backup -> staging -> final`，任一步失败恢复旧 final。single-file 也走同一 staging/backup/journal 语义。
- 非空 final 必须带有效 `.uai-export-owner`（single-file 使用相邻 owner sidecar）；记录包含稳定 owner UUID、contract/profile、workspace kind、final path 和格式版本。无 ownership 的非空目录、越界路径或 reparse 目标在创建、删除、copy 或发布前拒绝。
- directory Export 生成的根级 `.uai-export-owner` 是 publisher metadata，不是 authoring unit。Workspace Loader 在未知文件检查以及文件数/总字节预算计数前只忽略这个精确根级 marker；其他未知文件、子目录中的同名文件和伪造 sibling 仍按 contract 拒绝。因而共享 Export 产生的 workspace 可以原样交给对应 `*_apply_folder`。
- 成功的共享 writer result 除绝对 `written_files` 外，还返回相对 `entry_file`、完整 `written_relative_files` 和 `publisher` transaction receipt。verification/readback 调用方必须把声明的输出 override 指向 `runtimeLogs/uai_verification/<request>/<method>` 下独立的 request-scoped owned root，不能把 authoring input 当 readback 输出。
- HJSON artifact 不能只凭路径存在判定成功。verification receipt 必须绑定当前 request、live server session 与调用时间，并验证 project-contained root、相对 entry、完整且无额外文件的集合、规范化 size/hash、逐文件 HJSON parse、profile、asset identity、contract、same-volume publisher 与 workspace validation；缺 receipt、旧 receipt 或 publisher 自报不完整都必须失败。
- 只有一次提交完整 plan 的 exporter 才能声称整个 workspace 原子发布；复合 exporter若仍分多次提交 fragment，必须先在领域层聚合为单一 plan。
- Apply workspace 的 `reference_policy.external_references` 当前唯一 active 值是 `reject`。历史 `contract_allowlist` 没有完整 allowed-root、semantic scope 和 read/write 权限实现，因此解析或注册时返回 `apply_workspace_external_reference_policy_unimplemented:contract_allowlist`；不得把该值当成已支持能力。
- save-required Apply 使用 request-scoped durable journal。包从磁盘加载时，operation transaction backend 与默认 package stager 都会在发布前释放 package loader；staging 或 publish 失败必须从 backup 恢复并确认 hash，不能因 `.uasset` Linker 锁把已恢复状态报告为可安全重试。
- durable publish 只有在 provider commit 与 completed journal 均成功后才清除已持久化 package 的 dirty 标记；commit 失败或回滚路径恢复进入事务前的 dirty 状态。同一 `request_id` 与相同 fingerprint 的重放从 completed receipt 解析，不重复 mutation 或改写包/receipt；相同 ID 配不同 fingerprint 必须拒绝。
- compact writer 对 object 递归计算有效字段数：scalar 计 1；不含 object 的 list 在所属 object 中计 1 且列表同行；嵌套 object 的字段递归累计。有效字段数 `<= 6` 且所有子值可同行时 object 同行，否则折行。含 object 的 list 不作为普通同行列表。
- 字符串是否引用由 writer 的 HJSON 语法安全判断。注释符、引号、反斜杠、冒号、边界符、换行或 Unicode 不得因同行输出而改变值；重要写入执行 parse -> write -> parse round-trip。

## Field Rules

1. 已知路径实体用 `path`，无路径候选用 `name`。不要让 LLM 手填 `full_name` 或细分旧路径字段。
2. 可编辑属性或等价编辑项的主身份使用 `property_path` 或域内等价 selector；legacy `name` 只作为显式迁移、debug 或 readback 识别字段，不作为默认导出字段。
3. `required_readonly` 字段可以留在 `llm_authoring`，但只用于识别、校验、约束或差异判断，不由 apply 写入。
4. UObject 属性统一使用 `uai.uobject_properties.v2` canonical `value`；具体 shape、精确数值类型、struct 递归和容器内层类型规则见 `UObjectPropertyValueV2.md`。enum/choice 必须带 `candidates`，LLM 只能写候选值。
5. 每个可编辑 UObject 属性必须包含 `property_path`、`value_kind` 和 canonical `value`；`display_name` 只在它提供额外语义时保留，不重复输出 `selector`、`property_name` 或 `category_path`。该去重只适用于 UObject property descriptor；Niagara parameter、节点、module 等领域条目的稳定 `selector` 必须保留。
6. `operation` 只用于 add/remove/replace/clear/rename/set_binding 等非普通值意图。
7. 不写 derived count、export timestamp、file path、compile report、runtime probe、coverage report、roundtrip status 或 raw enum options。
8. 不把 `raw_properties`、`readonly_properties`、`missing_properties` 或 `unsupported_properties` 当成通用可写面；这些字段不作为 apply 输入。
9. unknown/unsupported operation 必须在 adapter 或 validate 阶段失败，不得静默丢弃用户意图。

## Coverage Boundaries

当前专用 validate/diff 覆盖不是完整矩阵。

- 这些类型当前缺 dedicated `*_validate_folder`：`blueprint`、`umg`、`anim_blueprint`、`material`、`material_instance`、`material_function`、`niagara_system`、`niagara_emitter`、`niagara_script`、`sequence`。
- 上述类型也缺 dedicated `*_diff_folder`。
- AI 行为树相关既有 folder 文档存在，但 contract operation registration 仍为 `missing`，不得写成闭环 authoring 能力。

缺 dedicated validate/diff 时，不能声称 full coverage；改用 export/readback、command response、authoring consistency gate 或结构化比较补验证。

实现一致性入口、失败 issue 字段、command toolchain audit 和不得宽泛搜索源码/旧文档的规则见 `hjson-authoring/07_ImplementationConsistency.md`。

## Standard Loop

1. 导出或读取固定 fixture。
2. 读取导航文件，按需打开目标 `llm_authoring` 文件。
3. 只编辑 authoring 文件，不改 readback/debug/legacy。
4. 新增内容时调用对应领域 candidate command，只复制返回合同明确允许的 candidate projection；通常是 executable `name`/path、`binding_revision` 与必要 context，Blueprint node/Component 则是完整 candidate object。不从显示文本猜 identity。
5. 运行 lint、validate 或 dry-run；没有 dedicated validate 时记录 coverage gap。
6. apply。
7. export/readback，比较语义结果。
8. 对支持编译的域检查 compile/stack issue。
9. 记录 warning、dirty resources、process state 和剩余边界。

普通导出、apply、readback、smoke 复用当前 UE Editor，不因为普通验证完成而关闭用户已有 UE。只有需要重新编译插件/UE C++ 且 DLL 被占用时，才先处理 dirty resource，然后安全关闭 UE 构建。

## Verification Requirements

| Case | Required check |
| --- | --- |
| Value edit | command response plus readback exact or normalized value check. |
| Graph edit | node/link count, supported node type, layout if edited, compile/validation report when available, readback graph. |
| Niagara edit | stack issues, compile log, active branch/mode, runtime or preview probe when visual behavior matters. |
| Space edit | same subject, same frame, same state readback; visual check when layout or rendering matters. |
| Destructive edit | explicit destructive gate, dry-run or plan first, readback after apply. |
| Long-tail config | validate/diff/dry-run when available; do not treat packaging/config output as persistent asset state unless command reports it. |
