---
title: "面向Maya用户的虚幻引擎动画制作"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/animating-in-unreal-engine-for-maya-users"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "面向Maya用户的虚幻引擎", "面向Maya用户的虚幻编辑器和功能概述", "面向Maya用户的虚幻引擎动画制作"]
---

# 面向Maya用户的虚幻引擎动画制作

> 路径：虚幻引擎5.7文档 / 入门指南 / 面向Maya用户的虚幻引擎 / 面向Maya用户的虚幻编辑器和功能概述 / 面向Maya用户的虚幻引擎动画制作

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/animating-in-unreal-engine-for-maya-users

虚幻引擎提供一套动画工具和编辑器，可用于创建角色和对象运行时动画系统、电影级内容渲染，还可以直接在引擎内实时创作新动画内容，你可以立即看到所有修改的效果。

对于Maya用户，虚幻引擎在实时环境中处理动画的方式如下：采用状态驱动逻辑为游戏定制交互式内容，打造可供用户参与的交互式体验，而非单纯的播放。 虽然虚幻引擎的环境专为这类开发而设计，但这并不意味着你只能打造此类体验。 你可以修改离线工作流程来适应完全实时的环境，这种环境强调协作以及光照和材质的即时反馈，同时无需长时间渲染场景即可在当下做出选择，从而提升工作效率。

本指南小节将对比Maya与虚幻引擎的概念，帮助你熟悉虚幻引擎的主要动画组件，概述在引擎中创建动画或使用导入内容的工作流程，并为你推荐一些需要了解的额外动画工具。

## 关键概念对比

以下是Maya的概念及其在虚幻引擎中的对应关系。

| Maya | 虚幻引擎 |
| --- | --- |
| 关节和骨架 | 骨架 |
| 绑定 | 骨架 |
| 蒙皮 | 骨骼网格体 |
| 关键帧动画 | 导入的动画资产 |
| 动画导出（OBJ、FBX等） | 动画序列 |
| 混合形状和驱动关键点 | 变形目标、混合空间和动画曲线 |
| 动画层/非线性动画（NLA） | 动画层 |
| 图表编辑器 | Sequencer曲线和动画图形 |
| IK、FK和HumanIK | 控制绑定、实时IK和非实时IK重定向 |
| Trax编辑器（非线性编辑） | 动画蒙太奇和Sequencer |
| 物理/动力学 | 基于物理的动画系统 |

## 动画组件

下方列出了虚幻引擎的不同组件，可用于为对象制作动画，以及处理在编辑器中导入或创建的动画。

| 虚幻引擎组件 | 说明 |
| --- | --- |
| **骨架和骨骼网格体** | 骨架用于定义骨架（蒙皮）网格体中的骨骼（有时称为关节）。 这些骨骼通过其位置和对角色网格体变形的控制机制，在某种程度上模拟了真实的生物骨架。 骨架用于存储和关联动画数据、整体骨架层级和动画序列。 骨架可以在不同骨骼网格体和动画之间共享。 骨骼网格体包含角色或对象的可视网格体，其使用骨架存储用于为其制作动画的骨骼数据。 骨骼网格体可以播放动画、构造逻辑以实时控制角色的行为。 如需更多信息，请参阅以下主题： [骨骼网格体](../../../../working-with-content/skeletal-mesh-assets/index.md)[骨骼网格体编辑器](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-editors/skeletal-mesh-editor/index.md)[骨架编辑器](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-editors/skeleton-editor/index.md) |
| **动画序列** | 这是一种包含动画数据的资产，可在骨骼网格体上播放以使其产生动画效果。 这些动画序列包含关键帧，用于指定分配给骨骼网格体的骨架在特定时间点的位置、旋转和缩放。 通过在按顺序播放的过程中混合关键帧，骨架的运动将使角色动起来。 动画序列与特定骨架资产绑定，使得所有采用相同骨架资产的骨骼网格体均可共享这些动画。如需更多信息，请参阅以下主题：[动画序列](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/animation-sequences/index.md)[动画序列编辑器](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-editors/animation-sequence-editor/index.md) |
| **混合空间** | 它们是一种资产，允许混合多个动画或姿势，方法是将其绘制到一维或二维图表中。 然后，该图表可以在动画蓝图中进行引用，其中混合通过Gameplay输入或其他变量进行控制。 通过使用混合空间，几乎所有类型的混合布局都可以用于你的动画。混合空间可被视为交互式滑块或驱动关键点，其使用可视化网格基于输入在动画之间进行平滑插值。 尽管混合空间通常用于在空闲/行走/奔跑循环动画之间实现平滑过渡，但它们也可以同时考虑速度和方向等因素。如需更多信息，请参阅[混合空间](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/blend-spaces/index.md)。 |
| **控制绑定** | 这是一套动画工具，用于直接在引擎内对角色进行绑定和动画制作，从而无需在外部工具中进行绑定和动画制作。 你可以使用控制绑定在角色上创建和绑定自定义控制点，在Sequencer中制作动画，并使用各种其他动画工具辅助工作流程。如需更多信息，请参阅[控制绑定](../../../../animating-characters-and-objects/control-rig/index.md)。 |
| **模块化控制绑定** | 这是数字动画绑定，通过组合一系列称为"模块"的预编译控制绑定资产而创建。 模块是一个控制绑定组件，代表角色的身体部位，例如手臂、腿或脊椎，可用于自动创建一组控制点并绑定该身体部位，使其能够接收动画数据。 模块可以连接在一起，形成完整的动画绑定，从而通过关节来驱动骨架。如需更多信息，请参阅[模块化控制绑定](../../../../animating-characters-and-objects/control-rig/rigging-with-control-rig/modular-control-rigs/index.md)。 |
| **曲线编辑器** | 使用此编辑器可修改和微调动画对象的关键帧。 在曲线编辑器的图表中，你可以编辑现有关键帧或创建新关键帧、编辑切线，并使用其内置工具调整动画曲线。 曲线资产可在引擎的其他编辑器中使用，比如Niagara，但主要与Sequencer配合用于动画制作。[曲线编辑器](../../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/animation-curve-editor/index.md)[Sequencer](../../../../animating-characters-and-objects/cinematics-and-movie-making/how-to-make-movies/index.md)[Sequencer中的关键帧设置](../../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/creating-animation-keyframes/index.md) |
| **Sequencer** | 这是虚幻引擎的过场动画编辑器，用于随时间推移为角色、摄像机、各种属性以及其他Actor制作动画。 Sequencer提供了一个非线性的编辑环境，允许你沿着时间轴创建、修改轨道和关键帧。如需更多信息，请参阅以下主题：[过场动画和Sequencer](../../../../animating-characters-and-objects/cinematics-and-movie-making/index.md)[Sequencer基础](../../../../animating-characters-and-objects/cinematics-and-movie-making/how-to-make-movies/index.md)[Sequencer编辑器](../../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/sequencer-editor/index.md)[Sequencer概述](../../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/index.md) |
| **动画模式** | 关卡编辑器可切换为不同模式以实现不同功能，例如塑造和绘制地貌、为几何体建模或制作动画。 关卡编辑器的**动画**模式支持使用Sequencer直接在场景中为关卡Actor和组件制作动画，整个创作过程均在所见即所得（WYSIWYG）的实时环境中完成。该动画模式包含以下用于控制绑定的工具：约束工具姿势工具Tween工具运动尾迹工具以及其他工具！[动画模式](https://dev.epicgames.com/community/api/documentation/image/452d1ee8-5702-41a3-88eb-235d609c07f7?resizing_type=fit)如需更多信息，请参阅以下主题：[关卡编辑器模式](../../../../building-virtual-worlds/level-editor/level-editor-modes/index.md)[动画模式](../../../../animating-characters-and-objects/control-rig/animating-with-control-rig/animation-editor-mode/index.md)[Sequencer基础](../../../../animating-characters-and-objects/cinematics-and-movie-making/how-to-make-movies/index.md)[控制绑定](../../../../animating-characters-and-objects/control-rig/index.md)[约束](../../../../animating-characters-and-objects/control-rig/animating-with-control-rig/animation-constraint-tools/index.md)[Unreal Fest 2024 "打造非凡动画（Making Your Animation Unreal）"](https://www.youtube.com/watch?v=PDz4bvP2MG0)请注意，本演示使用的是虚幻引擎5.5。 |
| **动画蓝图** | 这是一种特殊的蓝图，用于在模拟或Gameplay中控制骨骼网格体的动画效果。 动画图表可在动画蓝图编辑器中进行编辑，你可在其中混合动画、控制骨架的骨骼结构，或创建逻辑来定义骨骼网格体每帧使用的最终动画姿势。如需更多信息，请参阅以下主题：[动画蓝图](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-blueprints/index.md)[动画蓝图编辑器](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-blueprints/animation-blueprint-editor/index.md)[在动画蓝图中使用图表功能](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-blueprints/graphing-in-animation-blueprints/index.md) |
| **状态机** | 这是你可以在动画蓝图中编译的模块化系统，用于定义可以播放的特定动画，以及何时允许播放。 这种类型的系统主要用于将动画关联到角色的动作状态，例如空闲、行走、奔跑和跳跃。 你可以用其创建由动画定义的"状态"（这些动画会在相应时段播放），并设置多种过渡效果来控制状态间的切换时机。 这样就可以更轻松地创建复杂的动画混合，而不必使用过于复杂的动画图表。 [状态机](https://dev.epicgames.com/community/api/documentation/image/85bc8d08-82f0-4ede-b316-eddd9f8c2f91?resizing_type=fit)如需更多信息，请参阅[状态机](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-blueprints/state-machines/index.md)。 |

## 其他动画工具

虚幻引擎自带许多工具和系统，支持在引擎内完成项目的完整动画制作。 以下是在虚幻引擎中制作动画时需要了解的其他工具、系统及注意事项。

### 动画重定向

利用**动画重定向**功能可以在多个角色之间重复使用动画，这些角色的特点是使用相同的**骨架**资产，但可能比例差异较大。 这样就无需创建全新动画，角色之间可以共享动画资产。

动画重定向有两种使用方式：

- 你要重定向的角色骨架所使用的骨架资产，与创建动画时所使用的骨架资产相同。
- 你要重定向的角色骨架未使用相同的骨架资产。 相反，你需要使用绑定将骨架的骨骼信息传递给另一个角色。

在下面的示例中，有三个角色使用相同的骨架资产，但彼此的比例各不相同。 在重定向之前，尽管比例不同，骨架仍会按原骨架的形态变形。 在重定向之后，每个角色的比例均进行保留。

![动画重定向](../../../../../assets/images/7e/7e38efdc4b3c3d414702d15d06d0885a91bcc920c04c26c62d6ee3ab52c33c14.jpg)

如需更多信息，请参阅以下主题：

- [动画重定向](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/skeletons/animation-retargeting/index.md)
- [使用重定向动画](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-workflow-guides-and-examples/using-retargeted-animations/index.md)

### 基于物理的动画

虚幻引擎使用物理模拟（布娃娃、布料、动态毛发）增强画面真实感

可与关键帧动画无缝融合，该功能比Maya传统工作流程更具灵活性。

物理驱动动画会将模拟结果与关键帧动画混合，为需要呈现"布娃娃"效果的角色，或具有未设置关键帧的元素（比如毛发、布料、链条）的角色，创造自然真实的模拟效果，无需专门制作动画。

*"内容示例"示例项目中基于物理的动画示例。*

基于物理的动画确实需要为每个角色设置物理资产，使其能够与其他已设置碰撞的表面产生交互。

如需更多信息，请参阅以下主题：

- [基于物理的动画](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-workflow-guides-and-examples/physics-driven-animation/index.md)
- [物理资产编辑器](../../../../gameplay-systems/physics/physics-asset-editor/index.md)
- [内容示例](../../../../samples-and-tutorials/content-examples-sample-project/index.md)

### 分层控制绑定

分层控制绑定是一种可在多种其他工作流程之上叠加使用控制绑定的系统，无需烘焙数据即可编辑角色，如果进行数据烘焙，后续进行更改时最终可能导致破坏性工作流程。 分层控制器支持在Sequencer中混合和叠加不同的控制绑定，并将控制绑定中的后向解算实时应用到Sequencer片段中。 以往如果要编辑动画，需在Sequencer中为骨骼网格体分配控制绑定，烘焙关键点，才能实时播放。

如需更多信息，请参阅EDC学习课程[分层控制绑定 - 深入了解](https://dev.epicgames.com/community/learning/tutorials/Op78/unreal-engine-fortnite-layered-control-rigs-deep-dive)。 此外，你可以从Fab下载[内容示例](https://www.fab.com/listings/4d251261-d98c-48e2-baee-8f4e47c67091)项目。 "Animation_ControlRig"关卡包含分层控制绑定的多个演示和用例，可供你探索。

### 控制绑定后向解算

控制绑定通过多种称为解算方向的方式进行求值。 解算方向在控制绑定图表中创建，可将绑定逻辑拆分为多个解算方向（或称解算器），你可以通过它们扩展绑定的输入数据。 这支持绑定共享、将动画烘焙回控制点以及调试行为等工作流程。

后向解算的主要用途是将动画序列烘焙到控制绑定，从而对虚幻引擎中的动画进行进一步更改。 后向解算还可用于对已导入到引擎中的现有动画或动作捕捉数据进行精细化编辑，然后将这些修改烘焙到其中。

如需更多信息，请参阅[解算方向](../../../../animating-characters-and-objects/control-rig/rigging-with-control-rig/control-rig-forwards-solve-and-backwards-solve/index.md)的"后向解算"小节。

### 动画师工具包插件

**动画师工具包**是一款可为项目添加动画师友好型变形器和实用绑定的插件。 这些操作就像通过Sequencer添加控制绑定一样。

在主菜单中依次选择**编辑（Edit）>插件（Plugins）**并搜索"动画师工具包（Animator Kit）"，即可启用该插件。

该插件包含以下可在Sequencer中使用的控制绑定：

- 实用绑定

  - BlendParent
  - 3Node
  - ChainSim
  - SingleCim
  - SplinePath
- 变形器

  - 塑造变形器
  - 格栅变形器（2x2x2、3x3x3、4x4x4）
  - 摄像机空间格栅

如需详细了解该插件和变形器的用法，请参阅EDC上的[变形器快速入门](https://dev.epicgames.com/community/learning/tutorials/wj6z/unreal-engine-getting-started-with-deformers-in-ue-5-5)学习课程。

## 关于在虚幻引擎中制作动画的其他说明

- **根骨骼运动**

  - 在虚幻引擎中，角色由许多组件构成，其移动通常由角色的[移动组件](../../../../gameplay-systems/gameplay-framework/components/movement-components/index.md)处理，而动画播放则叠加在移动组件之上，用于呈现动作的视觉反馈。 通过根骨骼运动动画，可以用动画数据驱动角色的动作，从而在关卡中创建更真实的动作。 依赖根骨骼运动的动画示例包括会使角色远离其初始根位置的动作，例如前后跳跃，或执行复杂的组合剑术动作等。
  - 如需更多信息，请参阅[根骨骼运动](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/locomotion/root-motion/index.md)。
- **动画压缩**

  - 这是对动画序列资产中的动画数据进行转换的过程，旨在降低整体动画文件大小并降低内存占用。 采用压缩技术时，需要在项目性能上做出权衡，尤其是当项目需要在多种不同规格的硬件目标上进行适配时。 动作幅度较小的动画相比动作丰富的动画从压缩中获益更多，因为后者可能会出现明显的画质下降。 务必要根据项目可以承受的质量损失级别来确定你要实施的压缩类型。
  - 如需更多信息，请参阅[动画压缩](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-debugging-and-optimization/animation-compression/index.md)。
- **Live Link**

  - 它为从Maya等外部来源将动画数据流式传输并导入到虚幻引擎中提供了通用接口。 它支持在外部编辑动画的同时，实时查看虚幻引擎内的工作预览。 这对动作捕捉系统和工作流程特别有用。
  - 如需更多信息，请参阅[Live Link](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/live-link/index.md)。

## 下一页

- [面向Maya用户的虚幻引擎过场动画和Sequencer的使用](../using-cinematics-and-sequencer-in-unreal-engine-673b09a9/index.md) - 面向Maya用户的虚幻引擎过场动画工具Sequencer概述。
