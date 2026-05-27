---
title: "虚幻引擎反射系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/reflection-system-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻引擎反射系统"]
---

# 虚幻引擎反射系统

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻引擎反射系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/reflection-system-in-unreal-engine

**虚幻引擎反射系统** 使用宏为提供引擎和编辑器各种功，封装你的类。在使用 **虚幻引擎（**UE**）** 时，可以使用标准的C++类、函数和变量。

- 虚幻中对象的基类是 [UObject](objects/index.md)。每个类都新定义了一个用于[Actor](../../gameplay-systems/gameplay-framework/actors/index.md)或对象（Object）的模板。
- 你可以使用 `UCLASS` 宏来标记从 `Uobject` 派生的类，以便[UObject处理系统](objects/unreal-object-handling/index.md)可以注意到这些类。
- [TSubclassOf](typed-object-pointer-properties/index.md)是模板类，提供 `Uclass` 类型保险。 它在分配从特定类型派生出来的类时很有效。例如，你可以把这个变量公开给蓝图，设计者可以为玩家角色指定生成的武器类别。
- 类可以包含[结构体](https://dev.epicgames.com/documentation/404)。结构体是帮助组织和操控其相关相关属性的数据结构。结构体可以使用 `USTRUCT()` 宏来单独定义。
- [虚幻智能指针库](smart-pointers/index.md)为C++11智能指针的自定义实现，旨在减轻内存分配和追踪的负担。该实现包括行业标准[共享指针](smart-pointers/shared-pointers/index.md)，[弱指针](smart-pointers/weak-pointers/index.md)，**唯一指针（Unique Pointers）**，和[共享引用](smart-pointers/shared-references/index.md)，此类引用的行为与不可为空的共享指针相同。
- [接口](https://dev.epicgames.com/documentation/404) 提供可以在多个或不同的类中实现函数和额外的游戏行为。 你的玩家角色可以与世界中的各种Actor互动。 每个这些互动都能引起对一个事件的不同反应。
- [Metadata说明符](metadata-specifiers/index.md)控制类、接口、结构体、列举、函数，或属性与引擎和编辑器各方面的交互方式。每一种类型的数据结构或成员都有自己的元数据说明符列表。
- [UFUNCTION](https://dev.epicgames.com/documentation/unreal-engine/ufunctions-in-unreal-engine)，以及[UPROPERTY](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-uproperties)宏使UE注意到新的类、函数和变量。这些宏由引擎进行垃圾收集。 在说明宏时, 你可以在虚幻编辑器中编辑和显示它们。

## 章节目录

- [对象](objects/index.md) - 介绍引擎中的基本游戏性元素、Actor和对象。

- [属性](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-uproperties) - 关于为Gameplay类创建和实现属性的参考。

- [TSubclassOf](typed-object-pointer-properties/index.md) - 使用TSubclassOf模板类提供类型安全性。

- [元数据说明符](metadata-specifiers/index.md) - 声明UClasses、UFunctions、UProperties、UEnums和UInterfaces时使用的元数据关键词，说明其与虚幻引擎和关卡编辑器诸多方面的互动方式。

- [UFunction](https://dev.epicgames.com/documentation/unreal-engine/ufunctions-in-unreal-engine) - 创建和实现游戏性类函数的概述。

- [虚幻智能指针库](smart-pointers/index.md) - 共享指针的自定义实现，包括弱指针和不可为空的共享引用。
