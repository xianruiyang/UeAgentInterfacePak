---
title: "Mover示例"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/mover-examples-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Mover", "Mover示例"]
---

# Mover示例

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Mover / Mover示例

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/mover-examples-in-unreal-engine

本文将为你介绍 ***Mover Examples**插件中的一些示例内容，以便你了解 **Mover** 系统。

> [!NOTE]
> Mover Example插件的中的示例内容不应被直接用于发行产品。

## 先决条件

启用Mover和Mover Examples插件，并在使用示例内容前调整项目设置。

### 启用插件

要启用Mover和Mover Examples插件，请按以下步骤操作：

1. 选择

   编辑（Edit） > 插件（Plugins）

   ，打开

   插件（Plugin）

   面板。
2. 在

   插件（Plugin）

   面板的搜索栏中，输入"Mover"。
3. 启用

   Mover

   和

   Mover Examples

   插件。
4. 重启

   虚幻编辑器

   。

### 调整项目设置

对项目设置做如下调整：

1. 选择

   编辑（Edit） > 项目设置（Project Settings）

   打开

   项目设置（Project Settings）

   面板。
2. 选择

   项目（Project）

   标题下的

   Network Prediction

   筛选器，或使用搜索栏找到以下设置并调整其值：

   1. 将

      偏好更新策略（Preferred Ticking Policy）

      设置为

      固定（Fixed）

      。
   2. 将

      模拟代理网络LOD（Simulated Proxy Network LOD）

      设置为

      插值（Interpolated）

      。
   3. 将

      启用固定更新平滑（Enable Fixed Tick Smoothing）

      设置为

      True

      。

推荐在一般使用情况下调整以上设置。我们也鼓励探索和浏览相关设置的说明文本。

## 示例内容概述

Mover Examples插件为学习Mover的用户提供了许多宝贵内容，包括关卡和Pawn。

### 关卡

Mover Examples插件提供了数个关卡来展示Mover的功能，包括：

- L_CharacterMovementBasics

  ：展示各种地形功能、移动以及经过扩展的、具有额外移动能力的Pawn。
- L_PhysicsSimulatedCharacter

  ：提供了一个基于物理的Pawn的示例实现。更多详情，请参阅

  基于物理的移动

  。
- L_LayeredMoves

  ：展示了多种分层移动类型以及众多选项。
- L_PathfindingMovement

  ：集中展示由AI驱动的，具有寻路功能的移动方法，包括一种NavWalking模式。

你可以在 `All/Engine/Plugins/Mover Examples Content/Maps` 中找到上述所有关卡以及更多其他关卡。

你可以打开每个关卡，随意操作一番以更好地理解Mover的功能。每个关卡都被划分成了若干部分，并附有说明以阐明每个区域的作用。

![Example Level](../../../../assets/images/17/179c45330f15827430073786d8da1639b435c092814cd6cdb0aae73d4b8b3668.jpg)

### Pawns

Mover Examples插件提供了一些示例Pawn实现，以展示Mover的功能，包括：

- AnimatedMannyPawn

  ：用于执行类似项目模板中的默认Pawn的行为。
- AnimatedMannyPawnExtended

  ：提供了一个通过扩展默认Pawn实现来赋予其更多移动能力（包括冲刺、多段跳、飞跃以及滑索移动）的示例。你可以在名为

  L_CharacterMovementBasics

  的关卡中通过进入

  Swap For Extended Pawn

  区域来拥有这种Pawn。
- PathFollowingMannyPawn

  ：展示基于AI的路径跟随，并以此为例说明寻路网格体的移动方式。
- PhysicsMannyPawn

  ：使用Chaos联网物理（Chaos Networked Physics）系统，而非Network Prediction插件的实现。相关的移动方法也经过了定制，以适应物理系统的限制。更多详情，请参阅

  基于物理的移动

  .

你可以在 `All/Engine/Plugins/Mover Examples Content/Pawns` 中找到上述所有Pawn以及更多其他Pawn。

要熟悉示例Pawn的移动模式和设置，你可以：

1. 在

   内容浏览器

   中双击想要了解的Pawn，以打开

   蓝图编辑器

   。
2. 在

   组件（Components）

   绵中，选择

   角色动作组件（Mover组件）（Character Motion Component (MoverComponent)）

   。
3. 在

   细节

   面板中查看Pawn的属性。

   移动模式（Movement Modes）

   和

   共享设置（Shared Settings）

   属性将是很好的切入点。

![Mode Details](../../../../assets/images/52/52c3ac6ea6d21ee17963f36e03e52bf07ff0b84ff7ddbb9ba1f746c61f824bf3.png)

> [!NOTE]
> 在体验关卡时，玩家控制Pawn的控制按钮会出现在视口的左下角。

## 基于物理的移动

`L_PhysicsSimulatedCharacter` 关卡展示了 `PhysicsMannyPawn`，该Pawn由Chaos联网物理系统驱动，而不是Network Prediction插件。

除了[调整项目设置](#%E8%B0%83%E6%95%B4%E9%A1%B9%E7%9B%AE%E8%AE%BE%E7%BD%AE)中更改的设置，你还需要在项目设置中进行以下调整：

1. 启用

   异步更新物理（Tick Physics Async）

   。
2. 对于联网操作，还需启用

   启用物理预测（Enable Physics Prediction）

   。

物理模拟以固定的更新评率在游戏线程之前运行。随着模拟的推进，游戏线程中角色的呈现会平滑地过渡到最近的物理状态。然而，这意味着玩家输入与Pawn移动之间存在一些延迟。

### 其他注意事项

- 物理系统中的

  角色地面约束（Character Ground Constraint）

  负责执行由Mover系统生成的建议动作。
- 你需要为其他可交互物理对象设置复制功能。否则，服务器和客户端会不同步。
- 与移动中的非物理对象的交互结果不佳，因为物理模拟和其余游戏世界的更新频率不同。
- 由物理驱动的Mover Actor不能与使用Network Prediction插件的Actor实现同步。
- Gameplay事件

  无法连接到Mover系统。

## 自定义与扩展

你可以更改MoverComponent上的移动模式映射，从而自定义Mover Actor，使其可以用新的移动方式在世界中移动。在运行时，你可以通过调用 `QueueNextMode` 函数或（如果使用默认的角色输入结构体）通过设置 `SuggestedMovementMode` 来在这些模式之间切换。你甚至可以在运行时添加或移除模式。

> [!WARNING]
> 在关卡中的Actor实例上移除和替换移动模式映射中元素时，存在一些已知问题，可能会导致这些Pawn无法移动。

默认的角色移动模式具有多种设置，可以定制其行为和手感。你可以在各个模式本身以及共享设置中找到这些单独的设置。

要定义你自己的移动模式，请参考 `UZipliningMode` 示例。你可以按照此示例重载以下函数：

- OnGenerateMove

  ：创建建议动作。
- OnSimulationTick

  ：通过世界模拟建议动作以创建下一个状态快照。

滑索移动的实现会添加一些自定义状态数据，以追踪角色沿着滑索的移动进度。`FZipliningState` 定义了这些数据，而 `UZipliningMode::OnSimulationTick` 在移动模拟状态中添加和修改这些数据。与自定义输入数据一样，自定义状态数据需要有原生C++的定义。

对于输入，MoverExamples中的Pawn使用C++和蓝图函数相结合的方式来为编写移动模拟的输入。

这些Pawn的常见输入（方向移动、跳跃）在 `AMoverExamplesCharacter::OnProductInput` 中编写，额外的自定义输入则在 `AnimatedMannyPawnExtended` 的 `OnProduceInput` 蓝图函数中编写。

尽管你可以在蓝图中生成自定义输入，但添加你自己的数据仍需要使用C++代码，具体方法可参考 `FMoverExampleAbilityInputs` 示例。类型要在C++中定义，但由蓝图将其添加到模拟并完成编写。

滑索示例还在 `UZiplineStartTransition` 和 `UZiplineEndTransition` 中展示了自定义过渡效果以及通过模块化方式添加新的移动机制。
