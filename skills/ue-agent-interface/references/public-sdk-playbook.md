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
`query.command.detail` 同时返回该引用与
`uai-docs:python-sdk-and-cli#command-discovery`。不知道 command 名称时按以下单向
流程调用，不从源码、旧测试或历史 helper 猜 ID 和参数：

```python
import uai

with uai.connect("connection.toml") as client:
    candidates = client.query.command_search(
        "inspect the current editor without changing assets",
        limit=3,
    )
    candidate = candidates.payload["candidates"][0]
    detail = client.query.command_detail(
        candidate["command_id"],
        candidate["contract_hash"],
    )

    # 读取 detail.input_fields 后，选择默认命名方法、generic 或 exact。
    result = client.query.calibration_read("runtime_probe", limit=2)
```

只有 `query.command.search` 允许按意图匹配；detail 与执行必须保留精确
`command_id`/`contract_hash`。默认动态调用为 `client.execute(command_id, params)`；
版本锁定调用为
`client.execute_exact(command_id, params, contract_hash=contract_hash)`。

同一流程的 CLI 形式是：

```powershell
uai-cli --connection connection.toml exec query.command.search `
  --params-json '{"intent":"inspect the current editor without changing assets","limit":3}'
uai-cli --connection connection.toml exec query.command.detail `
  --params-json '{"command_id":"query.calibration.read","contract_hash":"sha256:<exact>"}'
uai-cli --connection connection.toml exec query.calibration.read `
  --contract-hash sha256:<exact> `
  --params-json '{"category":"runtime_probe","limit":2}'
```

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
