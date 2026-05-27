---
title: "动画调试和优化"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/animation-debugging-and-optimization-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画调试和优化"]
---

# 动画调试和优化

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画调试和优化

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/animation-debugging-and-optimization-in-unreal-engine

**虚幻引擎** 提供了一套调试和优化工具和技术，可用于简化项目的动画系统，从而提高性能并减小文件大小。以下文档将介绍可用于在虚幻引擎中完善和优化动画系统的工具和功能。

## 调试工具

虚幻引擎提供了一些调试工具，可用于在受控环境中分析动画系统，以便进行调整并找到问题的解决方案。

### 倒回调试器

使用[倒回调试器（Rewind Debugger）](animation-rewind-debugger/index.md)可以录制项目 **在编辑器中运行**（**Play In Editor，简称PIE**）Gameplay的片段，然后使用基于时间轴的可视化界面实时浏览录制的内容以观察过渡行为、变量值、姿势混合等。录制的Gameplay提供了比传统模拟更稳定的工作过程，并且可以保留不正确的动画行为以便于协作和调试。

如需了解关于使用 **倒回调试器** 来调试动画系统的更多信息，请参阅以下文档：


- [Rewind调试器](animation-rewind-debugger/index.md)

### Animation Insights

可以使用[Animation Insights](animation-insights/index.md) [插件](../../../understanding-the-basics/foundational-knowledge-in/working-with-plugins/index.md)来分析项目的动画系统，以查看一段时间内所有操作的可视化图表。此图表可用来确定正在评估的动画进程、这些进程使用的性能预算以及时间，以便做出明智的优化选择，实现项目所需的性能质量。

如需了解关于使用 **Animation Insights** 来分析动画系统的更多信息，请参阅以下文档：


- [Animation Insights](animation-insights/index.md)

### 姿势观察

在使用复杂的动画蓝图和分层动画系统时，可以在个体动画数据源项目模拟期间使用[姿势观察（Pose Watching）](../animation-shortcuts-and-tips/index.md#%E5%A7%BF%E5%8A%BF%E8%A7%82%E5%AF%9F)在视口中切换动态可视化调试渲染。渲染个体动画源时，可以直观地隔离每个节点或层对最终输出姿势的影响，从而确定动画系统中错误或不规则动画行为的来源。

如需了解关于使用 **姿势观察** 来调试动画系统的更多信息，请参阅以下文档：


- [动画生产率提示与技巧](../animation-shortcuts-and-tips/index.md)

## 动画优化

可以使用[动画优化](animation-optimization/index.md)技术和功能来提高动画系统的性能和质量并减小文件大小。

如需了解关于虚幻引擎中的 **动画优化** 的更多信息，请参阅以下文档：


- [动画优化](animation-optimization/index.md)

### 动画预算分配器

[动画预算分配器（Animation Budget Allocator）](animation-budget-allocator/index.md)是虚幻引擎的一个[插件](../../../understanding-the-basics/foundational-knowledge-in/working-with-plugins/index.md)，可用于限制多个角色的动画评估和质量，以降低项目整个动画系统的性能成本。

如需了解关于使用 **动画预算分配器** 来优化动画系统的更多信息，请参阅以下文档：


- [动画预算分配器](animation-budget-allocator/index.md)
