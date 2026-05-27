---
title: "虚幻引擎中的游戏对象"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/game-objects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "为Unity开发者准备的虚幻引擎指南", "虚幻引擎中的游戏对象"]
---

# 虚幻引擎中的游戏对象

> 路径：虚幻引擎5.7文档 / 入门指南 / 为Unity开发者准备的虚幻引擎指南 / 虚幻引擎中的游戏对象

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/game-objects-in-unreal-engine

## 比较GameObject与UObject和Actor

在Unity中，**GameObject**代表游戏中的可编程对象。 GameObject本身功能有限，主要作为**组件**（如光源和网格体）的容器来提供特定功能。 每个GameObject都包含一个变换组件，用于表示在世界中的位置和方向。

在虚幻引擎中，**UObject**代表游戏世界中的可编程对象。 UObject类作为虚幻引擎中大多数类的共享基类， 支持[虚幻引擎反射系统](../../../cpp-programming/reflection-system/index.md)，该系统可提供自动回收垃圾等功能。

[Actor](../../../gameplay-systems/gameplay-framework/actors/index.md)作为UObject的子类，相当于Unity中的GameObject。 Actor支持虚幻引擎的[组件系统](index.md#comparing-component-systems)和变换（USceneComponent），因此你可以将Actor放在世界中。 但是与Unity不同的是，你可以直接扩展Actor的功能，而不是完全依赖组件。

> [!TIP]
> 如果对象的实现不需要UObject子类提供额外功能，你可以直接扩展UObject，以更轻量化的方式实现对象。 如需详细了解UObject，请参阅[对象](../../../cpp-programming/reflection-system/objects/index.md)文档。

## 比较组件系统

与Unity类似，虚幻引擎也有组件系统，可用于为游戏对象附加可重复利用的功能。 你可以从零开始创建自定义组件，也可以扩展虚幻引擎提供的众多基础组件。 在此之前，建议先了解以下核心组件类型：

- **Actor组件**——附加在Actor上的基础组件类型。 Actor组件没有变换属性，因此它们在世界中没有物理位置。 适合抽象行为，例如物品栏或属性管理。
- **场景组件**——为在世界中定位提供变换的一种Actor组件。 场景组件没有视觉表示，适合基于位置但无视觉效果的行为，比如物理力、摄像机或音频。
- **基元组件**——可提供视觉和物理表示的一种场景组件。 适合渲染视觉元素和碰撞体积。

> [!TIP]
> 在Unity中，你可以通过父子关系创建复杂的GameObject。 例如，父对象可以包含多个子对象，每个子对象拥有自己的网格体、碰撞体或行为。
>
> 在虚幻引擎中，你可以使用组件（而非子Actor）构建类似的层级结构，从而减少性能和内存开销。

如需详细了解虚幻引擎的组件系统，请参阅[组件](../../../gameplay-systems/gameplay-framework/actors/index.md)。

## 比较Update()和Tick()

在Unity中，组件的更新主要由MonoBehaviour中的`Update()`和`FixedUpdate()`驱动。

在虚幻引擎中，Actor使用`Tick()`（默认启用），组件可选择性地使用`TickComponent()`（默认禁用）。

默认情况下，Tick每帧执行一次。 你可以通过指定Tick组（如`TG_DuringPhysics`）设置不同的Tick间隔。 你还可以设置Tick依赖性，防止在另一个指定的Tick函数完成前执行Tick。

如需更多信息，请参阅以下资源：

- [Actor生命周期](../../../gameplay-systems/gameplay-framework/actors/unreal-engine-actor-lifecycle/index.md)
- [Actor Ticking](../../../gameplay-systems/gameplay-framework/actors/actor-ticking/index.md)
- [组件Ticking](../../../gameplay-systems/gameplay-framework/components/index.md)

## Gameplay框架

**虚幻引擎的Gameplay框架**是一个类集合，包括Actor和组件，为你提供了打造游戏体验的模块化基础。

对比Unity的游戏玩法实现与虚幻引擎的Gameplay框架，两者的差异多于共同之处。 因此，建议查阅[Gameplay框架部分](../../../gameplay-systems/gameplay-framework/index.md)，进一步了解本文档中介绍的概念是如何融入该框架的。 此外，以下部分将简要介绍了一些重要的框架类。

### 重要UObject子类

- [关卡](../../../understanding-the-basics/levels/index.md)——包含构成游戏关卡的一系列游戏对象。 关卡类似于Unity中的场景。
- [数据资产](../../../cpp-programming/programming-in-the-unreal-engine-architecture/data-assets/index.md)——用于定义存储游戏数据的资产。 数据资产类似于Unity中的ScriptableObject。

### 重要Actor子类

- [Pawn](../../../gameplay-systems/gameplay-framework/pawn/index.md)——在世界中充当“代理”。 控制器可以拥有并控制一个Pawn。

  - [角色](../../../gameplay-systems/gameplay-framework/pawn/characters/index.md)——一种代表人形角色的Pawn，提供基本移动和碰撞功能。
- [控制器](../../../gameplay-systems/gameplay-framework/controllers/index.md)——在控制Pawn后负责指挥其行为。

  - [玩家控制器](../../../gameplay-systems/gameplay-framework/controllers/player-controllers/index.md)——用于为Pawn提供本地人类玩家控制。
  - [AI控制器](../../../gameplay-systems/gameplay-framework/controllers/ai-controllers/index.md)——用于通过人工智能控制Pawn。
- [游戏模式](../../../gameplay-systems/gameplay-framework/game-mode-and-game-state/index.md)——一个管理器Actor，用于定义和设置游戏。
- [游戏状态](../../../gameplay-systems/gameplay-framework/game-mode-and-game-state/index.md)——包含游戏的状态信息。

  - **玩家状态**——包含玩家的状态信息。 游戏状态会跟踪所有玩家状态并存储在一个数组中。
