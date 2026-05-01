# CLI Diagnostics And Release Checks

本页只记录插件外工具链。具体命令行为以 `UeAgentInterfaceCMD/docs/USAGE.md` 为准。

## 快速入口

```powershell
.\UeAgentInterfaceCMD\dist\uai-cli.exe manifest --summary --json-output
.\UeAgentInterfaceCMD\dist\uai-cli.exe compat --json-output
.\UeAgentInterfaceCMD\dist\uai-cli.exe index --limit 20 --json-output
.\UeAgentInterfaceCMD\dist\uai-cli.exe crash inspect --json-output
.\UeAgentInterfaceCMD\dist\uai-cli.exe crash signature --json-output
.\UeAgentInterfaceCMD\dist\uai-cli.exe crash replay --json-output
.\UeAgentInterfaceCMD\dist\uai-cli.exe crash bisect --json-output
.\UeAgentInterfaceCMD\dist\uai-cli.exe e2e local --json-output
.\UeAgentInterfaceCMD\dist\uai-cli.exe release all --json-output
.\UeAgentInterfaceCMD\dist\uai-cli.exe release gate --json-output
```

## 使用边界

- `manifest` 用于生成机器可读命令清单，并支撑 `exec/batch/run/resume` 的命令名校验。
- `param_schema` 由 manifest 从命令文档关键参数推导；默认 warn，必要时设置 `param_validation_mode=strict`。
- `compat` 用于检查 CLI 版本、插件 `/api/status` 和显式 `expected_plugin_version_tag`。
- `crash` 用于收集、检查、签名、replay 和二分失败现场；自动收集目录在项目 `runtimeLogs/crashes/<run_id>/`。
- `index` 用于查看、过滤和统计项目 `runtimeLogs/uai_cli_index.json` 最近 report 摘要。
- `release coverage` 用于生成 `命令 -> 文档 -> 实现 -> smoke` 覆盖矩阵。
- `release examples` 用于生成 golden E2E 只读示例。
- `release gate` 用于 CI/发布门禁。
- `release pak-verify` 用于检查 Pak 目录关键文件与开发态 CLI 的基础差异。

## 判断规则

- 命令清单校验失败时，先检查命令拼写和当前 CLI 是否在正确项目根下运行。
- 截图或预览相关失败不能只看文件是否存在；以 report/crash capture 中的 PNG 有效性检查为准。
- Pak 发布前至少执行一次 `release all`；有 `issues[]` 必须处理，有 `warnings[]` 必须记录是否接受。
- 发布前优先跑 `release gate --run-tests`；UE 在线时再补 `e2e ue-readonly`。
