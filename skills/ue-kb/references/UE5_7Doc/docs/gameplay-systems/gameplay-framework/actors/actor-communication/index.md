---
title: "Actor通信"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/actor-communication-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay框架", "Actors", "Actor通信"]
---

# Actor通信

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay框架 / Actors / Actor通信

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/actor-communication-in-unreal-engine

编程语言

C++

从下拉菜单中选择一个选项以查看与之相关的内容

蓝图脚本和 C++ 提供了多种在 Actor 之间通信和共享信息的方式。本文概述可用的 Actor 通信方法，以及每种方法的要求和常见用例。

你还可以找到每种 Actor 通信类型对应的更详细快速入门指南链接。

## 直接通信

直接 Actor 通信是在关卡中的蓝图 Actor 之间共享信息最常见的方法。

该方法需要目标 Actor 类蓝图的引用，这样才能从当前工作的 Actor 访问其信息。此通信类型在工作 Actor 和目标 Actor 之间使用一对一关系。

### 何时使用

如果已经拥有关卡中特定 Actor 类蓝图的引用，并且需要在该特定 Actor 类蓝图中共享信息或触发功能，请使用此通信方法。

### 示例

- 在 Actor 上触发事件。
- 从关卡中的 Actor 获取信息。

## 使用蓝图类进行类型转换

类型转换是一种常见通信方法：获取 Actor 类蓝图的引用，并尝试将其转换为其他类。如果转换成功，就可以使用直接通信访问它的信息和功能。

该方法需要关卡中 Actor 类蓝图的引用，因为可以使用 **类型转换**尝试将其转换为特定类。此通信方法在工作 Actor 和目标 Actor 之间使用一对一关系。

### 何时使用

如果拥有 Actor 类蓝图的引用，并希望检查该 Actor 类蓝图是否属于某个类以访问其信息，请使用此通信方法。

### 示例

- 使用 AVolume 与所有 APawn 重叠，并将 Pawn 引用转换为特定子类（例如 ACharacter）以访问其信息。
- 使用 Actor 类蓝图的引用转换为公共父类，并访问其信息。

## 接口

接口（UInterface）定义一组可由不同类实现的公共方法行为。此通信类型可简化在不同 Actor 类蓝图上实现同类功能的过程。

该方法要求每个 Actor 实现接口，才能访问其公共方法。你需要 Actor 类蓝图的引用，以便使用该引用调用接口函数。此通信方法在工作 Actor 和目标 Actor 之间使用一对一关系。

> [!NOTE]
> 注意：请参阅 [接口](../../../../cpp-programming/reflection-system/interfaces/index.md) 获取更多文档。

### 何时使用

当需要创建适用于不同类型蓝图 Actor 的公共功能时，请使用此方法。

### 示例

- 创建交互系统，使每个 Actor 类蓝图在玩家交互时执行不同操作。例如，玩家与门 Actor 交互时门会打开，而玩家执行相同交互时灯 Actor 会激活。
- 对关卡中的不同 Actor 施加伤害。每个 Actor 类蓝图都可以对受到的伤害做出不同反应。例如，墙 Actor 受到伤害时可能破碎，而门 Actor 受到伤害后可能打开。

## 委托

委托可以以类型安全的方式调用 Actor 类蓝图中的方法。委托可以动态绑定，形成一种关系：一个 Actor 触发事件，另一个“监听”的 Actor 接收该事件通知。

> [!NOTE]
> 注意：请参阅 [委托](../../../../cpp-programming/delegates-and-lambda-functions/index.md) 获取更多文档。

### 何时使用

当希望单个事件影响多个不同 Actor 类蓝图时，请使用此通信类型。

**示例**

- 在游戏中创建 BossDied 事件。Boss 敌人死亡后，该事件会触发，使门 Actor 打开、UMG 蓝图显示消息，并打开宝箱 Actor。
- 创建昼夜循环，其中 DayStarted 事件会通知 NPC 开始日常行为。

## 与蓝图类通信参考表

| 通信类型 | 何时使用 | 要求 | 示例 |
| --- | --- | --- | --- |
| 直接通信 | 当需要与关卡中 Actor 的特定实例通信时。 | 需要关卡中该 Actor 的引用。 | 在关卡中的特定 Actor 上触发事件。 |
| 类型转换 | 当需要验证 Actor 是否属于某个类以访问其属性时。 | 需要关卡中某个 Actor 的引用，以便转换为目标 Actor 类。 | 访问共享同一父类的子 Actor 的特定功能。 |
| 接口 | 当需要向不同 Actor 类添加相同功能时。 | 需要关卡中该 Actor 的引用，并且该 Actor 需要实现接口。 | 向不同类型的 Actor 添加交互行为。 |
| 事件分发器 | 当需要从一个 Actor 向多个 Actor 触发事件时。 | Actor 需要订阅该事件才能响应。 | 通知多种不同类型的 Actor 某个事件已触发。 |

## 快速入门指南

- [类型转换快速入门指南](casting-quick-start-guide/index.md) - 类型转换通信方法的快速入门指南。
- [直接Actor通信快速入门](direct-actor-communication-quick-start-guide/index.md) - 直接Actor通信方法的快速入门。
- [事件分发器/委托快速入门指南](event-dispatchers-and-delegates-quick-start-guide/index.md) - 事件分发器/委托通信方法的快速入门指南。
- [接口快速入门指南](https://dev.epicgames.com/documentation/unreal-engine/interface-quick-start-guide-in-unreal-engine) - 接口通信方法的快速入门指南。
