# Editor lifecycle

## 默认策略

默认复用并保持用户当前 Unreal Editor。只有任务必须拥有独立 Editor，或插件/Editor C++ 的正式
构建流程要求关闭时，才进入生命周期 runner。UAI 插件 C++ 修改不使用 Live Coding；不得用强杀代替正常退出。

## 启动 owned Editor

项目正式入口是 `scripts/ue/StartUaiEditorLifecycle.ps1`。首次使用或参数不明时读取 `-?`/help，再提供它要求的
UE 根目录、项目路径和任务专属 receipt 路径。

默认以不激活的最小化方式启动普通 Editor，保留任务栏入口；启动结束后窗口恢复与焦点由用户控制。
`-Minimized` 可显式指定该默认方式；`-Visible` 显示并激活窗口；`-Offscreen` 才使用隐藏、离屏、unattended 模式。
这三种方式互斥。示意：

```powershell
pwsh -File scripts/ue/StartUaiEditorLifecycle.ps1 `
  -UERoot "<ue-root>" `
  -ProjectPath "<project>" `
  -ReceiptPath "<task-temp-receipt>"
```

代理只消费 receipt 的 `public` 摘要来判断 ready、失败和可继续动作；底层连接与进程见证由 runner 持有。

若同一项目已有 Editor，runner 返回 `preexisting_project_editor`，不要再次启动。启动后按短错误区分
没有启动日志、Editor 初始化超时、Editor 已初始化但 UAI 未启动，以及 UAI 已启动但认证探针未就绪；
不要把这些情况统一解释为“UE 没打开”。Editor 初始化后的 UAI 等待是独立短期限，不应继续等完整冷启动期限。

## 关闭 owned Editor

仅保存指定资源并保持Editor打开时，使用[仅保存既有资源](hjson-workspace.md#仅保存既有资源)的 `editor.save_resources`，不必启动退出流程。

关闭前通过公开查询读取 dirty resources（单次查询可用 [CLI](cli.md)），并按任务授权决定。
启动和退出继续使用本页生命周期 runner，它们的进程与收据管理不由普通 `exec` 替代：

- `reject`：存在未保存资源即拒绝退出；
- `save`：用重复的 `--save-resource <resource-ref>` 提供已授权的全部 dirty resources，保存后正常退出；
- `discard`：仅在用户明确接受丢弃时使用，并用 `--discard-resource <resource-ref>` 指定资源。

调用 `scripts/ue/SafeExitLifecycle.py`。runner 会从项目进程集合解析唯一 Editor，并使用显式连接文件或项目
runtime settings 装配公开 SDK 连接：

```powershell
python.exe scripts/ue/SafeExitLifecycle.py `
  --project "<project>" `
  --output "<task-temp-exit-receipt>" `
  --mode reject
```

`--output` 是本次调用的公开摘要；复用路径时更新当前结果。内部两阶段回执由 runner 维护。
runner 在发送前登记 Operation 恢复名称；确认进程退出并保存外部见证结果后清理本地登记。
普通 Operation 收据不能代替进程退出见证；失败摘要仍保留具体原因和恢复名称。

不要从 receipt 提取或手工传递进程身份。项目中没有或存在多个可匹配 Editor 时让 runner 失败关闭，
不要自行猜测目标。退出失败时保留用户 Editor 和 dirty 资源，报告公开错误并
停止；只有规则和当前授权明确允许时，才采取更强的恢复动作。
