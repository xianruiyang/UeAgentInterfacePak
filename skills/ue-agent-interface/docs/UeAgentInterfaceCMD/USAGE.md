# UeAgentInterfaceCMD 使用说明

## 1. 目标

`UeAgentInterfaceCMD` 是 `UeAgentInterface` 的外置命令行工具目录（主入口：`dist/uai-cli.exe`）。
它的作用是：

- 避免手写 HTTP
- 避免在命令行内联长 JSON
- 固化 `doctor / exec / batch / run / resume / namegen` 工作流
- 统一报告输出，便于失败定位与复盘
- 固化命令清单、兼容检查、崩溃现场收集、覆盖矩阵与 Pak 发布验证

## 2. 前置条件

1. 打开 UE Editor 工程
2. 在 UE 中启动服务：
   - `Window -> UeAgentInterface -> Start UeAgentInterface Server`

## 3. 配置文件 `uai-cli.default.json`

默认配置文件位于：

- 开发态：`UeAgentInterfaceCMD/uai-cli.default.json`
- 打包版：`UeAgentInterfaceCMD/dist/uai-cli.default.json`（与 `uai-cli.exe` 同目录）

典型字段：

```json
{
  "base_url": "http://127.0.0.1:17777",
  "token": "",
  "timeout_seconds": 60,
  "clear_log_on_start": true,
  "log_level": "info",
  "niagara_guard_enabled": true,
  "niagara_guard_strict": true,
  "auto_cleanup_enabled": true,
  "cleanup_tmp_max": 120,
  "cleanup_tmp_keep": 40,
  "cleanup_reports_max": 200,
  "cleanup_reports_keep": 120,
  "command_manifest_enabled": true,
  "compatibility_check_enabled": true,
  "expected_plugin_version_tag": "",
  "crash_capture_enabled": true,
  "runtime_index_enabled": true,
  "param_validation_mode": "warn"
}
```

说明：

- `token` 可以留空：CLI 会尝试从项目 `Saved/Config/WindowsEditor/UeAgentInterface.ini` 读取（前提是你至少在 Editor 里启动过一次服务端以生成 token）。
- 默认只允许 loopback（`127.0.0.1/localhost`）；如确需非本机地址，使用 `--allow-nonloopback`。

## 4. 常用命令

下面示例均以打包版为主（推荐）。若使用开发态，把 `.\dist\uai-cli.exe` 替换为 `python .\run_uai_cli.py` 即可。

### 4.1 健康检查：`doctor`

```powershell
.\dist\uai-cli.exe doctor --json-output
```

建议：任何写操作前先跑 `doctor`，失败就停止排查，不要继续写。

### 4.2 单条命令：`exec`

```powershell
.\dist\uai-cli.exe exec --cmd list_actors --params "{}" --json-output
```

也可以把参数放到文件里（推荐，避免命令行转义）：

```powershell
.\dist\uai-cli.exe exec --cmd list_actors --params-file ".\tmp\list_actors.json" --json-output
```

### 4.3 一次性批处理：`batch`

```powershell
.\dist\uai-cli.exe batch --file ".\tmp\my_batch.json" --json-output
```

### 4.4 模板化执行：`run`（plan + vars）

```powershell
.\dist\uai-cli.exe run --plan ".\plans\sample_plan_list_actors.json" --vars ".\vars\sample_vars.json" --json-output
```

只展开模板不执行：

```powershell
.\dist\uai-cli.exe run --plan ".\plans\sample_plan_list_actors.json" --vars ".\vars\sample_vars.json" --dry-run
```

### 4.5 从报告恢复：`resume`

```powershell
.\dist\uai-cli.exe resume --report ".\dist\reports\task_*.json" --json-output
```

只从失败 phase 重试：

```powershell
.\dist\uai-cli.exe resume --report ".\dist\reports\task_*.json" --retry-failed-phase --json-output
```

### 4.6 生成短资产名：`namegen`

```powershell
.\dist\uai-cli.exe namegen --kind blueprint --base Door --tag-mode none --max-len 20 --json-output
```

### 4.7 命令清单：`manifest`

```powershell
.\dist\uai-cli.exe manifest --summary --json-output
.\dist\uai-cli.exe manifest --output ".\docs\generated\command_manifest.json" --json-output
```

`manifest` 会从插件命令文档、C++ dispatch 和 smoke test 中生成机器可读清单。`exec / batch / run / resume` 默认会先用该清单检查命令名，避免把明显不存在的指令发给 UE。

manifest 内同时包含从文档关键参数推导出的 `param_schema`。默认 `param_validation_mode=warn`，类型不匹配或未知参数会进入 report warning；设置为 `strict` 时 warning 会升级为执行失败。

### 4.8 兼容检查：`compat`

```powershell
.\dist\uai-cli.exe compat --json-output
```

`doctor` 和写入类执行流程会带兼容检查结果。默认只把服务未运行、状态异常或显式配置的 `expected_plugin_version_tag` 不匹配视为硬失败；缺少版本字段会作为 warning 返回。

### 4.9 失败现场：`crash`

```powershell
.\dist\uai-cli.exe crash collect --json-output
.\dist\uai-cli.exe crash inspect --json-output
.\dist\uai-cli.exe crash pack --json-output
.\dist\uai-cli.exe crash signature --json-output
.\dist\uai-cli.exe crash replay --json-output
.\dist\uai-cli.exe crash bisect --json-output
```

`crash_capture_enabled=true` 时，`doctor / exec / batch / run / resume / release` 失败会自动在项目 `runtimeLogs/crashes/<run_id>/` 生成现场包，包含 report、最新 UE log、CrashContext、视觉输出有效性检查和 `crash-summary.md`。

### 4.10 运行索引：`index`

```powershell
.\dist\uai-cli.exe index --limit 20 --json-output
.\dist\uai-cli.exe index --failed-only --stats --json-output
```

每次写 report 后，CLI 会更新项目 `runtimeLogs/uai_cli_index.json`，用于快速查找最近失败命令、失败报告和执行结果。

### 4.11 发布验证：`release`

```powershell
.\dist\uai-cli.exe release coverage --json-output
.\dist\uai-cli.exe release pak-verify --json-output
.\dist\uai-cli.exe release examples --json-output
.\dist\uai-cli.exe release gate --json-output
.\dist\uai-cli.exe release all --json-output
.\dist\uai-cli.exe release sync-check --json-output
.\dist\uai-cli.exe release dev-mirror --dry-run --json-output
.\dist\uai-cli.exe release verify --run-tests --json-output
.\dist\uai-cli.exe release ci --json-output --ci-output .\reports\release_ci.json
.\dist\uai-cli.exe release manifest --release-id 2026.05.02 --json-output
```

`release ci` is the formal CI gate entrypoint. It runs coverage checks, sync-check, Pak verify, release-package hygiene checks, Dev CLI unit tests and Pak CLI unit tests by default, then returns one machine-readable gate result. It rejects dirty related worktrees unless `--allow-dirty` is explicitly used for local diagnostics. It also rejects release-package artifacts such as `runtimeLogs/`, `logs/`, report payloads, `tmp/`, `.pytest_cache/`, `__pycache__/`, `Binaries/`, `Intermediate/`, `Saved/` and `DerivedDataCache/` inside `UeAgentInterfacePak`. Test-generated CLI logs/cache are cleaned before the final hygiene pass so CI does not leave a polluted Pak tree behind.

- Use `--skip-tests` only for fast local diagnosis.
- Use `--write-coverage` when intentionally regenerating `docs/generated/*` before committing release docs.
- Use `--ci-output <path>` to write the full formal gate JSON report as a CI artifact.

`release dev-mirror` 默认保护 Pak 内 git submodule 工作区：非 `--dry-run` 写入会拒绝直接复制到
`UeAgentInterfacePak/UeAgentInterface` 和 `UeAgentInterfacePak/UeAgentInterfaceCMD`。只有明确需要本地临时镜像时，
才传 `--allow-submodule-content-write`；该结果仍然返回 `formal_release_allowed=false`，不能作为正式发布。

`release coverage` 生成 `docs/generated/command_coverage_matrix.json|md`，汇总 `命令 -> 文档 -> 实现 -> smoke` 覆盖关系。所有已实现命令都必须出现在 automation smoke 源码或显式 smoke coverage ledger 中，否则 `missing_smoke` 会进入债务报告。
`release pak-verify` 检查 Pak 目录关键文件、skill、CLI 与基础 hash 差异。`release examples` 生成 `examples/generated/` 里的只读 golden E2E 示例。`release gate` 汇总 manifest、coverage、Pak verify，可加 `--run-tests` 同时运行 CLI 单测；`missing_smoke` 不再只是提示，会让 gate 失败。

发布拓扑相关命令：

- `release sync-check`：只读检查开发插件/CLI、Pak 插件/CLI 的 commit、当前文件树 hash 和 dirty 状态。
- `release dev-mirror`：把开发副本镜像到 Pak 副本，只用于本地临时验证；返回 `formal_release_allowed=false`，不能作为正式发布。
- `release verify`：兼容的底层发布校验，默认禁止任一相关仓库 dirty，并要求 sync-check、coverage 和 quality gate 全部通过。
- `release ci`：正式 CI / 发布门禁单入口，覆盖 `release verify` 的核心校验，并额外检查 Pak layout、发布包 hygiene、Dev CLI 测试和 Pak CLI 测试。
- `release manifest`：生成 `UeAgentInterfacePak/releases/<release_id>/manifest.json`，记录 commit、tree hash、sync 状态和 coverage 摘要。

正式发布不复制源码。插件和 CLI 应先分别提交/tag，再让 Pak 内 submodule checkout 到对应 commit；Pak 仓库只记录 gitlink、README、skills、release notes 和 manifest 等发布材料。

GitHub 远端发布是明确的人工边界：CLI 和 Agent 可以准备本地提交、manifest、release notes、待执行命令清单和 gate report，但不执行 `git push`、创建 GitHub Release 或写入远端 tag。最后远端动作由项目维护者手动完成。

### 4.12 Golden E2E：`e2e`

```powershell
.\dist\uai-cli.exe e2e local --json-output
.\dist\uai-cli.exe e2e ue-readonly --json-output
```

`e2e local` 不依赖 UE，只生成并检查本地示例库。`e2e ue-readonly` 需要 UAI 服务在线，运行 `get_world_state/list_actors` 只读批次。

## 5. `run` vs `batch` 怎么选

- 用 `run`：
  - 任务结构稳定、可复用
  - 希望把变量抽到 `vars.json`
  - 希望按 phase 分阶段执行（便于失败定位与恢复）
- 用 `batch`：
  - 一次性任务/临时验证
  - 步骤明确且不需要模板抽象

## 6. 输出位置（报告 / 日志 / 临时文件）

输出目录取决于运行方式：

- 打包版（`dist/uai-cli.exe`）：
  - 报告：`UeAgentInterfaceCMD/dist/reports/`
  - 日志：`UeAgentInterfaceCMD/dist/logs/`
  - 临时 JSON：`UeAgentInterfaceCMD/dist/tmp/`
- 开发态（`python run_uai_cli.py`）：
  - 报告：`UeAgentInterfaceCMD/reports/`
  - 日志：`UeAgentInterfaceCMD/logs/`
  - 临时 JSON：`UeAgentInterfaceCMD/tmp/`

报告里会带 `failed_index/failed_command/failed_error` 等字段；不要只看最后一条报错字符串。

失败现场位于项目根目录：

- `runtimeLogs/crashes/<run_id>/manifest.json`
- `runtimeLogs/crashes/<run_id>/crash-summary.md`
- `runtimeLogs/uai_cli_index.json`
- `examples/generated/`
- `docs/generated/implemented_command_catalog.md`

## 7. 常见问题

### 7.1 `doctor` 失败

按顺序检查：

1. UE Editor 是否已打开项目
2. UE 菜单里是否已启动 `UeAgentInterface Server`
3. `base_url` 是否正确（默认 `http://127.0.0.1:17777`）
4. `token` 是否正确（或是否能从 `Saved/Config/WindowsEditor/UeAgentInterface.ini` 读取）

### 7.2 401 Unauthorized

说明 token 缺失或不匹配：

- 确认请求头/配置里的 `token`
- 在 UE 中使用 `Window -> UeAgentInterface -> Copy Connection Info` 获取当前会话的连接信息

### 7.3 命令清单校验失败

说明 batch/plan 中存在当前文档或插件 dispatch 均未发现的命令名。先检查拼写；如果是新插件命令，必须同步插件文档或确认 CLI 正在读取正确项目。

### 7.4 截图文件存在但无效

CLI 会检查 report 中的 PNG 路径。若图片全黑、全透明或像素方差过低，失败现场会标为 `BlackScreenshot`，不能把“文件存在”当作可视化验证通过。
BMP 也会做像素统计；JPG/JPEG 当前做尺寸有效性检查。
