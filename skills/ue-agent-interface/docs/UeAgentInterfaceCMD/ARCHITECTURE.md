# UeAgentInterfaceCMD 架构说明

## 1. 模块划分

- `uai_cli.main`
  - 命令行入口与参数解析
  - 子命令分发：`doctor/exec/batch/run/resume/namegen/manifest/compat/crash/index/release`
- `uai_cli.config`
  - 配置加载、覆盖与校验
  - loopback 安全限制
  - Niagara 护栏与自动清理配置
- `uai_cli.http_client`
  - HTTP GET/POST 封装与错误转换
- `uai_cli.templating`
  - `defaults + vars` 合并
  - `{{var}}` 模板渲染
  - phase 结构归一化
- `uai_cli.runner`
  - `exec_batch` 执行引擎
  - phase 顺序执行与失败中断
- `uai_cli.niagara_guard`
  - Niagara 变更护栏（预处理 + 结果校验）
- `uai_cli.cleanup`
  - `tmp/reports` JSON 自动裁剪
- `uai_cli.naming`
  - 简短资产名生成（前缀 + 可选短标签）
- `uai_cli.reporting`
  - 执行报告生成与落盘
- `uai_cli.logging_setup`
  - CLI 日志初始化（含 hostname）
- `uai_cli.command_manifest`
  - 从插件 docs、C++ dispatch、smoke test 生成机器可读命令清单
  - 在 `exec/batch/run/resume` 执行前做命令名校验
- `uai_cli.command_schema`
  - 从命令文档关键参数推导轻量 `param_schema`
  - 在 warn/strict 模式下检查 params 对象、未知参数和基础类型
- `uai_cli.compatibility`
  - 读取 `/api/status`，生成 CLI/插件版本与命令集兼容报告
- `uai_cli.visual_validation`
  - 对 report 中的 PNG 视觉输出做尺寸、透明度、非黑和像素方差检查
- `uai_cli.crash_capture`
  - 失败时收集 report、UE log、CrashContext、视觉检查和复现线索
- `uai_cli.runtime_index`
  - 将 report 摘要写入项目 `runtimeLogs/uai_cli_index.json`
- `uai_cli.release_verify`
  - 生成命令覆盖矩阵，检查 Pak 分发布局和关键文件 hash 差异
- `uai_cli.example_library`
  - 生成 `examples/generated/` golden E2E 只读示例
- `uai_cli.e2e`
  - 本地 E2E 与 UE 只读 E2E 执行器
- `uai_cli.quality_gate`
  - 汇总 manifest、coverage、Pak verify、可选单测为发布门禁

## 2. 执行链

1. 入口解析参数与配置（支持命令行覆盖默认配置）。
2. 按需执行自动清理（启动阶段）。
3. 执行子命令：
   - `doctor`：`/api/ping` + `/api/status`
   - `exec`：单次 `/api/exec`
   - `batch`：读取 JSON 后走统一 `execute_batch()`
   - `run`：读取 `plan + vars`，按 phase 调 `execute_batch()`
   - `resume`：从报告失败点继续
   - `namegen`：生成短资产名
   - `manifest`：生成命令清单
   - `compat`：检查 CLI/插件兼容性
   - `crash`：收集、检查、打包失败现场
   - `index`：读取运行索引
   - `release`：生成覆盖矩阵、示例、验证 Pak 或运行 gate
   - `e2e`：运行本地或 UE 只读 golden E2E
4. 对 `exec/batch/run/resume` 执行命令清单校验和兼容 preflight。
5. 记录报告、日志和 runtime index。
6. 命令失败时按配置自动 crash capture。
7. 命令结束后再次执行自动清理。

## 3. Niagara 护栏机制

### 3.1 预处理

当批次包含 Niagara 变更指令时：

- 自动注入 preflight：关闭资产编辑器句柄（避免 stale editor state）。
- 严格模式下，拦截“同一 system 同批次 remove_emitter + add_emitter”。

### 3.2 后校验

对每个触及的 NiagaraSystem 自动注入：

- `niagara_compile_system`
- `niagara_get_compile_log`
- `niagara_system_list_emitters`

若出现以下任一情况，批次判失败：

- 编译日志含错误；
- emitter 列表出现 `Unknown Emitter` / `Unknown Em`；
- emitter 缺失 `id`。

## 4. 命名策略

- 统一前缀：`BP/WBP/M/MI/NS/NE/LS`
- 支持 `tag_mode`：`none/time/date/datetime`
- 默认输出短名，降低在 UE 内容浏览器中的检索成本

## 5. 报告模型

每次执行输出结构化报告，包含：

- 任务 ID、时间戳、配置快照（token 脱敏）
- phase 级执行结果
- 失败索引与失败指令
- 耗时分解：`t_prepare_ms/t_http_ms/t_parse_ms/t_verify_ms/t_total_ms`
- 命令清单校验摘要
- CLI/插件兼容检查摘要

## 6. 失败现场与视觉验证

失败现场默认写入项目根目录：

- `runtimeLogs/crashes/<run_id>/manifest.json`
- `runtimeLogs/crashes/<run_id>/crash-summary.md`
- `runtimeLogs/crashes/<run_id>/ue/`
- `runtimeLogs/crashes/<run_id>/ue-crash/`

失败分类包括：

- `CommandFailed`
- `ServiceLost`
- `Timeout`
- `CliException`
- `BlackScreenshot`

视觉验证目前使用零依赖 PNG 解码器，检查宽高、像素数、非黑像素、非透明像素、平均亮度和亮度方差。它的职责是挡住“截图文件存在但实际全黑/空白”的假成功。
BMP 使用零依赖像素统计；JPG/JPEG 当前只解析尺寸并标注 `pixel_statistics_available=false`。

## 7. 发布验证

`release coverage` 会生成：

- `docs/generated/command_coverage_matrix.json`
- `docs/generated/command_coverage_matrix.md`
- `docs/generated/implemented_command_catalog.md`

`release pak-verify` 会检查 Pak 中 README、插件目录、CLI 目录、skill、command-map 以及开发态 CLI 与 Pak CLI 的基础 hash 差异。
`release gate` 在 release 前聚合 manifest、coverage、Pak verify 和可选单测，适合 CI 调用；同等入口也提供 `tools/ci_gate.py`。

## 8. 安全与约束

- 默认仅允许 loopback（`127.0.0.1/localhost`）
- token 必须来自配置或参数，不写死在代码里
- 报告中 token 脱敏
