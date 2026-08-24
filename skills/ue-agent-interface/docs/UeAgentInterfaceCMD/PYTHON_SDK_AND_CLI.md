# Python SDK 与 CLI

`UeAgentInterfaceCMD` 对调用方只暴露远程调用能力。Python 不实现 UE 业务、
HJSON、Planning、State、Verification 或领域规则；这些语义由 C++ UAI 服务端
唯一拥有。

当前版本只提供 HTTP Transport Adapter，但 Client、Protocol、静态 command
method 和 CLI 不依赖 HTTP 类型。以后增加 TCP、UDP 或其他 Transport 时，公开
command 调用方式不变。

## 安装与导入

业务代码只导入一个包：

```python
import uai
```

`import uai` 不读取配置、不连接网络、不启动线程，也不触碰 Unreal Editor。

## Connection TOML

一份 TOML 包含一次连接所需的全部网络配置。当前 C++ public command ingress
使用 `/api/uai/command`：

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

连接文件采用严格字段校验。当前 command ingress 强制认证，正式模板通过
`UAI_AUTH_TOKEN` 环境变量显式引用 secret；TOML、业务调用、command params、日志和
manifest 都不保存 token。也可以使用 `bearer_file` 引用只含 token 的受控文件。
`connection probe` 只证明与 command route 同属一个 owned transport 生命周期的
ping route 可达；probe 不进入 CommandService，也不证明 command 认证。只有真实
command Result 才证明认证后的 public command edge 可用。

## SDK 调用

一行加载 Connection TOML 后，命名方法只发送一条对应的真实 command：

```python
import uai

with uai.connect("connection.toml") as ue:
    result = ue.query.command_search(
        "inspect the current editor without changing assets",
        limit=3,
    )

if not result.ok:
    print(result.error)
else:
    print(result.payload)
```

当前由 C++ 正式 manifest 生成的命名方法包括：

```python
ue.query.command_search(intent, limit=3)

ue.query.command_detail(command_id, contract_hash)

ue.query.calibration_read("runtime_probe", limit=2)

ue.asset.factory_candidates(
    "asset.media_source.create",
    query="file media",
    limit=5,
)

ue.reference.asset_apply(
    object_path,
    intent,
    proposed_text=None,  # 可省略；也可显式传入 null
)

ue.reference.asset_read(
    object_path,
)

ue.project.summary()

ue.world.content(
    input={...},
    context={...},
    projection={...},
)

ue.content_graph.compound(
    target,
    input={
        "sections": [
            "summary",
            "structure",
            "items",
            "relations",
            "properties",
            "parameters",
            "diagnostics",
        ],
        "include_closure": True,
    },
    context={...},
    projection={...},
)

ue.content_graph.export_workspace(
    target,
    workspace_path,
    profile_id="llm_authoring",
)

import json

authoring = ue.content_graph.authoring_schema(target).payload["query_result"]
document = authoring["template"]
document["root"]["fields"][chosen_field]["value"] = desired_value
edited_hjson = json.dumps(
    document,
    ensure_ascii=False,
    separators=(",", ":"),
)

# authorization_id 来自本次已授权工作流；不得照抄示例或自行生成。
ue.content_graph.import_workspace(
    target,
    {
        "kind": "inline",
        "document": edited_hjson,
    },
    authoring["revision"],
    authorization_id,
)
```

当前公开命令集合以 C++ 冻结 `FUeAgentImmutableCommandRegistry` 的正式 manifest
为唯一依据，覆盖 Query discovery、Read/Export、Reference CRUD、
SimpleAuthoring、Timeline/Spatial、GraphCompound、Destructive/Import 与
LongRunning/Session 等模块。命名方法全部由该 manifest 生成，Python 不手写或
补充第二份命令列表；硬编码命令数量既不是同步机制，也不代表每条 command 都已
获得完整 E3/E4 真实 UE 证据。

创建 typed asset 时若缺少精确 factory identity，先调用
`asset.factory.candidates`，并把返回的 `factory_ref` 按
`query.command.detail` 所示字段原样交给选定 create command。factory catalog、
官方插件可用性和不支持语义只由服务端拥有；SDK 不扫描源码、猜 class path 或在
插件缺失时伪造成功。

`content_graph.compound` 的领域合同要求 `input.sections`。SDK 不在客户端
补业务默认值；完整 authoring Export 需要的 sections 和 closure 默认由
服务端 `content_graph.export_workspace` command 统一拥有。

复杂资产编辑在领域显式支持时先调用 `content_graph.authoring_schema`。其
`query_result` 是模型字段入口，返回领域 schema/field owner、允许的 intents、
当前值、可直接编辑的稀疏模板和本次 content-graph revision。调用方只修改返回模板
中已声明可写的值；不得从旧教程、源码或其他资产类型猜字段，也不得把 native Timeline
revision 与 content-graph revision 互换。不支持该查询的领域会 typed fail closed，
而不是返回一个伪通用 schema。

`content_graph.import_workspace` 的 `source` 只描述工作区来源，可使用
`{"kind":"directory","path":"..."}`、`{"kind":"single_file","path":"..."}` 或
`{"kind":"inline","document":"..."}`；目标类型、解析、Planning、执行、验证、
保存和读回事务全部由 C++ 服务端负责。Python 只原样转发一个调用。领域 mutation
意图写在对应 HJSON schema 中，不存在旧 `intent` 或 `dry_run` 公开参数。
当前 Sequence schema 的稀疏 settings 路径委派给
`timeline.sequence.settings.update`，只修改已声明字段并保留既有 bindings/tracks/sections/
channels/keys；完整 structure replacement 是不同的显式语义。Localization target 使用
显式 create/update/upsert/remove。字段省略、preserve、remove/null/default 的适用性只由
对应服务端 schema 决定。`expected_revision` 是写前必填并发条件，
`authorization_id` 绑定本次公开写入。

领域 candidate 返回值不是由 Python 翻译的通用 seed。调用方只按 owning domain 合同复制允许的
projection；当前 Blueprint node/Component authoring 将选中的完整 `candidate` object 原样放进
`uai.blueprint.edit/1`。服务端在首写前复用同一 candidate mechanics 校验 target、graph/SCS context、
executable identity 与 binding revision，再展开 native node `node_type/node_class` 或 Component
`name/class`。SDK 不重建这些字段，response-level `graph_revision`/`scs_revision` 也不替代 Import 所需的
公开 content-graph `expected_revision`。

三种 carrier 在 C++ source loader 中先收敛为同一个只读 resolved source。服务端分别
保留 carrier/path/manifest/digest 形成的来源完整性指纹，以及由规范化 HJSON 文档形成的
语义指纹；Import planning 只使用后者，因此仅改变 inline、single-file、directory 或
空白/字段顺序不会改变业务计划。directory manifest 的 `base_revision` 必须与本次
`expected_revision` 完全一致。以上 resolved 字段均为服务端内部合同，调用方不得自行
构造或传入指纹。

成功的领域 Import 至少返回 `terminal_status=succeeded`、`mutation_applied=true`、
`compile_settled=true`、`saved=true`、`reloaded=true`、非空
`persistence_receipt_id` 和 `independent_readback`。这些值只能由领域 mechanics 已取得的
编译稳定、保存、卸载/重载与独立读回证据生成；缺少任一阶段时服务端返回 typed failure，
SDK 不补真值或把部分结果升级为成功。

TextureGraph graph mutation 与 `graph_validate_evaluate_settle` 返回同一
AssetDurable owner 生成的 `package-md5:*` 修订。把 settle 的返回值原样交给
`artifact_capture.expected_settled_revision` 或 `artifact_bake.expected_revision`；
不得换成 content-graph 查询修订。bake 会在源资产未持久化、内存状态仍脏、修订过期或
目标冲突时 fail closed。`runtime_probe` 是不持久化的当前状态读取，只接受自身正式参数。

需要按 command ID 调用时使用同一个 Client：

```python
result = ue.execute(
    "query.calibration.read",
    {
        "category": "runtime_probe",
        "limit": 2,
    },
)
```

命名方法、`Client.execute()` 和 CLI 共用相同的 Client、Protocol 与 Transport。
它们不会在 Python 侧选择业务 route、补业务默认值、重试 command，或重新判断
服务端 Result。Unicode、任意精度整数、显式 `null`、未知 response 字段和失败
结果均按协议保留。

## Editor safe-exit lifecycle runner

生成 binding 会精确暴露 `client.editor.safe_exit(dirty_resolution,
external_witness)`，但 `external_witness` 不是普通业务参数。安全关闭 Editor 时使用项目正式
runner `scripts/ue/SafeExitLifecycle.py`；它保持 Python SDK 的单 command 转发边界，同时负责
外层进程身份、heartbeat、两阶段不可变回执和 terminal 解析。不要在业务脚本、Connection TOML
或 CLI 参数中复制这套生命周期状态。

runner 需要 `.uproject`、完整 Connection TOML、`RunEditor.ps1 -PassThru` 返回的精确 Editor
PID，以及 coordination root 之外的输出路径。`reject` 不接受资源列表；`save` 只接受重复的
`--save-resource <exact-package-name>`，`discard` 只接受重复的
`--discard-resource <exact-package-name>`。服务端会将列表与当前 `/Game` dirty package 集合做
exact-set 比较。

成功输出为 `uai.safe_exit.terminal.v1`，必须同时具有 `terminal_status=succeeded`、
`exit_requested=true`、`process_exited=true`、`force_kill=false` 和匹配的两阶段摘要。
dirty reject 输出 `uai.safe_exit.runner_result.v1` 且 Editor 保持运行；外部等待超时保留精确
coordination root 并返回非成功状态。`transport_disconnected` 本身不表示退出成功。

## Command discovery

不知道 command 名称时，只在 `query.command.search` 这一步按意图搜索；它返回少量
候选、匹配原因、精确 `command_id` 与 `contract_hash`。随后必须把候选身份原样交给
`query.command.detail`，读取 `purpose`（含 `non_purpose`）、`input_fields` 与
`result_fields` 的 nested `schema`、`errors`、named/generic/exact/CLI 调用模板和
稳定教程引用。detail 返回的两个稳定逻辑引用是：

- `uai-docs:python-sdk-and-cli#command-discovery`：本节；
- `uai-skill:public-sdk-playbook#command-discovery`：installed
  `ue-agent-interface/references/public-sdk-playbook.md` 的对应章节。

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

    tutorial = detail.payload
    # 按 tutorial["input_fields"] 的 nested schema 填充参数；
    # invocation.python_named 由正式生成方法与字段投影得出。
    result = client.query.calibration_read("runtime_probe", limit=2)
```

需要动态调用时使用 `client.execute(command_id, params)`；需要锁定搜索返回的精确
版本时使用 `client.execute_exact(command_id, params, contract_hash=contract_hash)`。
搜索结果不得被前缀、别名或旧 helper 重写。
每条 command 的具体教程不复制进 SDK 文档或 skill；detail 的
`tutorial_references` 指向稳定逻辑文档，字段与 hash 随活动 registry 即时返回。

CLI 走同一 Client、Protocol 和 Transport：

```powershell
uai-cli --connection connection.toml exec query.command.search `
  --params-json '{"intent":"inspect the current editor without changing assets","limit":3}'
uai-cli --connection connection.toml exec query.command.detail `
  --params-json '{"command_id":"query.calibration.read","contract_hash":"sha256:<exact>"}'
uai-cli --connection connection.toml exec query.calibration.read `
  --contract-hash sha256:<exact> `
  --params-json '{"category":"runtime_probe","limit":2}'
```

## CLI

CLI 仍然只接受一份完整 Connection TOML：

```powershell
uai-cli --connection connection.toml connection show
uai-cli --connection connection.toml connection probe
uai-cli --connection connection.toml exec query.calibration.read `
  --params-file params.json
```

参数来源三选一：

- `--params-json '{"intent":"inspect the current editor","limit":3}'`
- `--params-file params.json`
- `--params-stdin`

不提供参数时发送空对象。`--report <path>` 将 stdout 的同一份无损 Result JSON
写入文件，不生成第二种业务报告。

稳定退出码：

| 退出码 | 含义 |
|---:|---|
| `0` | command 成功，或 connection probe 成功 |
| `2` | CLI 用法、参数或配置错误 |
| `3` | Transport/连接失败 |
| `4` | 序列化或协议错误 |
| `5` | 服务端已返回 command failure Result |

## 静态 binding 生成

静态 binding 的唯一输入是 C++ `FUeAgentImmutableCommandRegistry` 经
`FUeAgentActiveCommandManifest` 导出的正式 manifest：

```powershell
python tools/uai_binding/generate_bindings.py `
  --manifest ../Plugins/UeAgentInterface/Resources/UaiCommandManifest.json `
  --output-root cli/uai

python tools/uai_binding/generate_bindings.py `
  --manifest ../Plugins/UeAgentInterface/Resources/UaiCommandManifest.json `
  --output-root cli/uai `
  --check
```

generator 不扫描 C++ 源码、Markdown、旧 CommandSpec 或 Python registry，也不按
command 前缀猜测 handler。生成的 `.py` 与 `.pyi` 必须和正式 manifest hash、
registry hash 一致。

## 当前验证边界

本地 E0/E1 已证明公开导入、Connection、Transport/Protocol 分层、单次 command
转发、静态 binding、CLI 同链路和无损 Result/Error 合同。E3 已使用运行中的 C++
UAI 服务验证：SDK 命名 Query 与 CLI 调用共用同一真实 command edge；
`reference.asset_apply` 创建和删除测试资产后，`reference.asset_read` 能独立读回
持久值与删除后的空快照。Read/Export E3 还验证了公开 Query 通过 exact
QueryDescriptor 到达 production provider，semantic Export 消费同一次真实 C4
snapshot，经 C5 生成 workspace 并由 C8F 发布；旧 `/api/uai/reference` 与
`/api/uai/export` route 不再是 active 或 fallback 入口。尚未进入 manifest 的旧
能力不属于公开 SDK。
