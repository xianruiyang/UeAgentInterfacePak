---
title: "编写第一人称冒险游戏"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/code-a-firstperson-adventure-game-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "编写第一人称冒险游戏"]
---

# 编写第一人称冒险游戏

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 编写第一人称冒险游戏

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/code-a-firstperson-adventure-game-in-unreal-engine

在虚幻引擎中使用C++可以让你完全控制和访问引擎功能，让你可以在项目中创建新功能。 这种做法适用于创建复杂系统，优化性能，将游戏提升到新的高度！

凭借虚幻引擎中的代码，你可以使用**蓝图**或C++类创建新功能。 蓝图是引擎的可视化编码工具。 它对初学者非常友好，易于探索，并且可以快速编辑。 你将使用虚幻引擎的蓝图编辑器编辑蓝图，并最终在内容浏览器中得到蓝图类型的资产。

不过，随着蓝图的复杂性增加，蓝图的读取和管理也会变得越来越困难。 在大型项目中，C++更简洁、更易于读取、执行速度更快，并且可以让你访问虚幻引擎的所有功能，从而让你能够完全掌控Gameplay机制。

C++和蓝图也可以配合使用！ 你可以将C++类扩展为蓝图，从而让设计者能够轻松调整变量，或以更直观的方式对其加以使用。 蓝图会充当C++类的子类，继承该类的所有功能。

在本教程中，你将使用C++和虚幻编辑器建立一个新的虚幻引擎代码项目，同时编译一个自定义玩家角色。

## 开始之前

- 阅读[虚幻引擎新用户指南](../index.md)中的其他快速入门页面。
- [为虚幻引擎设置Visual Studio](../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/setting-up-visual-studio-development-environmen-6a24252b/index.md)

## 开始实践！

- [设置并编译项目](coder-01-set-up-and-compile-a-cplusplus-project/index.md) - 学习如何使用模板设置并编译新的C++游戏项目。
- [创建具有输入操作的玩家角色](coder-02-create-a-player-character-with-input-a-9df71be2/index.md) - 学习如何开始编译具有输入操作的C++角色。
- [配置角色移动](coder-03-configure-character-movement-with-cplusplus/index.md) - 学习如何使用C++绑定玩家输入与角色移动。
- [添加第一人称摄像机、网格体和动画](coder-04-adding-a-firstperson-camera-mesh-and-animation/index.md) - 学习如何使用C++为第一人称角色附加网格体和摄像机组件。
- [管理物品和数据](coder-05-manage-item-and-data-in-an-unreal-engine-game/index.md) - 学习使用物品数据结构体、数据资产和数据表来定义物品，并存储和组织物品数据以实现可伸缩性。
- [创建可重新生成的拾取物](coder-06-create-a-respawning-pickup-item/index.md) - 了解如何使用C++创建自定义拾取物并将其在关卡中初始化。
- [装备角色](coder-07-equip-your-character-with-cplusplus-tools/index.md) - 学习使用C++创建自定义可装备物品，并将其附加到角色身上。
- [实现发射物](coder-08-implement-a-projectile/index.md) - 学习使用C++实现发射物并在Gameplay过程中生成发射物。
