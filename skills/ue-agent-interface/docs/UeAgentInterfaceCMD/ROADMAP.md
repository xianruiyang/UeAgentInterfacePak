# UeAgentInterfaceCMD 路线图

## P0（已实现）

- `doctor / exec / batch / run / resume` 子命令
- `plan + vars` 模板渲染
- phase 级 `exec_batch` 执行与失败中断
- 结构化报告输出（含失败点与耗时）
- 日志文件输出（主机名后缀 + 版本标签）
- 命令清单生成：`manifest`
- `exec / batch / run / resume` 执行前命令名校验
- 参数 schema 推导与 warn/strict 校验
- CLI/插件兼容检查：`compat` 与执行 preflight
- CLI 端到端单测覆盖新增入口与本地校验

## P1（已实现）

- 命令覆盖矩阵：`release coverage`
- Pak 分发布局验证：`release pak-verify`
- 发布门禁：`release gate` 与 `tools/ci_gate.py`
- 覆盖矩阵输出 `docs/generated/command_coverage_matrix.json|md`
- 已实现但缺显式命令表的命令会进入 `docs/generated/implemented_command_catalog.md`
- Pak 验证检查 README、插件目录、CLI 目录、skill、command-map 和基础 hash 差异

## P2（已实现）

- 失败现场收集：`crash collect / inspect / pack`
- crash 签名、replay 命令生成与 batch 二分文件生成：`crash signature / replay / bisect`
- 执行失败自动 crash capture
- PNG/BMP 视觉输出有效性检查，覆盖全黑/全透明/低方差截图；JPG/JPEG 做尺寸有效性检查
- runtime report 索引与查询统计：`runtimeLogs/uai_cli_index.json`
- `index` 子命令读取、过滤和统计最近执行摘要
- Golden E2E：`e2e local / ue-readonly`
- 示例库生成：`release examples`
- CLI 使用文档和架构文档已同步

## 后续可增强

- ProcDump / minidump 自动抓取
- report diff 与 HTML 可视化摘要
