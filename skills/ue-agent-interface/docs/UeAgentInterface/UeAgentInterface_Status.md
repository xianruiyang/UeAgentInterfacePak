# UeAgentInterface 当前能力与边界

本文记录统一框架的当前正式状态。它不以旧 CommandSpec、旧 handler 数量或 generated
目录数量推导可用性；命令全集以 `Resources/UaiCommandManifest.json` 为准，单条命令
的 production-ready 状态以对应真实纵向证据为准。

## 当前公开边界

- 正式 active command 集合与数量在读取时从 `Resources/UaiCommandManifest.json` 动态取得；
  command ID 必须唯一，长期文档不固化易过期数量。
- 业务请求只经 `POST /api/uai/command` 进入正式 CommandService。
- HTTP 只是当前 Transport Adapter；Protocol、Client、CommandService 和 C++ owner
  不依赖 HTTP 业务类型，可在保持上层调用不变的情况下增加其他 transport。
- Python SDK/CLI 只转发一条真实 command，不拥有 UE、HJSON 或领域业务。
- dotted canonical command 不进入旧 underscore prefix fallback。
- 已迁移 legacy command ID 在正式 registry 中 fail closed；旧业务 ingress 不再绑定。
- ping/status/listener 只承担连接和服务状态，不是业务第二入口。

manifest 或 generated binding 只证明其读取时公开结构存在，不代表其中全部 command 已经获得
同等级的真实 UE 纵向证明。对外声明能力时必须引用对应模块测试与读回证据。

## 统一模块职责

| 模块 | 唯一职责 | 当前验证重点 |
| --- | --- | --- |
| NetworkTransport | 连接、认证、wire request/response；当前实现 HTTP Adapter | 认证、协议、失败映射，不含领域业务 |
| CommandService / Registry | canonical ID、binding、正式 dispatch、legacy fail-closed | public ingress 与唯一 owner |
| Read / Export | 无副作用查询、投影、分页、artifact export | complete/partial 语义与来源可追踪 |
| Reference CRUD | 通用目标解析和 typed CRUD | create/update/delete、持久化、独立读回 |
| SimpleAuthoring | typed 属性与项目配置 | 字段合同、原生默认、保存与读回 |
| Timeline / Spatial | 时间、空间、序列与世界状态 | frame/subject 不混用、HJSON source parity |
| GraphCompound | 图结构、关系、节点属性与复合资产 | 公共 composition、compile/settle、持久读回 |
| Destructive / Import | 删除、世界破坏性操作、外部导入 | 完整 preflight、terminal state、rollback/state_unknown |
| LongRunning / Session | operation lifecycle、cancel/recovery、safe exit | 外部 terminal witness 与 cleanup |

跨模块公共能力必须由 composition、事务、持久化、settle 和 readback owner 提供；单条
route 不得复制 parser、直接保存、伪造 readback 或建立第二套业务实现。

## HJSON 架构

HJSON 以 LLM 易用和最小必要字段为目标：

- token 控制通过 profile、字段分层、投影、引用与文件拆分完成，不设置导出硬限制。
- 统一对象/属性/关系模型组合类属性、节点属性、图结构、连接和领域扩展。
- folder export 的 `included_files`、`read_order` 和实际 ref 决定读取顺序。
- 同一 owner 的 inline 属性与 grouped details ref 冲突时 fail closed。
- `update` 与 `replace` 语义由服务端合同决定；Python 不补默认值。
- import 由唯一 C++ owner 完成 parse、Planning、execution、compile/settle、save 与独立
  readback；失败必须给出明确 terminal state。

## 已证明的纵向范围

本轮统一框架验收已经覆盖以下代表性纵向路径：

- public Read/Export 正式 route 与 production dispatch；
- Reference CRUD owned fixture 的真实 create/update/delete 和持久读回；
- SimpleAuthoring Editor/Project 配置的持久读回；
- Timeline/Spatial public HJSON source parity；
- GraphCompound public Rig/IK 纵向路径；
- DestructiveImport public asset delete 纵向路径；
- LongRunning safe-exit 的进程外 terminal witness；
- active framework 的未知 ingress、重复 owner、legacy fallback 与 cleanup 审计。

这些代表性测试不能自动替代未选择 command 的领域验收；修改具体 route 时仍应运行其
模块测试，并按影响范围扩大验证。

## 测试与门禁边界

- 测试先依据目标设计确定证明对象，再修改实现。
- 模块测试只验证本模块合同；跨模块测试只覆盖明确集成合同。
- mock、recording port、synthetic success、manifest 数量和 generated 文件数量不能
  冒充 production-ready。
- Result envelope 有效与业务成功必须分开判断。
- SafeExit 会终止 owned worker，必须独立运行并由外部进程 witness 验收。
- 局部修改只运行最小充分验证；无关旧 selector、runner 或发布 Gate 不得阻断。
- 旧测试、旧 fixture 和旧门禁不因曾经通过而成为权威；确认无适配价值的删除，有
  审计价值的物理隔离且不进入编译、发现、selector、runner 或 Gate。

## 分发边界

Pak 与 installed `ue-agent-interface` skill 只同步正式可用文档、公开 CLI、Connection
模板和稳定工作流。以下内容不得进入 skill：

- deprecated 命令页
- 旧生成文档和覆盖报告
- coverage 生成物
- 任务表、任务复盘、runtime log 与临时文件

分发前必须检查正式 manifest 与 generated binding 一致、Dev/Pak 正式文档副本一致，
再执行 Pak 到 installed skill 的完整文件集同步检查。

## 当前限制

- Transport 抽象已与业务解耦，但当前只实现 HTTP Adapter。
- 命令存在于 manifest 不等于已获得完整 E3/E4 证据；缺少真实 readback 的 route 不得
  声称 production-ready。
- 需要可选 UE 插件或运行时环境的命令必须显式返回 availability 失败，不静默降级。
- 发布提交、推送和远端发布不属于普通验证流程。
