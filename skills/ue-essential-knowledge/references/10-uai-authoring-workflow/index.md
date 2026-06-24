# UAI Authoring 工作流

## 覆盖范围

- UeAgentInterface 命令、folder format、apply/readback/smoke。
- 结构化 JSON authoring、Profile、Adapter、Migration warning。
- node/module 查询、`kind/name/full_name` 身份、来源解析。
- 文档、Pak skill、installed skill 同步边界。

## 阅读时机

- 需要通过 UAI 修改 UE 资产或验证当前项目状态。
- 需要从节点/模块查询结果写入结构化 JSON，再 apply/readback。
- 需要判断某个字段是 LLM 可写、只读信息、诊断信息还是 legacy 兼容字段。

## 后续填充位置

- catalog search -> authoring JSON -> apply -> readback 的标准流程。
- folder format 与 LLM-facing profile 的区别。
- apply 后编译与保存门禁。
- 文档和 skill 同步检查清单。
