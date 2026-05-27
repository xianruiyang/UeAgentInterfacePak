---
title: "控制绑定"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/control-rig-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "控制绑定"]
---

# 控制绑定

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 控制绑定

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/control-rig-in-unreal-engine

虚幻引擎提供了一套动画工具，供你直接在引擎中操纵和动画化角色，称为控制绑定（Control Rig）。 使用Control Rig，你无需在外部工具中进行操纵和制作动画，而是直接在虚幻编辑器中制作动画。 你可以使用此系统在角色上创建和绑定自定义控制点，在**[Sequencer](../cinematics-and-movie-making/index.md)**中制作动画，并使用各种其他动画工具来帮助完成动画制作过程。

此页面包含文档链接，涵盖虚幻引擎的Control Rig工具，以及它们工作流程的实际示例。

## 开始入门

如果你才开始学习在虚幻引擎中制作动画，本页面将简短概述如何创建基本Control Rig，并为其制作动画。

- [控制绑定快速入门指南](how-to-create-control-rigs/index.md) - 了解虚幻引擎中控制绑定的基础知识。

## 创建绑定

**控制绑定**是你将用于创建绑定的主要资产。 这些页面介绍了它的用法和主要功能。

- [使用控制绑定制作动画](rigging-with-control-rig/index.md) - 本文通过新建一个控制绑定资产来介绍其中的各种功能。

- [控制绑定编辑器](rigging-with-control-rig/control-rig-editor/index.md) - 学习控制绑定编辑器中的各种工具和区域。
- [模块化控制绑定](rigging-with-control-rig/modular-control-rigs/index.md) - 在虚幻引擎中使用模块化绑定工具快速绑定角色。
- [控制点、骨骼和Null](rigging-with-control-rig/controls-bones-and-nulls-in-control-rig/index.md) - 了解构成控制绑定的主要绑定元素。
- [解算方向](rigging-with-control-rig/control-rig-forwards-solve-and-backwards-solve/index.md) - 了解控制绑定中的不同解算方向以及它们启用的功能。
- [全身IK](rigging-with-control-rig/control-rig-full-body-ik/index.md) - 为你的角色创建全身IK。
- [样条线操控](rigging-with-control-rig/control-rig-spline-rigging/index.md) - 利用控制绑定中的样条线，在比较长的关节链上实现更简单的程序动画。
- [姿势缓存](rigging-with-control-rig/control-rig-pose-caching/index.md) - 文档主题的一句话概述。
- [控制点形状和控制点形状库](rigging-with-control-rig/control-shapes-and-control-shape-library/index.md) - 使用控制点形状库中的不同控制点形状，自定义你的控制点。
- [控制绑定组件](rigging-with-control-rig/control-rig-in-blueprints/index.md) - 在虚幻引擎蓝图中使用控制绑定组件。
- [Control Rig函数库](rigging-with-control-rig/control-rig-function-libraries/index.md) - 构造和引用公有Control Rig函数以加速操控工作流程。
- [控制绑定中的Python脚本](rigging-with-control-rig/control-rig-python-scripting/index.md) - 使用Python脚本，扩展并自定义控制绑定的功能。
- [控制绑定调试](rigging-with-control-rig/control-rig-debugging/index.md) - 使用控制绑定调试工具查找并修复控制绑定图表中的问题。

## 创建动画

创建控制绑定后，你可以在Sequencer和虚幻引擎的其他区域中为其制作动画。 下列页面提供了此过程的概述。

- [使用控制绑定实现动画效果](animating-with-control-rig/index.md) - 介绍如何借助各种工具和流程实现控制绑定动画。

- [虚幻引擎中的动画编辑器模式](animating-with-control-rig/animation-editor-mode/index.md) - 在虚幻引擎中启用动画模式，为动画师提供更加易用的环境和工具。
- [在动画蓝图中使用控制绑定](animating-with-control-rig/control-rig-in-animation-blueprints/index.md) - 通过在动画蓝图中使用控制绑定来制作程序化效果。
- [FK控制绑定](animating-with-control-rig/fk-control-rig/index.md) - 使用FK控制绑定快速编辑动画，无需使用任何控制绑定资产。
- [约束](animating-with-control-rig/animation-constraint-tools/index.md) - 使用各种约束将对象的位置、方向或缩放附加到其他对象。
- [空间切换](animating-with-control-rig/re-parent-control-rig-controls-in-real-time/index.md) - 在利用控制绑定实现动画时，动态地重新确定控制点的关联
- [控制绑定动画Python脚本编写](animating-with-control-rig/python-scripting-for-animating-with-control-rig/index.md) - 使用Python脚本驱动和扩展控制绑定动画制作。
