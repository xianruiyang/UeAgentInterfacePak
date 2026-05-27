---
title: "控制器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/controllers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay框架", "控制器"]
---

# 控制器

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay框架 / 控制器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/controllers-in-unreal-engine

**控制器（Controller）** 是一种可以控制Pawn（或Pawn的派生类，例如角色（Character）），从而控制其动作的非实体Actor。人类玩家使用PlayerController控制Pawn，而AIController则对它们控制的Pawn实加人工智能效果。控制器用Possess函数控制Pawn，用Unpossess函数放弃控制Pawn。

控制器会接收其控制的Pawn所发生诸多事件的通知。因此控制器可借机实现 响应此事件的行为，拦截事件并接替Pawn的默认行为。可以让控制器在给定的Pawn之前运行， 从而从而最大限度减少输入处理与Pawn移动之间的延迟。

默认情况下，控制器与Pawn之间存在一对一的关系；也就是说，每个控制器在任何给定的时间只控制一个Pawn。这对于大多数 类型的游戏都是可以接受的，但对于某些类型的游戏可能需要进行调整，因为实时策略可能需要能够同时控制多个实体。
