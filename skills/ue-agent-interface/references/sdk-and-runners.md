# SDK 与 runner

## 连续 SDK 操作与环境

需要 workspace、operation、artifact、PIE 等 typed handle，或需连续消费结果时使用 SDK。
普通单次调用见 [CLI](cli.md)，不为简单查询创建临时 Python。已有 SDK 流程中的查询可复用同一 Client。
例如直接编辑 HJSON 后，沿用已导出的 `target` 和短名称导入：

```python
import uai

with uai.connect_project() as client:
    workspace = client.content_graph.open_workspace(target, name="current")
    result = workspace.import_changes()
    result.raise_for_error()
    print(result.payload.get("warnings"), result.payload.get("workspace_refresh"))
```

已有 SDK 环境直接运行：

```powershell
python.exe UeAgentInterfaceCMD/tools/sdk_environment.py run -- <script.py>
```

SDK 与 CLI 共用预装环境，安装与卸载见 [CLI](cli.md#项目与安装)。独立连接见 CMD `docs/PYTHON_SDK_AND_CLI.md`。

按决策边界组织有限批次，逐项检查 Result。前步生成的名称或字段能从公开结果确定性取得时继续；
换命令或换资产本身不要求返回模型。需要新设计/视觉判断时结束批次。
HJSON 文件编辑仍用文件工具，不为合并 SDK 调用改写成 Python，也不为保持 handle 建常驻等待脚本。
可按操作时长传 `io_timeout_seconds`；超时不证明写入失败，状态不明时先核对，不能直接重放。

SDK 普通调用用 named method；动态自动化已持有精确命令名和参数时可用 `client.execute(name, params)`。

## Result 与文件产物

消费 `result.ok/payload/error`；失败时保留具体诊断，停止依赖失败结果的步骤。
`raise_for_error()` 只检查顶层 `ok`，不替代领域完成或清理判断。
`ok=True` 仍可能有 `payload.warnings`；结果摘要保留并检查这些警告，不能仅输出 `ok/error`。
警告不等于操作失败，不因此自动重试已经成功的写入。
完整公开 payload 按需存任务文件，在执行脚本内一次输出下一判断需要的状态、诊断和产物路径。
摘要已覆盖判断时直接消费；缺字段或出现异常再定向读原结果，不反复用全文搜索重建同一份摘要。
文件通过 `result.artifacts` 的公开 handle 取得：

```python
file = result.artifacts[0].materialize("tmp/current-task/frame.png")
print(file.path)
```

默认复用内容一致的已有文件，不同内容自动选择带数字后缀的文件名；使用返回的 `file.path`，不假定输出仍是请求路径。
确需精确路径时传 `on_conflict="error"`。保存失败只重试同一 artifact 的 `materialize`，不恢复或重跑已成功的 UE 操作。
不要提取原 locator、hash、artifact identity 或机器信封。
PIE 的操作与截图结果见 [PIE 流程](pie.md)。

## 非 PIE 长任务与恢复

调用返回 `result.operation` 时，有限操作用 `handle.finish(timeout=...)` 取得收据并完成释放。
持久 Editor 会话用 `handle.wait(until=...)` 等 policy 就绪信号；`asset_editor/open` 的就绪是
`payload.latest_signal.payload.phase == "active"`。检查返回结果仍未终止且已就绪，再保留 handle 交互，结束时 `handle.close()`。
`wait(until=...)` 可返回满足条件的非终态观察，也可在条件满足前返回终态收据；顶层成功不保证已就绪。
不传 `until` 时等待终态，超时或未完成停止仍按返回/异常处理。`finish()` 取得终态收据后完成释放；
`close()` 先请求取消再收尾。普通有限操作使用 `finish()`，无需另写 `resume/release` 循环。
`receipt.ok` 只表示读取成功；业务成功看 `payload.lifecycle_status/error_code` 和领域报告，
原生收尾看 `cleanup_complete`；主动关闭持久会话的取消终态应按关闭语义判断，不要求它变成业务成功终态。
已发布 artifacts 在 operation 释放后仍可 materialize，不要求先保存文件再释放。

SDK 在发送可产生 Operation 的请求前自动保存恢复记录，响应丢失也保留原请求。
需要可读名称时，在启动调用外使用 `with client.operation.named("short-name"):`；
否则读 `handle.recovery_name`，或用 `client.operation.pending()` 查本地待处理名称。
跨进程用 `client.operation.recover(name)` 恢复原操作；本地记录缺失时用 `discover()`，
确认目标后显式 `takeover(name)` 接管，旧句柄随即失效。发现本身不接管，也不重放业务。
名称对应同一项目中当前认证主体的操作，不代表不同代理之间的身份隔离。
`checkpoint(name)` 仅是可选别名；收据已保存后 `forget_checkpoint(name)` 只清理本地记录。
服务端会自行观察已启动操作并完成原生收尾，保留收据待领取；持久会话仍需显式关闭。
等待超时或断连不代表完成，保留原记录恢复。Editor 退出使用专用 runner 的外部见证。
公共 API 与失败边界见 CMD `docs/active/t32_long_running.md`。
不手工读写 continuation identity，也不把 Python 对象或终端 ID 当作恢复凭据。
公共事务错误中的事务状态、回滚结果与 `retry_safe` 决定可重试范围，不自行推断。
AssetDurable 恢复使用 `result.durable_journals` 返回的 handle 的 `inspect/reconcile`。

PIE 专用 SDK 使用同一公共生命周期，并维护父会话与流程快照。

## 项目单命令 runner

仅在任务需要项目 runner 的机器收据时使用此入口；普通命令发现、查询和留存 Result 用 [CLI](cli.md)。
参数/输出文件是 runner 收据路径的要求，不是普通命令的前置步骤：

```powershell
python.exe scripts/ue/InvokeUaiCommand.py `
  --mode execute `
  --expected-command-id "<exact-command-name>" `
  --params-file "<task-temp-json>" `
  --output "<task-result-json>"
```

参数文件放本次 `tmp/<run-id>/`。首次使用或参数不明时查 `--help`，已有适用调用无需重复查询。
runner 的 search resolve 要求预期精确命令，未知名称的首次发现使用公开 `command_search`。
不手工建立连接配置、猜 endpoint 或调用静态打包的旧 CLI。
