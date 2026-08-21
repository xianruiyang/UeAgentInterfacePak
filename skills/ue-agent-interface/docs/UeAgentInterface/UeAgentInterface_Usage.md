# UeAgentInterface 使用入口

本文只说明当前正式公开入口和验证边界。命令全集与参数以
`Resources/UaiCommandManifest.json` 为真源；Python 签名以该 manifest 生成的
`UeAgentInterfaceCMD/cli/uai/commands/generated.pyi` 为准。

## 统一调用链

公开调用固定经过以下链路：

```text
Agent / 用户
  -> import uai 或薄 CLI
  -> Connection TOML
  -> 可替换 Transport（当前为 HTTP Adapter）
  -> POST /api/uai/command
  -> CommandService
  -> 正式 Command Registry
  -> 唯一 C++ 业务 owner
  -> UE mechanics / save / settle / readback
```

Python 只负责读取连接配置、编码一条 `uai.command.v1` 请求、发送并无损还原
`Result`。它不实现 HJSON、Planning、Verification、领域默认值、route 选择、业务
重试或第二套 UE 逻辑。命名方法、`Client.execute()` 和 CLI 共用同一 Client、
Protocol 与 Transport。

`/api/uai/command` 是业务命令的唯一 HTTP ingress。ping/status/listener 只负责连接
与服务状态，不拥有业务语义。未出现在正式 manifest 中的命令必须 fail closed。

## Python SDK

调用方只需导入一个包，并用一行 Connection TOML 建立连接：

```python
import uai

with uai.connect("connection.toml") as ue:
    result = ue.project.summary()

if not result.ok:
    raise RuntimeError(result.error)
print(result.payload)
```

动态 command ID 使用同一个 Client：

```python
result = ue.execute("project.summary", {})
```

一个命名方法或一次 `execute()` 只发送一条同名 command。多步骤工作流由调用者
显式逐条执行；每一步先判断稳定 Result，再根据独立 readback 决定是否继续。

Connection TOML、认证引用和完整 SDK 说明见
`UeAgentInterfaceCMD/docs/PYTHON_SDK_AND_CLI.md`。认证 secret 只通过 TOML 支持的
环境变量或受控文件引用，不进入业务参数、report 或日志。

## CLI

CLI 是同一 SDK 的薄入口：

```powershell
uai-cli --connection connection.toml connection probe
uai-cli --connection connection.toml exec project.summary
uai-cli --connection connection.toml exec reference.asset_read --params-file params.json
```

复杂参数写入 `<UserWorkDir>/tmp/uai_params/`；report 和程序日志写入
`<UserWorkDir>/runtimeLogs/`。CLI 不提供隐藏的批处理语义、业务默认值或兼容 route。

## 查询、修改与读回

标准节奏是：

```text
query/export -> choose one command -> execute -> settle/save -> independent readback -> cleanup
```

- Query 必须无业务副作用。
- 写命令返回 `ok=true` 只证明服务端完成了该 command 的返回语义。
- 持久资产必须通过正式读取 command、unload/reload 或等价独立机制验证。
- 需要 compile、probe、screenshot 或 diff 的领域，必须在读回后继续完成对应验收。
- 失败时读取 `result.error`；不得静默重放 effectful command。
- Result envelope 有效不等于业务成功，必须先检查 `ok` 和领域错误字段。

## HJSON authoring

复杂资产优先使用服务端结构化 HJSON export/apply/readback：

1. 先导出目标、直接引用和必要 owner context。
2. 通过 profile、字段投影、引用和文件拆分控制 token，不使用硬性 token 拒绝门禁。
3. 类属性、对象/节点属性、图结构和关系使用统一对象/属性/关系模型。
4. `update` 保留省略字段；`replace` 只使用服务端合同声明的原生默认值。
5. 写入前携带导出 revision；写入后由 C++ owner 负责 Planning、执行、保存与独立读回。
6. Python 不解析、合并或重建 HJSON 业务语义。

完整规则见 `HjsonAuthoring_Guide.md`、`hjson-authoring/` 分册，以及
`active/t07_hjson_model.md` 至 `active/t10_operation_lifecycle_core.md` 和
`active/t60_hjson_external_input_domain.md` 的当前实现与验证边界。

## Editor 与长任务

默认复用并保持用户主 Editor 运行。启动 UAI Editor 时可使用：

```text
-UeAgentInterfaceAutoStart -UeAgentInterfaceStartMinimized
```

该参数只控制启动首态，不持续压制用户恢复窗口。普通读写、readback、screenshot 和
smoke 结束后不得关闭 Editor。

只有插件或 Editor C++ 普通编译、证据确认必须重启，或用户明确要求时才关闭。
关闭前先调用 `editor.dirty_resources()`，处理 dirty resource，再调用
`editor.safe_exit(...)`；异步接受不等于退出完成，必须由进程外 witness 验证终止。
长任务、cancel/recovery 和 terminal state 见
`contracts/long_running_session_public_commands.md`。

## 证据等级

manifest、generated binding、handler forwarding 或 mock 只能证明结构层。声明命令
production-ready 还必须证明正式 public ingress、唯一 C++ owner、真实 UE mechanics、
必要的 compile/settle、持久化、独立读回、失败语义和 cleanup。旧实现、旧测试、旧
门禁与旧 fixture 只作为待审资产，不得形成第二套权威。

## 文档路由

- 当前架构与覆盖边界：`UeAgentInterface_Status.md`
- 正式命令集合与参数：`Resources/UaiCommandManifest.json`
- Python 静态签名：`UeAgentInterfaceCMD/cli/uai/commands/generated.pyi`
- 当前实现与验证边界：`active/`；该目录只描述产品合同和验证边界，不承担交付工作区的需求、任务状态或最终完成裁判
- Python SDK 与 CLI：`UeAgentInterfaceCMD/docs/PYTHON_SDK_AND_CLI.md`
- Read/Export：`contracts/read_export_command_contract.md`
- Reference CRUD：`contracts/reference_crud_route.md`
- SimpleAuthoring typed CRUD：`contracts/simple_authoring_typed_crud.md`
- Long-running / Session：`contracts/long_running_session_public_commands.md`

历史命令分册、生成式命令规格和覆盖债务报告已退出活动文档路径；不得用它们反推
当前命令合同或实现状态。
