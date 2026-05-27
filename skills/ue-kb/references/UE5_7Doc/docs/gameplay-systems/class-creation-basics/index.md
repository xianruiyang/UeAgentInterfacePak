---
title: "类创建基础知识"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/class-creation-basics-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "类创建基础知识"]
---

# 类创建基础知识

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 类创建基础知识

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/class-creation-basics-in-unreal-engine

这些示例展示了如何仅使用蓝图、仅使用C++代码以及同时使用C++代码和蓝图创建新类。目标是分别使用这三种工作流程创建具有相同属性和行为的新LightSwitch类，然后将每个新类的一个实例添加到关卡中，这样关卡中就具有三个新LightSwitch Actor。

LightSwitch类直接基于Actor类，因为这些类的主要要求是它们可被放置在关卡中。它们各自包含一个PointLightComponent（根组件）和一个SphereComponent（PointLightComponent的子项）。每个LightSwitch类都还包含一个名称为DesiredIntensity的变量，用于设置PointLightComponent的强度。最后，这些类的默认行为是当玩家进入或离开SphereComponent时，PointLightComponent的可视性会切换。

## 示例


- [仅使用蓝图](blueprints-only-example/index.md)

- [仅使用C++的示例](cpp-only-example/index.md) - 为使用虚幻引擎的游戏开发入门人员提供的入门信息。

- [C++和蓝图](cpp-and-blueprints-example/index.md) - 向初识虚幻引擎的游戏程序员讲解相关信息。
