# UAI Authoring 工作流

## 阅读时机

通过 UAI 修改 UE 资产、处理候选查询与 HJSON 工作区，或判断可写属性、诊断与读回的职责时，进入
`ue-agent-interface` skill。已知 command 和参数、且无需 UE 原理或版本判断的普通查询直接使用 UAI，
不要求先检索知识库。

## 正式入口

- 知识、命令与项目事实的使用边界由 `ue-agent-interface/references/verification-and-knowledge.md` 维护。
- `ue-agent-interface/references/hjson-workspace.md` 说明当前导出、编辑、导入、诊断与持久读回流程；
  本分类不复制字段或生成第二套 authoring 规范。
- Level viewport 取景先读 `../07-world-level-rendering/viewport-projection-and-framing.md`，
  再使用当前公开查询和 capture 入口。
- Plugin/CMD 文档由各自仓库维护，Pak-owned skill 与 installed 副本的边界见 Pak `skills/README.md`。
