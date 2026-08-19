# Implementation Consistency

本页定义结构化 HJSON authoring 的实现一致性检查入口。它用于确认 docs、source contract、Python wrapper、command pack、search/show 输出和实际导出 profile 的语义一致；不是宽泛搜索源码或文档目录后的人工判断。

## Entry Points

| 层级 | 入口 | 检查内容 | 使用时机 |
| --- | --- | --- | --- |
| Authoring consistency | `uai_core.authoring_consistency.run_authoring_consistency_checks(...)` | folder registry、field contract、export profile、command docs、Python wrapper、`show_command`、`pack_commands`、seed 规则 | 修改 contract、profile、field、wrapper、command docs、HJSON authoring 文档后 |
| Command toolchain audit | `python UeAgentInterfaceCMD/tools/audit_command_toolchain.py --project-root <ProjectRoot> --fail-on-error --output <ProjectRoot>/runtimeLogs/uai_command_toolchain_audit.hjson` | 插件/UAICMD/Pak/installed 命令文档同步、active wrapper import、manifest 污染、旧 wrapper import、关键 search/pack 示例 | 怀疑命令查询包、wrapper 或文档同步不一致时 |
| Command docs tests | `python -m pytest UeAgentInterfaceCMD/tests/test_command_docs.py -q` | `search_commands`、`show_command`、`pack_commands(profile=authoring)`、`hjson_authoring_docs`、seed 和 sections contract | 改 command docs API、USAGE、命令文档路由后 |
| Authoring consistency tests | `python -m pytest UeAgentInterfaceCMD/tests/test_authoring_consistency.py -q` | checker 正向路径和失败 issue 字段 | 改 consistency checker 或矩阵相关文档后 |
| HJSON writer tests | `python -m pytest UeAgentInterfaceCMD/tests/test_authoring_io_hjson.py UeAgentInterfaceCMD/tests/test_hjson_authoring_io.py -q` 与插件 `StructuredHjsonFormatter` automation | 递归 6 字段同行、无 object 列表计 1、特殊字符和 parse/write/parse | 改 writer、字段格式规则或 HJSON 文档后 |
| Skill sync check | `python scripts/skills/sync_codex_skills.py --direction pak-to-installed --skills ue-agent-interface --mode check` | Pak skill 与 `CODEX_HOME/skills`（或显式 installed root）的完整文件集 parity；UTF-8 文本规范化换行、二进制逐字节比较 | 改 skill 路由或 skill 内正式文档后 |
| Release gate | `python UeAgentInterfaceCMD/run_uai_cli.py release ci --json-output --ci-output <ProjectRoot>/runtimeLogs/uai_release_ci.hjson` | coverage、fail-closed sync-check、Pak semantic contract closure、hygiene、Dev tests、Pak static quality、完整 skill parity，以及测试/清理/安全 artifact 后的最终状态复检 | P5 发布门禁；仅 clean、已运行测试且全部 blocking gate 通过时允许 formal release |

`run_authoring_consistency_checks` 返回的 report 包含 `schema`、`ok`、`matrix_loaded`、`matrix_check_count`、`checked_type_count`、`checked_command_count`、`issue_count`、`deferred_checks` 和 `issues`。每个 issue 必须包含 `check_id`、`object`、`evidence`、`expected`、`actual`、`rollback_target`；失败处理必须按这些字段回到对应 contract、profile、wrapper、docs 或验证任务修正。

## What Is Checked

| 分组 | 证据入口 | 失败归属 |
| --- | --- | --- |
| `folder` | `load_command_folder_contract_registry`、operation status、export/apply/validate/diff 注册 | `P2-001` 或对应 folder contract 任务 |
| `field` | `load_field_contract`、字段 role/source/apply/readback、duplicate group | `P2-002` |
| `type` | `build_export_profile_plan`、`llm_authoring` included/excluded files and fields | `P2-003..P2-007` |
| `legacy` | 旧输入拒绝、历史归档、deprecated command boundary；公开 Catalog 只保留 `seed/placement` | `P1-004`、`P2-008`、`P4-005` |
| `command` | `build_command_index`、`show_command(..., output_format="json")`、`pack_commands(profile=authoring)` | `P2-009`、`P4-003` |
| `docs` | command doc index、`skill_doc_path`、`hjson_authoring_docs`、guide route | `P0-003`、`P4-001..P4-006` |
| `gate` | P3 fixture reports、P5 release gate report、skill sync check | `P3-009`、`P5-001..P5-003` |

当前 `show_command(..., output_format="json")` 的正文必须在 `sections`，不是 `content`。`pack_commands(profile=authoring)` 必须包含 `Authoring Contract`、FieldContract 生成的 `minimal_seed`、`python_import`、`skill_doc_path`、`hjson_authoring_docs` 和 seed/placement/coverage/raw/debug 边界。Catalog 的 exact `seed` 与教程的 `minimal_seed` 都来自正式 contract，但用途不同：前者是选中候选的目标片段，后者是命令 authoring 文件的最小入口。

## Failure Handling

1. 如果 checker 或 audit 输出 `ok=false` / `success=false`，停止继续 authoring 或发布任务。
2. 先读取失败 report，不用宽泛 `rg` 扫全源码或全 docs。根据 `check_id`、`object`、`evidence`、`expected`、`actual` 定位唯一真源。
3. 按归属修正源头：插件正式 docs、contract registry、field contract、export profile、Python wrapper、command docs API、Pak skill 源或 installed skill 同步。不要只改生成副本、Pak 镜像或 installed skill 来掩盖源头不一致。
4. 修改后重新运行对应最小入口；若失败跨层，先修复最底层 contract/profile/wrapper，再修 docs/pack/skill。
5. 只有 P3/P5 已标记为 deferred 的项可以进入后续门禁；不得把 deferred 写成已验证通过。

## Search Boundary

日常 authoring 和文档修正必须使用明确入口：

- 已知命令且当前版本 authoring 用法已在上下文：直接调用 typed wrapper，不 search、不重复打包。
- 已知命令但 authoring 参数、文件或验证不确定：`pack_commands([...], profile="authoring")` 或 `command pack`，只加载缺失 section。
- 未知命令：先 `search_commands(...)` 或 `command search` 定位命令名，再只为选中命令生成 authoring pack。
- HJSON authoring 规则：只读包内列出的 `hjson_authoring_docs` 和当前命令 `skill_doc_path`。
- HJSON 文件导航和修改：使用 `load_authoring_file` / `write_authoring_file` 与 manifest/index/ref；不通过正则、字符串拼接或全目录搜索发现字段。
- 旧输入规则：读 `hjson-authoring/06_LegacyMigration.md`，不要从 deprecated 命令推断新主路径或建立兼容 adapter。
- 同步状态：用 `audit_command_toolchain.py` 和 `sync_codex_skills.py --mode check`，不要手动比较全目录。

不得把宽泛搜索源码、旧模板、旧大文档、runtime log 或 generated 产物作为常规字段发现路径。只有在上述入口自身失败、证据不足或正在修复工具实现时，才可以限定到相关模块做局部源码定位，并在修复后回到 checker/audit 验证。

## Current Boundaries

- 当前正式 coverage 由 `tools/audit_authoring_coverage.py` 动态生成，不在文档中硬编码历史 matrix 数字。
- 当前活跃集合应为 43 个 profile、10 个 Authoring domain owner；`ai_behavior_stack` 是 composite read-only package，不能生成单 UObject authoring 教程。
- Niagara 当前统一领域已覆盖受控 Renderer、Event Handler、System User Parameter、普通 literal/linked input 与递归 Dynamic Input；Data Interface 的任意对象拓扑和任意 Script graph topology 仍是明确能力边界，不能计入已支持 coverage。
- packaged contract closure 必须验证 folder/field/quality schema、catalog/receipt payload hash、引用闭包与解析后路径 containment；文件存在或仅 HJSON parse 成功不能作为合同有效证据。
- Pak/installed skill 同步和 release gate 是独立门禁；development docs 通过不代表分发副本已经同步。
