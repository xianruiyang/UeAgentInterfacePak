# Level Design Docs

<!-- Source: leveldesign skill / levelDesignDocs/README.md -->

# Level Design Docs

## 目的

这里存放项目内长期复用的关卡白盒规则，不放单次交付说明或运行记录。

当前目录按“流程向导 -> 核心规则 -> 清单 -> 专题 -> 参考”组织，避免单一文档无限追加。

## 开始做白盒时先看

如果本轮要跑**第一次自动化生成/第一次批次**（尤其是中型以上白盒），建议在开跑前先按清单逐条过一遍，避免进入“补丁式修几何”的循环：
- [checklists/first-automation-generation-checklist.md](checklists/first-automation-generation-checklist.md)

1. [core/whitebox-workflow.md](core/whitebox-workflow.md)
2. [references/level-design-methodology.md](references/level-design-methodology.md)
3. [core/design-doc-spec.md](core/design-doc-spec.md)
4. [core/automated-level-design.md](core/automated-level-design.md)
5. [core/multifloor-connections-and-facilities.md](core/multifloor-connections-and-facilities.md)
6. [checklists/first-automation-generation-checklist.md](checklists/first-automation-generation-checklist.md)

## 当前主文档

### 核心规则

- [core/whitebox-workflow.md](core/whitebox-workflow.md)
  - 白盒搭建的总流程向导与阅读顺序

- [core/automated-level-design.md](core/automated-level-design.md)
  - 自动化白盒的总纲、工作流、可达定义与验收顺序

- [core/design-doc-spec.md](core/design-doc-spec.md)
  - 中型以上白盒开搭前必须完成的最小设计包规范

- [core/multifloor-connections-and-facilities.md](core/multifloor-connections-and-facilities.md)
  - 跨楼层连接单元、竖向设施、门与贴合规则

- [checklists/first-automation-generation-checklist.md](checklists/first-automation-generation-checklist.md)
  - 把“第一次就生成正确”拆成可执行检查项

### Modeling

- [modeling/modeling-assisted-blockout.md](modeling/modeling-assisted-blockout.md)
  - `Modeling` 在当前项目里的职责、边界和使用方式

### 参考与方法

- [references/level-design-methodology.md](references/level-design-methodology.md)
  - 更偏方法论的关卡设计总纲

- [references/reference-image-reconstruction.md](references/reference-image-reconstruction.md)
  - 参考图任务的约束、验收与失败复盘

- [references/lock-and-key-design.md](references/lock-and-key-design.md)
  - 锁钥设计专题

- [references/whitebox-common-structural-errors.md](references/whitebox-common-structural-errors.md)
  - 高频失败模式与修复入口

## 使用边界

- 这里优先保存长期复用的规则与方法。
- 具体关卡说明、交付说明、结构表默认仍放在 `docs/` 或 `docs/temp/`。
- 新增文档前，优先判断是否应并入现有主文档；只有形成新的长期独立主题时才新增。

