# 为Unity开发者准备的虚幻引擎系统和工作流程概述

---
title: "为Unity开发者准备的虚幻引擎系统和工作流程概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engines-systems-and-workflows-overview-for-unity-developers"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "为Unity开发者准备的虚幻引擎指南", "为Unity开发者准备的虚幻引擎系统和工作流程概述"]
---

# 为Unity开发者准备的虚幻引擎系统和工作流程概述

> 路径：虚幻引擎5.7文档 / 入门指南 / 为Unity开发者准备的虚幻引擎指南 / 为Unity开发者准备的虚幻引擎系统和工作流程概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engines-systems-and-workflows-overview-for-unity-developers

## 简介

本页将概括介绍虚幻引擎的主要系统和工作流程，并比较其与Unity常用编辑器、工具和资产类型之间的异同。 本文档旨在帮助Unity开发者了解如何在虚幻引擎中完成熟悉的工作流程。 如需详细了解各功能，请访问各小节中的链接。

> [!NOTE]
> 本页引用的工具和功能基于**虚幻引擎5.5.4**和**Unity 6 (6000.0.30f1)**版本。 这两个引擎的其他版本的功能参考可能有所不同。

## Gameplay

### 物理

> 动图已省略：670efebd5464c1a370bb60436e193dd3b7daac4fa7fd508f040bb5965ad6f9bd

如需详细了解Chaos物理系统的功能，请参阅物理文档。

#### 物理引擎

虚幻引擎自带**Chaos物理系统**，这是一款轻量级的物理模拟解决方案，专为满足次世代游戏的需求而从零开始搭建。 Chaos物理系统具备许多功能，如破坏、联网物理、刚体物理、载具等。

Unity的默认3D游戏物理引擎是NVIDIA PhysX，它具备许多与Chaos物理系统相似的功能。

#### Chaos破坏系统

**Chaos破坏系统**是虚幻引擎的一套工具集，可用于达到电影级质量的实时破坏效果。 除了炫目的视觉效果，该系统还优化了性能，让美术和设计师能够更好地控制内容创作。

Chaos破坏系统利用了**几何体集合**，这是一种根据一个或多个静态网格体编译的资产，包括蓝图中嵌套的静态网格体。 这些几何体集合可以破裂，从而达到实时破坏效果。

该系统使用直观的非线性工作流对破裂过程进行前所未有的控制。 用户可以在几何体集合的多个部分上创建多个破裂级别和选择性破裂，更好地进行美术控制。 用户还可以定义各群集触发破裂所需的破坏阈值。

如需详细了解Chaos破坏系统，请参阅[Chaos破坏系统](../../../gameplay-systems/physics/chaos-destruction/index.md)文档。

#### 联网物理

游戏中的联网或复制是指通过互联网连接在多台设备之间传递Gameplay信息的能力。 虚幻引擎具有健壮的网络框架，可帮助开发者简化多人游戏的创建。

**联网物理**是网络框架的一部分，使物理驱动型模拟能够在多人游戏环境中运行。 在虚幻引擎中，物理复制是指具有复制的移动效果且能模拟物理效果的Actor。 在Gameplay过程中，这些模拟在本地客户端（玩家的设备）内运行。

你可以阅读[联网物理](../../../gameplay-systems/physics/networked-physics/index.md)文档，以详细了解联网物理功能。

#### 刚体动力学

Chaos物理系统提供了许多种**刚体动力学**功能。 具体包括碰撞响应、追踪、物理约束、阻尼、摩擦。

##### 碰撞

在虚幻引擎中，大多数使用物理引擎的Actor组件都内置了碰撞功能。 在组件的细节面板中，找到"碰撞（Collision）"分段即可修改Actor的碰撞设置。 例如，启用"模拟生成命中事件（Simulation Generates Hit Events）"即可让对象触发命中事件，而你可以通过蓝图或代码访问这些事件，从而检测碰撞。 这就类似于在Unity中使用C#或可视化脚本的OnCollisionEnter来处理碰撞。

如需详细了解如何为Actor设置碰撞，请参阅碰撞文档。

##### 使用射线进行命中判定

Chaos物理系统自带多种**碰撞检测方法**。 碰撞检测方法让你能收集Actor的外部信息。 你可以在运行时使用这些信息，以对不断变化的Gameplay条件做出反应。

运行追踪时有数个不同的可用选项。 你可以使用不同的碰撞检测类型，例如**线型**、**球型**、**盒体**或**胶囊体**碰撞检测等。 你还可以检测单次或多次的命中，甚至可以检测特定的对象类型或碰撞通道。

虚幻引擎中的碰撞检测系统类似于Unity的光线投射系统。

如需详细了解碰撞检测，请参阅[使用射线进行命中判定](../../../gameplay-systems/physics/traces-with-raycasts/index.md)文档。

#### Chaos布料

**Chaos布料**可为游戏和实时体验提供精确、高性能的布料模拟。 该系统配备了丰富的用户控制功能和物理反应（比如，风），可实现特定的美术构想。 此外，Chaos布料还配备了强大的动画驱动系统，可以使布料网格体变形，以匹配其父项的带动画骨架网格体。

Chaos布料还提供机器学习布料模拟功能。 相比基于物理的传统模型，该系统能带来更高的保真度，并使用经过训练的、可实时使用的数据集，从而生成之前只能通过离线模拟来实现的结果。

如需详细了解Chaos布料，请参阅[Chaos布料](../../../gameplay-systems/physics/cloth-simulation/index.md)文档。

#### Chaos载具

**Chaos载具**是虚幻引擎用来执行载具物理模拟的轻量级系统。 该系统为用户提供了更大的灵活性，因为它能逐车模拟任意数量的车轮。 你还可以配置任意数量的前进挡和后退挡，以进一步实现自定义效果。

Chaos载具支持复杂的载具模拟配置。 你可以添加任意数量的翼面，而这类翼面可在底盘的特定位置提供下行压力或升力。 这些翼面还可以模拟载具扰流板，甚至模拟飞行器的机翼或方向舵。 你可以通过滚动、俯仰和偏转等方法操纵这些控制表面。

如需详细了解Chaos载具，请参阅[Chaos载具](../../../gameplay-systems/physics/vehicles/chaos-vehicles/index.md)文档。

#### 流体模拟

虚幻引擎自带一套内置的工具，可用于实时模拟2D和3D流体效果。 这些系统使用基于物理的模拟方法，来产生逼真的效果，例如火焰、烟雾、云层、河流、飞溅物和海滩上的波浪。

这套工具旨在通过利用模拟阶段、可复用的模块、强大的数据接口，构筑一个开放性的试验平台。

如需详细了解流体模拟，请参阅 [流体模拟](../../../gameplay-systems/physics/fluid-simulation/index.md) 文档。

### 人工智能

> 动图已省略：c96325c24fe59961b84c321baa3e97327a54f520fdc6890a2869fab9f849ce5c

虚幻引擎配备了多种系统，用于在Gameplay过程中创建和管理AI代理（NPC）。

#### 大规模模拟AI代理

**MassEntity**是一款聚焦于Gameplay的框架，旨在实现高性能的、以数据为导向的模拟。 你可以使用MassEntity来高效管理并渲染大量屏上实体。

如需了解详情，请参阅 [MassEntity](../../../gameplay-systems/artificial-intelligence/massentity/index.md) 文档。

#### 模拟AI代理的行为

虚幻引擎自带各种AI代理功能，其分类如下：感知和刺激、决策、世界寻路、环境交互。 每个类别都有一套或多套系统，可帮助你实现预期的结果。

##### 感知和刺激

在**感知和刺激**方面，虚幻引擎提供[Pawn感应](https://dev.epicgames.com/documentation/unreal-engine/BlueprintAPI/AI/Components/PawnSensing?application_version=5.6)、[Pawn噪声发射器](https://dev.epicgames.com/documentation/unreal-engine/BlueprintAPI/Audio/Components/PawnNoiseEmitter?application_version=5.6)、AI感知[三大AI组件](../../../gameplay-systems/artificial-intelligence/ai-components/index.md)。

**AI感知**可用于定义和处理AI代理可运用的感官。 AI感知组件是一种可通过组件窗口被添加至Pawn的AI控制器蓝图的组件。它可用于定义要监听的感官、这些感官的参数以及检测到感官时的响应方式。

你还可以使用几个不同的函数来获取所感应到内容的信息、所感应到的Actor，甚至开关某个特定类型的感官。

如需了解详情，请参阅[AI感知](../../../gameplay-systems/artificial-intelligence/ai-perception/index.md)文档。

##### 决策

在**决策**方面，虚幻引擎提供行为树和状态树。 这些资产自带AI代理在Gameplay过程中制定决策所用的逻辑。

**行为树资产**包含一个决策图表，其中有各种节点，这些节点含有AI代理可执行的逻辑。 行为树从根部开始，根据存储在**黑板资产**中的数据或代理自带的数据来执行特定的节点。 行为树直观地呈现了AI代理制定决策的过程，并可进行配置，以实现可复用性和灵活性。

如需了解详情，请参阅[行为树](../../../gameplay-systems/artificial-intelligence/behavior-trees/index.md)文档。

**状态树**是一种通用的层级化状态机，可组合行为树中的选择器与状态机中的状态和过渡。 你可以使用状态树创建非常高效、始终灵活且井然有序的逻辑。

如需了解详情，请参阅[状态树](https://dev.epicgames.com/documentation/unreal-engine/BlueprintAPI/StateTree?application_version=5.6)文档。

##### 世界寻路

在**世界寻路**方面，虚幻引擎为AI代理配备了功能齐全的寻路系统。

**寻路系统**可为项目中的AI代理提供高效的寻路功能。 你可以在关卡中创建一个**寻路网格体Actor**，并以此为你的代理编译和绘制寻路地图。 你还可以使用[寻路网格体修饰符](../../../gameplay-systems/artificial-intelligence/navigation-system/modifying-the-navigation-mesh/overview-of-how-to-modify-the-navigation-mesh/index.md)和[自定义寻路区域](../../../gameplay-systems/artificial-intelligence/navigation-system/custom-navigation-areas-and-query-filters/index.md)来影响穿越特定区域的开销，从而主动影响AI代理选择到达目标的最佳寻路路径的方式。

此外，该系统还配备了两套[避障系统](../../../gameplay-systems/artificial-intelligence/navigation-system/using-avoidance-with-the-navigation-system/index.md)，即相对速度障碍物和大规模人群绕行避让管理器，以帮助AI代理避开环境中的以及彼此间的动态元素。

如需了解详情，请参阅 [寻路系统](../../../gameplay-systems/artificial-intelligence/navigation-system/index.md) 文档。

##### 环境交互

在**环境交互**方面，虚幻引擎提供智能对象功能。

**智能对象（Smart Objects）**是可以放置在关卡中与AI代理和玩家交互的对象。 这些对象自带了交互所需的所有信息。 智能对象隶属于一个全局数据库，并使用一种空间分区结构。 这意味着可以在运行时使用过滤器（例如代理和Gameplay标签周围的搜索区域）来查询智能对象。

如需了解详情，请参阅 [智能对象](https://dev.epicgames.com/documentation/unreal-engine/BlueprintAPI/SmartObject?application_version=5.6) 文档。

#### 机器学习

为制作更加复杂的AI解决方案，让AI代理可以学习和适应，虚幻引擎提供了学习代理（Learning Agents）插件，该插件会使用强化学习（Reinforcement Learning）等算法来训练AI代理。 此虚幻引擎插件相当于Unity的MLAgents软件包。

如需了解详情，请参阅[学习代理](https://dev.epicgames.com/documentation/unreal-engine/BlueprintAPI/LearningAgents?application_version=5.6)文档。

## 为角色和对象制作动画

> 动图已省略：af0f057ff4e86fb0d3c1d7574b3a61383e184ea42be28ab7374797dcf309449d

虚幻引擎的**动画蓝图**就相当于Unity的Animator Controller。 动画蓝图包含**动画图表**和标准的蓝图事件图表，让用户能通过单一入口点定义参数和编写复杂动画行为和逻辑的脚本。

如需了解详情，请参阅[动画蓝图](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-blueprints/index.md) 文档。

如果你更喜欢用状态机来组织动画，那么你可以在动画图表中创建**State Machine**节点。双击这些节点即可打开它们各自的专用子图表。 然后你就可以创建新状态、导管和状态别名，并在它们之间建立连接。 每种状态都有其自身的动画图表，用于控制状态的输出，而连接则负责控制状态之间的过渡。

如需了解详情，请参阅[状态机](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-blueprints/state-machines/index.md)文档。

**混合空间**定义了根据参数进行混合的动画图表。 例如，一个2D混合空间可以根据角色的速度和朝向混合向前、向后、向左和向右行走的动画。

如需了解详情，请参阅 [混合空间](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/blend-spaces/index.md) 文档。

Unity会使用Timeline工具来制作过场动画序列的动画。 虚幻引擎的**Sequencer编辑器**就相当于Unity的Timeline工具，它的界面更类似于非线性编辑器，可用于协调动画、特效和摄像机的运动。 你可以使用Sequencer来定义代表过场动画的关卡序列，或定义角色和对象的独立动画。

如需详细了解序列的创作，请参阅[Sequencer编辑器](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/sequencer-editor/index.md)文档。

虚幻引擎还自带 **控制绑定系统**，可用于在编辑器中直接为动画绑定骨架网格体。 你可以使用控制绑定为角色创建并绑定自定义控制点、在Sequencer中为其制作动画，并使用各种其他动画工具来帮助你完成动画的制作。

如需详细了解虚幻引擎中的绑定，请参阅 [控制绑定](../../../animating-characters-and-objects/control-rig/index.md) 文档。

要在虚幻编辑器中捕获并导出图像和视频序列，请使用**影片渲染队列**。 这就相当于Unity Recorder工具。 影片渲染队列能够以无损质量渲染并导出逐帧序列、游戏内图像或视频录像。

如需详细了解影片渲染队列，请参阅[如何将影片渲染队列用于高质量渲染](../../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/rendering-high-quality-frames-with-movie-render-queue/index.md)文档。

## Gameplay框架

虚幻引擎的**Gameplay****框架**是类的集合，你可以在此模块化的基础上打造Gameplay体验，例如**游戏****模式**、**玩家状态**、**控制器**、**Pawn**和**摄像机**等。

在Unity中，类似的结构由GameObjects所附带的CharacterController和MonoBehaviour脚本等组件来处理，以定义各种行为。

如需详细了解如何利用Gameplay框架，请参阅 [Gameplay框架](../../../gameplay-systems/gameplay-framework/index.md) 文档。

## 输入

**增强****输入系统**旨在跨平台处理玩家输入，如键盘、游戏手柄和触摸屏等设备。

你可以定义输入操作（针对跳跃和射击等操作）和输入轴（针对移动或摄像头旋转等连续输入）。 你可以将这些操作和轴绑定到特定的按键、按钮，甚至是触摸手势，从而提供高度的自定义功能。

要开始使用增强输入系统，请在内容浏览器中按下**+ 添加（+ Add）**按钮并选择**输入（Input）**，从而创建增强输入资产。 配置这些资产即可为你的游戏定义按键绑定和输入。

你可以将这些操作和轴绑定到游戏逻辑中的玩家输入事件。 你还可以使用该系统管理不同的输入方案（如键盘 与游戏手柄方案），并定义复杂的控制方案。

Unity开发者可能对Unity输入系统并不陌生，其功能就类似于虚幻引擎的增强输入系统。 在虚幻引擎中，增强输入（Enhanced Input）是复杂输入处理或运行时控制重映射的标准解决方案。

如需详细了解如何为项目定义输入，请参阅 [增强输入](../../../gameplay-systems/input/enhanced-input/index.md) 文档。

## 世界创建和设计

> 动图已省略：15122dfd873b7104422536b253f783678993091c7f864ca86b789f162182986c

虚幻引擎中负责建造世界的功能在关卡视口中被划分为了不同的编辑器模式。

### 建模和关卡原型设计

**建模（Modeling）**模式的功能与Unity的ProBuilder扩展类似，它配备了大量的顶点、边缘、面和UV编辑工具，与其他建模程序中使用的工具类似。

要激活建模模式，请点击视口的模式（Modes）下拉菜单并选择建模（Modeling）。

如需详细了解虚幻引擎中的建模，请参阅 [建模模式概述](../../../working-with-content/modeling-and-geometry-scripting/getting-started-with-modeling-mode/modeling-mode/index.md) 文档。

### 创建地貌/地形

**地形（Landscape）**模式的功能与Unity的地形（Terrain）系统类似。 你可以使用地形（Landscape）模式创建地形，并使用与Unity的地形（Terrain）系统类似的工具套件（如升高、降低和压平）等功能来塑造地形。

要激活地形模式，请点击视口的模式（Modes）下拉菜单并选择地形（Landscape）。

如需了解详情，请参阅地形快速入门指南文档。 另外还请参阅[户外地形](../../../building-virtual-worlds/landscape-outdoor-terrain/index.md)文档，了解如何为大型开放户外环境创建地貌。

### 植被

**植被（Foliage）**模式类似于Unity的地形（Terrain）系统，可用于添加和管理植被。 在植被模式中，你可以在关卡中绘制树木、草地等植被，并调整每片植被的密度、高度和旋转等属性。

与Unity的地形系统的一个主要区别在于，虚幻引擎的植被模式可为所有对象绘制植被，不仅限于地形。 植被模式让你可以直观地为世界填充自然元素，同时还让你可以控制它们在地形或关卡中任意表面上的显示效果。

要激活植被模式，请点击视口的模式（Modes）下拉菜单并选择植被（Foliage）。

如需了解相关信息，请参阅[植被模式](../../../building-virtual-worlds/open-world-tools/foliage-mode/index.md)文档。 此外，请参阅 [开放世界工具](../../../building-virtual-worlds/open-world-tools/index.md) 文档，了解如何在大型场景中程序化地填充静态网格体资产，以创建自然而生动的户外空间。

### 程序化内容生成（PCG）

**程序化内容生成****（Procedural Content Generation，PCG）框架**是用于在虚幻引擎内创建程序化内容的工具集。 美术师和设计师可以利用PCG编译快速迭代工具和任意复杂度的内容，从资产工具（如建筑物或群系生成等）到整个世界，不一而足。

PCG为支持可扩展性和交互性而设计，可集成到现有的世界建造管线中，从而在事实上模糊了程序化流程和传统工作流程之间的界限。

如需详细了解如何在虚幻引擎中创建程序化内容，请参阅[程序化内容生成框架](../../../building-virtual-worlds/procedural-content-generation/index.md)文档。

### 水体系统

你可以使用 **水体系统**，以样条线工作流程为基础，创建各种可以和你的地形地貌交互并协同工作的河流、湖泊、海洋等水体。

Unity开发者可能对使用HDRP的项目所用的水体系统并不陌生。 虚幻引擎中的水体系统具有可伸缩性，可适用各种规模的项目，并且支持所有平台。

如需详细了解如何在你的关卡中启用水体，请参阅 [水体系统](../../../building-virtual-worlds/water-system/index.md) 文档。

## 视觉效果和渲染

> 动图已省略：12eee659c3a2f63f97bae60e82b285ee60e8efd91b0e423c36d43ce98536160e

Unity使用可编程渲染管线（SRP）系统，同时还提供了高清渲染管线（HDRP）等模板。 而虚幻引擎拥有统一、强大且可高度自定义的渲染管线。 这意味着设备支持、功能和特性集并不会被模板所分割。

在虚幻引擎中，你可以使用**可伸缩性设置**来更改游戏的视觉保真度。 如需了解详情，请参阅 可伸缩性参考 文档。

### 光源

虚幻引擎中的光源工作流程与Unity中的类似。 你可以为关卡添加或移除光源。同时你还有各种类型的光源可用，如定向光源、点光源和聚光光源等。

转到**创建（Create） > 光源（Light）**分段即可选择要添加到关卡中的光源的形状。 这将创建一个新对象。 如需详细了解光源类型及其使用方法，请参阅 [光源类型及其可移动性](../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/index.md) 文档。

### 天空光源

**天空光源**能捕捉关卡的远处部分并将其作为光源应用到场景中。 这意味着，即使天空来自大气层、天空盒顶部的云层或者远山，天空的外观及其光照/反射也会相互匹配。

默认情况下，虚幻引擎中的新关卡在**大纲视图**面板中会有一个**Lighting**文件夹。 该文件夹包含了一组默认的光照对象，如DirectionalLight、ExperimentalHeightFog和SkyLight等。 如需了解详情，请参阅 [天空光照](../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/sky-lights/index.md) 文档。

### Lumen全局光照和反射

**Lumen**是虚幻引擎专为次世代设备而设计的全动态全局光照和反射系统，也是默认的全局光照和反射系统。 这意味着光线会反弹并与表面交互，从而瞬间创建自然的光照效果，而无需使用预先计算的工作流程来烘焙光照。

如需详细了解如何在项目中使用动态全局光照和反射，请参阅 [Lumen全局光照和反射](../../../building-virtual-worlds/lighting-the-environment/global-illumination/lumen-global-illumination-and-reflections/index.md) 文档。

### 后期处理

Unity会使用体积（Volume）进行后期处理。 创建带有体积组件的GameObject后，你可以为其分配后期处理配置文件，并设置它是全局还是局部的。

而虚幻引擎主要使用放置的体积来后期处理。 但你也可以通过其他方式应用后期处理。 总的来说，两者使用后期处理的方式类似，而你可以重载默认值。

| 后期处理的应用方法 | 说明 |
| --- | --- |
| 项目设置 | 默认情况下，虚幻引擎会根据可伸缩性设置对你的游戏应用一组后期处理效果。 除非被重载，否则这些设置将对整个项目应用。要更改项目全局应用的后期处理效果，请转到**项目设置（Project Settings） > 引擎（Engine） > 渲染（Rendering）**。 |
| 摄像机组件 | 所有摄像机组件都各有一套可被重载的后期处理设置。 这些设置以每台摄像机为基础，也就是说，不重载任何设置的摄像机将应用"项目设置"中定义的默认效果，或使用被放置的体积所应用的值。 |
| 后期处理体积 | 转到**添加（Add） > 体积（Volume）**即可为关卡添加后期处理体积。 这会创建一个新的关卡Actor来重载默认的后期处理设置，而它与Unity的体积组件极为类似。这些体积可以在玩家摄像机位于体积内时应用后期处理，也可以在启用**无限范围（未限制）（Infinite Extent (Unbound)）**设置时，为整个关卡全局应用任意重载项。 其工作方式与Unity体积框架中的**全局模式（Global Mode）**选项类似。 |

### 材质

Unity使用着色器图表（Shader Graph）来定义新的着色器。 虚幻引擎与之对应的系统是**材质系统**。 虚幻引擎中的着色器和材质存在以下区别：

1. 着色器是一种C++低级别结构，可定义基础着色模型，例如"光照（Lit）"、"无光照（Unlit）"、"透明涂层（Clear Coat）"或"毛发（Hair）"。 这将决定着色器的输入，如金属感（Metallic）或半透明（Translucent），以及它们各自对光源的反应。
2. 材质是由纹理输入、公式和指令构成的逻辑图表，这些内容被输入到着色器中，代表了单个对象的表面质量和着色器的具体表达式。

要创建材质，请右键点击**内容浏览器**中的任意位置，然后点击**创建基础资产（Create Basic Asset） > 材质（Materials）**。 材质编辑器会显示一份带有Main Material节点的空白图表。

点击**Main** **Material**节点，即可在**细节（Details）**面板中显示这些属性。 使用**着色模型（Shading Model）**设置即可选择不同的着色器。

如果你想为多个网格体应用一种独特的材质，建议使用**材质实例（Material Instances）**。 材质实例是材质的参数化版本，使用材质实例即可引入多样性和独特性，且不会导致额外的开销。

所有材质实例都会使用一个材质或另一个材质实例作为其父项（或"主"材质）来进行编辑。 你可以通过**实例化材质编辑器**访问主材质中参数化的所有节点。 你可以使用这些公开的参数从单一的源材质创建无穷无尽的变体，如创建颜色变体、应用不同纹理、增加或减少细节等。

使用主材质及其子材质来驱动变体时，使用材质实例会更有效率。

要创建材质实例，请右键点击**内容浏览器**中的某个材质，然后点击**创建材质实例（Create Material Instance）**。

如需详细了解材质和材质实例，请参阅[材质](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/index.md)文档和[创建和使用材质实例](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/instanced-materials/creating-and-using-material-instances/index.md)文档。 另外，如需详细了解材质编辑器，请参阅[材质编辑器指南](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/unreal-engine-material-editor-user-guide/index.md)文档。

### Nanite

Nanite是虚幻引擎的虚拟化几何体系统，它采用内部的网格体格式和渲染技术来渲染像素级别的细节以及海量对象。 它仅处理能被感知到的细节。

Nanite系统能为项目带来诸多裨益，例如将几何体形状的复杂度提高多个数量级，同时三角形和对象的数量也超过了以往在实时环境中所能达到的水平。 帧预算不再会因为多边形数量、绘制调用和网格体内存占用而受限。

如需详细了解Nanite及其在项目中的使用方法，请参阅[Nanite虚拟几何体](../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/nanite/nanite-virtualized-geometry/index.md)文档。

## 音频

Unity使用一套音频源框架，在此框架中，游戏世界中的每个音频源都关联了一个声音。 Unity会使用混音器（Mixer）为这些源应用音频通道设置。

虚幻引擎的**MetaSounds**插件是一款音频生成系统，可在类似于蓝图的可视化脚本环境中完全控制**数字信号处理（DSP）**图表。

如需了解详情，请参阅[MetaSounds](../../../working-with-audio/sound-source/metasounds/index.md)文档。

我们建议使用**音频调制（Audio Modulation）**插件来混合音频，该插件可通过虚幻引擎的蓝图或组件系统动态地控制音频参数（如音量和音高）。

如需了解详情，请参阅 [音频调制概述](../../../working-with-audio/audio-mixing/audio-modulation/audio-modulation-overview/index.md) 文档。

**Sound** **Cue**是一种音频对象，它利用节点式图表封装了复杂的声音设计逻辑。 利用此音频对象，你只需排列和修改各个声音节点，就能动态地修改音效的各个部分，从而创建复杂的音频输出。

如需详细了解Sound Cue，请参阅 [Sound Cue参考](../../../working-with-audio/sound-source/sound-cue/sound-cue-reference/index.md) 文档。

如需全面了解虚幻引擎的音频系统，请参阅 [处理音频](../../../working-with-audio/index.md) 页面。

## 视觉效果

> 动图已省略：2625d51aefa3d9d6af5b3378fc6d839a6b791e0b974cdee74eda7570c4e635f0

虚幻引擎的**Niagara粒子系统**就相当于Unity的粒子系统（Particle Systems）和视觉特效处理图表（VFX Graph）。 你可以创建Niagara发射器来打造单个粒子发射器，也可以创建多个Niagara系统来让多个发射器合成更复杂的视觉效果。 创建新系统或发射器资产时，可以将现有的Niagara发射器作为模板。

Niagara编辑器的系统概览（System Overview）图表提供的粒子编辑界面与Unity的粒子系统编辑器的界面类似。 Niagara发射器和系统由模块化组件组成，可处理各种行为或事件。 每添加一个模块，都会增加粒子系统的复杂度，并增加新的需配置参数。

如需了解详情，请参阅 [创建视觉效果](../../../visual-effects/index.md) 文档。

你可以使用**Niagara****流体**插件为项目添加烟雾、火焰、爆炸、水体、飞溅等逼真的物理效果。

如需了解详情，请参阅 [**Niagara流体**](https://dev.epicgames.com/community/learning/paths/mZ/unreal-engine-niagara-fluids) 文档。

## 用户界面

虚幻引擎的**虚幻动态图形**编辑器（简称**UMG**）相当于Unity的UI工具包和UI组件库。 UMG提供了一款所见即所得的编辑器，用于使用各种控件打造UI，其中包括按钮、文本元素以及不计其数的容器和网格。

要创建新UI，请在**内容浏览器（Content Browser）**中新建**控件蓝图（Widget Blueprint）**。 打开控件蓝图时，系统会打开UMG编辑器，并显示一个空白网格，网格左侧是控件的**控制板**面板，右侧是细节面板。 使用右上角的按钮即可在**设计师（Designer）**视图和**图表（Graph）**视图之间切换。

使用设计师视图即可在控件蓝图内排列控件。 点击控制板面板中的控件并将其拖动到图表中，然后使用**层级（Hierarchy）**更改绘制顺序。 列表中靠后的控件会在顶部显示。 在控件的细节面板中勾选**Is Variable（可变）**复选框，即可将其显示在UI脚本中。

顾名思义，你创建的所有控件蓝图都在其他控件蓝图中作为控件使用。 这些控件会出现在控制板的**用户创建（User Created）**类别下。 你既可以将控件蓝图用于整个菜单和HUD，也可以将其用于按钮或进度条等可重复使用的组件。

如需了解详情，请参阅 [UMG UI设计器快速入门](../../../user-interfaces/basics-of-user-interface-development/building-your-ui/umg-ui-designer-quick-start-guide/index.md) 文档。 另外，如需详细了解UI的编译和显示，请参阅[创建用户界面](../../../user-interfaces/index.md)文档。

## 保存和加载

大多数现代游戏都能让玩家在退出游戏后从上次离开的地方继续游戏。 具体视你所开发的游戏类型而定，你可能仅需保存一些基本信息，例如玩家到达的最后一个检查点，或者其他更详细的信息。

Unity开发者可能对PlayerPref比较熟悉（它可用于在游戏会话之间存储玩家的偏好设置），也可能对Asset Store上各种提供保存和加载功能的资产包也不陌生。 虚幻引擎内置了这些功能。

如需详细了解如何在虚幻引擎中保存和加载游戏会话，请参阅 [保存和加载游戏](../../../gameplay-tutorials/saving-and-loading-your-game/index.md) 文档。

## 两种引擎之间的高级别功能对比

本节概述了Unity和虚幻引擎中部分功能和工具的名称和用途。

| 用途 | 虚幻引擎 | Unity |
| --- | --- | --- |
| 用户界面（UI） |  |  |
| 创建UI | 虚幻动态图形（UMG） | UI工具包 |
| 世界建造 |  |  |
| 创建各种形状的地形 | 地形（Landscape）模式 | 地形（Terrain）系统 |
| 为地形添加植被 | 植被模式 | 地形（Terrain）系统的植被 |
| 编译关卡方块 | 建模模式 | ProBuilder |
| 创建水体表面和水下效果 | 水体系统 | 水体系统 |
| 程序化地生成世界和工具 | 程序化内容生成（PCG） | 第三方工具 |
| 优化 |  |  |
| 用于识别性能问题的分析套件。 | 追踪 | 性能分析器 |
| Gameplay |  |  |
| 处理玩家输入 | 增强输入系统 | 输入系统 |
| 可视化脚本 | 蓝图编辑器 | 可视化脚本（之前被称为Bolt） |
| 支持的脚本编写和编程语言 | C++（编程） | C#（脚本编写） |
| 物理引擎 | Chaos物理系统 | NVIDIA PhysX |
| 保存和加载游戏数据 | SaveGame对象 | PlayerPrefs / 自定义解决方案 |
| 人工智能 |  |  |
| 用于创建AI状态的状态机 | 状态树 | 第三方工具 |
| 创建可供AI寻路的区域 | 寻路系统 | 寻路网格体 |
| 动画 |  |  |
| 处理动画数据 | 动画蓝图 | Animator Controller |
| 创建动画序列 | Sequencer编辑器 | Timeline |
| 绑定3D角色 | 控制绑定 | 第三方工具 |

