---
title: "游戏性架构"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/programming-with-cpp-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "游戏性架构"]
---

# 游戏性架构

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 游戏性架构

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/programming-with-cpp-in-unreal-engine

使用 C++ 代码进行游戏性元素编程时，每个模块会包含许多 C++ 类。

每个类定义新 Actor 或对象的模板。类头文件中声明了类、类[函数](https://dev.epicgames.com/documentation/unreal-engine/ufunctions-in-unreal-engine)和类[属性](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-uproperties)。 类还包括[结构体](https://dev.epicgames.com/documentation/404)这种有助于进行相关属性组织和操作的数据结构。结构也可被自行定义。 通过[接口](https://dev.epicgames.com/documentation/404)可以使不同的类应用额外的游戏性行为。

在虚幻引擎中进行编程时，可使用标准 C++ 类、函数和变量。可使用标准 C++ 语法对它们进行定义。 然而，`UCLASS()`、`UFUNCTION()` 和 `UPROPERTY()` 宏可使虚幻引擎识别新的类、函数和变量。例如，以 `UPROPERTY()` 宏作为声明序言的变量可被引擎执行垃圾回收， 也可在虚幻编辑器中显示和编辑。此外还有 `UINTERFACE()` 和 `USTRUCT()` 宏， 以及用于指定 [类](../../cpp-programming/containers/class-specifiers/index.md)、[函数](https://dev.epicgames.com/documentation/404)、[属性](https://dev.epicgames.com/documentation/404)、 接口或结构体在虚幻引擎和虚幻编辑器中行为的每个宏关键词。

除以上的宏外还有一个 UPARAM() 宏，主要用于将 C++ 代码公开到蓝图。在 [向蓝图公开游戏逻辑内容](../../blueprints-visual-scripting/blueprints-technical-guide/exposing-gameplay-elements-to-blueprints-visual-74ff2735/index.md) 文档中可查看 UPARAM() 的使用范例。

## Gameplay编程参考目录


- [游戏性类](gameplay-classes/index.md)

- [UFunction](https://dev.epicgames.com/documentation/unreal-engine/ufunctions-in-unreal-engine) - 创建和实现游戏性类函数的概述。

- [属性](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-uproperties) - 关于为Gameplay类创建和实现属性的参考。

%programming-and-scripting/programming-language-implementation/unreal-engine-reflection-system/Structs:topic% %programming-and-scripting/programming-language-implementation/unreal-engine-reflection-system/Interfaces:topic%
