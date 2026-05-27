---
title: "Gameplay系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gameplay-systems-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统"]
---

# Gameplay系统

> 路径：虚幻引擎5.7文档 / Gameplay系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gameplay-systems-in-unreal-engine

在"Gameplay系统"这一小节中，我们将概括介绍**虚幻引擎**（**UE**）中有关Gameplay编程以及脚本编写的一系列内容，重点帮助你实现玩家与世界的交互功能。

- UE中的[Gameplay框架](gameplay-framework/index.md)包括核心系统和用于处理通用Gameplay元素的框架，比如[Actor](gameplay-framework/actors/index.md)、[摄像机](gameplay-framework/cameras/index.md)、[组件](gameplay-framework/components/index.md)、[控制器](gameplay-framework/controllers/index.md)、[游戏规则](https://dev.epicgames.com/documentation/unreal-engine/game-features-and-modular-gameplay-in-unreal-engine?application_version=5.7)、[游戏模式](gameplay-framework/game-mode-and-game-state/index.md)、[玩家输入](input/index.md)、[Gameplay定时器](gameplay-framework/gameplay-timers/index.md)和[用户界面](gameplay-framework/user-interfaces-and-huds/index.md)。
- [人工智能](artificial-intelligence/index.md)介绍了可用于在UE中进行创作的各种可用系统，比如[行为树](artificial-intelligence/behavior-trees/index.md)、[批量实体系统](https://dev.epicgames.com/documentation/assets/making-interactive-experiences/artificial-intelligence/mass-entity)、[状态树](artificial-intelligence/statetree/index.md)、[寻路系统](https://dev.epicgames.com/documentation/assets/making-interactive-experiences/artificial-intelligence/navigation)、[智能对象](artificial-intelligence/smart-objects/index.md)、[环境查询系统](artificial-intelligence/environment-query-system/index.md)、[AI感知组件](https://dev.epicgames.com/documentation/assets/making-interactive-experiences/artificial-intelligence/ai-perception)和[调试](artificial-intelligence/ai-debugging/index.md)等。
- [物理](physics/index.md)包含各种子系统，可计算[碰撞](physics/collision/index.md)、[光线投射](physics/traces-with-raycasts/index.md)、[Chaos破坏系统](physics/chaos-destruction/index.md)和模拟[物理Actor](physics/physics-bodies/index.md)、[布料物理](physics/cloth-simulation/index.md)和[材质](physics/physical-materials/index.md)等，包括[毛发物理](physics/hair-physics/index.md)。
- [大型世界坐标](large-world-coordinates/index.md)在UE中引入了对双精度数据变量类型的支持，并对所有引擎系统进行了广泛更改，以便提高其浮点精度。
- [数据驱动型Gameplay元素](data-driven-gameplay-elements/index.md)有助于降低生命周期延长的游戏所涉及的工作量和复杂性。 例如，有些游戏可能通过在线服务模式为用户提供更新。 此模式可能调整游戏中的某些数据参数，以基于用户反馈平衡或增加内容。
- [Gameplay技能系统](gameplay-ability-system/index.md)是一款高度灵活的框架，可编译你可能在RPG或MOBA作品中看到的技能类型和属性。 你可以为游戏中的角色构建要使用的操作或被动技能，以及因为这些操作而加强或削弱各种属性的状态效果，此外，你还可以实现"冷却"定时器或资源成本，以调节这些操作的用法，更改技能等级及其在每个等级的效果，激活粒子、音效等。
- [载具](physics/vehicles/index.md)是虚幻引擎的轻量级系统，用于执行载具物理模拟。
- [网络和多人玩家](networking-and-multiplayer/index.md)的现代多人游戏体验要求在全球大量客户端之间同步海量数据。 为了让用户拥有引人入胜的体验，你发送什么数据以及如何发送数据就变得极其重要，因为这会显著影响项目的表现和玩家的感受
- 本小节的[Gameplay教程](../gameplay-tutorials/index.md)指南将介绍如何使用这些功能，并讲解如何使用蓝图和C++在游戏中重新创建通用机制和系统。

## 小节主题目录

- [人工智能](artificial-intelligence/index.md) - 介绍了虚幻引擎中的AI系统——一种可用于在项目中创建高真实度AI实体的系统。
- [数据驱动的Gameplay元素](data-driven-gameplay-elements/index.md) - 使用外部存储的数据来驱动Gameplay元素。
- [Gameplay技能系统](gameplay-ability-system/index.md) - Gameplay技能系统概览
- [Gameplay摄像机系统](gameplay-camera-system/index.md) - 介绍虚幻引擎Gameplay摄像机系统的文档。
- [Gameplay定位系统](gameplay-targeting-system/index.md) - 虚幻引擎中Gameplay定位系统插件框架的概述。
- [输入](input/index.md) - 在虚幻引擎中创建和设置输入的不同方法
- [Gameplay框架](gameplay-framework/index.md) - 核心游戏系统，入游戏模式、玩家状态、控制器、Pawn、摄像机等。
- [物理](physics/index.md) - Chaos物理系统是虚幻引擎提供的轻量级物理模拟解决方案。
- [大世界坐标](large-world-coordinates/index.md) - 介绍虚幻引擎5中的大世界坐标及其用法。
- [联网和多人游戏](networking-and-multiplayer/index.md) - 为多人游戏设置联网游戏。
- [Mover](mover/index.md) - 创建具有回滚网络支持的动作功能。
- [游戏性架构](programming-with-cpp/index.md) - 创建和实现游戏性类的参考。
- [类创建基础知识](class-creation-basics/index.md) - 多个示例，展示如何仅使用蓝图，仅使用C++以及同时使用C++和蓝图创建类。
- [在线子系统和服务](online-subsystems-and-services/index.md) - 学习如何使用虚幻引擎中的在线子系统和服务，包括Epic在线服务。
