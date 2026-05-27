---
title: "为角色和对象制作动画"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/animating-characters-and-objects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画"]
---

# 为角色和对象制作动画

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/animating-characters-and-objects-in-unreal-engine

**虚幻引擎**提供了一套强大的动画工具和编辑器，让你可以为角色和对象创建运行时动画系统、渲染过场动画内容，并在引擎中直接新建动画内容。

## 骨架网格体动画

借助[骨架网格体动画系统](skeletal-mesh-animation-system/index.md)，你可以在虚幻引擎中为角色和对象创建强大的动画系统。 当你把某个带蒙皮的网格体对象导入为[骨架网格体资产](../working-with-content/skeletal-mesh-assets/index.md)后，你就可以使用[动画蓝图](skeletal-mesh-animation-system/animation-blueprints/index.md)可视化脚本编辑器来管理其资产，并建立逻辑来执行动态的动画内容。

如需详细了解如何在虚幻引擎中使用**骨架动画系统**对角色和对象制作动画，请参阅以下文档：

- [骨架网格体动画系统](skeletal-mesh-animation-system/index.md) - 虚幻引擎中的动画和角色控制系统。

## Sequencer

你可以使用Sequencer为游戏过场动画或传统的动画电影制作创建并编辑分阶段的动画内容，同时发挥虚幻引擎的动画和世界渲染工具的优势。 当使用[Sequencer](cinematics-and-movie-making/index.md)创建过场动画内容时，你可以建立自定义的角色套件，使用[控制绑定](control-rig/index.md)在你的场景中直接为角色制作动画，同时为其他角色、对象、镜头和特效制作动画。

如需详细了解如何在虚幻引擎中使用**Sequencer**创建过场动画，请参阅以下文档：

- [过场动画和Sequencer](cinematics-and-movie-making/index.md) - Sequencer 是虚幻引擎的多轨道编辑器，用于实时创建和预览动画序列。

## 控制绑定

使用骨架网格体动画系统，导入的角色可以运行在外部数字内容创建(DCC)软件中创建的动画。 你可以使用[控制绑定](control-rig/index.md)为角色和对象建立动态的动画绑定，使你可以在虚幻引擎中编辑现有的动画或创建新的动画。 你可以使用[控制绑定蓝图图表](control-rig/rigging-with-control-rig/control-rig-editor/index.md)创建动态绑定，这种绑定可以为网格体骨架应用骨骼变换。 然后，这些动画可以在Sequencer中播放，甚至可以作为独立的资产烘焙，可以在运行时动画系统中使用。

如需详细了解如何在虚幻引擎中使用**控制绑定**为角色制作动画，请参阅以下文档：

- [控制绑定](control-rig/index.md) - 使用Control Rig实时操纵和动画化角色。

## Paper 2D

你可以使用虚幻引擎的2D动画工具集[Paper 2D](paper-2d-overview/index.md)创建传统的2D角色或关卡，从而充分利用虚幻引擎的世界渲染功能，并创建动态的高保真2D和2D/3D混合项目。 Paper 2D包含一套工具和编辑器，你可以在虚幻引擎的现代光线、世界和物理模拟的框架内使用并编辑2D纹理。

如需了解如何在虚幻引擎中使用**Paper 2D**创建传统2D和现代混合风格的项目，请参阅以下文档：

- [虚幻引擎](paper-2d-overview/index.md) - Paper 2D是一种基于Sprite的系统，用于在虚幻引擎中开发2D或2D/3D结合的游戏。
