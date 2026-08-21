# Public Authoring Consistency

本页定义结构化 HJSON authoring 在当前公开架构中的一致性检查。它只检查仍由正式
owner 维护的链路，不恢复旧 `uai_core` checker、命令 pack、任务级 audit 或旧 release
入口。

## Authority Chain

公开能力沿以下单向链路成立：

1. `Resources/UaiCommandManifest.json` 定义公开 command identity 与参数合同；
2. `tools/uai_binding/generate_bindings.py` 只从该 manifest 生成 Python binding；
3. named method、`Client.execute()` 与 CLI 共用同一个 Client、Protocol 和 Transport；
4. command 经正式 ingress 进入 CommandService，再进入唯一 C++ 业务 owner；
5. 写操作由对应 owner 完成 compile/settle、持久化和独立 readback。

HJSON 的 schema、workspace、selector、operation 和 readback 语义由服务端 authoring
owner 持有。Python/CLI、skill 文档和测试不得复制这些业务决定。

## Current Entry Points

| 检查 | 正式入口 | 直接证明范围 |
| --- | --- | --- |
| Binding 可重建 | 在 `UeAgentInterfaceCMD` 运行 `python tools/uai_binding/generate_bindings.py --manifest ../Plugins/UeAgentInterface/Resources/UaiCommandManifest.json --output-root cli/uai --check` | committed binding 与当前正式 manifest 一致 |
| CMD 公共合同 | 在 `UeAgentInterfaceCMD` 设置 `PYTHONPATH=cli` 后运行 `python -m pytest -q` | SDK、CLI、Protocol、Transport、binding 和分发边界的活动测试合同 |
| Plugin 公开链路 | 使用项目正式 Automation runner 运行受影响 composition/vertical discovery set | 被选测试覆盖的 C++ ingress、owner、真实 UE mechanics 与 readback |
| Skill 分发一致性 | 在外层项目运行 `python scripts/skills/sync_codex_skills.py --mode check --direction pak-to-installed --skills ue-agent-interface` | Pak-owned skill 与 installed 副本的完整文件集一致 |

这些检查彼此不能替代。manifest、binding、handler forwarding 或 mock 只证明其所在
结构层；真实可用性仍需要 public input 到 UE 状态与独立 readback 的纵向证据。

## Command And Candidate Discovery

- 已知 command 且签名已明确时，直接使用生成的 named method。
- 不知道 command 时，先调用 `query.command.search`，再把候选返回的精确
  `command_id` 与 `contract_hash` 原样交给 `query.command.detail`。
- 版本锁定的动态调用使用 `Client.execute_exact(...)`；普通动态调用使用
  `Client.execute(...)`。
- factory、node、component、actor 或其他 candidate 查询返回的 identity 必须可原样
  进入对应 create/apply 输入；调用侧不得建立别名表或领域映射。
- HJSON 文件导航只依据正式 export profile、`included_files`、`read_order`、manifest、
  index 和 ref，不扫描 sibling 或历史文档猜测字段。

## Failure Handling

1. 先确认失败属于 manifest/binding、Client/Protocol/Transport、CommandService、领域
   owner、持久化/readback、正式文档或 Pak/installed 同步中的哪一层。
2. 在该层的唯一 owner 修复，不在 SDK、CLI、skill 或单条 route 内增加业务兜底。
3. command 返回成功但 UE 状态或独立 readback 不符合语义时，停止依赖该成功结果，
   保存输入、Result、readback 和运行日志，并修复服务端 owner。
4. 先运行覆盖改动机制的最小检查，再运行所有受影响消费者；只有对应证据通过后才
   更新 Pak 和 installed skill。

## Current Boundaries

- 正式能力全集与参数只由当前 manifest 定义，不在本文硬编码命令数、profile 数或
  domain 数。
- `query.command.search/detail` 只解决公开 command 发现；领域 candidate discovery
  仍由对应 C++ owner 返回可直接消费的 identity。
- 结构化 HJSON authoring 至少保留一条不可拆分的黄金链路：公开查询取得 exact
  identity，生成 seed/placement/scoped edit，经 validate/import/apply 写入，再完成
  compile/settle/save 与 unload/reload 后的独立 Query readback。
- Pak/installed 零差异只证明副本一致；还必须由公开分发测试排除已退役入口，并用
  packaged CLI 经 Connection TOML 调用真实服务。
