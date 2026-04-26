---
name: ue-engine-knowledge
description: 官方文档优先的 Unreal Engine 知识库，覆盖 Blueprint、Gameplay/C++、GAS、Gameplay Tags、SaveGame、Asset Manager、Material、UMG、CommonUI、Niagara、Input、Level/Landscape、Sequencer、Static Mesh、Animation/IK、AI、PCG、Audio、Networking、Performance 和 Production Pipeline。
---

# UE Engine Knowledge

## 目标

为生产向 UE5 项目提供可执行的知识库入口，覆盖：

- Blueprint / Gameplay Framework / C++
- Gameplay Ability System / Gameplay Tags
- SaveGame / Asset Manager / 异步加载
- Material / UMG / CommonUI / Niagara
- Enhanced Input
- Level / World / Landscape
- Static Mesh / 导入管线
- Sequencer / Cinematic / UMG Animation
- Animation / IK / Control Rig
- AI / Behavior Tree / EQS
- PCG
- Audio
- Networking / Multiplayer
- Profiling / Performance
- Pipeline / Plugin / Editor Automation

本 skill 用于把模糊需求转成可执行方案，减少 UE 编辑器试错，按官方资料排查编译/运行问题，并维护长期可扩展性。

## 引擎版本范围

- 默认面向现代 UE5 项目，按 UE 5.3+ 风格组织建议。
- 用户未说明版本时，假设是较新的 UE5 项目；当版本会影响结论时，必须说明这个假设。
- 如果用户明确使用 UE 5.0-5.2 或 UE4，先指出插件默认值、编辑器 UI、API 命名和流程可能不同，再给步骤。
- 版本敏感主题优先确认版本：CommonUI、Enhanced Input、GAS、Lyra、PCG、Networking、Editor Automation、Commandlet、CI/Build。

## 来源策略

始终优先 Epic 官方文档。先读：

- `references/official-sources.md`

再按领域读取对应 reference。Niagara 的详细模块/参数库不要默认全量加载；只有用户明确需要时再按规则打开。

## 使用流程

1. 按领域和任务类型分类：创建、调试、优化、重构。
2. 判断是否版本敏感；必要时确认 UE 版本，或明确工作假设。
3. 读取 `references/official-sources.md`，选最接近的官方页面。
4. 读取相关领域 reference。
5. 跨多个领域时先用快速路由，再按需读 `references/integration-playbook.md`。
6. 输出顺序：
   - 架构决策
   - 资产/图/代码设置步骤
   - 验证与调试检查
   - 性能和维护风险
   - 备选方案

## 多领域快速路由

- UI 焦点、返回栈、手柄导航、菜单层级：`commonui.md`、`umg.md`，输入问题再加 `enhanced-input.md`。
- HUD、Widget 更新、UMG 性能：`umg.md`，输入问题加 `enhanced-input.md`，性能问题加 `performance.md`。
- Ability、Cooldown、Tag Gate、战斗状态同步：`gameplay-ability-system-tags.md`，复制/权威问题加 `networking.md`，类结构加 `gameplay-cpp.md`。
- Lyra、Experience、Game Feature：`lyra-patterns.md`，再按问题加 `gameplay-cpp.md`、`gameplay-ability-system-tags.md`、`enhanced-input.md` 或 `pipeline-plugin-automation.md`。
- 存档、持久状态、异步资产、Primary Asset：`savegame-asset-manager.md`，运行时所有权加 `gameplay-cpp.md`。
- 动画驱动 Gameplay、Montage 时序、Ability 表现：`animation-ik.md`，再加 `gameplay-ability-system-tags.md` 和 `gameplay-cpp.md`。
- Gameplay 驱动 VFX：`niagara.md`、`material.md`，GameplayCue/状态再加 `gameplay-ability-system-tags.md`。
- 大世界、Landscape、Streaming、遍历性能：`level-world-landscape.md`、`performance.md`，多人问题加 `networking.md`。
- Sequencer 混合 Gameplay 或 UI：`sequencer.md`，UI 动画加 `umg.md`，运行时所有权加 `gameplay-cpp.md` 或 `animation-ik.md`。
- 批量资产编辑、插件、Editor Scripting、CI 失败：`pipeline-plugin-automation.md`，再加受影响资产领域 reference。

如果超过三个领域看起来都相关，先选一个主领域和一到两个次领域，再用 `integration-playbook.md` 梳理边界。

## 领域路由

- 官方来源索引：`references/official-sources.md`
- 当前覆盖和优先级：`references/current-needed-kb.md`
- Blueprint：`references/blueprint.md`
- Gameplay Framework / C++：`references/gameplay-cpp.md`
- GAS / Gameplay Tags：`references/gameplay-ability-system-tags.md`
- SaveGame / Asset Manager：`references/savegame-asset-manager.md`
- Enhanced Input：`references/enhanced-input.md`
- Material：`references/material.md`
- UMG：`references/umg.md`
- CommonUI：`references/commonui.md`
- Niagara：`references/niagara.md`
- Level / World / Landscape：`references/level-world-landscape.md`
- Static Mesh：`references/static-mesh-pipeline.md`
- Sequencer：`references/sequencer.md`
- Animation / IK：`references/animation-ik.md`
- AI / Behavior Tree / EQS：`references/ai-behavior-tree-eqs.md`
- PCG：`references/pcg.md`
- Audio：`references/audio.md`
- Networking：`references/networking.md`
- Performance：`references/performance.md`
- Pipeline / Plugin / Editor Automation：`references/pipeline-plugin-automation.md`
- Lyra：`references/lyra-patterns.md`
- 跨领域集成：`references/integration-playbook.md`

## Niagara 详细参考加载规则

- 默认 Niagara 问题：只读 `references/niagara.md`。
- 默认参数面板或内置命名空间：读 `references/niagara-detail/default-parameters.md`。
- 实际效果制作或模块选择：读 `references/niagara-detail/common-modules.md`。
- 全量内置模块检索：先读 `references/niagara-detail/README.md`，再读 `module-inventory.md` 或精确分类文件。
- 不要无故把整个 Niagara 模块库加载进上下文。

## 输出标准

每次回答都提供：

1. 首选方案。
2. 至少一个备选方案。
3. 可执行验证清单，覆盖编辑器和运行时。
4. 常见失败模式和快速排查步骤。
