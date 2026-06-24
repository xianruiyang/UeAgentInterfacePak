# CLI Diagnostics And Release Checks

本页只记录 CLI 回退、插件外工具链和发布诊断。日常 UAI 操作优先使用已定位 `UeAgentInterfaceCMD` 的 Python `uai_core`；默认候选找不到时先向用户确认安装路径，确认没有可用 UAICMD 后才进入 CLI 回退。进入 CLI 回退时，具体命令行为以 `<SkillDir>/docs/UeAgentInterfaceCMD/USAGE.md` 为准，`uai-cli.exe` 固定使用 `<SkillDir>/tools/uai-cli.exe`，report、crash capture 和索引默认写入 `<UserWorkDir>/runtimeLogs/`。

## 快速入口

```powershell
$SkillDir = "<SkillDir>"
$UserWorkDir = "<UserWorkDir>"
$UaiCli = Join-Path $SkillDir "tools/uai-cli.exe"
$RuntimeLogs = Join-Path $UserWorkDir "runtimeLogs"
New-Item -ItemType Directory -Force -Path $RuntimeLogs | Out-Null

& $UaiCli --report-file (Join-Path $RuntimeLogs "uai_manifest.json") manifest --summary --json-output
& $UaiCli --report-file (Join-Path $RuntimeLogs "uai_compat.json") compat --json-output
& $UaiCli --report-file (Join-Path $RuntimeLogs "uai_index.json") index --limit 20 --json-output
& $UaiCli --report-file (Join-Path $RuntimeLogs "uai_crash_inspect.json") crash inspect --json-output
& $UaiCli --report-file (Join-Path $RuntimeLogs "uai_crash_signature.json") crash signature --json-output
& $UaiCli --report-file (Join-Path $RuntimeLogs "uai_crash_replay.json") crash replay --json-output
& $UaiCli --report-file (Join-Path $RuntimeLogs "uai_crash_bisect.json") crash bisect --json-output
& $UaiCli --report-file (Join-Path $RuntimeLogs "uai_e2e_local.json") e2e local --json-output
& $UaiCli --report-file (Join-Path $RuntimeLogs "uai_release_all.json") release all --json-output
& $UaiCli --report-file (Join-Path $RuntimeLogs "uai_release_gate.json") release gate --json-output
```

## 使用边界

- `manifest` 用于生成机器可读命令清单，并支撑 `exec/batch/run/resume` 的命令名校验。
- `param_schema` 由 manifest 从命令文档关键参数推导；默认 warn，必要时设置 `param_validation_mode=strict`。
- `compat` 用于检查 CLI 版本、插件 `/api/status` 和显式 `expected_plugin_version_tag`。
- `crash` 用于收集、检查、签名、replay 和二分失败现场；自动收集目录应位于 `<UserWorkDir>/runtimeLogs/crashes/<run_id>/`。
- `index` 用于查看、过滤和统计 `<UserWorkDir>/runtimeLogs/uai_cli_index.json` 最近 report 摘要。
- `release coverage` 用于生成 `命令 -> 文档 -> 实现 -> smoke` 覆盖矩阵。
- `release examples` 用于生成 golden E2E 只读示例。
- `release gate` 用于 CI/发布门禁。
- `release pak-verify` 用于检查 Pak 目录关键文件与开发态 CLI 的基础差异。

## 判断规则

- CLI 回退模式下命令清单校验失败时，先检查命令拼写和当前 `$UaiCli` 是否为 `<SkillDir>/tools/uai-cli.exe`。
- 截图或预览相关失败不能只看文件是否存在；以 report/crash capture 中的 PNG 有效性检查为准。
- Pak 发布前至少执行一次 `release all`；有 `issues[]` 必须处理，有 `warnings[]` 必须记录是否接受。
- 发布前优先跑 `release gate --run-tests`；UE 在线时再补 `e2e ue-readonly`。
