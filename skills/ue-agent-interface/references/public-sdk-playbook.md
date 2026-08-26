# UAI Public SDK Playbook

本页只说明 Agent 如何通过公开 Python SDK 或薄 CLI 调用运行中的
UeAgentInterface 服务。C++ 正式 command manifest 是公开能力真源；Python 只做
网络转发、协议封装与无损结果还原。

## Python

调用方只导入一个包，并用一行连接配置创建 Client：

```python
import uai

with uai.connect("connection.toml") as ue:
    result = ue.query.calibration_read(
        "runtime_probe",
        limit=2,
    )
```

每个 `ue.<namespace>.<command>(...)` 只发送一条同名真实 command。需要动态调用时，
使用 `ue.execute("namespace.command", params)`；不得在 Python 中补写 UE 业务、
HJSON、Planning、Verification、重试或 route 选择。

静态方法以 `UeAgentInterfaceCMD/cli/uai/commands/generated.pyi` 为调用说明，能力
全集以 `Plugins/UeAgentInterface/Resources/UaiCommandManifest.json` 为准。正式
manifest 没有的命令视为尚未迁移，必须明确报告能力缺口，不能回退旧 Python
实现、扫描源码猜参数或直接调用 HTTP。

## Command discovery

稳定逻辑引用 `uai-skill:public-sdk-playbook#command-discovery` 指向本节；机器
`query.command.detail` 至少返回该引用与
`uai-docs:python-sdk-and-cli#command-discovery`，复杂领域还会返回注册声明拥有的
领域或 command-specific 引用。不知道 command 名称时按以下单向
流程调用，不从源码、旧测试或历史 helper 猜 ID 和参数：

```python
import uai

with uai.connect("connection.toml") as client:
    candidates = client.query.command_search(
        "inspect the current editor without changing assets",
        limit=3,
    )
    candidate = candidates.payload["candidates"][0]
    detail_options = {}
    if candidate.get("variant_id"):
        detail_options["variant_id"] = candidate["variant_id"]
    detail = client.query.command_detail(
        candidate["command_id"],
        candidate["contract_hash"],
        **detail_options,
    )

    tutorial = detail.payload
    # variant 读取 request_schema；command-only 读取 input_fields/result_fields 的 nested schema；
    # errors、invocation 与 tutorial_references 后选择 named、generic 或 exact。
    result = client.query.calibration_read("runtime_probe", limit=2)
```

只有 `query.command.search` 允许按意图匹配；detail 必须保留精确
`command_id`/`contract_hash` 与候选可选的 `variant_id`。variant detail 返回完整顶层
`request_schema`；实际执行仍使用候选的 command identity，不把 variant 建成第二入口。
默认动态调用为 `client.execute(command_id, params)`；
版本锁定调用为
`client.execute_exact(command_id, params, contract_hash=contract_hash)`。
`invocation.python_named` 由正式 namespace、function 与字段投影生成；复制调用形状时
仍以生成 binding 为执行入口。每条 command 的大段教程和 schema 留在 detail/稳定
tutorial reference 的 owner，不复制进 skill。

创建 typed asset 时若不知道精确 factory identity，使用公开查询而不是猜类名：

```python
candidates = client.asset.factory_candidates(
    "asset.media_source.create",
    query="file media",
    limit=5,
)
```

按 `query.command.detail` 的字段合同复制返回的 `factory_ref`；factory catalog、
官方插件可用性与 unsupported failure 都由服务端拥有，Python 不扫描源码或建立第二份映射。

TextureGraph mutation/settle 返回 `package-md5:*`。将成功 settle 的修订原样交给
`artifact_capture.expected_settled_revision` 或 `artifact_bake.expected_revision`；
不得改用 content-graph revision。bake 对未持久化、内存脏、stale 或目标冲突 fail closed，
`runtime_probe` 则是无 revision 参数的不持久化当前状态读取。

同一流程的 CLI 形式是：

```powershell
uai-cli --connection connection.toml exec query.command.search `
  --params-json '{"intent":"inspect the current editor without changing assets","limit":3}'
uai-cli --connection connection.toml exec query.command.detail `
  --params-json '{"command_id":"editor.session","contract_hash":"sha256:<exact>","variant_id":"policy:world-context:set-current/v1"}'
uai-cli --connection connection.toml exec query.calibration.read `
  --contract-hash sha256:<exact> `
  --params-json '{"category":"runtime_probe","limit":2}'
```

## HJSON authoring bootstrap

领域显式支持动态 authoring schema 时，模型只需一条查询取得当前字段合同和可编辑
模板，再用一条 Import 提交稀疏文档：

```python
import json

with uai.connect("connection.toml") as client:
    authoring = client.content_graph.authoring_schema(target).payload["query_result"]
    document = authoring["template"]
    document["root"]["fields"][chosen_field]["value"] = desired_value
    result = client.content_graph.import_workspace(
        target,
        {
            "kind": "inline",
            "document": json.dumps(
                document,
                ensure_ascii=False,
                separators=(",", ":"),
            ),
        },
        authoring["revision"],
        authorization_id,
    )
```

`authorization_id` 必须来自本次已授权工作流。不得从示例生成授权，也不得从旧文档、
源码或另一资产类型猜字段。`fields[].allowed_intents` 决定 set/remove/null/default 的
适用性；缺失字段按 schema 的 missing 语义处理。领域不支持
`content_graph.authoring_schema` 时会 typed fail closed，再用 command search/detail
确认当前入口或报告能力缺口。

Sequence 的稀疏 HJSON settings 由服务端委派给
`timeline.sequence.settings.update`；直接 native 调用前仍须读取该命令 detail，并使用
它自己的 native revision。content-graph revision 与 native Timeline revision 不互换。

## Durable journal maintenance

资产写操作返回 durable `journal_id`、`persisted_unverified` 或 `state_unknown` 时，停止
自动重试和原业务命令重放。当前项目使用
`scripts/ue/ReconcileAssetDurableJournal.py` 作为唯一维护 runner：它通过公开 SDK 先执行
精确 journal read，取得当前稳定 owner/fence、plan/inventory 绑定和独立 artifact
readback，再把同一绑定原样交给 reconcile。runner 不读取 journal 文件、不实现资产
保存/回滚，也不激活 Editor 窗口。

```powershell
python scripts/ue/ReconcileAssetDurableJournal.py `
  --journal-id <32-hex-journal-id> `
  --verification-id <caller-owned-verification-id> `
  --receipt runtimeLogs/<task>/asset-durable-reconciliation.json
```

命令的实际输入、结果、错误和 exact binding 必须先通过 `query.command.search/detail`
取得；本节不复制字段合同。runner 收据中的 `verified` 或 `rolled_back` 才是 terminal；
`state_unknown` 会保留活动 journal 和缺失证据，调用方应停止并按收据裁决，不得重放原
操作。已存在的 receipt 路径会 fail closed，避免覆盖前一次处置证据。

## Owned Editor startup lifecycle

默认复用用户已经运行的 Editor。只有任务需要一个可由本次工作精确清理的独立 Editor 时，使用项目正式
`scripts/ue/StartUaiEditorLifecycle.ps1`：

```powershell
pwsh -NoProfile -File scripts/ue/StartUaiEditorLifecycle.ps1 `
  -UERoot <UE-install-root> `
  -ProjectPath <project.uproject> `
  -ReceiptPath runtimeLogs/<task>/editor-startup.json
```

该入口让 `UeLifecycleHost.psm1` 持有 PID、start-time、executable、listener 与 exact cleanup，让
`RunEditor.ps1` 只组装 UE 启动参数。它通过本项目 `InvokeUaiCommand.py` 的 runtime descriptor 取得非敏感端口
投影，并由同一 public SDK exact 执行 `query.calibration.read("runtime_probe", limit=1)`。只有外部 launch
identity 仍与 OS 进程精确匹配，且返回的 `items[0].identity="process:<PID>"` 等于 launch PID 时，
`uai.editor_startup_lifecycle_receipt.v1` 才能进入 `ready`。

runtime probe 本身没有 start time、launch nonce 或 server-session ID；端口开放、`connection probe`、窗口出现
或一个未与 launch identity 交叉验证的 PID 均不是 readiness。`port_conflict`、`exited_before_ready`、
`readiness_process_identity_mismatch` 与 `unconnectable_timeout` 必须保持不同终态。失败只清理 receipt 所属的
owned process tree；成功后正常关闭仍交给 `SafeExitLifecycle.py`，startup runner 不复制 safe-exit witness 或
terminal owner。receipt 路径必须是未使用的新路径，认证 secret 只经现有受控环境装配，不进入 receipt、参数或日志。

## Connection TOML

一份文件包含连接所需的全部网络配置：

```toml
format_version = 1

[connection]
transport = "http"
endpoint = "http://127.0.0.1:17777"

[protocol]
version = "current"

[timeouts]
connect_seconds = 5.0
io_seconds = 120.0

[authentication]
mode = "bearer_env"
bearer_env = "UAI_AUTH_TOKEN"

[transport_options.http]
tls_verify = true
route_path = "/api/uai/command"
probe_path = "/api/ping"
auth_header = "X-UeAgentInterface-Token"
```

当前 command ingress 强制认证。认证信息只进入 Connection TOML 支持的 secret
引用或环境变量，不进入 command 参数、脚本输出或对话。

## CLI

CLI 复用同一个 Client、Protocol 与 Transport：

```powershell
uai-cli --connection connection.toml connection probe
uai-cli --connection connection.toml exec query.calibration.read --params-file params.json
```

参数只能从 `--params-json`、`--params-file`、`--params-stdin` 三者之一提供。不提供
参数时发送空对象。CLI 不提供隐式多命令工作流；多步任务由 Agent 显式逐条调用，
每一步根据真实 Result 决定是否继续。

## 写后验证

`result.ok` 只证明服务端完成了该 command 的返回语义。写操作仍需调用正式读取
command 独立读回；例如 `reference.asset_apply` 后用
`reference.asset_read` 验证持久状态。若 manifest 尚未提供所需 readback，必须
停止并报告服务端能力缺口，不用 Catalog、文件存在性或 Python 本地推断冒充验证。

任务结束清理 Agent 自己创建的临时资产、测试线程和无继续价值的服务，但保持用户
的主 Unreal Editor 运行。
