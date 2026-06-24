# UeAgentInterface 批处理执行手册

## 目标

多步骤 UE 编辑器自动化默认使用 `exec_batch` 或 CLI 的 `batch`，让顺序、失败位置和中间结果都可追踪。

## 为什么优先批处理

- 操作顺序确定。
- `stop_on_error=true` 时第一处失败立即停止。
- 返回失败位置：`failed_index`、`failed_command`、`failed_error`。
- 返回已执行步骤：`results[]`。
- 减少大量独立调用造成的半完成状态和排查成本。

## 请求结构

```json
{
  "request_id": "batch-001",
  "command": "exec_batch",
  "params": {
    "stop_on_error": true,
    "commands": [
      {
        "request_id": "step-001",
        "command": "begin_transaction",
        "params": { "label": "MyBatchEdit" }
      },
      {
        "request_id": "step-002",
        "command": "list_actors",
        "params": { "limit": 20 }
      },
      {
        "request_id": "step-003",
        "command": "end_transaction",
        "params": { "commit": true }
      }
    ]
  }
}
```

## 优先读取的返回字段

- `ok`
- `error`
- `data.interrupted`
- `data.failed_index`
- `data.failed_command`
- `data.failed_error`
- `data.results[]`

## 失败处理模式

1. `ok=true`：批次完成。
2. `ok=false` 且 `failed_index>=0`：
   - 读取失败步骤和之前成功步骤的结果。
   - 先修根因，再继续。
   - 幂等批次可以整体重跑；非幂等批次从失败步骤之后重组新批次。
3. 记录 `request_id` 和每个 step id，便于 report 与 runtime log 对齐。

## 推荐批次结构

### 只读审计

- `list_actors`
- `actor_list_components`
- `blueprint_get_info`
- `niagara_get_info`
- `niagara_get_stack_issues`

### 事务式内容编辑

- `begin_transaction`
- 写入步骤
- 编译/读回/诊断步骤
- `save_asset` 或 `save_current_level`
- `end_transaction`

### JSON / 文件夹式资产编辑

- 创建最小骨架命令
- `*_export_json` 或 `*_export_folder`
- 外部修改 JSON 文件
- `*_apply_json` 或 `*_apply_folder`
- 编译、读回、coverage 或 Stack issue 验证

### Niagara 安全编辑

- `niagara_create_system` 或 `niagara_create_emitter` 创建最小骨架。
- `niagara_export_folder` / `niagara_emitter_export_folder` 导出真实模板。
- 修改 folder JSON 后 `niagara_apply_folder` / `niagara_emitter_apply_folder`。
- 检查 apply 返回的 `warnings`、`stack_error_count`、`stack_issues`。
- 检查 module input 的控制分支：mode / enum / static switch 必须读回为预期值，目标参数必须位于活跃分支。
- 按当前 mode 校验有效属性组；非当前 mode 的字段即使 JSON 可读回，也不算验收通过。
- 遇到 `module_input_hidden_or_inactive_branch` 时不要继续堆模块；先修控制项，重新导出，再写分支值。
- 对 Sprite 形状类需求，读回 `Sprite Size Mode`、`Module.Sprite Size`、Renderer `SpriteSizeBinding` 和 Alignment，避免“值存在但视觉仍是圆点”。
- 必要时执行 `niagara_refresh_system`。
- 执行 `niagara_compile_system`、`niagara_get_compile_log`、`niagara_system_runtime_probe`。

## 护栏

- 不嵌套 `exec_batch`。
- 每一步都写明确 `request_id`。
- 单批步骤数保持可读；超大任务按领域拆批。
- 尽量把 write 后的 readback 放在同一个批次里。
- 碰到失败先查根因，不继续堆新操作。
- 批处理 report 必须落盘并在最终回复中说明路径。

## CLI 回退的最小 PowerShell 调用

```powershell
$SkillDir = "<SkillDir>"
$UserWorkDir = "<UserWorkDir>"
$UaiCli = Join-Path $SkillDir "tools/uai-cli.exe"
$ParamDir = Join-Path $UserWorkDir "tmp/uai_params"
$RuntimeLogs = Join-Path $UserWorkDir "runtimeLogs"
New-Item -ItemType Directory -Force -Path $ParamDir, $RuntimeLogs | Out-Null

$BatchFile = Join-Path $ParamDir "list_actors.batch.json"
$ReportFile = Join-Path $RuntimeLogs "list_actors_report.json"

# 将 batch JSON 写入 $BatchFile，随后执行：
& $UaiCli --report-file $ReportFile batch --file $BatchFile --json-output
```

Python `uai_core` 可直接传结构化参数或读取 JSON；只有 CLI 回退时，才必须把参数写入 `<UserWorkDir>/tmp/uai_params/` 下的 JSON 文件，再用 `<SkillDir>/tools/uai-cli.exe batch --file <batch.json> --json-output` 执行。report 默认写入 `<UserWorkDir>/runtimeLogs/`。
